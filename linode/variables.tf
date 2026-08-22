variable "linode_token" {
  type        = string
  description = "The Linode API token"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "The Linode region to deploy resources into"
  default     = "eu-central"
}

variable "admin_ip_ranges" {
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
