terraform {
  backend "s3" {
    bucket  = "abdulqayoom-s3-memos"
    key     = "ecs-project/terraform.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}