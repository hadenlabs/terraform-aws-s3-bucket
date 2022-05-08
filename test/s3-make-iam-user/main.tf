module "main" {
  source                 = "../.."
  acl                    = var.acl
  allowed_bucket_actions = var.allowed_bucket_actions
  force_destroy          = var.force_destroy
  use_fullname           = var.use_fullname
  namespace              = var.namespace
  stage                  = var.stage
  tags                   = var.tags
  user_enabled           = var.user_enabled
  versioning_enabled     = var.versioning_enabled
  name                   = var.name
}
