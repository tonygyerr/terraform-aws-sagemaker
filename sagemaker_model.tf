resource "aws_sagemaker_model" "this" {
  name               = var.sagemaker_model_name
  execution_role_arn = data.aws_iam_role.sagemaker.arn #aws_iam_role.this.arn
  primary_container {
    image          = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.sagemaker_ecr_name}" #data.aws_ecr_repository.name
    model_data_url = "https://${data.aws_s3_bucket.computer_vision.id}.s3.us-west-2.amazonaws.com/v1.0.0/model.tar.gz"
  }

  tags = merge(map("Name", local.environment_name != local.tf_workspace ? "${local.tf_workspace}-${var.app_name}-model" : "${var.app_name}-model"), merge(var.tags, var. acn_tags))
}