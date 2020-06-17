// run this command to check the VM is up and running
output "test_command" {
  value = format("ping -c 1 %s", module.vm.external_ip)
}