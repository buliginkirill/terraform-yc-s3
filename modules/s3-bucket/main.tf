resource "yandex_storage_bucket" "this" {
  bucket     = var.bucket_name
  access_key = var.sa_access_key
  secret_key = var.sa_secret_key

  acl      = "private"
  max_size = 5 * 1024 * 1024 * 1024  # 5 GB пример

  lifecycle_rule {
    prefix  = ""
    enabled = true
    expiration {
      days = 365
    }
  }
}