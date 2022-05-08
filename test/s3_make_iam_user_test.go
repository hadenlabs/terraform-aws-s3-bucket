package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	"github.com/hadenlabs/terraform-aws-s3-bucket/internal/app/external/faker"
	"github.com/hadenlabs/terraform-aws-s3-bucket/internal/testutil"
)

func TestMakeIamUserSuccess(t *testing.T) {
	t.Parallel()

	tags := map[string]interface{}{
		"tag1": "tags1",
	}
	namespace := testutil.Company
	stage := testutil.Stage
	name := faker.Bucket().Name()
	acl := "private"
	versioningEnabled := false
	forceDestroy := true
	userEnabled := true

	allowedBucketActions := []string{
		"s3:GetObject",
		"s3:ListBucket",
		"s3:GetBucketLocation",
	}

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "s3-make-iam-user",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"namespace":              namespace,
			"stage":                  stage,
			"name":                   name,
			"user_enabled":           userEnabled,
			"acl":                    acl,
			"versioning_enabled":     versioningEnabled,
			"force_destroy":          forceDestroy,
			"allowed_bucket_actions": allowedBucketActions,
			"tags":                   tags,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)
	outputInstance := terraform.Output(t, terraformOptions, "instance")
	assert.NotEmpty(t, outputInstance, outputInstance)
	outputUserAccessKeyID := terraform.Output(t, terraformOptions, "access_key_id")
	assert.NotEmpty(t, outputUserAccessKeyID, outputUserAccessKeyID)
}
