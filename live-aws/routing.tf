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
resource "aws_route_table_association" "pub_assoc_a" {
    subnet_id = aws_subnet.pub_sub_a.id
    route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "pub_assoc_b" {
    subnet_id = aws_subnet.pub_sub_b.id
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
    subnet_id = aws_subnet.pub_sub_a.id

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