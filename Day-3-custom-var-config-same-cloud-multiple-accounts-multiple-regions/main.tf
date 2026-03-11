#dev resouce creating in us-west-2
resource "aws_instance" "dev" {
    ami = var.dev_ami_id
    instance_type = var.dev_instance_type
    provider = aws.devenv
    tags = {
      Name = "Dev-instance"
    }  
}

#test resource creating in us-east-1
resource "aws_instance" "test" {
    ami = var.test_ami_id
    instance_type = var.test_instance_type
    provider = aws.testenv
    tags = {
      Name = "test-instance"
    }  
}