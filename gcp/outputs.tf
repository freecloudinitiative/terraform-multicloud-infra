output "external_ips" {
  value = merge(
    { for name, instance in google_compute_instance.master : name => instance.network_interface[0].access_config[0].nat_ip },
    { for name, instance in google_compute_instance.worker : name => instance.network_interface[0].access_config[0].nat_ip }
  )
}
