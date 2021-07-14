data "template_file" "instance_init" {
  template = file("${path.module}/userdata/sagemaker/notebook/scikit/scripts/sagemaker_instance_init.sh")

  vars = {
    bucket_name = data.aws_s3_bucket.computer_vision.id #var.bucket_name
  }
}