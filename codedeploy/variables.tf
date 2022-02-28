variable "name" {
  type        = string
  description = "Name value"
  default     = ""
}

variable "environment" {
  type        = string
  description = "Environment"
  default     = "dev"
}

variable "service_role_arn" {
    type = string
    description = "Service Role"
    default = ""  
}