locals {
  all_masters = {
    "master-1" = {
      size   = var.instance_size
      region = var.region
    }
    "master-2" = {
      size   = var.instance_size
      region = var.region
    }
    "master-3" = {
      size   = var.instance_size
      region = var.region
    }
  }

  masters = var.cluster_mode == "simple" ? {
    "master-1" = local.all_masters["master-1"]
  } : local.all_masters

  workers = {
    "worker-1" = {
      size   = var.instance_size
      region = var.region
    }
    "worker-2" = {
      size   = var.instance_size
      region = var.region
    }
    "worker-3" = {
      size   = var.instance_size
      region = var.region
    }
  }

  admin_ip_ranges = var.admin_ip_ranges
}
