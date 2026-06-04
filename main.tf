# Public EC2 Instance
resource "aws_instance" "pub_inst" {
    ami = "ami-0a2b6680ef4ed0596"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.pub_sub.id
    vpc_security_group_ids = [aws_security_group.pub_sg.id]
    associate_public_ip_address = true

    tags = {  
        Name = "pub_inst"
    }
}

# Private EC2 Instance
resource "aws_instance" "prv_inst" {
    ami = "ami-0a2b6680ef4ed0596"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.prv_sub.id

    tags = {
        Name = "prv_inst"
    }
}