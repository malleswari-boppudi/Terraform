resource "aws_instance" "name" {
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t2.micro"
    tags = {
      Name = "Dev-instance"
    }  
}


#terraform workspace new dev    ##new workspace dev is created
#terraform workspace select default     #switch to default workspace 
#terraform workspace list   # gives the list of workspaces 
#not recommended in production 
