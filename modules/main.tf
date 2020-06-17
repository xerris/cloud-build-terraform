terraform {
  required_version = "0.12.26"
}
provider "google" {
  project     = var.project_name
  region      = "us-central1"
  version     = "<= 3.25.0"
}