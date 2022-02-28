resource "aws_lb_target_group" "tg" {
  name     = join("-", ["tg", var.environment, var.name])
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id


  dynamic "health_check" {
    for_each = var.health_check != null ? [1] : []
    content {
      path                = try(var.health_check.path, null)
      timeout             = var.health_check.timeout
      matcher             = try(var.health_check.matcher, null)
      interval            = var.health_check.interval
      protocol            = try(var.health_check.protocol, null)
      healthy_threshold   = try(var.health_check.healthy_threshold, null)
      unhealthy_threshold = try(var.health_check.unhealthy_threshold, null)
    }
  }

  tags = {
    Name          = join("-", ["tg", var.environment, var.name])
    ProvisionedBy = var.provisioned
    Environment   = var.environment
    Service       = var.name
  }  
}