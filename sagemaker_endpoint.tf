resource "aws_sagemaker_endpoint_configuration" "this" {
  name = var.sagemaker_endpoint_cfg_name

  production_variants {
    variant_name           = "variant-1"
    model_name             = aws_sagemaker_model.this.name
    initial_instance_count = var.initial_instance_count
    instance_type          = var.ml_instance_type
    initial_variant_weight = var.initial_variant_weight
  }

  tags = {
    Name = "sagemaker-object-endpoint-cfg"
  }
}

resource "aws_sagemaker_endpoint" "this" {
  name                 = var.sagemaker_endpoint_name
  endpoint_config_name = aws_sagemaker_endpoint_configuration.this.name

  tags = {
    Name = "sagemaker-object-endpoint"
  }
}

