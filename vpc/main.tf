resource "aws_vpc" "VPC" {
  cidr_block = var.vpc-cidr 

  tags = {
    Name = var.vpc-name
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = var.IGW-name
  }
}