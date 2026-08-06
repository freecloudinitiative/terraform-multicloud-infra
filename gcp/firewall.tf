resource "google_compute_firewall" "allow_grafana" {
  name     = "allow-grafana"
  network  = google_compute_network.k3s_vpc.name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["3000"]
  }

  source_ranges = local.admin_ip_ranges
}

resource "google_compute_firewall" "allow_argocd" {
  name     = "allow-argocd"
  network  = google_compute_network.k3s_vpc.name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = local.admin_ip_ranges
}

resource "google_compute_firewall" "allow_prometheus" {
  name     = "allow-prometheus"
  network  = google_compute_network.k3s_vpc.name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["9090"]
  }

  source_ranges = local.admin_ip_ranges
}

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

resource "google_compute_firewall" "allow_gitea" {
  name     = "allow-gitea"
  network  = google_compute_network.k3s_vpc.name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["3001"]
  }

  source_ranges = local.admin_ip_ranges
}

resource "google_compute_firewall" "allow_docker_registry" {
  name     = "allow-docker-registry"
  network  = google_compute_network.k3s_vpc.name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["5000", "5001"]
  }

  source_ranges = local.admin_ip_ranges
}

resource "google_compute_firewall" "allow_kyverno_policy_reporter" {
  name     = "allow-kyverno-policy-reporter"
  network  = google_compute_network.k3s_vpc.name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["8082"]
  }

  source_ranges = local.admin_ip_ranges
}

resource "google_compute_firewall" "allow_openbao" {
  name     = "allow-openbao"
  network  = google_compute_network.k3s_vpc.name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["8200"]
  }

  source_ranges = local.admin_ip_ranges
}


resource "google_compute_firewall" "allow_loki" {
  name     = "allow-loki"
  network  = google_compute_network.k3s_vpc.name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["3100"]
  }

  source_ranges = local.admin_ip_ranges
}

resource "google_compute_firewall" "allow_tempo" {
  name     = "allow-tempo"
  network  = google_compute_network.k3s_vpc.name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["3200"]
  }

  source_ranges = local.admin_ip_ranges
}

resource "google_compute_firewall" "allow_otel_collector" {
  name     = "allow-otel-collector"
  network  = google_compute_network.k3s_vpc.name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["4317", "4318", "8889"]
  }

  source_ranges = local.admin_ip_ranges
}

resource "google_compute_firewall" "allow_alloy" {
  name     = "allow-alloy"
  network  = google_compute_network.k3s_vpc.name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["12345"]
  }

  source_ranges = local.admin_ip_ranges
}


resource "google_compute_firewall" "allow_traefik" {
  name     = "allow-traefik"
  network  = google_compute_network.k3s_vpc.name
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["9000"]
  }

  source_ranges = local.admin_ip_ranges
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

resource "google_compute_firewall" "k3s_allow_rdp" {
  name        = "k3s-allow-rdp"
  network     = google_compute_network.k3s_vpc.name
  priority    = 65534
  description = "Allow RDP from admin IP ranges"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = local.admin_ip_ranges
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
