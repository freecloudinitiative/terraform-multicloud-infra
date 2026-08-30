# Single SG: AWS allows 5 security groups per ENI by default.
# The previous split (web / api / internal / icmp / ssh / egress) exceeded that limit.
resource "aws_security_group" "k3s_node" {
  name        = "k3s-node"
  description = "k3s node ingress and egress"
  vpc_id      = aws_vpc.k3s_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from admin IPs"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.admin_ip_ranges
  }

  ingress {
    description = "k3s API from admin IPs"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = local.admin_ip_ranges
  }

  ingress {
    description = "ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "All traffic within the VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
