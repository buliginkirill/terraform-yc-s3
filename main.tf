provider "yandex" {
  # token, cloud_id, folder_id берутся из:
  #   • env-переменных YC_TOKEN / YC_CLOUD_ID / YC_FOLDER_ID
  #   • или из профиля `yc init`
  zone = "ru-central1-a"
}

module "s3_bucket" {
  source    = "./modules/s3-bucket"
  providers = { yandex = yandex }

  bucket_name     = var.bucket_name
  sa_access_key   = var.sa_access_key
  sa_secret_key   = var.sa_secret_key
}
