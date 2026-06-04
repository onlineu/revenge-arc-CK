# VPC
resource "aws_vpc" "test_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true

    tags = {
        Name = "test"
    }
}

/*      **NOTICE_1** 

Should only use for real AWS, not simulated

data "http" "my_ip" {
    url = "https://checkip.amazonaws.com/"
} 

*/

# Public Security Group
resource "aws_security_group" "pub_sg" {
    name = "pub_sec"
    description = "Allows SSH and HTTP"
    vpc_id = aws_vpc.test_vpc.id

    #HTTP
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #SSH
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

# Public Subnet
resource "aws_subnet" "pub_sub" {
    vpc_id = aws_vpc.test_vpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "pub-sub"
    }
}

# Private Subnet 
resource "aws_subnet" "prv_sub" {
    vpc_id = aws_vpc.test_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "prv_sub"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "test_igw" {
    vpc_id = aws_vpc.test_vpc.id

    tags = {
        Name = "test_igw"
    }
}

# Public Route Table
resource "aws_route_table" "pub_rt" {
    vpc_id = aws_vpc.test_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.test_igw.id
    }

    tags = {
        Name = "pub_rt"
    }
}

# Private Route Table   
resource "aws_route_table" "prv_rt" {
    vpc_id = aws_vpc.test_vpc.id

    tags = {
        Name = "prv_rt"
    }
}

# Assoc Pub Sub - RT
resource "aws_route_table_association" "pub_assoc" {
    subnet_id = aws_subnet.pub_sub.id
    route_table_id = aws_route_table.pub_rt.id
}

# Assoc Prv Sub - RT
resource "aws_route_table_association" "prv_assoc" {
    subnet_id = aws_subnet.prv_sub.id
    route_table_id = aws_route_table.prv_rt.id
}

# Elastic IP for NAT
resource "aws_eip" "nat_eip" {
    domain = "vpc"
    depends_on = [aws_internet_gateway.test_igw]

    tags = {
        Name = "nat_eip"
    }
}

# NAT Gateway
resource "aws_nat_gateway" "prv_inst_nat" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.pub_sub.id

    tags = {
        Name = "prv_inst_nat"
    }
}

# Route traffic via NAT
resource "aws_route" "prv_inst_route" {
    route_table_id = aws_route_table.prv_rt.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.prv_inst_nat.id
}