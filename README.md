For AWS running on LocalStack

This repository serves as my dedicated, hands-on infrastructure environment focused on mastering IaC, cloud networking, and automated deployments.

Check out my devlog at: [doc\DEVLOG.md](https://github.com/onlineu/revenge-arc-CK/blob/main/doc/DEVLOG.md)

Tech Stack and Local Env:
- IaC Engine: Terraform
- Platform Core: AWS
- Simulation: Docker-based offline AWS Simulation - LocalStack 

To run this simulation, paste the following line into the CLI:
docker run --rm -it -p 4566:4566 -p 4510-4559:4510-4559 -e LOCALSTACK_AUTH_TOKEN="lyour_local_stack_token" localstack/localstack

**Code has been validated and confirmed to be functional**