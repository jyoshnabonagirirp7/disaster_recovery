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
variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "alb_name" {
  type = string
}

variable "alb_sg_description" {
  type = string
}

variable "ec2_sg_description" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "s3_bucket" {
  type = string
}

variable "s3_image_key" {
  type = string
}

variable "asg_name_tag" {
  type = string
}

variable "launch_template_name" {
  type = string
}

variable "target_group_name" {
  type = string
}

variable "alb_listener_port" {
  type = number
  default = 80
}

variable "ec2_instance_profile" {
  type = string
}
variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  default     = "MySecurePassword123!"
  sensitive   = true
}

