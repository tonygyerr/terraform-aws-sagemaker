app_name                    = "app"
sagemaker_model_name        = "app-sagemaker"
sagemaker_notebook_name     = "sagemaker-notebook-example"
sagemaker_endpoint_cfg_name	= "app-sagemaker"
sagemaker_endpoint_name	    = "sagemakerml-endpoint"  	
# sagemaker_role_arn          = "arn:aws:iam::123456789012:role/app-sagemaker-role"
ml_instance_type            = "ml.t2.medium"
initial_instance_count      = "1"
initial_variant_weight      = "1"
bucket_name                 = "echo-workstream-dev-bucket"
sagemaker_ecr_name          = "sagemaker-ecr:v1"

tags = {
  Environment = "dev"
  Name        = "app"
  Region      = "us-east-1"
  Owner       = "app"
  CostCenter  = "fatm"
}