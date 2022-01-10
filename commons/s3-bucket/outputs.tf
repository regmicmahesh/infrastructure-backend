output "bucket_domain_name" {
  value       = var.enabled ? join("", aws_s3_bucket.default.*.bucket_domain_name) : ""
  description = "FQDN of bucket"
}

output "bucket_id" {
  value       = var.enabled ? join("", aws_s3_bucket.default.*.id) : ""
  description = "Bucket Name (aka ID)"
}

output "bucket_arn" {
  value       = var.enabled ? join("", aws_s3_bucket.default.*.arn) : ""
  description = "Bucket ARN"
}

output "enabled" {
  value       = var.enabled
  description = "Is module enabled"
}

output "bucket_name" {
  description = "Name of bucket"
  value       = join("", aws_s3_bucket.default.*.bucket)
}

output "website_endpoint" {
  description = "Website endpoint of bucket"
  value       = length(var.website) >= 1 ? join("", aws_s3_bucket.default.*.website_endpoint) : ""
}
