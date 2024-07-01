resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr #"10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "main" {
  count         = length(var.subnet_cidrs)
  vpc_id        = aws_vpc.main.id
  cidr_block        = element(var.subnet_cidrs, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  
  tags = {
    Name = "main-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "route-table"
  }
}

resource "aws_route_table_association" "route_table_association" {
  count = length(var.subnet_cidrs)

  subnet_id      = element(aws_subnet.main[*].id, count.index)
  route_table_id = aws_route_table.route_table.id
}