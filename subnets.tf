#Subnet creation resource
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.checkpoint-vpc.id
  cidr_block              = var.public-subnet-1
  map_public_ip_on_launch = true
  availability_zone       = var.az_us_east_1a
  tags                    = var.public-subnet-1-tags
}
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.checkpoint-vpc.id
  cidr_block              = var.public-subnet-2
  map_public_ip_on_launch = true
  availability_zone       = var.az_us_east_1b
  tags                    = var.public-subnet-2-tags
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.checkpoint-vpc.id
  cidr_block        = var.private-subnet-1
  availability_zone = var.az_us_east_1a
  tags              = var.private-subnet-1-tags
}
resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.checkpoint-vpc.id
  cidr_block        = var.private-subnet-2
  availability_zone = var.az_us_east_1b
  tags              = var.private-subnet-2-tags
}
