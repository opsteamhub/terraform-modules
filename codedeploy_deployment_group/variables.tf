variable "name" {}

variable "app_name" {}

variable "environment" {
  type        = string
  description = "Environment"
  default     = "dev"
}

variable "service_role_arn" {}