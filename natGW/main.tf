

resource "aws_nat_gateway" "NAT-GW" {
  allocation_id = aws_eip.EIP.id
  subnet_id = var.subnet_id

  tags = {
    Name = var.NAT-GW-name
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
}

# Elastic IPs
resource "aws_eip" "EIP" {
  vpc = true
}