output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value = [
    aws_subnet.pubsubnet_a1.id,
    aws_subnet.pubsubnet_a2.id,
  ]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value = [
    aws_subnet.prisubnet_a1.id,
    aws_subnet.prisubnet_a2.id,
  ]
}