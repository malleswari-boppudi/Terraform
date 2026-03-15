terraform {
  backend "s3" {
    bucket = "malli-bucket-14032026"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}