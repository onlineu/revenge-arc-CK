For AWS running on LocalStack

This repository serves as my dedicated, hands-on infrastructure environment focused on mastering IaC, cloud networking, and automated deployments.

Tech Stack and Local Env:
- IaC Engine: Terraform
- Platform Core: AWS
- Simulation: Docker-based offline AWS Simulation - LocalStack 

June 3rd, 2026: First version
- VPC-Subnet-EC2: Added VPC (10.0.0.0/16) with a public subnet (10.0.0.0/24) and a t3.micro EC2 instance running inside.
- Storage: Added an S3 Bucket for future purposes.
- Database: Added a DynamoDB for future purposes.
- SNS-SQS: Not sure what to do for now.

June 4th, 2026: Decluttered, Updated Security and Routed Internet connection to EC2 instances
- Decluttered main.tf into smaller files.
- Security Group: Added 2 SGs: Private and Public with different inbound and outbound rules.
- Route Tables, Subnets, Assocs, Internet Gateway, and NAT Gateway: Added a private Subnet, 2 RTs, an IGW, and a NAT Gateway, allowing EC2 Instances to access the Internet.
- Private EC2 instance: Added a private EC2 instance, which can only be accessed via the public EC2 one.

June 5th, 2026: Lambda, Python, and IAM
- Lambda: Created a Lambda function which will execute the Python file.
- Python: Created a Python file stored in Lambda which will automatically generate a text file and move it to the S3 Bucket.
- IAM: Created an IAM role for Lambda, S3, and DynamoDB. Bridged DNMDB and S3 to the private EC2 instance.

*I could not confirm if Lambda is going to work or not due to 500 InternalError and ResourceConflictException. However, according to https://app.localstack.cloud/, it should work in a real environment. The code was validated via "tflocal validate"*

**Code has been validated and confirmed to be functional**