output "external_ips" {
  value = merge(
    { for name, instance in linode_instance.master : name => instance.ip_address },
    { for name, instance in linode_instance.worker : name => instance.ip_address }
  )
}
