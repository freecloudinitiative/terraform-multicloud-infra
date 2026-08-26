data "civo_disk_image" "ubuntu" {
  filter {
    key    = "name"
    values = ["ubuntu-jammy"] # Ubuntu 22.04 LTS
  }
}

resource "civo_instance" "master" {
  for_each = local.masters

  hostname    = each.key
  size        = each.value.size
  region      = each.value.region
  disk_image  = data.civo_disk_image.ubuntu.diskimages[0].id
  volume_type = "standard"
  network_id  = var.network_id == "" ? null : data.civo_network.custom[0].id
  firewall_id = civo_firewall.k3s_firewall.id
  sshkey_id   = var.ssh_key_id == "" ? null : var.ssh_key_id
  tags        = ["k3s-master", "k3s-cluster"]
}

resource "civo_instance" "worker" {
  for_each = local.workers

  hostname    = each.key
  size        = each.value.size
  region      = each.value.region
  disk_image  = data.civo_disk_image.ubuntu.diskimages[0].id
  volume_type = "standard"
  network_id  = var.network_id == "" ? null : data.civo_network.custom[0].id
  firewall_id = civo_firewall.k3s_firewall.id
  sshkey_id   = var.ssh_key_id == "" ? null : var.ssh_key_id
  tags        = ["k3s-worker", "k3s-cluster"]
}
