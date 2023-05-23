output "vpc_id" {
  value = aws_vpc.VPC.id
}

output "IGW_id" {
  value = aws_internet_gateway.IGW.id
}

output "IGW" {
  value = aws_internet_gateway.IGW
}