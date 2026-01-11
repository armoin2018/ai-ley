resource "aws_db_instance" "production" {
  identifier             = "prod-postgres"
  engine                = "postgres"
  engine_version        = "14.9"
  instance_class        = "db.r5.xlarge"
  allocated_storage     = 500
  storage_encrypted     = true
  multi_az             = true
  backup_retention_period = 30
  backup_window        = "03:00-04:00"
  maintenance_window   = "Sun:04:00-Sun:05:00"
  
  tags = {
    Environment = "production"
    Backup     = "required"
  }
}