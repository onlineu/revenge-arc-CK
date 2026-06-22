resource "aws_network_acl" "prv_sub_acl" {
    vpc_id = aws_vpc.test_vpc.id
    subnet_ids = [aws_subnet.prv_sub_a, aws_subnet.prv_sub_b]

    ingress {
        protocol = "tcp"
        rule_no = 100
        action = "allow"
        cidr_block = aws_subnet.pub_sub_a.cidr_block
        from_port = 80
        to_port = 80
    }

    ingress {
        protocol = "tcp"
        rule_no = 110
        action = "allow"
        cidr_block = aws_vpc.test_vpc.cidr_block
        from_port = 1024
        to_port = 65535
    }

    egress {
        protocol = "tcp"
        rule_no = 100
        action = "allow"
        cidr_block = aws_subnet.pub_sub_a.cidr_block
        from_port = 1024
        to_port = 65535
    }

    egress {
        protocol = "tcp"
        rule_no = 120
        action = "allow"
        cidr_block = aws_vpc.test_vpc.cidr_block
        from_port = 443
        to_port = 443
    }

    tags = {
        Name = "prv-sub-nacl"
    }
}