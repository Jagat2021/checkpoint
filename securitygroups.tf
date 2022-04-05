# ALB security group
resource "aws_security_group" "checkpoint-alb-sg" {
  name        = "checkpoint-alb-sg"
  description = "Allow internet traffic"
  vpc_id      = aws_vpc.checkpoint-vpc.id

  ingress {
    description = "Allow All Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "checkpoint-alb-sg"
  }
}

# LT security group
resource "aws_security_group" "checkpoint-lt-sg" {
  name        = "checkpoint-lt-sg"
  description = "LT security group"
  vpc_id      = aws_vpc.checkpoint-vpc.id

  ingress {
    description     = "Allow All Traffic"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.checkpoint-alb-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "checkpoint-lt-sg"
  }
}


