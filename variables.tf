variable "function_name" {
  description = "Yandex Cloud Function name"
  type        = string
}

variable "function_description" {
  description = "Description of the Yandex Cloud Function"
  type        = string
  default     = ""
}

variable "user_hash" {
  description = "User-defined string for current function version"
  type        = string
}

variable "runtime" {
  description = "Runtime for Yandex Cloud Function"
  type        = string
}

variable "entrypoint" {
  description = "Entrypoint for Yandex Cloud Function"
  type        = string
}

variable "memory" {
  description = "Memory in megabytes (aligned to 128MB) for Yandex Cloud Function"
  type        = string
}

variable "execution_timeout" {
  description = "Execution timeout in seconds for Yandex Cloud Function"
  type        = string
  default     = "3"
}

variable "service_account_id" {
  description = "Service account ID for Yandex Cloud Function"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags for Yandex Cloud Function"
  type        = list(string)
  default     = []
}

variable "secrets" {
  description = "Secrets for Yandex Cloud Function"
  type = list(object({
    id                   = string
    version_id           = string
    key                  = string
    environment_variable = string
  }))
  default = []
}

variable "zip_filename" {
  description = "Filename to zip archive for the version"
  type        = string
}

variable "async_invocation" {
  description = "Config for asynchronous invocations of Yandex Cloud Function"
  type = object({
    retries_count      = string
    service_account_id = string
    ymq_failure_target = optional(object({
      service_account_id = string
      arn                = string
    }))
    ymq_success_target = optional(object({
      service_account_id = string
      arn                = string
    }))
  })
  default = null
}

variable "log_options" {
  description = "Options for logging from Yandex Cloud Function"
  type = object({
    log_group_id = string
    min_level    = string
  })
  default = null
}
