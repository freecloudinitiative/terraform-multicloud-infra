variable "region" {
  type        = string
  description = "The Civo region to deploy to"
  default     = "FRA1"
}

variable "cluster_mode" {
  type        = string
  description = "Cluster mode: 'simple' (1 master + 3 workers) or 'HA' (3 masters + 3 workers)"
  default     = "simple"

  validation {
    condition     = contains(["simple", "HA"], var.cluster_mode)
    error_message = "cluster_mode must be either 'simple' or 'HA'."
  }
}

variable "instance_size" {
  type        = string
  description = "The Civo instance size"
  default     = "g4s.small"
}

variable "admin_ip_ranges" {
  type        = list(string)
  description = "IP ranges allowed to access administrative services (SSH, K3s API)"
  default     = ["0.0.0.0/0"]
}

variable "network_id" {
  type        = string
  description = "Optional custom network ID. Uses default network if empty."
  default     = ""
}

variable "ssh_key_id" {
  type        = string
  description = "Optional Civo SSH key ID to associate with the instances"
  default     = ""
}
