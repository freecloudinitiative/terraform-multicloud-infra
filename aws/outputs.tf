output "vpc_id" {
  value       = aws_vpc.k3s_vpc.id
  description = "The ID of the created AWS VPC"
}

output "secondary_vpc_id" {
  value       = aws_vpc.k3s_vpc_secondary.id
  description = "The ID of the secondary-region VPC used by worker-2"
}
