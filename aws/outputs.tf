output "vpc_id" {
  value       = aws_vpc.k3s_vpc.id
  description = "The ID of the created AWS VPC"
}

output "secondary_vpc_id" {
  value       = aws_vpc.k3s_vpc_secondary.id
  description = "The ID of the secondary-region VPC used by worker-2, worker-3, and worker-4"
}

output "external_ips" {
  description = "Public IP addresses for all cluster instances"
  value       = { for name, instance in local.instances : name => instance.public_ip }
}

output "private_ips" {
  description = "Private IP addresses for all cluster instances"
  value       = { for name, instance in local.instances : name => instance.private_ip }
}

output "regions" {
  description = "AWS region for each cluster instance"
  value       = { for name, instance in local.instances : name => instance.region }
}

output "engines" {
  description = "Instance type (engine) for each cluster instance"
  value       = { for name, instance in local.instances : name => instance.engine }
}

output "instances" {
  description = "Cluster instances with IPs, region, and engine"
  value       = local.instances
}
