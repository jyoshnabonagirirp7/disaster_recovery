resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group-a"
  subnet_ids = [
    aws_subnet.prisubnet_a1.id,
    aws_subnet.prisubnet_a2.id
  ]

  tags = {
    Name = "RDS Subnet Group A"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL access from EC2"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS SG"
  }
}

resource "aws_db_instance" "mysql_db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.small" 
  db_name              = "mydatabase" 
  identifier           = "mydb-instance"
  username             = var.db_username
  password             = var.db_password 
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = true
  publicly_accessible  = false
  multi_az             = false
  availability_zone    = "us-east-1a"
  backup_retention_period = 1

  tags = {
    Name = "MySQL-RDS-A"
  }
}
