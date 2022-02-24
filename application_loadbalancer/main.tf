resource "aws_lb" "lb" {
  name               = join("-", ["lb", var.name])
  internal           = false
  load_balancer_type = var.lb_type
  subnets            = var.subnets
  security_groups    = [var.security_group]

  tags = {
    Name          = join("-", ["lb", var.name])
    ProvisionedBy = var.provisioned
    Environment   = var.environment
    Service       = var.name
  }
}

