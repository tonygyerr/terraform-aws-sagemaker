## Module Sagemaker

```hcl
data "template_file" "instance_init" {
  template = file("${path.module}/userdata/sagemaker/notebook/scikit/scripts/sagemaker_instance_init.sh")

  vars = {
    bucket_name = data.aws_s3_bucket.computer_vision.id #var.bucket_name
  }
}

module "sagemaker" {
  source                      = "git::sshh://git@github.com:tonygyerr/terraform-aws-sagemaker.git"
  bucket_name                   = data.aws_s3_bucket.computer_vision.id
  initial_instance_count        = var.initial_instance_count
  initial_variant_weight        = var.initial_variant_weight
  ml_instance_type              = var.ml_instance_type
  sagemaker_ecr_name            = var.sagemaker_ecr_name
  sagemaker_endpoint_cfg_name   = var.sagemaker_endpoint_cfg_name
  sagemaker_endpoint_name       = var.sagemaker_endpoint_name
  sagemaker_instance_init_file  = base64encode(data.template_file.instance_init.rendered)
  sagemaker_model_name          = var.sagemaker_model_name
  sagemaker_notebook_name       = var.sagemaker_notebook_name
}

```

## Prerequisites
- Docker (for using Docker Image of dependencies)
- Git
- Terraform
- AWS Key pair for Terraform provisioning.
- AWS S3 bucket for remote terraform state file (tfstate)
- AWS Dynamo Database for tfstate table state lock 

## How to run this Module using Terraform Commands
```bash
cd examples
terraform get
terraform init -backend-config ../backend-config/dev.tfvars
terraform plan -var-file="../env-config/dev.tfvars"
terraform apply -var-file="../env-config/dev.tfvars" -auto-approve
terraform destroy -var-file="../env-config/dev.tfvars"
```

## How to Run this Module using Makefile Process
```bash
make auth
make get
make init
make plan
make apply
```

## How to build dockerfile 
<!-- ** Note You can create a repository using the AWS CLI. We have developed a Terraform ECR Module as well.
```bash
aws ecr create-repository --repository-name sagemaker-ecr
``` -->
1. Build your Docker Image
```bash
cd docker/Dockerfile
docker build -f Dockerfile -t sagemaker-ecr:v1 .
```
## How to build Dockerfile using Makefile process
```bash
make docker-build
```

## How to deploy Docker Container
```bash
docker run sagemaker-ecr:v1 /bin/bash
```

## How to Authenticate against AWS ECR
1. Authenticate against the AWS ECR
```bash
aws ecr get-login --no-include-email --region us-east-1
```
2. You will see a long string of output like below
```
docker login -u AWS -p eyJwYXlsb2Fk***************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
```
3. Run the output command to log in to docker ECR
```bash
docker login -u AWS -p eyJwYXlsb2FkIjoicHVac1R6WVQxZGRsaX************************
```

### How to commit docker container and push Image to AWS ECR
```bash
docker commit -m "sagemaker-ecr" -a "stanley.petaway" 9e2e7ad50b82 "123456789012.dkr.ecr.us-east-1.amazonaws.com/sagemaker-ecr:v1"
docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/sagemaker-ecr:v1
```

### Docker Maintenance Commands
```bash
docker rm $(docker ps -a -q)
docker system prune -a --volumes
```

## Requirements

| Name | Version |
|------|---------|
| aws | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alb\_health\_check\_backend\_protocol | alb health check backend protocol | `string` | `"HTTP"` | no |
| alb\_health\_check\_path | alb health check path | `string` | `"/"` | no |
| alb\_security\_policy | alb security policy | `string` | `"ELBSecurityPolicy-TLS-1-2-2017-01"` | no |
| bucket\_name | S3 Bucket to store Sagemaker Notebook | `string` | `""` | no |
| expiration\_days | number of days to expunge the objects | `string` | `"90"` | no |
| glacier\_transition\_days | number of days to move data to the glacier storage tier | `string` | `"60"` | no |
| initial\_instance\_count | n/a | `string` | n/a | yes |
| initial\_variant\_weight | n/a | `string` | n/a | yes |
| lifecycle\_rule\_enabled | enable lifecycle events on bucket | `string` | `"true"` | no |
| ml\_instance\_type | n/a | `string` | n/a | yes |
| noncurrent\_version\_expiration\_days | set expiration period for noncurrent object versions | `string` | `"90"` | no |
| noncurrent\_version\_transition\_days | set period for noncurrent object version transitions | `string` | `"30"` | no |
| object\_model\_prv\_bucket | S3 bucket for storing Sagemaker object. Setting this means the module will try to create the bucket. | `string` | `"app-ai-sagemaker-model-bucket"` | no |
| object\_prv\_bucket | S3 bucket for storing Sagemaker access logs. Setting this means the module will try to create the bucket. | `string` | `"sagemaker-prv-log"` | no |
| sagemaker\_endpoint\_cfg\_name | n/a | `string` | n/a | yes |
| sagemaker\_endpoint\_name | n/a | `string` | n/a | yes |
| sagemaker\_model\_name | n/a | `string` | n/a | yes |
| sagemaker\_notebook\_name | n/a | `string` | `""` | no |
| sagemaker\_prv\_force\_destroy\_log\_bucket | if set to true and if the log bucket already exists, it will be destroyed and recreated. | `string` | `"true"` | no |
| sagemaker\_prv\_log\_prefix | S3 prefix within the log\_bucket under which logs are stored. | `string` | `"logs"` | no |
| sagemaker\_role\_arn | n/a | `string` | n/a | yes |
| standard\_transition\_days | number of days to persist in the standard storage tier before moving to the infrequent access tier | `string` | `"30"` | no |
| tags | n/a | `map` | <pre>{<br>  "Name": "dev-sagemaker-prv-1-subnet",<br>  "environment": "dev",<br>  "project": "sagemaker",<br>  "role": "ml"<br>}</pre> | no |
| versioning\_enabled | keep multiple versions of objects within s3 bucket | `string` | `"true"` | no |
| wait\_for\_capacity\_timeout | n/a | `string` | `"10m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| sagemaker\_endpoint\_cfg\_name | n/a |
| sagemaker\_endpoint\_name | n/a |
| sagemaker\_model\_name | n/a |
| sagemaker\_model\_primary\_container\_image | n/a |
| sagemaker\_model\_primary\_container\_model\_data\_url | n/a |
