module "label" {
  source = "../label"

  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

resource "aws_s3_bucket" "default" {

  count = var.create_bucket ? 1 : 0

  bucket = join(var.delimiter, [module.label.id, var.bucket_suffix])

  force_destroy = var.force_destroy
  object_lock_enabled = var.object_lock_enabled
  

}
