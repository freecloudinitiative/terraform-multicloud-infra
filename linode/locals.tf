locals {
  all_masters = {
    "master-1" = {
      type   = "g6-standard-2"
      region = var.region
    }
    "master-2" = {
      type   = "g6-standard-2"
      region = var.region
    }
    "master-3" = {
      type   = "g6-standard-2"
      region = var.region
    }
  }

  masters = var.cluster_mode == "simple" ? {
    "master-1" = local.all_masters["master-1"]
  } : local.all_masters

  workers = {
    "worker-1" = {
      type   = "g6-standard-4"
      region = var.region
    }
    "worker-2" = {
      type   = "g6-standard-2"
      region = var.region
    }
    "worker-3" = {
      type   = "g6-standard-1"
      region = var.region
    }
  }

  admin_ip_ranges = var.admin_ip_ranges
}
