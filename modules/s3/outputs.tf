output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = try(aws_s3_bucket.default[0].id, "")
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = try(aws_s3_bucket.default[0].arn, "")
}

output "s3_bucket_bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = try(aws_s3_bucket.default[0].bucket_domain_name, "")
}

output "s3_bucket_bucket_regional_domain_name" {
  description = "The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL."
  value       = try(aws_s3_bucket.default[0].bucket_regional_domain_name, "")
}

output "s3_bucket_hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID for default bucket's region."
  value       = try(aws_s3_bucket.default[0].hosted_zone_id, "")
}

output "s3_bucket_region" {
  description = "The AWS region default bucket resides in."
  value       = try(aws_s3_bucket.default[0].region, "")
}

