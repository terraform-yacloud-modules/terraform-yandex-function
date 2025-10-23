output "id" {
  description = "Yandex Cloud Function ID"
  value       = yandex_function.main.id
}

output "name" {
  description = "Yandex Cloud Function name"
  value       = yandex_function.main.name
}

output "created_at" {
  description = "Creation timestamp of the Yandex Cloud Function"
  value       = yandex_function.main.created_at
}

output "version" {
  description = "Version of the Yandex Cloud Function"
  value       = yandex_function.main.version
}

output "folder_id" {
  description = "Folder ID of the Yandex Cloud Function"
  value       = yandex_function.main.folder_id
}

output "service_account_id" {
  description = "Service account ID associated with the function"
  value       = yandex_function.main.service_account_id
}

output "runtime" {
  description = "Runtime environment of the function"
  value       = yandex_function.main.runtime
}

output "entrypoint" {
  description = "Entrypoint of the function"
  value       = yandex_function.main.entrypoint
}
