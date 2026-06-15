This repository serves as my dedicated, hands-on infrastructure environment focused on mastering IaC, cloud networking, and automated deployments.

Check out my devlog at: [doc\DEVLOG.md](https://github.com/onlineu/revenge-arc-CK/blob/main/doc/DEVLOG.md)


For LocalStack version: 

Tech Stack and Local Env:
- IaC Engine: Terraform
- Platform Core: AWS
- Simulation: Docker-based offline AWS Simulation - LocalStack 

To run this simulation, paste the following line into the CLI:
docker run --rm -it -p 4566:4566 -p 4510-4559:4510-4559 -e LOCALSTACK_AUTH_TOKEN="lyour_local_stack_token" localstack/localstack


For live AWS version:
- To run the live version, follow the instructions:
+ Log into AWS account
+ Enter the credentials.
+ Run: "terraform init"
+ Run: "terraform plan", and then "terraform apply"

**Code has been validated and confirmed to be functional**