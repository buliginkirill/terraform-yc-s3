## Yandex Cloud Object-Storage Terraform Module

1. **Требования**  
   * Terraform ≥ 1.5  
   * `yc` CLI ( `brew install yandex-cloud/yc/yc` + `yc init` )  
   * AWS CLI v2 ( `brew install awscli` )

2. **Подготовка**  
   1. Создайте сервис-аккаунт, дайте роль `storage.editor`.  
   2. Выпустите *статический* ключ → получите **ID** и **Secret**.

3. **Настройка**  
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # впишите bucket_name + ключи
