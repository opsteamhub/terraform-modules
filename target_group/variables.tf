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
  default = "TCP"
}