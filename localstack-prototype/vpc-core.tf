# VPC
resource "aws_vpc" "test_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true

    tags = {
        Name = "test_vpc"
    }
}

/*      **NOTICE_1** 

Should only use for real AWS, not simulated

data "http" "my_ip" {
    url = "https://checkip.amazonaws.com/"
} 

*/

# Public Subnet A
resource "aws_subnet" "pub_sub_a" {
    vpc_id = aws_vpc.test_vpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "pub-sub-a"
    }
}

# Public Subnet B
resource "aws_subnet" "pub_sub_b" {
    vpc_id = aws_vpc.test_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "pub-sub-b"
    }
}
# Private Subnet 
resource "aws_subnet" "prv_sub_a" {
    vpc_id = aws_vpc.test_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "prv-sub-a"
    }
}

resource "aws_subnet" "prv_sub_b" {
    vpc_id = aws_vpc.test_vpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "prv-sub-b"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "test_igw" {
    vpc_id = aws_vpc.test_vpc.id

    tags = {
        Name = "test_igw"
    }
}

# VPC Gateway Endpoint
resource "aws_vpc_endpoint" "dyn_db_gwe" {
    vpc_id = aws_vpc.test_vpc.id
    service_name = "com.amazonaws.us-east-1.dynamodb"
    vpc_endpoint_type = "Gateway"

    route_table_ids = [aws_route_table.pub_rt.id, aws_route_table.prv_rt.id]

    tags = {
        Name = "dyn_db_gwe"
    }
}

resource "aws_vpc_endpoint" "s3_bck_gwe" {
    vpc_id = aws_vpc.test_vpc.id
    service_name = "com.amazonaws.us-east-1.s3"
    vpc_endpoint_type = "Gateway"

    route_table_ids = [aws_route_table.prv_rt.id]

    tags = {
        Name = "s3_bck_gwe"
    }
}