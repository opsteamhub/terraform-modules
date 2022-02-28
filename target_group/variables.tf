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

variable "target_group_timeout" {
  default = 5
}

variable "target_group_interval" {
  default = 10 
}