data "yandex_client_config" "client" {}

locals {
  folder_id = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)

  function_hash = md5("${file("${path.module}/main.py")}${file("${path.module}/requirements.txt")}")
}

module "iam_accounts" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-iam.git//modules/iam-account?ref=v1.0.0"

  name      = "function-iam"
  folder_id = local.folder_id
  folder_roles = [
    "serverless.functions.invoker",
    "storage.editor",
    "storage.uploader",
  ]
  cloud_roles              = []
  enable_static_access_key = false
  enable_api_key           = false
  enable_account_key       = false
}

data "archive_file" "main_zip" {
  type        = "zip"
  output_path = "${path.module}/main.zip"

  source {
    content  = file("${path.module}/main.py")
    filename = "main.py"
  }

  source {
    content  = file("${path.module}/requirements.txt")
    filename = "requirements.txt"
  }
}

module "function" {
  source = "../.."

  folder_id            = local.folder_id
  function_name        = "complete-function"
  public_function      = true
  function_description = "Complete example of a Yandex Cloud Function"
  user_hash            = local.function_hash
  runtime              = "python312"
  entrypoint           = "main.handler"
  memory               = "128"
  execution_timeout    = "10"
  service_account_id   = module.iam_accounts.id
  tags                 = ["complete"]
  labels = {
    environment = "test"
    managed     = "terraform"
  }
  metadata_options = {
    aws_v1_http_endpoint = 1
    gce_http_endpoint    = 1
  }
  async_invocation = {
    retries_count      = "3"
    service_account_id = module.iam_accounts.id
  }
  concurrency  = "10"
  zip_filename = data.archive_file.main_zip.output_path

  # Role serverless.functions.invoker for all users is managed by public_function
  iam_bindings = {
    viewer = ["serviceAccount:${module.iam_accounts.id}"]
  }

  scaling_policies = [
    {
      tag                  = "complete"
      zone_instances_limit = 2
      zone_requests_limit  = 10
    }
  ]

  timeouts = {
    create = "40m"
    update = "40m"
    delete = "40m"
  }
}
