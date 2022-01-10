module "label" {
  source = "../label"

  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = join("-", [var.database_name, "cluster"])
  engine                  = var.engine_name
  engine_mode             = "serverless"
  database_name           = var.database_name
  enable_http_endpoint    = true
  master_username         = var.master_username
  master_password         = var.master_password
  backup_retention_period = var.backup_retention_period

  db_subnet_group_name = aws_db_subnet_group.default.name

  vpc_security_group_ids = [aws_security_group.rds-sg.id]

  storage_encrypted   = true
  skip_final_snapshot = true

  scaling_configuration {
    auto_pause               = true
    min_capacity             = var.min_capacity
    max_capacity             = var.max_capacity
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }

  tags = var.tags
}


resource "aws_db_subnet_group" "default" {
  name       = join("-", [var.database_name, "subnet"])
  subnet_ids = var.subnet_ids
}


resource "aws_security_group" "rds-sg" {
  name   = join("-", [var.database_name, "sg"])
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ingress" {
  count                    = length(var.allowed_security_groups)
  description              = "Allow inbound traffic from existing Security Groups"
  from_port                = 0
  to_port                  = 5432
  protocol                 = "-1"
  source_security_group_id = var.allowed_security_groups[count.index]
  security_group_id        = aws_security_group.rds-sg.id
  type                     = "ingress"
}
