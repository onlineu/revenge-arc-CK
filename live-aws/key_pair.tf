resource "aws_key_pair" "key" {
    key_name = "key-pair"
    public_key = file("../../pub_ec2_keypair.pem") #Insert yo own path
}