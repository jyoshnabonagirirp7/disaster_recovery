variable "vpc_cidr" {
  type = string
}

variable "vpc_instance_tenancy" {
  type    = string
  default = "default"
}

variable "vpc_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "pubsubnet_a1_cidr" {
  type = string
}

variable "pubsubnet_a2_cidr" {
  type = string
}

variable "prisubnet_a1_cidr" {
  type = string
}

variable "prisubnet_a2_cidr" {
  type = string
}

variable "nat_gateway_subnet" {
  description = "Public subnet to place NAT gateway, values: 'a1' or 'a2'"
  type        = string
  default     = "a1"
}

variable "igw_name" {
  type = string
}

variable "nat_eip_name" {
  type = string
}

variable "nat_gateway_name" {
  type = string
}

variable "public_route_table_name" {
  type = string
}

variable "private_route_table_name" {
  type = string
}
variable "tags_publicsubnet_1" {
  type = string
}
variable "tags_publicsubnet_2" {
  type = string
}
variable "tags_privatesubnet_1" {
  type = string
}
variable "tags_privatesubnet_2" {
  type = string
}