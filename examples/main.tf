module "function" {
  source = "../"

  function_name        = "my_test_function"
  function_description = "A test function for Yandex Cloud"
  user_hash            = "user_defined_hash_12345"
  runtime              = "python37"
  entrypoint           = "main"
  memory               = "128"
  execution_timeout    = "10"
  service_account_id   = "xxxx"
  tags                 = ["my_tag"]
  secrets = [
    {
      id                   = "secret_id_1"
      version_id           = "secret_version_id_1"
      key                  = "secret_key_1"
      environment_variable = "SECRET_ENV_VAR_1"
    }
  ]
  zip_filename         = "function.zip"
  async_invocation = {
    retries_count      = "3"
    service_account_id = "xxx"
    ymq_failure_target = {
      service_account_id = "xxxx"
      arn                = "yrn:yc:ymq:ru-central1:xxxx:fail"
    }
    ymq_success_target = {
      service_account_id = "xxxx"
      arn                = "yrn:yc:ymq:ru-central1:xxxx:success"
    }
  }
  log_options = {
    log_group_id = "xxxx"
    min_level    = "ERROR"
  }
}
