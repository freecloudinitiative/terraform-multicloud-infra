# Allow ICMP (Ping)
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

# Allow SSH Access
resource "google_compute_firewall" "k3s_allow_ssh" {
  name        = "k3s-allow-ssh"
  network     = google_compute_network.k3s_vpc.name
  priority    = 1000
  description = "Allow SSH access"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
