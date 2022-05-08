module "tags" {
  source    = "hadenlabs/tags/null"
  version   = ">=0.2"
  namespace = local.outputs.namespace
  stage     = local.outputs.stage
  name      = local.outputs.name
  tags      = local.outputs.tags
}

locals {
  input = {
    acl                    = var.acl
    tags                   = var.tags
    force_destroy          = var.force_destroy
    versioning_enabled     = var.versioning_enabled
    allowed_bucket_actions = var.allowed_bucket_actions
    name                   = var.name
    namespace              = var.namespace
    stage                  = var.stage
    enabled                = var.enabled
    use_fullname           = var.use_fullname
    user_enabled           = var.user_enabled
    allowed_bucket_actions = var.allowed_bucket_actions
  }
}

locals {
  generated = {
    acl                    = local.input.acl
    tags                   = local.input.tags
    force_destroy          = local.input.force_destroy
    versioning_enabled     = local.input.versioning_enabled
    allowed_bucket_actions = local.input.allowed_bucket_actions
    name                   = local.input.name
    namespace              = local.input.namespace
    stage                  = local.input.stage
    enabled                = local.input.enabled
    use_fullname           = local.input.use_fullname
    user_enabled           = local.input.user_enabled
    allowed_bucket_actions = local.input.allowed_bucket_actions
  }
}

locals {
  outputs = {
    acl                    = local.generated.acl
    tags                   = local.generated.tags
    force_destroy          = local.generated.force_destroy
    versioning_enabled     = local.generated.versioning_enabled
    allowed_bucket_actions = local.generated.allowed_bucket_actions
    name                   = local.generated.name
    namespace              = local.generated.namespace
    stage                  = local.generated.stage
    enabled                = local.generated.enabled
    use_fullname           = local.generated.use_fullname
    user_enabled           = local.generated.user_enabled
    allowed_bucket_actions = local.generated.allowed_bucket_actions
  }
}

resource "aws_s3_bucket" "this" {
  count = local.outputs.enabled ? 1 : 0

  depends_on = [
    module.tags,
  ]
  bucket        = local.outputs.use_fullname ? module.tags.id_full : local.outputs.name
  acl           = local.outputs.acl
  force_destroy = local.outputs.force_destroy
  tags          = module.tags.tags

  dynamic "versioning" {
    for_each = local.outputs.versioning_enabled ? [true] : []
    content {
      enabled = true
    }
  }
}

module "s3_user" {
  source       = "hadenlabs/iam-s3-user/aws"
  version      = ">=0.1"
  enabled      = local.outputs.enabled && local.outputs.user_enabled
  s3_actions   = local.outputs.allowed_bucket_actions
  s3_resources = ["${join("", aws_s3_bucket.this.*.arn)}/*", join("", aws_s3_bucket.this.*.arn)]
  name         = local.outputs.name
  stage        = local.outputs.stage
  namespace    = local.outputs.namespace
  use_fullname = local.outputs.use_fullname
  tags         = local.outputs.tags
}
