resource "aws_db_instance" "dev" {
    engine = "MySQL"
    engine_version = "8.4.7"
    # This is the name of the database schema created upon startup
    db_name = "devDB"
    username = "admin"
    #this is for user managed password
    password = "Cloud123"
    #this is for secret manager password 
    #manage_master_user_password = true
    instance_class = "db.t4g.micro"
    #storage_type = "gp2"   #Terraform expects a short, machine-readable code for the storage type, not the full "friendly" name you see in the AWS Console dropdown. so, give gp2 not General Purpose SSD (gp2)
    allocated_storage = 20
    # This is the name AWS uses for the resource itself
    identifier = "awsdevdb"
    db_subnet_group_name    = aws_db_subnet_group.sub-grp.id
    parameter_group_name    = "default.mysql8.4"

     # Enable backups and retention
    backup_retention_period  = 7   # Retain backups for 7 days
    backup_window            = "02:00-03:00" # Daily backup window (UTC)

    # Maintenance window
    maintenance_window = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)

    # Enable deletion protection (to prevent accidental deletion)
    deletion_protection = true
    
    # Skip final snapshot
    skip_final_snapshot = true
    depends_on = [ aws_db_subnet_group.sub-grp ] # Ensure subnet group is created before the DB instance
}


    resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "dev"
    }
  
}
resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
  
}
resource "aws_subnet" "subnet-2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
  
}
resource "aws_db_subnet_group" "sub-grp" {
  name       = "mycutsubnett"
  subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]

  tags = {
    Name = "My DB subnet group"
  }
}