resource "google_compute_instance" "master" {
  for_each     = local.masters
  name         = each.key
  machine_type = each.value.machine_type
  zone         = each.value.zone

  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-arm64"
      size  = 50
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = google_compute_network.k3s_vpc.name
    access_config {}
  }
}

resource "google_compute_instance" "worker" {
  for_each     = local.workers
  name         = each.key
  machine_type = each.value.machine_type
  zone         = each.value.zone

  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-arm64"
      size  = 50
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = google_compute_network.k3s_vpc.name
    access_config {}
  }
}
