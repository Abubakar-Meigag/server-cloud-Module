
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
  
  vpc_security_group_ids = [
    "sg-004f60302a8d78348",
    "sg-07c594a0bf91f982e"
  ] 
  tags = {
    Name = "video-db"
  }   
}