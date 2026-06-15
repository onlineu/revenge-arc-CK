resource "aws_launch_template" "test_template" {
    name_prefix = "test-template"
    image_id = "ami-0a2b6680ef4ed0596"
    instance_type = "t3.micro"

    network_interfaces {
        associate_public_ip_address = true
        security_groups = [aws_security_group.pub_sg.id]
    }
    user_data = base64encode(<<-EOF
            #!/bin/bash
            echo "Hi!" > index.html
            python3 -m http.server 80 &
            EOF
    )
    lifecycle {
        create_before_destroy = true
    }
}
