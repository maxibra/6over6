terraform {
  backend "s3" {
    bucket         = "tf-state-bucket"        # name of the bucket
    key            = "./infrastructure.state" # name and path of the state files
    region         = "us-east-1"
    dynamodb_table = "tf-terraform-state-lock"
    encrypt        = true
  }
}
