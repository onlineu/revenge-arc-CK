resource "aws_dynamodb_table" "users_table" {
    name = "Users"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "UserId"

    attribute {
        name = "UserId"
        type = "S"
    }
}