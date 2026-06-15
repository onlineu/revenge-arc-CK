resource "aws_s3_bucket" "test" {
    bucket = "aws-test-bucket-unique0-6767"
    force_destroy = false
    tags = {
        Name = "Test Storage"
        Environment = "LocalTesting"
    }
}

resource "aws_s3_bucket_public_access_block" "storage_privacy" {
    bucket = aws_s3_bucket.test.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}