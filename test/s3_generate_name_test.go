package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	"fmt"
	"strconv"

	"github.com/hadenlabs/terraform-aws-s3-bucket/internal/app/external/faker"
	"github.com/hadenlabs/terraform-aws-s3-bucket/internal/testutil"
)

func TestGenerateNameSuccess(t *testing.T) {
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
	generateNameEnabled := true

	allowedBucketActions := []string{
		"s3:GetObject",
		"s3:ListBucket",
		"s3:GetBucketLocation",
	}

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "s3-generate-name",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"namespace":              namespace,
			"stage":                  stage,
			"name":                   name,
			"acl":                    acl,
			"versioning_enabled":     versioningEnabled,
			"force_destroy":          forceDestroy,
			"allowed_bucket_actions": allowedBucketActions,
			"tags":                   tags,
			"use_fullname":           generateNameEnabled,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)
	outputInstance := terraform.Output(t, terraformOptions, "instance")
	assert.NotEmpty(t, outputInstance, outputInstance)
	outputGenerateName, err := strconv.ParseBool(terraform.Output(t, terraformOptions, "use_fullname"))
	if err != nil {
		panic(err)
	}
	assert.True(t, outputGenerateName)
	outputID := terraform.Output(t, terraformOptions, "bucket_id")
	assert.Equal(t, outputID, fmt.Sprintf("%s-%s-%s", namespace, stage, name))
}
