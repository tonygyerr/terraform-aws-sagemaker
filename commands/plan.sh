#!/bin/bash
ENV=$1
AWS_REGION=$2
cd "$(pwd "${0}")/sagemaker" || exit
terraform init -backend-config "backend-config/${ENV}.tfvars"
terraform plan -var-file="env-config/${ENV}.tfvars"