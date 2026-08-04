output "master_ips" {
  value = {
    for name, instance in google_compute_instance.master : name => {
      internal_ip = instance.network_interface[0].network_ip
      external_ip = instance.network_interface[0].access_config[0].nat_ip
    }
  }
  description = "The internal and external IP addresses of the master nodes"
}

output "worker_ips" {
  value = {
    for name, instance in google_compute_instance.worker : name => {
      internal_ip = instance.network_interface[0].network_ip
      external_ip = instance.network_interface[0].access_config[0].nat_ip
    }
  }
  description = "The internal and external IP addresses of the worker nodes"
}
