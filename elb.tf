# Create application load balancer

resource "aws_lb" "checkpoint-alb" {
  name               = "checkpoint-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.checkpoint-alb-sg.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]

  tags = {
    Name = "checkpoint-alb"
  }
}

# Add listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.checkpoint-alb.arn
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_lb.checkpoint-alb]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }
}

# Add target groups
resource "aws_lb_target_group" "alb-tg" {
  name        = "alb-target-group"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.checkpoint-vpc.id
  depends_on  = [aws_lb.checkpoint-alb]

  health_check {
    path     = "/index.html"
    protocol = "HTTP"
  }
}

