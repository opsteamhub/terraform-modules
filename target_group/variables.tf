variable "vpc_id" {
  default = ""
}

variable "name" {}

variable "port" {}

variable "protocol" {}

variable "environment" {}

variable "provisioned" {
  default = "Terraform"
}

variable "path" {
  default = ""  
}

variable "health_check_protocol" {
  default = "HTTP"
}

variable "name_prefix" {
  description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name. Cannot be longer than 6 characters."
  default     = null
  type        = string
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
}  