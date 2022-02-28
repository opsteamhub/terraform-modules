resource "aws_lb_target_group" "tg" {
  name     = join("-", ["tg", var.environment, var.name])
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id

  health_check {
    port     = var.port
    protocol = var.health_check_protocol
    path     = var.path
    timeout  = 5
    interval = 10
  }

  tags = {
    Name          = join("-", ["tg", var.environment, var.name])
    ProvisionedBy = var.provisioned
    Environment   = var.environment
    Service       = var.name
  }  
}