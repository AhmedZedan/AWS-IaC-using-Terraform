resource "aws_security_group_rule" "SG_rule" {
  type              = var.type
  from_port         = var.from_port
  to_port           = var.to_port
  protocol          = var.protocols
  cidr_blocks       = var.Cidr_allow_all
  security_group_id = var.SG_id
}