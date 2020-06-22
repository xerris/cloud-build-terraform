# 
#

SOURCE:=--no-source

all:


lint: lint-tflint

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


dev:
	find inspec-profile/ -type f | entr -c make test
xdev:
	find inspec-profile/ -type f | entr -c make xtest-vm
		
validate:
	cd environments/staging ; terraform validate
	
dryrun:
	cloud-build-local --dryrun=true $(SOURCE)

build:
	cloud-build-local --dryrun=false $(SOURCE)


