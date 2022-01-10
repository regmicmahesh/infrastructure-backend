module "label" {
  source = "../../modules/label"

  enabled    = var.enabled
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

resource "aws_s3_bucket" "default" {
  count         = var.enabled ? 1 : 0
  bucket        = var.override ? var.bucket_name : module.label.id
  acl           = var.acl
  region        = var.region
  force_destroy = var.force_destroy
  policy        = var.policy

  dynamic "website" {
    for_each = length(var.website) >= 1 ? [var.website] : []
    content {
      index_document = website.value["index_document"]
      error_document = website.value["error_document"]
    }
  }

  versioning {
    enabled = var.versioning_enabled
  }

  lifecycle_rule {
    id      = module.label.id
    enabled = var.lifecycle_rule_enabled
    prefix  = var.prefix
    tags    = module.label.tags

    noncurrent_version_transition {
      days          = var.noncurrent_version_transition_days
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = var.noncurrent_version_expiration_days
    }
  }


  # https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html
  # https://www.terraform.io/docs/providers/aws/r/s3_bucket.html#enable-default-server-side-encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = var.sse_algorithm
        kms_master_key_id = var.kms_master_key_arn
      }
    }
  }

  tags = module.label.tags
}
