variable "aws_region" {
  type        = string
  description = "The AWS region to deploy resources into"
  default     = "us-east-1"
}

variable "aws_admin_ip_ranges" {
  type        = list(string)
  description = "IP ranges allowed to access administrative services (usually your public IP, you can find it using 'curl ifconfig.me')"
  default     = ["0.0.0.0/0"]
}

variable "cluster_mode" {
  type        = string
  description = "Cluster mode: 'simple' (1 master) or 'HA' (3 masters)"
  default     = "simple"

  validation {
    condition     = contains(["simple", "HA"], var.cluster_mode)
    error_message = "cluster_mode must be either 'simple' or 'HA'."
  }
}
