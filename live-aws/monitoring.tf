resource "aws_flow_log" "vpc_flow_log" {
    log_destination = aws_s3_bucket.vpc_flow_logs_bucket.arn
    log_destination_type = "s3"
    traffic = "ALL"
    vpc_id = aws_vpc.test_vpc.id

    tags = {
        Name = "flow-logs"
    }
}

