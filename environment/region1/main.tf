module "vpc" {
  source               = "../../modules/vpc"
  
  vpc_cidr             = var.vpc_cidr
  vpc_instance_tenancy = var.vpc_instance_tenancy
  vpc_name             = var.vpc_name
  aws_region           = var.aws_region

  pubsubnet_a1_cidr    = var.pubsubnet_a1_cidr
  pubsubnet_a2_cidr    = var.pubsubnet_a2_cidr
  prisubnet_a1_cidr    = var.prisubnet_a1_cidr
  prisubnet_a2_cidr    = var.prisubnet_a2_cidr

  nat_gateway_subnet   = var.nat_gateway_subnet

  igw_name             = var.igw_name
  nat_eip_name         = var.nat_eip_name
  nat_gateway_name     = var.nat_gateway_name

  public_route_table_name  = var.public_route_table_name
  private_route_table_name = var.private_route_table_name

  tags_publicsubnet_1 = var.tags_publicsubnet_1
  tags_publicsubnet_2 = var.tags_publicsubnet_2
  tags_privatesubnet_1 = var.tags_privatesubnet_1
  tags_privatesubnet_2 = var.tags_privatesubnet_2
}
  #---compute----

module "compute" {
  source = "../../modules/compute"
  
  vpc_id                = var.vpc_id
  public_subnet_ids     = var.public_subnet_ids
  alb_name              = var.alb_name
  alb_sg_description    = var.alb_sg_description
  ec2_sg_description    = var.ec2_sg_description
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  s3_bucket             = var.s3_bucket
  s3_image_key          = var.s3_image_key
  asg_name_tag          = var.asg_name_tag
  launch_template_name  = var.launch_template_name
  target_group_name     = var.target_group_name
  alb_listener_port     = var.alb_listener_port
  ec2_instance_profile  = aws_iam_instance_profile.ec2_profile.name
}



