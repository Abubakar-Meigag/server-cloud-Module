
resource "aws_db_instance" "existing" {
  identifier              = "video-db"
  engine                  = "postgres"
  engine_version          = "17.2"       
  instance_class          = "db.t4g.micro"    
  allocated_storage       = 20      
  db_name                 = ""
  username                = "postgres_beko"          
  publicly_accessible     = false
  multi_az                = false
  deletion_protection     = false
  skip_final_snapshot     = true
  backup_retention_period = 0
  storage_encrypted       = false
  tags = {
    Name = "video-db"
  }   
}