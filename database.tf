resource "aws_dynamodb_table" "test_table" {
    name = "Users"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "id"

    attribute {
        name = "id"
        type = "S"
    }
    attribute {
      name = "email"
      type = "S"
    }
    ttl {
      attribute_name = "TimeToLive"
      enabled = true
    }

    point_in_time_recovery {
      enabled = true
    }
    
    server_side_encryption {
      enabled = true
    }
    
    global_secondary_index {
      name = "EmailIndex"
      projection_type = "ALL"

      key_schema {
        attribute_name = "email"
        key_type = "HASH"
      }
    }

    tags = {
        Name = "test_table"
        Environment = "Hi"
    }
}