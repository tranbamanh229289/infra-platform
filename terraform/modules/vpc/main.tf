data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = length(var.availability_zones) > 0 ? var.availability_zones : slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnet_cidrs = length(var.public_subnet_cidrs) > 0 ? var.public_subnet_cidrs : [for i in range(length(local.azs)) : cidrsubnet(var.cidr, 8, i)]
  private_subnet_cidrs = length(var.private_subnet_cidrs) > 0 ? var.private_subnet_cidrs : [for i in range(length(local.azs)) : cidrsubnet(var.cidr, 8, i + 10)]
}

#VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr
}

#Internet Gateway 
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

#NAT Gateway
resource "aws_eip" "main" {
  count = var.enable_nat_gateway ? length(local.azs): 0
  depends_on = [ aws_internet_gateway.main ]
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  count = var.enable_nat_gateway ? length(local.azs): 0
  allocation_id = aws_eip.main[count.index].id
  subnet_id = aws_subnet.public[count.index].id
  depends_on = [ aws_internet_gateway.main ]
}

#Subnet
resource "aws_subnet" "public" {
  vpc_id = vpc.main.id
  count = length(local.azs)
  cidr_block = local.public_subnet_cidrs[count.index]
  availability_zone = local.azs[count.index]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  vpc_id = vpc.main.id
  count = length(local.azs)
  cidr_block = local.private_subnet_cidrs[count.index]
  availability_zone = local.azs[count.index]
}

#Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public[count.index].id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  route_table_id = aws_route_table.private.id
  subnet_id = aws_subnet.private[count.index].id
}