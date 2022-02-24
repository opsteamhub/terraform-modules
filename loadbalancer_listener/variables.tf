variable "target_group_arn" {
  default = ""
}
variable "load_balancer_arn" {}

variable "port" {}

variable "protocol" {}

variable "type" {
    default = "forward"
}

variable "ssl_policy" {
    default = ""  
}

variable "certificate_arn" {
    default = "" 
}


