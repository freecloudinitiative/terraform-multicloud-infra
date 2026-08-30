output "vpc_id" {
  value       = aws_vpc.k3s_vpc.id
  description = "The ID of the created AWS VPC"
}

output "secondary_vpc_id" {
  value       = aws_vpc.k3s_vpc_secondary.id
  description = "The ID of the secondary-region VPC used by worker-2"
}

output "external_ips" {
  description = "Public IP addresses for all cluster instances"
  value = merge(
    { for name, instance in aws_instance.master : name => instance.public_ip },
    { for name, instance in aws_instance.worker : name => instance.public_ip },
    { "worker-2" = aws_instance.worker_secondary.public_ip }
  )
}

output "private_ips" {
  description = "Private IP addresses for all cluster instances"
  value = merge(
    { for name, instance in aws_instance.master : name => instance.private_ip },
    { for name, instance in aws_instance.worker : name => instance.private_ip },
    { "worker-2" = aws_instance.worker_secondary.private_ip }
  )
}
