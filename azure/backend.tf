terraform {
  backend "gcs" {
    prefix = "terraform/state/azure"
  }
}
