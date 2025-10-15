resource "yandex_function" "main" {
  name               = var.function_name
  description        = var.function_description
  user_hash          = var.user_hash
  runtime            = var.runtime
  entrypoint         = var.entrypoint
  memory             = var.memory
  execution_timeout  = var.execution_timeout
  service_account_id = var.service_account_id
  tags               = var.tags

  dynamic "secrets" {
    for_each = var.secrets
    content {
      id                   = secrets.value.id
      version_id           = secrets.value.version_id
      key                  = secrets.value.key
      environment_variable = secrets.value.environment_variable
    }
  }

  environment = var.env_vars

  content {
    zip_filename = var.zip_filename
  }

  dynamic "async_invocation" {
    for_each = var.async_invocation != null ? [1] : []
    content {
      retries_count      = var.async_invocation.retries_count
      service_account_id = var.async_invocation.service_account_id

      dynamic "ymq_failure_target" {
        for_each = var.async_invocation.ymq_failure_target != null ? [1] : []
        content {
          service_account_id = var.async_invocation.ymq_failure_target.service_account_id
          arn                = var.async_invocation.ymq_failure_target.arn
        }
      }

      dynamic "ymq_success_target" {
        for_each = var.async_invocation.ymq_success_target != null ? [1] : []
        content {
          service_account_id = var.async_invocation.ymq_success_target.service_account_id
          arn                = var.async_invocation.ymq_success_target.arn
        }
      }
    }
  }

  dynamic "log_options" {
    for_each = var.log_options != null ? [1] : []
    content {
      log_group_id = var.log_options.log_group_id
      min_level    = var.log_options.min_level
    }
  }


  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = try(timeouts.value.create, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }

}

resource "yandex_function_iam_binding" "invoker" {
  count       = var.public_function ? 1 : 0
  function_id = yandex_function.main.id
  role        = "serverless.functions.invoker"
  members     = ["system:allUsers"]

}
