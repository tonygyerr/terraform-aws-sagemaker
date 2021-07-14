# variable "sagemaker_role_arn" {
#   type = string
# }

variable "sagemaker_instance_init_file" {
}

variable "sagemaker_model_name" {
}

variable "sagemaker_ecr_name" {
}

variable "sagemaker_endpoint_cfg_name" {
}

variable "sagemaker_endpoint_name" {
}

variable "ml_instance_type" {
}

variable "initial_instance_count" {
}

variable "initial_variant_weight" {
}

variable "alb_security_policy" {
  description = "alb security policy"

  # type        = string
  default = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "alb_health_check_path" {
  description = "alb health check path"

  # type        = string
  default = "/"
}

variable "alb_health_check_backend_protocol" {
  description = "alb health check backend protocol"
  default     = "HTTP"
}

variable "object_prv_bucket" {
  description = "S3 bucket for storing Sagemaker access logs. Setting this means the module will try to create the bucket."

  # type        = string
  default = ""
}

variable "object_model_prv_bucket" {
  description = "S3 bucket for storing Sagemaker object. Setting this means the module will try to create the bucket."

  # type        = string
  default = ""
}

variable "sagemaker_prv_log_prefix" {
  description = "S3 prefix within the log_bucket under which logs are stored."

  # type        = string
  default = "logs"
}

variable "bucket_name" {
  description = "S3 Bucket to store Sagemaker Notebook"
  # type        = string
  # default     = ""
}

variable "sagemaker_prv_force_destroy_log_bucket" {
  description = "if set to true and if the log bucket already exists, it will be destroyed and recreated."
  default     = "true"
}

variable "tags" {
  # type = map

  default = {}
  # "Name"        = "dev-sagemaker-prv-1-subnet"
  # "environment" = "dev"
  # "project"     = "sagemaker"
  # "role"        = "ml"
}

variable "acn_tags" {
  type        = map(string)
  description = "optional tags"

  default = {}
}

variable "wait_for_capacity_timeout" {
  # type    = string
  default = "10m"
}

variable "sagemaker_notebook_name" {
  default = ""
}

variable "deploy_env_map" {
  type = map
  default = {
    dev = "develop"
    test = "test"
    prod = "prod"
  }
}

variable "app_name" {
  type        = string
  description = "Application Name"
  default     = ""
}