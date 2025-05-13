variable "bucket_name" {
  description = "Global-unique bucket DNS name"
  type        = string
}

variable "sa_access_key" {
  description = "Static access key of service account"
  type        = string
  sensitive   = true
}

variable "sa_secret_key" {
  description = "Static secret key of service account"
  type        = string
  sensitive   = true
}
