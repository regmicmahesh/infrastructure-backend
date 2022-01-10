output "endpoint" {
  value = aws_rds_cluster.default.endpoint
}

output "arn" {
  value = aws_rds_cluster.default.arn
}

output "id" {
  value = aws_rds_cluster.default.id
}

output "rds_sg_id" {
  value = aws_security_group.rds-sg.id
}
