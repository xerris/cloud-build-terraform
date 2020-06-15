module "common_shared_module" {
  source            = "../../modules"
}
module "vm"{
  source  = "../../modules/vm"
}