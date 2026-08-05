variable "gcp_project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "region" {
  type        = string
  description = "The GCP region to deploy resources into"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "The GCP zone to deploy resources into"
  default     = "us-central1-a"
}

variable "gcp_admin_ip_ranges" {
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
