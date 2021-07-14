.PHONY: all plan apply destroy

all: help

export AWS_PROFILE := iesawsna-sandbox
export ACN_ENTERPRISE_ID := ekow.gyepi-garbrah
export ACN_EMAIL_ADDRESS := ekow.gyepi-garbrah@accenture.com
export ENV := dev
export AWS_REGION := us-east-1
export DYNAMODB_TABLE := terraform-dev-statelock 
export S3_BUCKET := terraform-state-fuse-dev-bucket
export WORKSPACE := /home/jenkins
export DOCKERFILE_PATH := Dockerfile
export DOCKER_IMAGE_NAME := sagemaker-ecr:v1
# export DOCKER_CONTAINER_ID := 4beea4e7e1ba
export DOCKER_CONTAINER_NAME := cv-service

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
help:			## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

auth:	## Authentication
	@echo "[INFO] Running AWS Federation Authentication"
	vip2adfs2aws aws-auth \
		--user-enterprise-id ${ACN_ENTERPRISE_ID} \
		--user-email ${ACN_EMAIL_ADDRESS} \
		--user-aws-role-index 0 \
		--aws-region ${AWS_REGION}
.PHONY: auth

docker-build: # Docker Build
	@echo "[INFO] Creating Docker Build"
	cd docker/; \
	docker build -f ${DOCKERFILE_PATH} -t ${DOCKER_IMAGE_NAME} .
.PHONY: docker-build

docker-login: # Docker Login
	@echo "[INFO] Docker Login"
	aws ecr get-login --no-include-email --region ${AWS_REGION}
.PHONY: docker-login

docker-commit: # Commit Docker Container changes
	@echo "[INFO] Commiting changes to Docker container"
	docker commit -m "${DOCKER_CONTAINER_NAME}" -a "${ACN_ENTERPRISE_ID}" ${DOCKER_CONTAINER_NAME} "868024899531.dkr.ecr.${AWS_REGION}.amazonaws.com/${DOCKER_IMAGE_NAME}"
.PHONY: docker-commit

docker-push: # Push Docker Image to AWS ECR
	@echo "[INFO] Pushing changes to Amazon ECR"
	docker push 868024899531.dkr.ecr.${AWS_REGION}.amazonaws.com/${DOCKER_IMAGE_NAME}
.PHONY: docker-push

clean:			## clean
	@echo "[INFO] Make Clean"	
	rm -rf .terraform \
	rm -rf examples/.terraform
.PHONY: clean

create-s3-bucket:	## Set S3 Bucket
	@echo "[INFO] Creating S3 Bucket for remote state file management"
	aws s3api create-bucket \
		--bucket ${S3_BUCKET} \
		--region ${AWS_REGION} 
.PHONY: create-s3-bucket

put-bucket-policy:	## Put S3 Bucket policy
	@echo "[INFO] Creating function zip files"
	aws s3api put-bucket-policy \
		--bucket ${S3_BUCKET} \
		--region ${AWS_REGION} \
		--policy file://backend/terraform/data/s3/policy/s3-policy/s3_bucket_policy.json
.PHONY: put-bucket-policy

create-dynamodb:	## Set DynamoDB Table
	@echo "[INFO] Setting DynamoDB Table"
	aws dynamodb create-table --region ${AWS_REGION} \
		--table-name ${DYNAMODB_TABLE} \
		--attribute-definitions AttributeName=LockID,AttributeType=S \
		--key-schema AttributeName=LockID,KeyType=HASH \
		--provisioned-throughput ReadCapacityUnits=20,WriteCapacityUnits=20
	@echo "[INFO] Wait 15s to acquire state lock"
	sleep 15s
.PHONY: create-dynamodb

set-iam-role:		## Set IAM Role
	@echo "[INFO] Creating IAM role"
	aws iam create-role --role-name lambda-basic-execution \
		--assume-role-policy-document file://data/s3/policy/s3-policy/lambda_bucket_policy.json \
		--region ${AWS_REGION}
.PHONY: set-iam-role

set-api-id:		## Set REST API ID
	@echo "[INFO] Creating REST API ID"
	aws apigateway create-rest-api --name 'my-rest-api' \
		--region ${AWS_REGION}
.PHONY: set-api-id

fmt:			## Get the Terraform Networking modules.
	@echo "[INFO] Geting Terraform modules"
	terraform fmt -recursive
.PHONY: fmt

get:		## Get the Terraform Sagemaker modules.
	@echo "[INFO] Geting Terraform modules"
	${MAKE} get -C examples/
.PHONY: get-app

init:		## Get the Terraform Sagemaker modules.
	@echo "[INFO] Geting Terraform modules"
	${MAKE} init -C examples/
.PHONY: plan-init

plan:		## Get the Terraform Sagemaker modules.
	@echo "[INFO] Geting Terraform modules"
	${MAKE} plan -C examples/
.PHONY: plan-app

apply:		## Get the Terraform Sagemaker modules.
	@echo "[INFO] Geting Terraform modules"
	${MAKE} apply -C examples/
.PHONY: apply-app

destroy:		## Destroy Terraform Sagemaker modules.
	@echo "[INFO] Destroying Sagemaker Terraform modules"
	${MAKE} destroy -C examples/
.PHONY: plan-app

destroy-backend:	## Destroy S3 bucket and DynamoDB table
	@if ! aws --profile $(AWS_PROFILE) dynamodb delete-table \
		--region $(REGION) \
		--table-name $(DYNAMODB_TABLE) > /dev/null 2>&1 ; then \
			echo "$(BOLD)$(RED)Unable to delete DynamoDB table $(DYNAMODB_TABLE)$(RESET)"; \
	 else
		echo "$(BOLD)$(RED)DynamoDB table $(DYNAMODB_TABLE) does not exist.$(RESET)"; \
	 fi
	@if ! aws --profile $(AWS_PROFILE) s3api delete-objects \
		--region $(REGION) \
		--bucket $(S3_BUCKET) \
		--delete "$$(aws --profile $(AWS_PROFILE) s3api list-object-versions \
						--region $(REGION) \
						--bucket $(S3_BUCKET) \
						--output=json \
						--query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')" > /dev/null 2>&1 ; then \
			echo "$(BOLD)$(RED)Unable to delete objects in S3 bucket $(S3_BUCKET)$(RESET)"; \
	 fi
	@if ! aws --profile $(AWS_PROFILE) s3api delete-objects \
		--region $(REGION) \
		--bucket $(S3_BUCKET) \
		--delete "$$(aws --profile $(AWS_PROFILE) s3api list-object-versions \
						--region $(REGION) \
						--bucket $(S3_BUCKET) \
						--output=json \
						--query='{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}')" > /dev/null 2>&1 ; then \
			echo "$(BOLD)$(RED)Unable to delete markers in S3 bucket $(S3_BUCKET)$(RESET)"; \
	 fi
	@if ! aws --profile $(AWS_PROFILE) s3api delete-bucket \
		--region $(REGION) \
		--bucket $(S3_BUCKET) > /dev/null 2>&1 ; then \
			echo "$(BOLD)$(RED)Unable to delete S3 bucket $(S3_BUCKET) itself$(RESET)"; \
	 fi
.PHONY: destroy-backend
ecr: docker-commit docker-push
all: create-s3-bucket put-bucket-policy create-dynamodb set-iam-role set-api-id fmt plan apply destroy-backend		## Run all #update set-iam-role
.PHONY: create-s3-bucket put-bucket-policy create-dynamodb set-iam-role set-api-id fmt plan apply destroy-backend docker-commit docker-push

