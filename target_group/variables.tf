variable "vpc_id" {
  default = ""
}

variable "name" {}

variable "port" {}

variable "protocol" {}

variable "target_type" {
  description = "Type of target that you must specify when registering targets with this target group. Valid values: ip|instance|lambda"
  default     = "instance"
  type        = string
}

variable "environment" {}

variable "provisioned" {
  default = "Terraform"
}

variable "health_check" {
  description = "Health Check configuration block."
  default     = null
  type = object({
    path                = string
    timeout             = number
    matcher             = optional(string)
    interval            = number
    protocol            = optional(string)
    healthy_threshold   = optional(number)
    unhealthy_threshold = optional(number)
  })
  # Example:
  # path                = "/"
  # timeout             = 10
  # matcher             = "200-399"
  # interval            = 15
  # protocol            = "HTTP"
  # healthy_threshold   = 2
  # unhealthy_threshold = 2
}