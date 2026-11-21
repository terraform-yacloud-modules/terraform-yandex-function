# Полнофункциональный пример (complete)

Пример использования модуля со всеми основными возможностями:

- **folder_id** — каталог (по умолчанию берётся из конфигурации провайдера);
- **labels** — метки функции;
- **tags** — теги версии функции;
- **timeouts** — таймауты операций create/update/delete;
- **metadata_options** — доступ к служебным метаданным;
- **async_invocation** — асинхронный вызов с повторами;
- **concurrency** — число одновременных запросов на экземпляр;
- **public_function** — публичный доступ к функции через роль
  `serverless.functions.invoker` для `system:allUsers`;
- **iam_bindings** — дополнительные IAM-привязки (в примере — роль `viewer`
  для сервисного аккаунта функции);
- **scaling_policies** — политики масштабирования версии с тегом `complete`;
- **zip_filename** — версия из локального zip-архива, собранного из `main.py`
  и `requirements.txt`.

Дополнительно пример создаёт сервисный аккаунт через модуль
`terraform-yandex-iam` и назначает ему роли, необходимые функции.

## Использование

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```

Провайдер `yandex` настраивается стандартно: через переменные окружения
(`YC_TOKEN`, `YC_FOLDER_ID`, `YC_CLOUD_ID`) или ключ сервисного аккаунта.
Если каталог не задан в конфигурации провайдера, передайте его через
переменную `folder_id`.

После применения пример можно проверить в Yandex Cloud:

```bash
yc serverless function get --name complete-function
yc serverless function version list --function-name complete-function
yc serverless function list-access-bindings --name complete-function
```

Политику масштабирования удобнее смотреть в состоянии Terraform:

```bash
terraform state show module.function.yandex_function_scaling_policy.main[0]
```
