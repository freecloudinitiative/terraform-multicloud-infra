output "network_name" {
  value       = google_compute_network.k3s_vpc.name
  description = "The name of the VPC network"
}

output "network_id" {
  value       = google_compute_network.k3s_vpc.id
  description = "The ID of the VPC network"
}
