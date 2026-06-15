resource "aws_autoscaling_group" "test_asg" {
    name_prefix = "test-ags"
    desired_capacity = 2
    min_size = 1
    max_size = 4

    launch_template {
        id = aws_launch_template.test_template.id
        version = "$Latest"
    }

    vpc_zone_identifier = [aws_subnet.prv_sub.id]

    target_group_arns = [aws_lb_target_group.pub_inst_ssh.arn, aws_lb_target_group.pub_inst_http.arn]

    health_check_type = "ELB"
    health_check_grace_period = 300

    lifecycle {
        create_before_destroy = true
    }
}