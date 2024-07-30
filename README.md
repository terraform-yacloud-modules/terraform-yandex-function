# Yandex Cloud <RESOURCE> Terraform module

Terraform module which creates Yandex Cloud <RESOURCE> resources.

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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
| [yandex_function.test_function](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/function) | resource |
| [yandex_function_iam_binding.invoker](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/function_iam_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_async_invocation"></a> [async\_invocation](#input\_async\_invocation) | Config for asynchronous invocations of Yandex Cloud Function | <pre>object({<br>    retries_count      = string<br>    service_account_id = string<br>    ymq_failure_target = optional(object({<br>      service_account_id = string<br>      arn                = string<br>    }))<br>    ymq_success_target = optional(object({<br>      service_account_id = string<br>      arn                = string<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_entrypoint"></a> [entrypoint](#input\_entrypoint) | Entrypoint for Yandex Cloud Function | `string` | n/a | yes |
| <a name="input_execution_timeout"></a> [execution\_timeout](#input\_execution\_timeout) | Execution timeout in seconds for Yandex Cloud Function | `string` | `"3"` | no |
| <a name="input_function_description"></a> [function\_description](#input\_function\_description) | Description of the Yandex Cloud Function | `string` | `null` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Yandex Cloud Function name | `string` | n/a | yes |
| <a name="input_log_options"></a> [log\_options](#input\_log\_options) | Options for logging from Yandex Cloud Function | <pre>object({<br>    log_group_id = string<br>    min_level    = string<br>  })</pre> | `null` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory in megabytes (aligned to 128MB) for Yandex Cloud Function | `string` | n/a | yes |
| <a name="input_public_function"></a> [public\_function](#input\_public\_function) | Determines if the function should be publicly accessible | `bool` | `false` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Runtime for Yandex Cloud Function | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Secrets for Yandex Cloud Function | <pre>list(object({<br>    id                   = string<br>    version_id           = string<br>    key                  = string<br>    environment_variable = string<br>  }))</pre> | `[]` | no |
| <a name="input_service_account_id"></a> [service\_account\_id](#input\_service\_account\_id) | Service account ID for Yandex Cloud Function | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for Yandex Cloud Function | `list(string)` | `[]` | no |
| <a name="input_user_hash"></a> [user\_hash](#input\_user\_hash) | User-defined string for current function version | `string` | n/a | yes |
| <a name="input_zip_filename"></a> [zip\_filename](#input\_zip\_filename) | Filename to zip archive for the version | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).
