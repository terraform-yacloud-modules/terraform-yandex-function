variable "function_name" {
  description = "Yandex Cloud Function name"
  type        = string
}

variable "function_description" {
  description = "Description of the Yandex Cloud Function"
  type        = string
  default     = null
}

variable "user_hash" {
  description = "User-defined string for current function version"
  type        = string
}

variable "runtime" {
  description = "Runtime for Yandex Cloud Function"
  type        = string

  validation {
    condition = contains(["python37", "python38", "python39", "python310", "python311",
      "python312", "nodejs12", "nodejs14", "nodejs16", "nodejs18", "golang114", "golang116",
      "golang118", "golang119", "php74", "php80", "php81", "java11", "dotnetcore31",
    "dotnet6", "r-for-yandex-cloud-1.0", "bash"], var.runtime)
    error_message = "Invalid runtime specified. Please choose from the allowed values."
  }
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

variable "env_vars" {
  description = ""
  type        = map(string)
  default     = {}
}

variable "zip_filename" {
  description = "Filename to zip archive for the version"
  type        = string
  default     = null
}

variable "package" {
  description = "Package configuration for deploying from object storage"
  type = object({
    bucket_name = string
    object_name = string
    sha_256     = optional(string)
  })
  default = null

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

variable "public_function" {
  description = "Determines if the function should be publicly accessible"
  type        = bool
  default     = false
}


variable "folder_id" {
  description = "Folder ID for the Yandex Cloud Function"
  type        = string
  default     = null
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the function"
  type        = map(string)
  default     = {}
}

variable "mounts" {
  description = "Mount configurations for the function"
  type = list(object({
    name = string
    mode = optional(string)
    ephemeral_disk = optional(object({
      size_gb       = number
      block_size_kb = optional(number)
    }))
    object_storage = optional(object({
      bucket = string
      prefix = optional(string)
    }))
  }))
  default = []
}

variable "connectivity" {
  description = "Network connectivity settings for the function"
  type = object({
    network_id = string
  })
  default = null
}

variable "metadata_options" {
  description = "Options to set the access mode to function's metadata endpoints"
  type = object({
    aws_v1_http_endpoint = optional(number)
    gce_http_endpoint    = optional(number)
  })
  default = null
}

variable "tmpfs_size" {
  description = "Size of the temporary file system"
  type        = string
  default     = null
}

variable "concurrency" {
  description = "The maximum number of requests processed by a function instance at the same time"
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Timeout settings for cluster operations"
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}
