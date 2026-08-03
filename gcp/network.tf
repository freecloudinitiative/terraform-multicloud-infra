resource "google_compute_network" "k3s_vpc" {
  name                    = "k3s-vpc"
  auto_create_subnetworks = true
  routing_mode            = "GLOBAL"
  description             = "VPC Network for K3s infrastructure"
}

