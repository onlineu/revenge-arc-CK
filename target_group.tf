/* resource "aws_lb_target_group" "pub_inst_ssh" {
    name = "pub_inst_ssh"
    port = 22
    protocol = "SSH"
    vpc_id = aws_vpc.test_vpc
}
*/

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