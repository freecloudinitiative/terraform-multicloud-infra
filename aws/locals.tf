locals {
  all_masters = {
    "master-1" = {
      instance_type     = "t4g.large"
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

  # worker-1 stays in the primary region; worker-2, worker-3, and worker-4
  # live in the secondary region so us-east-1 is not asked to launch more
  # instances while it is blocked by PendingVerification.
  workers = {
    "worker-1" = {
      instance_type     = "t4g.xlarge"
      availability_zone = "${var.aws_region}a"
    }
  }

  workers_secondary = {
    "worker-2" = {
      instance_type     = "t4g.medium"
      availability_zone = "${var.aws_secondary_region}a"
    }
    "worker-3" = {
      instance_type     = "t4g.medium"
      availability_zone = "${var.aws_secondary_region}c"
    }
    "worker-4" = {
      instance_type     = "t4g.medium"
      availability_zone = "${var.aws_secondary_region}b"
    }
  }

  secondary_azs = [
    "${var.aws_secondary_region}a",
    "${var.aws_secondary_region}b",
    "${var.aws_secondary_region}c",
  ]

  vpc_cidr           = "10.0.0.0/16"
  secondary_vpc_cidr = "10.1.0.0/16"
  cluster_cidrs      = [local.vpc_cidr, local.secondary_vpc_cidr]

  admin_ip_ranges = var.aws_admin_ip_ranges

  instances = merge(
    {
      for name, instance in aws_instance.master : name => {
        public_ip         = instance.public_ip
        private_ip        = instance.private_ip
        region            = var.aws_region
        availability_zone = instance.availability_zone
        engine            = instance.instance_type
      }
    },
    {
      for name, instance in aws_instance.worker : name => {
        public_ip         = instance.public_ip
        private_ip        = instance.private_ip
        region            = var.aws_region
        availability_zone = instance.availability_zone
        engine            = instance.instance_type
      }
    },
    {
      for name, instance in aws_instance.worker_secondary : name => {
        public_ip         = instance.public_ip
        private_ip        = instance.private_ip
        region            = var.aws_secondary_region
        availability_zone = instance.availability_zone
        engine            = instance.instance_type
      }
    }
  )
}
