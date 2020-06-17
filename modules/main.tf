    
terraform{
  required_version = "0.12.26"

    backend "gcs" {
        bucket         = var.bucket_name
        prefix         = "$tf-state/{var.project_name}/{var.branch_name}"
    }
}

provider "google" {
  project     = var.project_name
  region      = var.region
  version     = "<= 3.25.0"
}