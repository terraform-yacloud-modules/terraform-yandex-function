module "iam_accounts" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-iam.git//modules/iam-account?ref=v1.0.0"

  name = "iam"
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

locals {
  file1_content    = file("main.py")
  file2_content    = file("requirements.txt")
  combined_content = "${local.file1_content}${local.file2_content}"
  combined_hash    = md5(local.combined_content)
}

module "function" {
  source = "../"

  function_name        = "my-test-function"
  public_function      = true
  function_description = "A test function for Yandex Cloud"
  user_hash            = local.combined_hash
  runtime              = "python312"
  entrypoint           = "main.handler"
  memory               = "128"
  execution_timeout    = "10"
  service_account_id   = module.iam_accounts.id
  tags                 = ["my_tag"]
  zip_filename         = data.archive_file.main_zip.output_path
  depends_on           = [module.iam_accounts]
}
