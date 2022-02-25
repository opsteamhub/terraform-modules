resource "aws_security_group" "sg" {
  name        = join("-", ["SG", var.environment, var.name])
  description = "Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Name          = join("-", ["SG", var.environment, var.name])
    ProvisionedBy = var.provisioned
    Service       = var.name
    Environment   = var.environment
  }
}