output "function_id" {
  description = "ID функции"
  value       = module.function.id
}

output "function_name" {
  description = "Имя функции"
  value       = module.function.name
}

output "function_version" {
  description = "Версия функции"
  value       = module.function.version
}

output "service_account_id" {
  description = "ID сервисного аккаунта функции"
  value       = module.iam_accounts.id
}
