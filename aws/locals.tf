locals {
  all_masters = {
    "master-1" = {
      instance_type     = "t4g.medium"
      availability_zone = "${var.aws_region}a"
    }
    "master-2" = {
      instance_type     = "t4g.small"
      availability_zone = "${var.aws_region}b"
    }
    "master-3" = {
      instance_type     = "t4g.small"
      availability_zone = "${var.aws_region}c"
    }
  }

  masters = var.cluster_mode == "simple" ? {
    "master-1" = local.all_masters["master-1"]
  } : local.all_masters

  workers = {
    "worker-1" = {
      instance_type     = "t4g.xlarge"
      availability_zone = "${var.aws_region}a"
    }
    "worker-2" = {
      instance_type     = "t4g.medium"
      availability_zone = "${var.aws_region}b"
    }
    "worker-3" = {
      instance_type     = "t4g.small"
      availability_zone = "${var.aws_region}c"
    }
  }

  admin_ip_ranges = var.aws_admin_ip_ranges
}
