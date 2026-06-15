# Public Security Group
resource "aws_security_group" "pub_sg" {
    name = "pub_sec"
    description = "Allows SSH and HTTP"
    vpc_id = aws_vpc.test_vpc.id

    # HTTP
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # SSH
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        # **NOTICE_1** cidr_blocks = ["${chomp(data.http.my_ip.response_body)}/32"]
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0 
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "pub_sec"
    }
}

# Private Security Group
resource "aws_security_group" "prv_sg" {
    name = "prv_sec"
    description = "Allows SSH from Public EC2 Instance IP"
    vpc_id = aws_vpc.test_vpc.id

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "prv_sec"
    }
}
resource "aws_security_group_rule" "allows_SSH_from_pub_inst" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_group_id = aws_security_group.prv_sg.id
    source_security_group_id = aws_security_group.pub_sg.id
}