resource "aws_security_group" "alb_sg" {
  description = var.alb_sg_description
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ec2_sg" {
  description = var.ec2_sg_description
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
    description     = "Allow HTTP from ALB"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_template" "this" {
  name                   = var.launch_template_name
  image_id               = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  iam_instance_profile {
    name = var.ec2_instance_profile
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum install -y httpd awscli
    systemctl start httpd
    systemctl enable httpd

    aws s3 cp s3://${var.s3_bucket}/${var.s3_image_key} /var/www/html/s3-image.jpg

    cat <<EOT > /var/www/html/index.html
    <html>
      <head>
        <title>Welcome Page</title>
        <style>
          body {
            background-color: #f0f8ff;
            font-family: Arial, sans-serif;
            text-align: center;
            color: #003366;
            margin-top: 50px;
          }
          h1 {
            color: #006699;
            text-shadow: 1px 1px 2px #aaa;
          }
          img {
            max-width: 80%;
            height: auto;
            border: 5px solid #006699;
            border-radius: 10px;
            margin-top: 20px;
          }
        </style>
      </head>
      <body>
        <h1>Welcome to ASG EC2-A from Virginia</h1>
        <img src="s3-image.jpg" alt="S3-Image" />
      </body>
    </html>
    EOT
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.asg_name_tag
    }
  }
}

resource "aws_lb_target_group" "this" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_autoscaling_group" "this" {
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  target_group_arns   = [aws_lb_target_group.this.arn]
  vpc_zone_identifier = var.public_subnet_ids

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.asg_name_tag
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.alb_listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
