variable "name" {}

variable "environment" {}

variable "image_id" {}

variable "iam_instance_profile" {
  default = ""
}

variable "instance_type" {}

variable "key_name" {
  default = ""
}

variable "volume_type" {
  default = "standard"
}

variable "volume_size" {
  default = "8"
}

variable "security_group" {}

variable "max_size" {
  default = 4
}

variable "min_size" {
  default = 1
}

variable "desired_capacity" {
  default = 2
}

#variable "wait_for_elb_capacity" {
#  default = 2
#}

variable "health_check_grace_period" {
  default = 300
}

variable "health_check_type" {
  default = "ELB"
}

variable "subnets" {
  type = list(any)
}

variable "target_group_arns" {
  type    = list(any)
  default = []
}

variable "loadbalancer" {
  type    = list(any)
  default = []
}

variable "common_tags" {
  default = ""
}

variable "provisioned" {
  default = "Terraform"
}