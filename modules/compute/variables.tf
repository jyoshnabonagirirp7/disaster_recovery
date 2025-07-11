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
}

variable "ec2_instance_profile" {
  type = string
}

