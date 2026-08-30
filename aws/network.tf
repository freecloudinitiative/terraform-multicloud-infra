resource "aws_vpc" "k3s_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "k3s-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.k3s_vpc.id

  tags = {
    Name = "k3s-igw"
  }
}

resource "aws_subnet" "k3s_subnet" {
  for_each                = toset(["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"])
  vpc_id                  = aws_vpc.k3s_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.k3s_vpc.cidr_block, 8, index(["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"], each.value))
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name = "k3s-subnet-${each.key}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.k3s_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "k3s-public-rt"
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  for_each       = aws_subnet.k3s_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}
