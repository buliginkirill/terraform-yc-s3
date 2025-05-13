output "bucket_id"   { value = yandex_storage_bucket.this.bucket }
output "s3_endpoint" { value = "https://storage.yandexcloud.net/${yandex_storage_bucket.this.bucket}" }
