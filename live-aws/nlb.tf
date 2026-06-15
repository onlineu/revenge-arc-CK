# NLB
resource "aws_lb" "ssh_nlb" {
    name = "ssh-nlb"
    internal = false
    load_balancer_type = "network"
    subnets = [aws_subnet.pub_sub_a.id, aws_subnet.pub_sub_b.id]
}

resource "aws_lb_listener" "ssh_listener" {
    load_balancer_arn = aws_lb.ssh_nlb.arn
    port = "22"
    protocol = "TCP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.pub_inst_ssh.arn
    }
}

resource "aws_lb_target_group_attachment" "ssh_inst_attach" {
    target_group_arn = aws_lb_target_group.pub_inst_ssh.arn
    target_id = aws_instance.pub_inst.id
    port = 22
}