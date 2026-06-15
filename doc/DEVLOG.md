**DEVLOG**

This is where I document my work on this project. "revenge-arc-CK" was created as a way to practice my Terraform (.tf)
skills as I was rejected from an internship opportunity as a cloud engineer. I shall update this repo every now and then
as life might get in the way, but it will not be inactive for over 7 days.

LOG:

June 3rd, 2026: The start of an era
- VPC-Subnet-EC2: Added VPC (10.0.0.0/16) with a public subnet (10.0.0.0/24) and a t3.micro EC2 instance running inside.
- Storage: Added an S3 Bucket for future purposes.
- Database: Added a DynamoDB for future purposes.
- SNS-SQS: Not sure what to do for now.

June 4th, 2026: Decluttered, Security, and Internet Connection
- Decluttered main.tf into smaller files.
- Security Group: Added 2 SGs: Private and Public with different inbound and outbound rules.
- Route Tables, Subnets, Assocs, Internet Gateway, and NAT Gateway: Added a private Subnet, 2 RTs, an IGW, and a NAT Gateway, allowing EC2 Instances to access the Internet.
- Private EC2 instance: Added a private EC2 instance, which can only be accessed via the public EC2 one.

June 5th, 2026: Lambda, Python, and IAM
- Lambda: Created a Lambda function which will execute the Python file.
- Python: Created a Python file stored in Lambda which will automatically generate a text file and move it to the S3 Bucket.
- IAM: Created an IAM role for Lambda, S3, and DynamoDB. Bridged DNMDB and S3 to the private EC2 instance.
+ Not sure what to do with SQS and SNS but I will work on it tomorrow or next week.

June 8th, 2026: SQS-SNS, TGs and SOS:
- Added an SQS-SNS function which will sends notification if a file is sent and stored in S3.
- Added Target Groups for an ALB, deal with that tomorrow.
+ Tried fixing LocalStack and the container, failed.
+ Feel kinda lazy after the weekends and I'm running out of things to add.

June 9th and June 11th, 2026: ALB, NLB, and an additional subnet:
- Added an ALB for Lambda and the public instance HTTP port.
- Bored and unemployed so I added an NLB for public instance SSH port.
- Added a new public subnet to make the ALB and NLB work, the new subnet has nothing besides an attached RT.
- Added CloudWatch to look out for any execution error from Lambda.

June 12th, 2026: Secured and Scaled
- Blocked public access for the S3 Bucket.
- DynamoDB: Enabled TTL, added SSE and GSI.
- Added an ASG and a launch template.

June 15th, 2026: Ready For Deployment
- Modified the LocalStack version so that it could be deployed to actual AWS.
- Reorganised the files.
*Live AWS version has been confirmed to be fully functional*

*I could not confirm if Lambda is going to work or not due to 500 InternalError and ResourceConflictException. However, according to https://app.localstack.cloud/, it should work in a real environment. The code was validated via "tflocal validate"*