# Pulls pub_inst IP address
output "pub_inst_ip" {
    value = aws_instance.pub_inst.public_ip
    description = "Public IP address of Public EC2"
}

# Pulls prv_inst IP address
output "prv_inst_ip" {
    value = aws_instance.prv_inst.private_ip
    description = "Private IP address of Private EC2"
}