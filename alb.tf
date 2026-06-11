# ALB
resource "aws_lb" "test_alb" {
    name = "test-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.pub_sg.id]
    subnets = [aws_subnet.pub_sub_a.id, aws_subnet.pub_sub_b.id]
}

# Listener
resource "aws_lb_listener" "http_listener" {
    load_balancer_arn = aws_lb.test_alb.arn
    port = 80
    protocol = "HTTP"
    
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.pub_inst_http.arn
    }
}

# Routing
resource "aws_lb_listener_rule" "route_lambda" {
    listener_arn = aws_lb_listener.http_listener.arn
    priority = 100

    action {
            type = "forward"
            target_group_arn = aws_lb_target_group.lambda_py.arn
        }

    condition {
        path_pattern {
            values = ["/api/*"]
        }
    }
}

resource "aws_lb_target_group_attachment" "http_inst_attach" {
    target_group_arn = aws_lb_target_group.pub_inst_http.arn
    target_id = aws_instance.pub_inst.id
    port = 80
}

resource "aws_lambda_permission" "alb_lambda_perm" {
    statement_id = "AllowExecutionFromALB"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.file_generator_py.function_name
    principal = "elasticloadbalancing.amazonaws.com"
    source_arn = aws_lb_target_group.lambda_py.arn
}

resource "aws_lb_target_group_attachment" "lambda_attach" {
    target_group_arn = aws_lb_target_group.lambda_py.arn
    target_id = aws_lambda_function.file_generator_py.arn
    depends_on = [aws_lambda_permission.alb_lambda_perm]
}