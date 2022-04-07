resource "aws_autoscaling_group" "checkpoint-asg" {
  name                      = "checkpoint-asg"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  #availability_zones        = ["us-east-1a", "us-east-1b"]
  vpc_zone_identifier  = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
  target_group_arns    = [aws_lb_target_group.alb-tg.arn]
  launch_configuration = aws_launch_configuration.laucnh_configuration.name


}

