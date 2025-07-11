# resource "aws_db_subnet_group" "rds_subnet_group_b" {
#   provider   = aws.ohio
#   name       = "rds-subnet-group-b"
#   subnet_ids = [
#     aws_subnet.prisubnet_b1.id,
#     aws_subnet.prisubnet_b2.id
#   ]

#   tags = {
#     Name = "RDS Subnet Group Ohio"
#   }
# }
# resource "aws_security_group" "rds_sg_b" {
#   provider    = aws.ohio
#   name        = "rds-sg-b"
#   description = "Allow MySQL access from Ohio VPC"
#   vpc_id      = aws_vpc.main2.id  # Your Ohio VPC

#   ingress {
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = ["10.2.0.0/16"]  # Ohio VPC CIDR
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "RDS SG Ohio"
#   }
# }
# resource "aws_db_instance" "read_replica" {
#   provider             = aws.ohio
#   identifier           = "mysql-db-replica"
#   replicate_source_db  = "arn:aws:rds:us-east-1:590157784153:db:mydb-instance"
#   instance_class       = "db.t3.small"
#   publicly_accessible  = false
#   skip_final_snapshot  = true
#   db_subnet_group_name = aws_db_subnet_group.rds_subnet_group_b.name
#   vpc_security_group_ids = [aws_security_group.rds_sg_b.id]
#   availability_zone    = "us-east-2a"

#   tags = {
#     Name = "MySQL-Read-Replica"
#   }
# }
