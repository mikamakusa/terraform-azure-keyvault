## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.116.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.53.1 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.116.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_storage"></a> [storage](#module\_storage) | modules/storage | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_certificate.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |
| [azurerm_key_vault_certificate_contacts.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate_contacts) | resource |
| [azurerm_key_vault_certificate_issuer.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate_issuer) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_key_vault_managed_hardware_security_module.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_managed_hardware_security_module) | resource |
| [azurerm_key_vault_managed_hardware_security_module_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_managed_hardware_security_module_key) | resource |
| [azurerm_key_vault_managed_hardware_security_module_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_managed_hardware_security_module_role_assignment) | resource |
| [azurerm_key_vault_managed_hardware_security_module_role_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_managed_hardware_security_module_role_definition) | resource |
| [azurerm_key_vault_managed_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_managed_storage_account) | resource |
| [azurerm_key_vault_managed_storage_account_sas_token_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_managed_storage_account_sas_token_definition) | resource |
| [azurerm_key_vault_secret.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azuread_service_principal.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault_managed_hardware_security_module.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_managed_hardware_security_module) | data source |
| [azurerm_key_vault_managed_hardware_security_module_role_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_managed_hardware_security_module_role_definition) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_policy"></a> [access\_policy](#input\_access\_policy) | n/a | <pre>list(object({<br>    id                      = number<br>    key_vault_id            = any<br>    application_id          = optional(string)<br>    certificate_permissions = optional(list(string))<br>    key_permissions         = optional(list(string))<br>    secret_permissions      = optional(list(string))<br>    storage_permissions     = optional(list(string))<br>  }))</pre> | `[]` | no |
| <a name="input_certificate"></a> [certificate](#input\_certificate) | n/a | <pre>list(object({<br>    id           = number<br>    key_vault_id = any<br>    name         = string<br>    tags         = optional(map(string))<br>    certificate = optional(list(object({<br>      contents = string<br>      password = optional(string)<br>    })))<br>    certificate_policy = optional(list(object({<br>      issuer_parameters_name = string<br>      key_properties = list(object({<br>        key_type   = string<br>        reuse_key  = bool<br>        exportable = bool<br>        key_size   = optional(number)<br>        curve      = optional(string)<br>      }))<br>      lifetime_action = list(object({<br>        action_type                 = string<br>        trigger_days_before_expiry  = optional(number)<br>        trigger_lifetime_percentage = optional(number)<br>      }))<br>      secret_properties_content_type = string<br>      x509_certificate_properties = optional(list(object({<br>        key_usage          = list(string)<br>        validity_in_months = number<br>        subject            = string<br>        extended_key_usage = optional(list(string))<br>        subject_alternative_names = optional(list(object({<br>          dns_names = optional(list(string))<br>          emails    = optional(list(string))<br>          upns      = optional(list(string))<br>        })))<br>      })))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_certificate_contacts"></a> [certificate\_contacts](#input\_certificate\_contacts) | n/a | <pre>list(object({<br>    id           = number<br>    key_vault_id = any<br>    contact = list(object({<br>      email = string<br>      name  = optional(string)<br>      phone = optional(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_certificate_issuer"></a> [certificate\_issuer](#input\_certificate\_issuer) | n/a | <pre>list(object({<br>    id            = number<br>    key_vault_id  = any<br>    name          = string<br>    provider_name = string<br>    org_id        = optional(string)<br>    account_id    = optional(string)<br>    password      = optional(string)<br>    admin = optional(list(object({<br>      email_address = string<br>      first_name    = optional(string)<br>      last_name     = optional(string)<br>      phone         = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_key_vault"></a> [key\_vault](#input\_key\_vault) | n/a | <pre>list(object({<br>    id                              = number<br>    name                            = string<br>    sku_name                        = string<br>    enable_rbac_authorization       = optional(bool)<br>    enabled_for_deployment          = optional(bool)<br>    enabled_for_disk_encryption     = optional(bool)<br>    enabled_for_template_deployment = optional(bool)<br>    public_network_access_enabled   = optional(bool)<br>    purge_protection_enabled        = optional(bool)<br>    soft_delete_retention_days      = optional(number)<br>    tags                            = optional(map(string))<br>    access_policy = optional(list(object({<br>      application_id          = optional(string)<br>      certificate_permissions = optional(list(string))<br>      key_permissions         = optional(list(string))<br>      secret_permissions      = optional(list(string))<br>      storage_permissions     = optional(list(string))<br>    })))<br>    contact = optional(list(object({<br>      email = string<br>      name  = optional(string)<br>      phone = optional(string)<br>    })))<br>    network_acls = optional(list(object({<br>      bypass                     = string<br>      default_action             = string<br>      ip_rules                   = optional(list(string))<br>      virtual_network_subnet_ids = optional(list(string))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_key_vault_key"></a> [key\_vault\_key](#input\_key\_vault\_key) | n/a | <pre>list(object({<br>    id              = number<br>    key_opts        = list(string)<br>    key_type        = string<br>    key_vault_id    = any<br>    name            = string<br>    key_size        = optional(number)<br>    curve           = optional(string)<br>    not_before_date = optional(string)<br>    expiration_date = optional(string)<br>    tags            = optional(map(string))<br>    rotation_policy = optional(list(object({<br>      expire_after         = optional(string)<br>      notify_before_expiry = optional(string)<br>      automatic = optional(list(object({<br>        time_after_creation = optional(string)<br>        time_before_expiry  = optional(string)<br>      })))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_managed_hardware_security_module"></a> [managed\_hardware\_security\_module](#input\_managed\_hardware\_security\_module) | n/a | <pre>list(object({<br>    id                                        = number<br>    name                                      = string<br>    sku_name                                  = string<br>    purge_protection_enabled                  = optional(bool)<br>    soft_delete_retention_days                = optional(number)<br>    public_network_access_enabled             = optional(bool)<br>    security_domain_key_vault_certificate_ids = optional(list(string))<br>    security_domain_quorum                    = optional(number)<br>    tags                                      = optional(map(string))<br>    network_acls_bypass                       = string<br>    network_acls_default_action               = string<br>  }))</pre> | `[]` | no |
| <a name="input_managed_hardware_security_module_key"></a> [managed\_hardware\_security\_module\_key](#input\_managed\_hardware\_security\_module\_key) | n/a | <pre>list(object({<br>    id              = number<br>    name            = string<br>    key_opts        = list(string)<br>    key_type        = string<br>    managed_hsm_id  = any<br>    curve           = optional(number)<br>    expiration_date = optional(string)<br>    key_size        = optional(number)<br>    not_before_date = optional(string)<br>    tags            = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_managed_hardware_security_module_role_assignment"></a> [managed\_hardware\_security\_module\_role\_assignment](#input\_managed\_hardware\_security\_module\_role\_assignment) | n/a | <pre>list(object({<br>    id                 = number<br>    managed_hsm_id     = any<br>    name               = string<br>    role_definition_id = any<br>  }))</pre> | `[]` | no |
| <a name="input_managed_hardware_security_module_role_definition"></a> [managed\_hardware\_security\_module\_role\_definition](#input\_managed\_hardware\_security\_module\_role\_definition) | n/a | <pre>list(object({<br>    id            = number<br>    name          = string<br>    vault_base_id = any<br>    description   = string<br>    role_name     = string<br>    permission = optional(list(object({<br>      actions          = optional(list(string))<br>      not_actions      = optional(list(string))<br>      data_actions     = optional(list(string))<br>      not_data_actions = optional(list(string))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_managed_storage_account"></a> [managed\_storage\_account](#input\_managed\_storage\_account) | n/a | <pre>list(object({<br>    id                           = number<br>    key_vault_id                 = any<br>    name                         = string<br>    storage_account_id           = any<br>    storage_account_key          = string<br>    regenerate_key_automatically = optional(bool)<br>    regeneration_period          = optional(string)<br>    tags                         = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_managed_storage_account_sas_token_definition"></a> [managed\_storage\_account\_sas\_token\_definition](#input\_managed\_storage\_account\_sas\_token\_definition) | n/a | <pre>list(object({<br>    id                         = number<br>    managed_storage_account_id = any<br>    name                       = string<br>    sas_template_id            = any<br>    sas_type                   = string<br>    validity_period            = string<br>    tags                       = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_secret"></a> [secret](#input\_secret) | n/a | <pre>list(object({<br>    id              = number<br>    key_vault_id    = any<br>    name            = string<br>    value           = string<br>    content_type    = optional(string)<br>    not_before_date = optional(string)<br>    expiration_date = optional(string)<br>    tags            = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | n/a | `any` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_contacts_id"></a> [certificate\_contacts\_id](#output\_certificate\_contacts\_id) | n/a |
| <a name="output_certificate_id"></a> [certificate\_id](#output\_certificate\_id) | n/a |
| <a name="output_certificate_issuer_id"></a> [certificate\_issuer\_id](#output\_certificate\_issuer\_id) | n/a |
| <a name="output_certificate_issuer_name"></a> [certificate\_issuer\_name](#output\_certificate\_issuer\_name) | n/a |
| <a name="output_certificate_name"></a> [certificate\_name](#output\_certificate\_name) | n/a |
| <a name="output_key_vault_access_policy_id"></a> [key\_vault\_access\_policy\_id](#output\_key\_vault\_access\_policy\_id) | n/a |
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | n/a |
| <a name="output_key_vault_key_id"></a> [key\_vault\_key\_id](#output\_key\_vault\_key\_id) | n/a |
| <a name="output_key_vault_key_name"></a> [key\_vault\_key\_name](#output\_key\_vault\_key\_name) | n/a |
| <a name="output_managed_hsm_id"></a> [managed\_hsm\_id](#output\_managed\_hsm\_id) | n/a |
| <a name="output_managed_hsm_key_id"></a> [managed\_hsm\_key\_id](#output\_managed\_hsm\_key\_id) | n/a |
| <a name="output_managed_hsm_key_name"></a> [managed\_hsm\_key\_name](#output\_managed\_hsm\_key\_name) | n/a |
| <a name="output_managed_hsm_name"></a> [managed\_hsm\_name](#output\_managed\_hsm\_name) | n/a |
| <a name="output_managed_hsm_role_assignment_id"></a> [managed\_hsm\_role\_assignment\_id](#output\_managed\_hsm\_role\_assignment\_id) | n/a |
| <a name="output_managed_hsm_role_assignment_name"></a> [managed\_hsm\_role\_assignment\_name](#output\_managed\_hsm\_role\_assignment\_name) | n/a |
| <a name="output_managed_hsm_role_defintion_id"></a> [managed\_hsm\_role\_defintion\_id](#output\_managed\_hsm\_role\_defintion\_id) | n/a |
| <a name="output_managed_hsm_role_defintion_name"></a> [managed\_hsm\_role\_defintion\_name](#output\_managed\_hsm\_role\_defintion\_name) | n/a |
| <a name="output_managed_storage_account_id"></a> [managed\_storage\_account\_id](#output\_managed\_storage\_account\_id) | n/a |
| <a name="output_managed_storage_account_name"></a> [managed\_storage\_account\_name](#output\_managed\_storage\_account\_name) | n/a |
| <a name="output_managed_storage_account_sas_token_definition_id"></a> [managed\_storage\_account\_sas\_token\_definition\_id](#output\_managed\_storage\_account\_sas\_token\_definition\_id) | n/a |
| <a name="output_managed_storage_account_sas_token_definition_name"></a> [managed\_storage\_account\_sas\_token\_definition\_name](#output\_managed\_storage\_account\_sas\_token\_definition\_name) | n/a |
| <a name="output_secret_id"></a> [secret\_id](#output\_secret\_id) | n/a |
| <a name="output_secret_name"></a> [secret\_name](#output\_secret\_name) | n/a |
| <a name="output_secret_value"></a> [secret\_value](#output\_secret\_value) | n/a |
| <a name="output_secret_version"></a> [secret\_version](#output\_secret\_version) | n/a |
