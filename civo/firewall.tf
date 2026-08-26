data "civo_network" "custom" {
  count = var.network_id == "" ? 0 : 1
  id    = var.network_id
}

resource "civo_firewall" "k3s_firewall" {
  name                 = "k3s-cluster-firewall"
  network_id           = var.network_id == "" ? null : data.civo_network.custom[0].id
  create_default_rules = false

  ingress_rule {
    label      = "allow-ssh"
    action     = "allow"
    protocol   = "tcp"
    port_range = "22"
    cidr       = local.admin_ip_ranges
  }

  ingress_rule {
    label      = "allow-k3s-api"
    action     = "allow"
    protocol   = "tcp"
    port_range = "6443"
    cidr       = local.admin_ip_ranges
  }

  ingress_rule {
    label      = "allow-web-http"
    action     = "allow"
    protocol   = "tcp"
    port_range = "80"
    cidr       = ["0.0.0.0/0"]
  }

  ingress_rule {
    label      = "allow-web-https"
    action     = "allow"
    protocol   = "tcp"
    port_range = "443"
    cidr       = ["0.0.0.0/0"]
  }

  egress_rule {
    label      = "all-tcp"
    action     = "allow"
    protocol   = "tcp"
    port_range = "1-65535"
    cidr       = ["0.0.0.0/0"]
  }

  egress_rule {
    label      = "all-udp"
    action     = "allow"
    protocol   = "udp"
    port_range = "1-65535"
    cidr       = ["0.0.0.0/0"]
  }
}
