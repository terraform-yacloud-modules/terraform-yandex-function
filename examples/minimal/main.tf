data "yandex_client_config" "client" {}

data "archive_file" "main_zip" {
  type        = "zip"
  output_path = "${path.module}/main.zip"

  source {
    content  = file("${path.module}/main.py")
    filename = "main.py"
  }
}

module "function" {
  source = "../.."

  folder_id     = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)
  function_name = "minimal-function"
  runtime       = "python312"
  entrypoint    = "main.handler"
  memory        = "128"
  user_hash     = md5(file("${path.module}/main.py"))
  zip_filename  = data.archive_file.main_zip.output_path
}
