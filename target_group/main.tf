resource "aws_lb_target_group" "tg" {
  name     = join("-", ["tg", var.name])
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id

  health_check {
    port     = var.port
    protocol = var.protocol
    timeout  = 5
    interval = 10
  }
}