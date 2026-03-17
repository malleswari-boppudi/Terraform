resource "aws_vpc" "prod" {
    cidr_block = "10.0.0.0/16"
    tags = {
      "Name" = "Prod-vpc"
    }
}

resource "aws_subnet" "prod" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.0.0/24"
    tags = {
      "Name" = "prod-subnet"
    }
    
}

resource "aws_internet_gateway" "prod" {
    tags = {
      "Name" = "Prod-IG"
    }
    vpc_id = aws_vpc.prod.id
}

resource "aws_route_table" "prod" {
    vpc_id = aws_vpc.prod.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.prod.id
    }
    
}

resource "aws_route_table_association" "prod" {
    route_table_id = aws_route_table.prod.id
    subnet_id = aws_subnet.prod.id
    
}

resource "aws_security_group" "prod" {
    name = "prod-sg"
    description = "prod-sg"
    vpc_id = aws_vpc.prod.id
    
    #ingress means inbound 
    #inbound rule to allow port 22
    ingress {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 22
      protocol = "tcp"
      to_port = 22
    }

    #outbound rule to allow all traffic 
    egress  {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 0
      protocol = "-1"
      to_port = 0
    } 

}

resource "aws_instance" "prod" {
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.prod.id
    vpc_security_group_ids = [ aws_security_group.prod.id ]
    tags = {
      "Name" = "prod-instance"
    }

}