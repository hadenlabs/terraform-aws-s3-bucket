module "tags" {
  source    = "hadenlabs/tags/null"
  version   = ">=0.2"
  namespace = var.namespace
  stage     = var.stage
  name      = var.name
  tags      = var.tags
}

module "main" {
  source                 = "../.."
  name                   = module.tags.id_full
  stage                  = var.stage
  namespace              = var.namespace
  acl                    = var.acl
  versioning_enabled     = var.versioning_enabled
  force_destroy          = var.force_destroy
  allowed_bucket_actions = var.allowed_bucket_actions
  tags                   = module.tags.tags
  depends_on = [
    module.tags,
  ]
}
