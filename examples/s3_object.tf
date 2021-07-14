resource "aws_s3_bucket_object" "sagemaker_model" {
  bucket = data.aws_s3_bucket.computer_vision.id
  key    = "/v1.0.0/model.tar.gz"
  source = "userdata/sagemaker/model/model.tar.gz"
  etag   = filemd5("userdata/sagemaker/model/model.tar.gz")
}

resource "aws_s3_bucket_object" "notebook" {
  bucket = data.aws_s3_bucket.computer_vision.id
  key    = "/sagemaker/sample/notebooks/Scikit-learn_Estimator_Example_With_Terraform.ipynb"
  source = "userdata/sagemaker/notebook/scikit/Scikit-learn_Estimator_Example_With_Terraform.ipynb"
  etag   = filemd5("userdata/sagemaker/notebook/scikit/Scikit-learn_Estimator_Example_With_Terraform.ipynb")
}

resource "aws_s3_bucket_object" "scripts" {
  bucket = data.aws_s3_bucket.computer_vision.id
  key    = "/sagemaker/sample/scripts/scikit_learn_script.py"
  source = "userdata/sagemaker/notebook/scikit/scripts/scikit_learn_script.py"
  etag   = filemd5("userdata/sagemaker/notebook/scikit/scripts/scikit_learn_script.py")
}

resource "aws_s3_bucket_object" "data" {
  bucket = data.aws_s3_bucket.computer_vision.id
  key    = "/sagemaker-bucket-sample-test/sagemaker/sample/boston_housing.csv"
  source = "userdata/sagemaker/notebook/scikit/scripts/boston_housing.csv"
  etag   = filemd5("userdata/sagemaker/notebook/scikit/scripts/boston_housing.csv")
}

