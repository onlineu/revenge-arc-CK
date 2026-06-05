# DynamoDB IAM
resource "aws_iam_role" "prv_inst_app_iam" {
    name = "prv_inst_app_iam"

    assume_role_policy = jsonencode ({
        Version = "2012-10-17"
        Statement = [{
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = ["ec2.amazonaws.com", 
                "lambda.amazonaws.com"]
            }
        }]
    })
}

# DynamoDB IAM Policy
resource "aws_iam_policy" "dnm_write_policy" {
    name = "dnm_write_policy"
    description = "Allows private EC2 instance to modify a specific DynamoDB table"
    
    policy = jsonencode ({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Action = [
                "dynamodb:PutItem",
                "dynamodb:GetItem",
                "dynamodb:UpdateItem",
                "dynamodb:Scan",
                "dynamodb:Query"
            ]

            Resource = aws_dynamodb_table.test_table.arn
        }]
    })
}

# S3 Bucket Policy
resource "aws_iam_policy" "s3_write_policy" {
    name = "s3_write_policy"
    description = "Allows private EC2 instance to modify an S3 Bucket"
    
    policy = jsonencode ({
        Version = "2012-10-17"
        Statement = [{
            Sid = "AllowObjectLevelActions"
            Effect = "Allow"
            Action = [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ]

            Resource = "${aws_s3_bucket.test.arn}/*"
        }]
    })
}

# Attach
resource "aws_iam_role_policy_attachment" "attach_dnm" {
    role = aws_iam_role.prv_inst_app_iam.name
    policy_arn = aws_iam_policy.dnm_write_policy.arn
}

resource "aws_iam_role_policy_attachment" "attach_s3" {
  role       = aws_iam_role.prv_inst_app_iam.name
  policy_arn = aws_iam_policy.s3_write_policy.arn
}
# Bridge IAM to private EC2
resource "aws_iam_instance_profile" "prv_inst_bdg" {
    name = "prv_inst_bdg"
    role = aws_iam_role.prv_inst_app_iam.name
}