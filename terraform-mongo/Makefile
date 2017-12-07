# Makefile to kick of the terraform for this project
#
# You should set the following environment variable to authenticate
# with AWS so you can store and retrieve the remote state befor you run this Makefile.
#
# export AWS_ACCESS_KEY_ID= <your key>
# export AWS_SECRET_ACCESS_KEY= <your secret>
# export AWS_DEFAULT_REGION= <your bucket region eg ap-southeast-2>
# export TF_VAR_access_key=$AWS_ACCESS_KEY # exposed as access_key in the terraform scripts
# export TF_VAR_secret_key=$AWS_SECRET_ACCESS_KEY
# export TF_VAR_ec2_ami_id =<your ami id>
# export TF_VAR_key_file =<your keypair file>
# export TF_VAR_subnet_id =<your subnetid>
# export TF_VAR_vpc_id =<your vpc id> 
# ####################################################
#
STATEBUCKET = my-statefile-bucket-name
PREFIX = terraform-mongo

# # Before we start test that we have the manditory executables avilable
 EXECUTABLES = git terraform
 K := $(foreach exec,$(EXECUTABLES),\
  $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH, consider apt-get install $(exec)")))
#
#     .PHONY: all s3bucket plan


.PHONY: all plan apply

all: init.txt plan
  echo "All"

plan:
  @echo "running terraform plan"
  terraform plan

apply:
  @echo running terraform apply
  terraform apply
