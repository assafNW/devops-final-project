terraform {
  backend "s3" {
    bucket         = "seyoawe-terraform-bucket-332211"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "seyoawe-terraform-state-locking"
    encrypt        = true
  }
}