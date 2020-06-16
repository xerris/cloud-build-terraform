        
terraform{
  required_version = "0.12.26"

    backend "gcs" {
        bucket         = "tf-state-sandbox-1"
        prefix         = "enrichme-project/staging"
    }
}

module "common_shared_module" {
  source            = "../../modules"
}

module "vm"{
  source  = "../../modules/vm"
  vm_name = var.vm_name
}