        
terraform{
    backend "gcs" {
        bucket         = "tf-state-sandbox-1"
        prefix         = "enrichme-project/sandbox"
    }
}

module "common_shared_module" {
  source            = "../../modules"
}
module "vm"{
  source  = "../../modules/vm"
}