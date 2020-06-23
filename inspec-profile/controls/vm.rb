# vm.rb

title "Check VMs"

gcp_project_id = attribute("gcp_project_id")
gcp_zone = "us-central1-a"

control 'vm' do
  title "Check VMs"
  desc "Check all VMs (fast surface check)"

  describe google_compute_instances(project: gcp_project_id, zone: gcp_zone) do
      its('count') { should be == 1 }
  end

  describe google_compute_instance(project: gcp_project_id, zone: gcp_zone, name: 'nonexistent') do
    it { should_not exist }
  end

end