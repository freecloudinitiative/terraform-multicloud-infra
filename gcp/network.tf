resource "google_compute_network" "k3s_vpc" {
  name                                      = "k3s-vpc"
  auto_create_subnetworks                   = true
  routing_mode                              = "GLOBAL"
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
  description                               = "Custom auto-mode network matching default specs"
}

resource "google_compute_router" "nat_router" {
  name    = "k3s-nat-router"
  network = google_compute_network.k3s_vpc.name
  region  = var.region
}

resource "google_compute_router_nat" "nat_gateway" {
  name                               = "k3s-nat-gateway"
  router                             = google_compute_router.nat_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
