# Terraform + Yandex Cloud S3 Bucket

Быстрый репозиторий-шаблон: создаёт Object Storage-бакет в Yandex Cloud и сразу показывает, как им пользоваться через AWS CLI v2.



## Требования

| Компонент | Установка (macOS brew) |
|-----------|------------------------|
| Terraform | `brew install terraform` |
| Yandex Cloud CLI | `brew install yandex-cloud/yc/yc` |
| AWS CLI v2 | `brew install awscli` |

---

## Подготовка Yandex Cloud

1. **Создайте сервис-аккаунт** → дайте ему роль `storage.editor`.  
2. **Выпустите статический ключ**  
   и сохраните  
   * `<ID>` → **`sa_access_key`**  
   * `<SECRET>` → **`sa_secret_key`**.  
3. Запустите `yc init`, выберите Cloud/Folder, после чего:  
   ```bash
   export YC_TOKEN=$(yc iam create-token)
   ````


## Настройка переменных

```bash
cp terraform.tfvars.example terraform.tfvars
# откройте terraform.tfvars и впишите:
#   bucket_name     = "my-unique-bucket-name"
#   sa_access_key   = "<ID>"
#   sa_secret_key   = "<SECRET>"
```

## Деплой + проверка + удаление (пошагово)

```bash
# 0. клонируем репо
git clone git@github.com:buliginkirill/terraform-yc-s3.git
cd terraform-yc-s3

# 1. устанавливаем зависимости
brew install terraform
brew install yandex-cloud/yc/yc
brew install awscli          # v2

# 2. настраиваем yc
yc init                      # выбираем Cloud / Folder
export YC_TOKEN=$(yc iam create-token)

# 3. готовим tfvars
cp terraform.tfvars.example terraform.tfvars
# -> отредактировать bucket_name, sa_access_key, sa_secret_key

# 4. terraform: создаём бакет
terraform init
terraform validate           # должно быть Success
terraform apply -auto-approve

# 5. AWS CLI проверка
export AWS_ACCESS_KEY_ID=<ID>
export AWS_SECRET_ACCESS_KEY=<SECRET>
export AWS_DEFAULT_REGION=ru-central1

aws --endpoint-url https://storage.yandexcloud.net s3 ls          # видим бакет
echo "hi" > test.txt
aws --endpoint-url https://storage.yandexcloud.net \
s3 cp test.txt s3://<bucket_name>/
aws --endpoint-url https://storage.yandexcloud.net \
s3 ls s3://<bucket_name>/                                       # видим файл

# 6. очистка бакета (если force_destroy=false)
aws --endpoint-url https://storage.yandexcloud.net \
s3 rm s3://<bucket_name> --recursive

# 7. удаление инфраструктуры
terraform destroy -auto-approve
```
## Структура репозитория

```
terraform-yc-s3/
├─ versions.tf
├─ variables.tf
├─ main.tf
├─ outputs.tf
├─ terraform.tfvars.example     # ← шаблон
└─ modules/
   └─ s3-bucket/
       ├─ versions.tf
       ├─ variables.tf
       ├─ main.tf
       └─ outputs.tf
```

