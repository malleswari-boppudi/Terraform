provider "aws" {
    region = "us-west-2"
    alias = "devenv"
}

provider "aws" {
    region = "us-east-1"
    alias = "testenv"
}