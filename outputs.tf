output "sagemaker_model_name" {
  value = aws_sagemaker_model.this.name
}

output "sagemaker_model_primary_container_image" {
  value = aws_sagemaker_model.this.primary_container[0].image
}

output "sagemaker_model_primary_container_model_data_url" {
  value = aws_sagemaker_model.this.primary_container[0].model_data_url
}

output "sagemaker_endpoint_cfg_name" {
  value = aws_sagemaker_endpoint_configuration.this.name
}

output "sagemaker_endpoint_name" {
  value = aws_sagemaker_endpoint.this.name
}

