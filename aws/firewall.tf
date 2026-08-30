resource "aws_security_group" "allow_web" {
  name        = "allow-web"
  description = "Allow HTTP and HTTPS traffic"
  vpc_id      = aws_vpc.k3s_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_k3s_api_from_local" {
  name        = "allow-k3s-api-from-local"
  description = "Allow k3s API access from admin IPs"
  vpc_id      = aws_vpc.k3s_vpc.id

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = local.admin_ip_ranges
  }
}

resource "aws_security_group" "allow_k3s_internal" {
  name        = "allow-k3s-internal"
  description = "Allow k3s internal traffic"
  vpc_id      = aws_vpc.k3s_vpc.id

  ingress {
    from_port   = 6443
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 8472
    to_port     = 8472
    protocol    = "udp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}

resource "aws_security_group" "k3s_allow_icmp" {
  name        = "k3s-allow-icmp"
  description = "Allow ICMP from anywhere"
  vpc_id      = aws_vpc.k3s_vpc.id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "k3s_allow_internal" {
  name        = "k3s-allow-internal"
  description = "Allow internal traffic on the k3s network"
  vpc_id      = aws_vpc.k3s_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }
}

resource "aws_security_group" "k3s_allow_ssh" {
  name        = "k3s-allow-ssh"
  description = "Allow SSH from admin IP ranges"
  vpc_id      = aws_vpc.k3s_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.admin_ip_ranges
  }
}

# General Egress rule attached to all instances via a combined SG below or explicitly here
resource "aws_security_group" "k3s_egress" {
  name        = "k3s-egress"
  description = "Allow all outbound traffic"
  vpc_id      = aws_vpc.k3s_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
