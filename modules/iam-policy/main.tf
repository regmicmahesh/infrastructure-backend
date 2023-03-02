
locals {
  enabled = var.enabled

  iam_override_policy_documents = var.iam_override_policy_documents == null || var.iam_override_policy_documents == [] ? [] : var.iam_override_policy_documents
  iam_source_policy_documents   = var.iam_source_policy_documents == null || var.iam_source_policy_documents == [] ? [] : var.iam_source_policy_documents

  source_policy_documents = compact(local.iam_source_policy_documents)
}

module "label" {
  source = "../label"

  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}


data "aws_iam_policy_document" "default" {
  count = local.enabled ? 1 : 0

  policy_id = var.iam_policy_id

  override_policy_documents = local.iam_override_policy_documents != [] ? local.iam_override_policy_documents : null
  source_policy_documents   = local.source_policy_documents != [] ? local.source_policy_documents : null

  dynamic "statement" {
    # Only flatten if a list(string) is passed in, otherwise use the map var as-is
    for_each = try(flatten(var.iam_policy_statements), var.iam_policy_statements)

    content {
      sid    = lookup(statement.value, "sid", statement.key)
      effect = lookup(statement.value, "effect", null)

      actions     = lookup(statement.value, "actions", null)
      not_actions = lookup(statement.value, "not_actions", null)

      resources     = lookup(statement.value, "resources", null)
      not_resources = lookup(statement.value, "not_resources", null)

      dynamic "principals" {
        for_each = lookup(statement.value, "principals", [])

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = lookup(statement.value, "not_principals", [])

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = lookup(statement.value, "conditions", [])

        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

resource "aws_iam_policy" "default" {
  count = local.enabled && var.iam_policy_enabled ? 1 : 0

  name_prefix = join(var.delimiter, [module.label.id, "name_suffix"])
  description = var.description
  policy      = join("", data.aws_iam_policy_document.default.*.json)
  tags        = module.label.tags
}
