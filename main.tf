provider "aws" {
    region = "us-east-1"
    access_key = "mock_key"
    secret_key = "mock_secret"
}

resource "aws_s3_bucket" "test" {
    bucket = "local-test-bucket"
}   

resource "aws_dynamodb_table" "users_table" {
    name = "Users"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "UserId"

    attribute {
        name = "UserId"
        type = "S"
    }
}

resource "aws_sqs_queue" "test_queue" {
    name = "test-queue"
}


resource "aws_sns_topic" "test_topic" {
    name = "test-topic"
}

resource "aws_vpc" "test_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true

    tags = {
        name = "test"
    }
}

resource "aws_subnet" "pub_sub" {
    vpc_id = aws_vpc.test_vpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"

    tags = {
        name = "pub-sub"
    }
}

resource "aws_instance" "test" {
    ami = "ami-0a2b6680ef4ed0596"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.pub_sub.id

    tags = {
        name = "test_ec2_t3"
    }
}