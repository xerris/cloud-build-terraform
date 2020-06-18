# vm.rb

gcp_project_id = attribute("gcp_project_id")
gcp_zone = "us-central1-a"

control 'vm' do

#     describe google_compute_instance(project: gcp_project_id, zone: gcp_zone) do
#     it { should exist }
# #   its('hostname') { should match 'beer' }
# #   its('name') { should match 'beer' }
# its('machine_type') { should match 'n1-standard-1' }
# its('status') { should match 'RUNNING' }
# #   its('tag_count') { should cmp 1 }
#   its('service_account_scopes') { should include 'https://www.googleapis.com/auth/compute.readonly' }
# #   its('metadata_keys') { should include '123' }
# #   its('metadata_values') { should include 'asdf' }
# end

describe google_compute_instances(project: gcp_project_id, zone: gcp_zone) do
    its('count') { should be == 1 }
end

describe google_compute_instance(project: gcp_project_id, zone: gcp_zone, name: 'nonexistent') do
  it { should_not exist }
end

end