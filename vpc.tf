# Create VPC
resource "aws_vpc" "checkpoint-vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = var.vpc_tags
}

# Create the Internet Gateway
resource "aws_internet_gateway" "checkpoint-igw" {
  vpc_id = aws_vpc.checkpoint-vpc.id

  tags = {
    Name = "checkpoint-igw"
  }
}

# Create public route table and association
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.checkpoint-vpc.id

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public-rt-association-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-rt.id
  depends_on     = [aws_route_table.public-rt]
}
resource "aws_route_table_association" "public-rt-association-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-rt.id
  depends_on     = [aws_route_table.public-rt]
}

resource "aws_route" "igw-route" {
  route_table_id         = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.checkpoint-igw.id
  depends_on             = [aws_internet_gateway.checkpoint-igw, aws_route_table.public-rt]
}

# Create private route table and association
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.checkpoint-vpc.id

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private-rt-association-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-rt.id
  depends_on     = [aws_route_table.private-rt]
}
resource "aws_route_table_association" "private-rt-association-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-rt.id
  depends_on     = [aws_route_table.private-rt]
}

# NAT Gateway creation for private instance
resource "aws_eip" "nat_gateway_eip" {
  vpc = true
}

resource "aws_nat_gateway" "checkpoint-nat-gw" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name = "checkpoint-nat-gw"
  }
  depends_on = [aws_internet_gateway.checkpoint-igw]
}

# route in privat subnet to NAT GW
resource "aws_route" "natgw-route" {
  route_table_id         = aws_route_table.private-rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.checkpoint-nat-gw.id
  depends_on             = [aws_nat_gateway.checkpoint-nat-gw, aws_route_table.private-rt]
}


