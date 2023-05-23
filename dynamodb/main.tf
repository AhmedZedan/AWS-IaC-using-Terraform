resource "aws_dynamodb_table" "dynamodb_for_tf_locks" {
  name            = var.dynamodb_table_name
  billing_mode    = var.billing_mode
  hash_key        = var.hash_key

  attribute {
    name = var.name_of_attribute
    type = var.type_of_attribute
  }
}