output "vpc_id" {
  value       = aws_vpc.k3s_vpc.id
  description = "The ID of the created AWS VPC"
}
