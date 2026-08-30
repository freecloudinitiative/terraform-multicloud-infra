data "aws_ami" "ubuntu_arm64" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-server-*"]
  }
}

data "aws_ami" "ubuntu_arm64_secondary" {
  provider    = aws.secondary
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-server-*"]
  }
}

resource "aws_instance" "master" {
  for_each      = local.masters
  ami           = data.aws_ami.ubuntu_arm64.id
  instance_type = each.value.instance_type
  subnet_id     = aws_subnet.k3s_subnet[each.value.availability_zone].id

  vpc_security_group_ids = [aws_security_group.k3s_node.id]

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }

  tags = {
    Name = each.key
  }
}

resource "aws_instance" "worker" {
  for_each      = local.workers
  ami           = data.aws_ami.ubuntu_arm64.id
  instance_type = each.value.instance_type
  subnet_id     = aws_subnet.k3s_subnet[each.value.availability_zone].id

  vpc_security_group_ids = [aws_security_group.k3s_node.id]

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }

  tags = {
    Name = each.key
  }
}

resource "aws_instance" "worker_secondary" {
  provider      = aws.secondary
  ami           = data.aws_ami.ubuntu_arm64_secondary.id
  instance_type = local.worker_secondary.instance_type
  subnet_id     = aws_subnet.k3s_subnet_secondary.id

  vpc_security_group_ids = [aws_security_group.k3s_node_secondary.id]

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }

  tags = {
    Name = "worker-2"
  }
}
