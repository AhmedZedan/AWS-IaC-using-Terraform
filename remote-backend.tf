module "remote_tf_state_s3_bucket" {
  source             = "./s3-bucket"
  bucket_name        = "zedan-terraform-remote-state"
	versioning_status  = "Enabled"
}


module "dynamodb_table_for_tf_locks" {
  source               = "./dynamodb"
  dynamodb_table_name  = "dynamodb_table_for_tf_locks"
  billing_mode         = "PAY_PER_REQUEST"
  hash_key             = "LockID"
  name_of_attribute    = "LockID"
  type_of_attribute    = "S"
  }


terraform {
  backend "s3" {
    bucket         = "zedan-terraform-remote-state"
    key            = "zedan/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dynamodb_table_for_tf_locks"
    encrypt        = true
  }
}