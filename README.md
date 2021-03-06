# Cloud Build for Terraform

A simple starter kit for running your terraform code on every checkin.

You have two options for how release your environments depending on how you want to work:

1) Environment per tag (recommended)
2) Environment per branch

Which one you pick will determine your developer workflow for getting code into an environment.

## Environment per tag

The example only has master (and feature branches people are working on) and you use a Cloud Build Trigger to work off a regex of new tags. Following semantic versioning your tag specification could be something like:
```
staging-v1.0.0
production-v1.0.0
```

To tag git commits you can do this from your command line, or through tools provided by GitHub, Gitlab, etc:

```
git tag "production-v1.0.0"
git push origin production-v1.0.0
```

This then allows you to just have a tagging convention to release off a single master branch, reducing drift that using a environment per branch causes on a infrastructure as code project.

Your Cloud Build Triggers would look something like:

* sandbox, Push to branch,	`^master$` (inverted)
* staging,	Push to tag,	`^staging-.*$`	
* production, Push to tag, 	`^production-.*$`
	 

## Environment per branch

Each branch builds it's own stateful and isolated environment. master, staging, production become live branches that you can control merge requests into.

This has the advantage of isolation, but adds additional drift in your master->production branches, but also adds  additional approvals and merge requests not required in tag based release schema.


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
