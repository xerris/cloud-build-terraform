# Cloud Build for Terraform

A simple starter kit for running your terraform code on every checkin.

## Environment per branch

The example has a master and staging environment, but you can have as many branches and environments as you
want to automatically deploy to

## Gotchas

Currently this template only uses auto-approve on the `terraform apply` so when you setup your branch 
tiggers in GCP make sure you only trigger builds to branches you want to automatically apply.

A work around for manually looking at terraform plan output is not developed yet in this example.


# Setup your Project

1. Clone this repo and change the project name in all the environments folders main.tf
2. checkin your code
3. setup your GCP Project and and enable Cloud Build
4. setup your google build account to read from your repo
5. setup a trigger to master on every checking
6. test your deployment by going to /environments/master and typing `terraform plan`
7. check your changes  into master and watch it deploy
