data "yandex_client_config" "client" {}

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
  folder_id          = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)
  labels             = var.labels
  tmpfs_size         = var.tmpfs_size
  concurrency        = var.concurrency

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

  dynamic "content" {
    for_each = var.zip_filename != null ? [1] : []
    content {
      zip_filename = var.zip_filename
    }
  }

  dynamic "package" {
    for_each = var.package != null ? [var.package] : []
    content {
      bucket_name = package.value.bucket_name
      object_name = package.value.object_name
      sha_256     = try(package.value.sha_256, null)
    }
  }

  dynamic "mounts" {
    for_each = var.mounts
    content {
      name = mounts.value.name
      mode = try(mounts.value.mode, null)

      dynamic "ephemeral_disk" {
        for_each = try(mounts.value.ephemeral_disk, null) != null ? [mounts.value.ephemeral_disk] : []
        content {
          size_gb       = ephemeral_disk.value.size_gb
          block_size_kb = try(ephemeral_disk.value.block_size_kb, null)
        }
      }

      dynamic "object_storage" {
        for_each = try(mounts.value.object_storage, null) != null ? [mounts.value.object_storage] : []
        content {
          bucket = object_storage.value.bucket
          prefix = try(object_storage.value.prefix, null)
        }
      }
    }
  }

  dynamic "connectivity" {
    for_each = var.connectivity != null ? [var.connectivity] : []
    content {
      network_id = connectivity.value.network_id
    }
  }

  dynamic "metadata_options" {
    for_each = var.metadata_options != null ? [var.metadata_options] : []
    content {
      aws_v1_http_endpoint = try(metadata_options.value.aws_v1_http_endpoint, null)
      gce_http_endpoint    = try(metadata_options.value.gce_http_endpoint, null)
    }
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
