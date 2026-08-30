resource "aws_vpc" "k3s_vpc_secondary" {
  provider             = aws.secondary
  cidr_block           = local.secondary_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "k3s-vpc-secondary"
  }
}

resource "aws_internet_gateway" "igw_secondary" {
  provider = aws.secondary
  vpc_id   = aws_vpc.k3s_vpc_secondary.id

  tags = {
    Name = "k3s-igw-secondary"
  }
}

resource "aws_subnet" "k3s_subnet_secondary" {
  provider                = aws.secondary
  vpc_id                  = aws_vpc.k3s_vpc_secondary.id
  cidr_block              = cidrsubnet(aws_vpc.k3s_vpc_secondary.cidr_block, 8, 0)
  availability_zone       = local.worker_secondary.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "k3s-subnet-${local.worker_secondary.availability_zone}"
  }
}

resource "aws_route_table" "public_rt_secondary" {
  provider = aws.secondary
  vpc_id   = aws_vpc.k3s_vpc_secondary.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_secondary.id
  }

  tags = {
    Name = "k3s-public-rt-secondary"
  }
}

resource "aws_route_table_association" "public_rt_assoc_secondary" {
  provider       = aws.secondary
  subnet_id      = aws_subnet.k3s_subnet_secondary.id
  route_table_id = aws_route_table.public_rt_secondary.id
}

resource "aws_vpc_peering_connection" "primary_to_secondary" {
  vpc_id      = aws_vpc.k3s_vpc.id
  peer_vpc_id = aws_vpc.k3s_vpc_secondary.id
  peer_region = var.aws_secondary_region
  auto_accept = false

  tags = {
    Name = "k3s-primary-to-secondary"
  }
}

resource "aws_vpc_peering_connection_accepter" "secondary" {
  provider                  = aws.secondary
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id
  auto_accept               = true

  tags = {
    Name = "k3s-primary-to-secondary"
  }
}

resource "aws_route" "primary_to_secondary" {
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = local.secondary_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id

  depends_on = [aws_vpc_peering_connection_accepter.secondary]
}

resource "aws_route" "secondary_to_primary" {
  provider                  = aws.secondary
  route_table_id            = aws_route_table.public_rt_secondary.id
  destination_cidr_block    = local.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id

  depends_on = [aws_vpc_peering_connection_accepter.secondary]
}