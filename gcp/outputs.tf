output "master_ips" {
  value = {
    "master-1" = {
      internal_ip = google_compute_instance.master_1.network_interface[0].network_ip
      external_ip = google_compute_instance.master_1.network_interface[0].access_config[0].nat_ip
      zone        = google_compute_instance.master_1.zone
    }
    "master-2" = {
      internal_ip = google_compute_instance.master_2.network_interface[0].network_ip
      external_ip = google_compute_instance.master_2.network_interface[0].access_config[0].nat_ip
      zone        = google_compute_instance.master_2.zone
    }
    "master-3" = {
      internal_ip = google_compute_instance.master_3.network_interface[0].network_ip
      external_ip = google_compute_instance.master_3.network_interface[0].access_config[0].nat_ip
      zone        = google_compute_instance.master_3.zone
    }
  }
  description = "The internal and external IP addresses and zones of the master nodes"
}

output "worker_ips" {
  value = {
    "worker-1" = {
      internal_ip = google_compute_instance.worker_1.network_interface[0].network_ip
      external_ip = google_compute_instance.worker_1.network_interface[0].access_config[0].nat_ip
      zone        = google_compute_instance.worker_1.zone
    }
    "worker-2" = {
      internal_ip = google_compute_instance.worker_2.network_interface[0].network_ip
      external_ip = google_compute_instance.worker_2.network_interface[0].access_config[0].nat_ip
      zone        = google_compute_instance.worker_2.zone
    }
    "worker-3" = {
      internal_ip = google_compute_instance.worker_3.network_interface[0].network_ip
      external_ip = google_compute_instance.worker_3.network_interface[0].access_config[0].nat_ip
      zone        = google_compute_instance.worker_3.zone
    }
  }
  description = "The internal and external IP addresses and zones of the worker nodes"
}
