# Data sources for sequential dynamic zone evaluation
data "google_compute_zones" "zone_seq_1" {
  status = "UP"
}

# =====================================================================
# STEP 1: master-1
# =====================================================================
resource "google_compute_instance" "master_1" {
  name         = "master-1"
  machine_type = "t2a-standard-1"
  zone         = data.google_compute_zones.zone_seq_1.names[0]

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

# =====================================================================
# STEP 2: worker-1 (Depends on master-1)
# =====================================================================
data "google_compute_zones" "zone_seq_2" {
  status     = "UP"
  depends_on = [google_compute_instance.master_1]
}

resource "google_compute_instance" "worker_1" {
  name         = "worker-1"
  machine_type = "t2a-standard-1"
  zone         = data.google_compute_zones.zone_seq_2.names[0]

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

# =====================================================================
# STEP 3: worker-2 (Depends on worker-1)
# =====================================================================
data "google_compute_zones" "zone_seq_3" {
  status     = "UP"
  depends_on = [google_compute_instance.worker_1]
}

resource "google_compute_instance" "worker_2" {
  name         = "worker-2"
  machine_type = "t2a-standard-1"
  zone         = data.google_compute_zones.zone_seq_3.names[0]

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

# =====================================================================
# STEP 4: worker-3 (Depends on worker-2)
# =====================================================================
data "google_compute_zones" "zone_seq_4" {
  status     = "UP"
  depends_on = [google_compute_instance.worker_2]
}

resource "google_compute_instance" "worker_3" {
  name         = "worker-3"
  machine_type = "t2a-standard-1"
  zone         = data.google_compute_zones.zone_seq_4.names[0]

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

# =====================================================================
# STEP 5: master-2 (Depends on worker-3)
# =====================================================================
data "google_compute_zones" "zone_seq_5" {
  status     = "UP"
  depends_on = [google_compute_instance.worker_3]
}

resource "google_compute_instance" "master_2" {
  name         = "master-2"
  machine_type = "t2a-standard-1"
  zone         = data.google_compute_zones.zone_seq_5.names[0]

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

# =====================================================================
# STEP 6: master-3 (Depends on master-2)
# =====================================================================
data "google_compute_zones" "zone_seq_6" {
  status     = "UP"
  depends_on = [google_compute_instance.master_2]
}

resource "google_compute_instance" "master_3" {
  name         = "master-3"
  machine_type = "t2a-standard-1"
  zone         = data.google_compute_zones.zone_seq_6.names[0]

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
