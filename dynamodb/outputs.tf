output "dynamodb_table_id" {
  value = aws_dynamodb_table.dynamodb_for_tf_locks.id
}