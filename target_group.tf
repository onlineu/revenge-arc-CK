resource "aws_lb_target_group" "pub_inst_ssh" {
    name = "pub-inst-ssh"
    port = 22
    protocol = "TCP"
    vpc_id = aws_vpc.test_vpc.id
}

resource "aws_lb_target_group" "pub_inst_http" {
    name = "pub-inst-http"
    port = 80 
    protocol = "HTTP"
    vpc_id = aws_vpc.test_vpc.id
}

resource "aws_lb_target_group" "lambda_py" {
    name = "lambda-py"
    target_type = "lambda"
}