variable "name" {}

variable "environment" {}

variable "security_group" {}

variable "subnets" {
  type = list(any)
}

variable "provisioned" {
  default = "Terraform"
}

variable "vpc_id" {
  default = ""
}

variable "lb_type" {
    default = "application"
  
}