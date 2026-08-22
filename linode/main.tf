resource "random_password" "root_pass" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "linode_instance" "master" {
  for_each = local.masters

  label      = each.key
  image      = "linode/ubuntu24.04"
  region     = each.value.region
  type       = each.value.type
  private_ip = true
  root_pass  = random_password.root_pass.result

  tags = ["k3s-master", "k3s-cluster"]
}

resource "linode_instance" "worker" {
  for_each = local.workers

  label      = each.key
  image      = "linode/ubuntu24.04"
  region     = each.value.region
  type       = each.value.type
  private_ip = true
  root_pass  = random_password.root_pass.result

  tags = ["k3s-worker", "k3s-cluster"]
}
