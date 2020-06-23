all:


lint: lint-tflint
test: test-inspec
lint-and-test: lint test


# Inspec: check syntax (time: 15 sec)
lint-inspec:
	time inspec check inspec-profile

# xtest-vm: fast test, only "vm" section, x=local only (not CI)
xtest-vm:
	ARGS='--controls /vm/' make test-inspec

# test-inspec: check resources with Inspec (time: 1 minute)
test-inspec:
	time inspec exec inspec-profile -t gcp:// \
	--input-file inspec-profile/attributes.yml $(ARGS)

# Tflint: check Terraform for syntax and usage
# LOCAL INSTALL: brew install tflint
lint-tflint lint-tflint-local:
	build/run-tflint.sh

# dev -- local developer tools, creating a fast dev/test loop
# dev-lint -- run lint when TF files change
# dev-test -- check resources with Inspec when files change (X: VM tests only)
#
.PHONY: .watch.txt
.watch.txt:
	git ls-files *.tf cloudbuild.yaml | xargs -n1 echo > $@

dev-lint: .watch.txt
	entr < .watch.txt -c make lint
dev-test: .watch.txt
	entr < .watch.txt -c make xtest-vm
		
validate:
	cd environments/staging ; terraform validate
	
# cb-dryrun -- check using local CloudBuild on change (dry run, no resources updated)
# cb-apply -- use CloudBuild to change resources & validate on change
#
SOURCE:=.

cb-dryrun:
	cloud-build-local --dryrun=true $(SOURCE)

cb-apply:
	cloud-build-local --dryrun=false $(SOURCE)


