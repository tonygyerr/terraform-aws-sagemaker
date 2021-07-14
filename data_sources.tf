data "aws_s3_bucket" "computer_vision" {
  bucket = "echo-workstream-dev-bucket"
}

# data "aws_ecr_repository" "service" {
#   name = "sagemaker_ecr:v1"
# }

data "aws_iam_role" "sagemaker" {
  name = "${var.app_name}-sagemaker-role"
}

# data "aws_iam_policy" "sagemaker_full_access" {
#   arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
# }

# data "aws_iam_policy" "sagemaker_ground_truth" {
#   arn = "arn:aws:iam::aws:policy/AmazonSageMakerGroundTruthExecution"
# }

