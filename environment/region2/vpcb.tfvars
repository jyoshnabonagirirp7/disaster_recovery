aws_region               = "us-east-2"

vpc_cidr                 = "10.1.0.0/16"
vpc_name                 = "VPC-B"
vpc_instance_tenancy     = "default"

pubsubnet_a1_cidr        = "10.1.1.0/24"
pubsubnet_a2_cidr        = "10.1.2.0/24"

prisubnet_a1_cidr        = "10.1.11.0/24"
prisubnet_a2_cidr        = "10.1.12.0/24"

nat_gateway_subnet       = "a1"  

igw_name                 = "VPC-B-IGW"
nat_eip_name             = "VPC-B-NATGateway-EIP"
nat_gateway_name         = "VPC-B-NATGateway"

public_route_table_name  = "PublicRouteTable-B"
private_route_table_name = "PrivateRouteTable-B"

tags_publicsubnet_1     = "Public-Subnet-B1"
tags_publicsubnet_2     = "Public-Subnet-B2"
tags_privatesubnet_1    = "Private-Subnet-B1"
tags_privatesubnet_2    = "Private-Subnet-B2"

vpc_id                = "vpc-0911e7f94a4f4e978" 
public_subnet_ids     = ["subnet-056e7cbfec0a31030", "subnet-02ebccf492243faa6"] 
alb_name              = "alb-B"
alb_sg_description    = "Allow HTTP from anywhere"
ec2_sg_description    = "Allow SSH and HTTP from ALB"

ami_id                = "ami-0c803b171269e2d72"  
instance_type         = "t3.micro"

s3_bucket             = "disasterrecovery-bucket"
s3_image_key          = "s3-image.jpg"

asg_name_tag          = "ASG-EC2-B"
launch_template_name  = "Launch-template-B"
target_group_name     = "tg-B"
alb_listener_port     = 80

ec2_instance_profile  = "ec2_s3_profile"  # Must exist in us-east-2 or be created
