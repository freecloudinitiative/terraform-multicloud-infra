resource "google_compute_firewall" "allow_web" {
  name     = "allow-web"
  network  = google_compute_network.k3s_vpc.name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_k3s_api_from_local" {
  name     = "allow-k3s-api-from-local"
  network  = google_compute_network.k3s_vpc.name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["6443"]
  }

  source_ranges = local.admin_ip_ranges
}

resource "google_compute_firewall" "allow_k3s_internal" {
  name     = "allow-k3s-internal"
  network  = google_compute_network.k3s_vpc.name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["6443-10250"]
  }

  allow {
    protocol = "udp"
    ports    = ["8472"]
  }

  source_ranges = ["10.128.0.0/20"]
}

resource "google_compute_firewall" "k3s_allow_icmp" {
  name        = "k3s-allow-icmp"
  network     = google_compute_network.k3s_vpc.name
  priority    = 65534
  description = "Allow ICMP from anywhere"

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "k3s_allow_internal" {
  name        = "k3s-allow-internal"
  network     = google_compute_network.k3s_vpc.name
  priority    = 65534
  description = "Allow internal traffic on the k3s network"

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.128.0.0/9"]
}

resource "google_compute_firewall" "k3s_allow_ssh" {
  name        = "k3s-allow-ssh"
  network     = google_compute_network.k3s_vpc.name
  priority    = 65534
  description = "Allow SSH from admin IP ranges"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = local.admin_ip_ranges
}
