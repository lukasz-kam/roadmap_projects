variable "bucket_name" {
  description = "Bucket name for storing tfstate file."
  type = string
  default = "my-state-bucket-9323d"
}

variable "table_name" {
  description = "Table name for dynamoDB"
  type = string
  default = "my-dynamo-table-9323d"
}