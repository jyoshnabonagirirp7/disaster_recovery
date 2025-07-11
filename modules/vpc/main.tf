resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.vpc_instance_tenancy

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "pubsubnet_a1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pubsubnet_a1_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
  Name = var.tags_publicsubnet_1
  }
}

resource "aws_subnet" "pubsubnet_a2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pubsubnet_a2_cidr
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
  Name = var.tags_publicsubnet_2
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

resource "aws_route_table_association" "pub_sub_a1" {
  subnet_id      = aws_subnet.pubsubnet_a1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "pub_sub_a2" {
  subnet_id      = aws_subnet.pubsubnet_a2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "prisubnet_a1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.prisubnet_a1_cidr
  availability_zone = "${var.aws_region}a"

  tags = {
  Name = var.tags_privatesubnet_1
  }
}

resource "aws_subnet" "prisubnet_a2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.prisubnet_a2_cidr
  availability_zone = "${var.aws_region}b"

  tags = {
  Name = var.tags_privatesubnet_2
  }
}

resource "aws_eip" "ntgwy" {
  tags = {
    Name = var.nat_eip_name
  }
}

resource "aws_nat_gateway" "ntgwy" {
  allocation_id = aws_eip.ntgwy.id
  subnet_id     = aws_subnet.pubsubnet_a1.id
  tags = {
    Name = var.nat_gateway_name
  }
}

resource "aws_route_table" "private-a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ntgwy.id
  }

  tags = {
    Name = var.private_route_table_name
  }
}

resource "aws_route_table_association" "pri_sub_a1" {
  subnet_id      = aws_subnet.prisubnet_a1.id
  route_table_id = aws_route_table.private-a.id
}

resource "aws_route_table_association" "pri_sub_a2" {
  subnet_id      = aws_subnet.prisubnet_a2.id
  route_table_id = aws_route_table.private-a.id
}
