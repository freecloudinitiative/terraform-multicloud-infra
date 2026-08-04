locals {
  all_masters = {
    "master-1" = {
      machine_type = "t2a-standard-2"
      zone         = "us-central1-a"
    }
    "master-2" = {
      machine_type = "t2a-standard-1"
      zone         = "europe-west4-a"
    }
    "master-3" = {
      machine_type = "t2a-standard-1"
      zone         = "europe-west4-b"
    }
  }

  masters = var.cluster_mode == "simple" ? {
    "master-1" = local.all_masters["master-1"]
  } : local.all_masters

  workers = {
    "worker-1" = {
      machine_type = "t2a-standard-4"
      zone         = "us-central1-a"
    }
    "worker-2" = {
      machine_type = "t2a-standard-2"
      zone         = "us-central1-f"
    }
    "worker-3" = {
      machine_type = "t2a-standard-1"
      zone         = "us-central1-a"
    }
  }

  admin_ip_ranges = var.gcp_admin_ip_ranges
}
