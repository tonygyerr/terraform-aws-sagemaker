# variable "sagemaker_role_arn" {
#   type = string
# }

variable "sagemaker_instance_init_file" {
  type = string
  default = ""
}

variable "sagemaker_ecr_name" {
  type = string
}

variable "sagemaker_model_name" {
  type = string
}

variable "sagemaker_endpoint_cfg_name" {
  type = string
}

variable "sagemaker_endpoint_name" {
  type = string
}

variable "ml_instance_type" {
  type = string
}

variable "initial_instance_count" {
  type = string
}

variable "initial_variant_weight" {
  type = string
}

variable "bucket_name" {
  type    = string
  default = ""
}

variable "sagemaker_notebook_name" {
  type    = string
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

variable "acn_tags" {
  type        = map(string)
  description = "optional tags"

  default = {}
}

variable "tags" {
  type        = map(string)
  description = "optional tags"

  default = {}
}

variable "app_name" {
  type        = string
  description = "Application Name"
  default     = ""
}