# Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "main",
    Owner = "ANIRBAN"
  }
}

# Subnet
# Public Subnet 
resource "aws_subnet" "main-public-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    NAME = "main-public-1",
    OWNER = "ANIRBAN"
  }
}

# Private Subnet
resource "aws_subnet" "main-private-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    Name = "main-private-1",
    Owner = "ANIRBAN"
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main",
    Owner = "ANIRBAN"
  }
}

# Elastic IP 
resource "aws_eip" "main-eip" {
  vpc      = true
}

# NAT Gateway
resource "aws_nat_gateway" "main-nat" {
  allocation_id = aws_eip.main-eip.id
  subnet_id     = aws_subnet.main-public-1.id
}

# route tables for public
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }
  tags = {
    Name = "main-public-1",
    Owner = "ANIRBAN"
  }
}


# route tables for private 
resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main-nat.id
  }
  tags = {
    Name = "main-private-1",
    Owner = "gs-1074",
    Practice = "CIS",
    Project = "POC",
    Purpose = "Project POC",
    Duration = "1 Week"
  }
}

# route associations for public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.main-public-1.id
  route_table_id = aws_route_table.main-public.id
}

# route associations for private 
resource "aws_route_table_association" "main-private-1-a" {
  subnet_id      = aws_subnet.main-private-1.id
  route_table_id = aws_route_table.main-private.id
}
