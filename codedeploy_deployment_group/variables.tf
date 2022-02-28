variable "name" {
    default = ""
}

variable "app_name" {}

variable "environment" {
  type        = string
  description = "Environment"
  default     = "dev"
}

variable "service_role_arn" {}

variable "deployment_group_name" {}

variable "ec2_tag_group" {}