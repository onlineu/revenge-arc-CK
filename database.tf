resource "aws_dynamodb_table" "test_table" {
    name = "Users"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "id"

    attribute {
        name = "id"
        type = "S"
    }
    ttl {
      attribute_name = "TimeToLive"
      enabled = false
    }

    tags = {
        Name = "test_table"
        Environment = "Hi"
    }
}