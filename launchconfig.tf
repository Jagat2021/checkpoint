data "aws_ami" "latest-amazon-ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Launch Configuration
resource "aws_launch_configuration" "laucnh_configuration" {
  name            = "Launch_Configuration"
  image_id        = data.aws_ami.latest-amazon-ami.id
  instance_type   = "t2.micro"
  key_name        = "test"
  security_groups = [aws_security_group.checkpoint-lt-sg.id]
  user_data       = file("userdata.sh")
}
