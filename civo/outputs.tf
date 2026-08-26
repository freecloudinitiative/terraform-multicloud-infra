output "external_ips" {
  description = "Public IP addresses for all cluster instances"
  value = merge(
    { for name, instance in civo_instance.master : name => instance.public_ip },
    { for name, instance in civo_instance.worker : name => instance.public_ip }
  )
}

output "private_ips" {
  description = "Private IP addresses for all cluster instances"
  value = merge(
    { for name, instance in civo_instance.master : name => instance.private_ip },
    { for name, instance in civo_instance.worker : name => instance.private_ip }
  )
}
