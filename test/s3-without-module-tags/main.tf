module "main" {
  source                 = "../.."
  name                   = var.name
  stage                  = var.stage
  namespace              = var.namespace
  acl                    = var.acl
  versioning_enabled     = var.versioning_enabled
  force_destroy          = var.force_destroy
  allowed_bucket_actions = var.allowed_bucket_actions
}
