resource "aws_security_group" "SG" {
  description = "Security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.SG-name
  }
}