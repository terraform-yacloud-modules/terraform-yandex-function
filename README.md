# Yandex Cloud <RESOURCE> Terraform module

Terraform module which creates Yandex Cloud <RESOURCE> resources.

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.0.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_function.main](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/function) | resource |
| [yandex_function_iam_binding.invoker](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/function_iam_binding) | resource |
| [yandex_client_config.client](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_async_invocation"></a> [async\_invocation](#input\_async\_invocation) | Config for asynchronous invocations of Yandex Cloud Function | <pre>object({<br/>    retries_count      = string<br/>    service_account_id = string<br/>    ymq_failure_target = optional(object({<br/>      service_account_id = string<br/>      arn                = string<br/>    }))<br/>    ymq_success_target = optional(object({<br/>      service_account_id = string<br/>      arn                = string<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_concurrency"></a> [concurrency](#input\_concurrency) | The maximum number of requests processed by a function instance at the same time | `string` | `null` | no |
| <a name="input_connectivity"></a> [connectivity](#input\_connectivity) | Network connectivity settings for the function | <pre>object({<br/>    network_id = string<br/>  })</pre> | `null` | no |
| <a name="input_entrypoint"></a> [entrypoint](#input\_entrypoint) | Entrypoint for Yandex Cloud Function | `string` | n/a | yes |
| <a name="input_env_vars"></a> [env\_vars](#input\_env\_vars) | n/a | `map(string)` | `{}` | no |
| <a name="input_execution_timeout"></a> [execution\_timeout](#input\_execution\_timeout) | Execution timeout in seconds for Yandex Cloud Function | `string` | `"3"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Folder ID for the Yandex Cloud Function | `string` | `null` | no |
| <a name="input_function_description"></a> [function\_description](#input\_function\_description) | Description of the Yandex Cloud Function | `string` | `null` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Yandex Cloud Function name | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the function | `map(string)` | `{}` | no |
| <a name="input_log_options"></a> [log\_options](#input\_log\_options) | Options for logging from Yandex Cloud Function | <pre>object({<br/>    log_group_id = string<br/>    min_level    = string<br/>  })</pre> | `null` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory in megabytes (aligned to 128MB) for Yandex Cloud Function | `string` | n/a | yes |
| <a name="input_metadata_options"></a> [metadata\_options](#input\_metadata\_options) | Options to set the access mode to function's metadata endpoints | <pre>object({<br/>    aws_v1_http_endpoint = optional(number)<br/>    gce_http_endpoint    = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_mounts"></a> [mounts](#input\_mounts) | Mount configurations for the function | <pre>list(object({<br/>    name = string<br/>    mode = optional(string)<br/>    ephemeral_disk = optional(object({<br/>      size_gb       = number<br/>      block_size_kb = optional(number)<br/>    }))<br/>    object_storage = optional(object({<br/>      bucket = string<br/>      prefix = optional(string)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_package"></a> [package](#input\_package) | Package configuration for deploying from object storage | <pre>object({<br/>    bucket_name = string<br/>    object_name = string<br/>    sha_256     = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_public_function"></a> [public\_function](#input\_public\_function) | Determines if the function should be publicly accessible | `bool` | `false` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Runtime for Yandex Cloud Function | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Secrets for Yandex Cloud Function | <pre>list(object({<br/>    id                   = string<br/>    version_id           = string<br/>    key                  = string<br/>    environment_variable = string<br/>  }))</pre> | `[]` | no |
| <a name="input_service_account_id"></a> [service\_account\_id](#input\_service\_account\_id) | Service account ID for Yandex Cloud Function | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for Yandex Cloud Function | `list(string)` | `[]` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Timeout settings for cluster operations | <pre>object({<br/>    create = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_tmpfs_size"></a> [tmpfs\_size](#input\_tmpfs\_size) | Size of the temporary file system | `string` | `null` | no |
| <a name="input_user_hash"></a> [user\_hash](#input\_user\_hash) | User-defined string for current function version | `string` | n/a | yes |
| <a name="input_zip_filename"></a> [zip\_filename](#input\_zip\_filename) | Filename to zip archive for the version | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | Creation timestamp of the Yandex Cloud Function |
| <a name="output_entrypoint"></a> [entrypoint](#output\_entrypoint) | Entrypoint of the function |
| <a name="output_folder_id"></a> [folder\_id](#output\_folder\_id) | Folder ID of the Yandex Cloud Function |
| <a name="output_id"></a> [id](#output\_id) | Yandex Cloud Function ID |
| <a name="output_name"></a> [name](#output\_name) | Yandex Cloud Function name |
| <a name="output_runtime"></a> [runtime](#output\_runtime) | Runtime environment of the function |
| <a name="output_service_account_id"></a> [service\_account\_id](#output\_service\_account\_id) | Service account ID associated with the function |
| <a name="output_version"></a> [version](#output\_version) | Version of the Yandex Cloud Function |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).
