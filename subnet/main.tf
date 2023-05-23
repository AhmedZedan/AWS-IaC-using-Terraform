resource "aws_subnet" "subnet" {
  vpc_id                  = var.vpc-id
  cidr_block              = var.subnet-cidr
  map_public_ip_on_launch = var.map_public_ip
  availability_zone       = var.availability_zone

  tags = {
    Name = var.subnet-name
}
}


resource "aws_route_table" "RT" {
  vpc_id = var.vpc-id

  route {
    cidr_block = var.cidr_block_RT
    gateway_id = var.gateway_id
  }

  tags = {
    Name = var.RT_name
  }
}

resource "aws_route_table_association" "RT_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.RT.id
}