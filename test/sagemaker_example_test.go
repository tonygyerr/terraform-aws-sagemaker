package test

import (
	"fmt"
	"log"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the Terraform module in examples/terraform-aws-sagemaker-example using Terratest.
func TestTerraformLambdaExample(t *testing.T) {
	t.Parallel()

	targetRegions := []string{"us-east-1"}

	awsRegion := aws.GetRandomStableRegion(t, nil, nil)
	dir, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(dir)
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples",
		// Variables to pass to our Terraform code using -var options
		VarFiles: []string{"../env-config/dev.tfvars"},
		NoColor:  false,

		// Environment variables to set when running Terraform
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	planOut := terraform.InitAndPlan(t, terraformOptions)

	assert.Contains(t, planOut, "aws_s3_bucket_object.data will be created")
	assert.Contains(t, planOut, "aws_s3_bucket_object.notebook will be created")
	assert.Contains(t, planOut, "aws_s3_bucket_object.sagemaker_model will be created")
	assert.Contains(t, planOut, "aws_s3_bucket_object.scripts will be created")
	assert.Contains(t, planOut, "module.sagemaker.aws_iam_policy.this will be created")
	assert.Contains(t, planOut, "module.sagemaker.aws_iam_role.this will be created")
	assert.Contains(t, planOut, "module.sagemaker.aws_iam_role_policy_attachment.sagemaker_full_access will be created")
	assert.Contains(t, planOut, "module.sagemaker.aws_iam_role_policy_attachment.sagemaker_ground_truth will be created")
	assert.Contains(t, planOut, "module.sagemaker.aws_iam_role_policy_attachment.this will be created")
	assert.Contains(t, planOut, "module.sagemaker.aws_sagemaker_endpoint.this will be created")
	assert.Contains(t, planOut, "module.sagemaker.aws_sagemaker_endpoint_configuration.this will be created")
	assert.Contains(t, planOut, "module.sagemaker.aws_sagemaker_model.this will be created")
	assert.Contains(t, planOut, "module.sagemaker.aws_sagemaker_notebook_instance.this will be created")
	assert.Contains(t, planOut, "module.sagemaker.aws_sagemaker_notebook_instance_lifecycle_configuration.this will be created")
	assert.Contains(t, planOut, "Plan: 14 to add, 0 to change, 0 to destroy.")
}
