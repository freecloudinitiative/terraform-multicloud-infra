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

  # worker-2 lives in the secondary region so existing us-east-1 nodes stay put
  # when that region is blocked by PendingVerification.
  workers = {
    "worker-1" = {
      instance_type     = "t4g.xlarge"
      availability_zone = "${var.aws_region}a"
    }
    "worker-3" = {
      instance_type     = "t4g.small"
      availability_zone = "${var.aws_region}c"
    }
  }

  worker_secondary = {
    instance_type     = "t4g.medium"
    availability_zone = "${var.aws_secondary_region}a"
  }

  vpc_cidr           = "10.0.0.0/16"
  secondary_vpc_cidr = "10.1.0.0/16"

  admin_ip_ranges = var.aws_admin_ip_ranges
}
