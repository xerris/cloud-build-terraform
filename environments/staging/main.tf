terraform{
  required_version = "0.12.26"

  backend "gcs" {
      bucket         = "tf-state-sandbox-1"
      prefix         = "tf-state/enrichme-project/staging"
  }
}

module "common_shared_module" {
  source            = "../../modules"
  project_name = var.project_name
  branch_name = var.branch_name
}

module "vm"{
  source  = "../../modules/vm"
  vm_name = var.vm_name
  project_name = var.project_name
}