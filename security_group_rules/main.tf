resource "aws_security_group_rule" "rule" {
  type              = var.type
  from_port         = var.from_port
  to_port           = var.to_port
  protocol          = var.protocol
  cidr_blocks       = var.cidr_blocks 
  security_group_id = var.security_group_id
  ipv6_cidr_blocks  = var.ipv6_cidr_blocks
  prefix_list_ids   = var.prefix_list_ids
  description       = var.description
}