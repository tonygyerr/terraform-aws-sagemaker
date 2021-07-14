module "sagemaker" {
  source                      = "git::ssh://git@github.com:tonygyerr/terraform-aws-sagemaker.git"
  # source = "../"
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
  # sagemaker_endpoint_cfg_name = "${var.app_name}-ground-truth-labeling-cfg-endpoint" #var.sagemaker_endpoint_cfg_name
  # sagemaker_endpoint_name     = "${var.app_name}-ground-truth-labeling-endpoint" #var.sagemaker_endpoint_name
  # sagemaker_notebook_name     = "${var.app_name}-ground-truth-labeling-notebook" #var.sagemaker_notebook_name
  app_name                      = var.app_name
  tags                          = merge(map("Name", local.environment_name != local.tf_workspace ? "${local.tf_workspace}-${var.app_name}-sagemaker" : "${var.app_name}-sagemaker"), merge(var.tags, var. acn_tags))
}