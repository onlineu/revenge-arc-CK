# Public EC2 Instance
resource "aws_instance" "pub_inst" {
    ami = "ami-0a2b6680ef4ed0596"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.pub_sub_a.id
    vpc_security_group_ids = [aws_security_group.pub_sg.id]
    associate_public_ip_address = true

    tags = {  
        Name = "pub_inst"
    }
}


variable "prv_inst_type" {
    type = string
    default = "t3.micro"
}

variable "prv_inst_pub_ip" {
    type = bool
    default = false
}


# Private EC2 Instance
resource "aws_instance" "prv_inst" {
    ami = "ami-0a2b6680ef4ed0596"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.prv_sub.id
    vpc_security_group_ids = [aws_security_group.prv_sg.id]
    iam_instance_profile = aws_iam_instance_profile.prv_inst_bdg.name

    lifecycle {
      precondition {
        condition = var.prv_inst_pub_ip == false
        error_message = "Public IP address is not allowed here."
      }

      precondition {
        condition = contains(["t3.micro", "t3.small"], var.prv_inst_type)
        error_message = "Only instance type of t3.micro and/or t3.small is permitted."
      }
    }

    tags = {
        Name = "prv_inst"
    }
}