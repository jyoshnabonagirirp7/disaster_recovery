aws_region               = "us-east-1"

vpc_cidr                 = "10.0.0.0/16"
vpc_name                 = "VPC-A"
vpc_instance_tenancy     = "default"

pubsubnet_a1_cidr        = "10.0.1.0/24"
pubsubnet_a2_cidr        = "10.0.2.0/24"

prisubnet_a1_cidr        = "10.0.11.0/24"
prisubnet_a2_cidr        = "10.0.12.0/24"

nat_gateway_subnet       = "a1"  

igw_name                 = "VPC-A-IGW"
nat_eip_name             = "VPC-A-NATGateway-EIP"
nat_gateway_name         = "VPC-A-NATGateway"

public_route_table_name  = "PublicRouteTable-A"
private_route_table_name = "PrivateRouteTable-A"

tags_publicsubnet_1     = "Public-Subnet-A1"
tags_publicsubnet_2     = "Public-Subnet-A2"
tags_privatesubnet_1    = "Private-Subnet-A1"
tags_privatesubnet_2    = "Private-Subnet-A2"

#----compute-----

vpc_id                = "vpc-0a40a6b81012bc50f"                         
public_subnet_ids     = ["subnet-0d41d5dfba8397e83", "subnet-05ecb45b4c55dac77"] 

alb_name              = "alb-A"
alb_sg_description    = "Allow HTTP from anywhere"
ec2_sg_description    = "Allow SSH and HTTP from ALB"

ami_id                = "ami-05ffe3c48a9991133"
instance_type         = "t3.micro"

s3_bucket             = "disasterrecovery-bucket"
s3_image_key          = "s3-image.jpg"

asg_name_tag          = "ASG-EC2-A"
launch_template_name  = "Launch-template-A"
target_group_name     = "tg-A"
alb_listener_port     = 80

ec2_instance_profile  = "ec2_s3_profile"
