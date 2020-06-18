# global.rb

title 'SSH always disabled -- Loop over all GCP projects and look at firewalls in INGRESS direction'

control 'gcp-projects-firewalls-loop-1.0' do

  impact 1.0
  title 'Ensure INGRESS firewalls in all projects have the correct properties using google_compute_firewall for detail.'

  google_projects.project_names.each do |project_name|
    google_compute_firewalls(project: project_name).where(firewall_direction: 'INGRESS').firewall_names.each do |firewall_name|
      describe google_compute_firewall(project: project_name, name: firewall_name) do
        its('allowed_ssh?')  { should be false }
      end
    end
  end
end