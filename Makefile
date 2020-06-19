# 
#
# SIMPLE + FAST
# ls -1 inspec-profile/controls/*.rb | entr -c inspec exec inspec-profile -t gcp:// --input-file inspec-profile/attributes.yml --controls /vm/

SOURCE:=--no-source

all:


lint: lint-tflint

# inspec: check syntax (time: 15 sec)
lint-inspec:
	time inspec check inspec-profile

# tflint: check Terraform for syntax and usage
# LOCAL INSTALL: brew install tflint
lint-tflint-local:
	find [a-z]* -type d | xargs -n1 tflint
lint-tflint-docker:
	find [a-z]* -type d | xargs -n1 docker run --rm -v $$(pwd):/data -t wata727/tflint

xtest-vm:
	ARGS='--controls /vm/' make test

test:
	time inspec exec inspec-profile -t gcp:// \
	--input-file inspec-profile/attributes.yml $(ARGS)

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


