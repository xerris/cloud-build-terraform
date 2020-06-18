SOURCE:=--no-source

all:

# xdev:
# 	ls ./inspec-profile/controls/vm.rb \
# 	| entr -c inspec exec inspec-profile -t gcp:// \
# 	--controls /vm/ \
# 	--show-progress \
# 	--input-file inspec-profile/attributes.yml
xtest-vm:
	inspec exec inspec-profile -t gcp:// \
	--controls /vm/ \
	--show-progress \
	--input-file inspec-profile/attributes.yml
test:
	inspec exec inspec-profile -t gcp:// --input-file inspec-profile/attributes.yml

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


