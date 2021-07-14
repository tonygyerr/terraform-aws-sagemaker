resource "aws_sagemaker_notebook_instance" "this" {
  name                  = var.sagemaker_notebook_name
  role_arn              = data.aws_iam_role.sagemaker.arn #aws_iam_role.this.arn
  instance_type         = "ml.t2.medium"
  lifecycle_config_name = aws_sagemaker_notebook_instance_lifecycle_configuration.this.name
}

resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "this" {
  name     = var.sagemaker_notebook_name
  on_start = var.sagemaker_instance_init_file
}

