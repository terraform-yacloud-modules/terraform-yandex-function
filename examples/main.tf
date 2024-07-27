module "iam_accounts" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-iam.git//modules/iam-account"

  name      = "iam"
  folder_roles = [
    "admin",
  ]
  cloud_roles              = []
  enable_static_access_key = false
  enable_api_key           = false
  enable_account_key       = false

}

data "archive_file" "function_zip" {
  type        = "zip"
  output_path = "${path.module}/function.zip"

  source {
    content  = file("${path.module}/function.py")
    filename = "function.py"
  }

  source {
    content  = file("${path.module}/requirements.txt")
    filename = "requirements.txt"
  }
}


data "external" "user_hash" {
  program = ["sh", "-c", templatefile("${path.module}/generate_hash.sh", { path = path.module })]
}

module "function" {
  source = "../"

  function_name        = "my_test_function"
  function_description = "A test function for Yandex Cloud"
  user_hash            = "user_defined_hash_12345"
  runtime              = "python37"
  entrypoint           = "main"
  memory               = "1024"
  execution_timeout    = "10"
  service_account_id   = module.iam_accounts.id
  tags                 = ["my_tag"]
#   secrets = [
#     {
#       id                   = "secret_id_1"
#       version_id           = "secret_version_id_1"
#       key                  = "secret_key_1"
#       environment_variable = "SECRET_ENV_VAR_1"
#     }
#   ]
  zip_filename         = data.archive_file.function_zip.output_path
#   async_invocation = {
#     retries_count      = "3"
#     service_account_id = module.iam_accounts.id
#     ymq_failure_target = {
#       service_account_id = module.iam_accounts.id
#       arn                = "yrn:yc:ymq:ru-central1:xxxx:fail"
#     }
#     ymq_success_target = {
#       service_account_id = module.iam_accounts.id
#       arn                = "yrn:yc:ymq:ru-central1:xxxx:success"
#     }
#   }
#   log_options = {
#     log_group_id = "xxxx"
#     min_level    = "ERROR"
#   }

  depends_on = [ module.iam_accounts ]
}
