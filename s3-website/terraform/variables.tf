variable "bucket_name" {
  description = "Bucket name for S3."
  type = string
  default = "websitebucket-89541c"
}

variable "website_index_document" {
  description = "Website index document"
  default = "index.html"
}
