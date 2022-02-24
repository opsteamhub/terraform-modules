variable "security_group_id" {
    type = string
}

variable "from_port" {}

variable "to_port" {}

variable "protocol" {}

variable "cidr_blocks" {
    type = list(string)
    default = []
}

variable "type" {}

variable "description" {
    default = ""
}

variable "ipv6_cidr_blocks" {
    default = []
}

variable "prefix_list_ids" {
    default = []
}