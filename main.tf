resource "azurerm_key_vault" "this" {
  for_each                        = { for a in var.key_vault : a.name => a }
  location                        = data.azurerm_resource_group.this.location
  name                            = each.value.name
  resource_group_name             = data.azurerm_resource_group.this.name
  sku_name                        = each.value.sku_name
  tenant_id                       = data.azurerm_client_config.this.tenant_id
  enable_rbac_authorization       = each.value.enable_rbac_authorization
  enabled_for_deployment          = each.value.enabled_for_deployment
  enabled_for_disk_encryption     = each.value.enabled_for_disk_encryption
  enabled_for_template_deployment = each.value.enabled_for_template_deployment
  public_network_access_enabled   = each.value.public_network_access_enabled
  purge_protection_enabled        = each.value.purge_protection_enabled
  soft_delete_retention_days      = each.value.soft_delete_retention_days
  tags                            = merge(var.tags, each.value.tags)

  dynamic "network_acls" {
    for_each = { for a in var.key_vault : a.name => a if contains(keys(a), "network_acls") && a.network_acls != null }
    content {
      bypass                     = lookup(each.value, "bypass")
      default_action             = lookup(each.value, "default_action")
      ip_rules                   = lookup(each.value, "ip_rules")
      virtual_network_subnet_ids = lookup(each.value, "virtual_network_subnet_ids")
    }
  }
}

resource "azurerm_key_vault_access_policy" "this" {
  for_each                = { for a in var.key_vault : a.name => a if contains(keys(a), "access_policy") && a.access_policy != null }
  key_vault_id            = azurerm_key_vault.this[each.key].id
  object_id               = lookup(each.value, "object_id")
  tenant_id               = data.azurerm_client_config.this.tenant_id
  application_id          = lookup(each.value, "application_id")
  certificate_permissions = lookup(each.value, "certificate_permissions")
  key_permissions         = lookup(each.value, "key_permissions")
  secret_permissions      = lookup(each.value, "secret_permissions")
  storage_permissions     = lookup(each.value, "storage_permissions")
}

resource "azurerm_key_vault_certificate" "this" {
  for_each     = { for a in var.key_vault : a.name => a if contains(keys(a), "certificate") && a.certificate != null }
  key_vault_id = azurerm_key_vault.this[each.key].id
  name         = lookup(each.value, "name")
  tags         = merge(var.tags, lookup(each.value, "tags"))

  dynamic "certificate" {
    for_each = { for a in var.key_vault.*.certificate : a.name => a if contains(keys(a), "certificate") && a.certificate != null }
    content {
      contents = file(join("/", [path.cwd, "certificate", lookup(each.value, "contents")]))
      password = sensitive(lookup(each.value, "password"))
    }
  }

  dynamic "certificate_policy" {
    for_each = { for a in var.key_vault.*.certificate : a.name => a if contains(keys(a), "certificate_policy") && a.certificate_policy != null }
    content {
      issuer_parameters {
        name = lookup(each.value, "issuer_parameters_name")
      }

      key_properties {
        key_type   = lookup(each.value, "key_type")
        reuse_key  = lookup(each.value, "reuse_key")
        exportable = lookup(each.value, "exportable")
        key_size   = lookup(each.value, "key_size")
        curve      = lookup(each.value, "curve")
      }

      dynamic "secret_properties" {
        for_each = { for a in var.key_vault.*.certificate : a.name => a if contains(keys(a), "content_type") }
        content {
          content_type = lookup(each.value, "content_type")
        }
      }

      dynamic "lifetime_action" {
        for_each = { for a in var.key_vault.*.certificate : a.name => a if contains(keys(a), "lifetime_action") && a.*.certificate_policy.lifetime_action != null }
        content {
          action {
            action_type = lookup(lifetime_action.value, "action_type")
          }
          trigger {
            days_before_expiry  = lookup(lifetime_action.value, "days_before_expiry")
            lifetime_percentage = lookup(lifetime_action.value, "lifetime_percentage")
          }
        }
      }

      dynamic "secret_properties" {
        for_each = { for a in var.key_vault.*.certificate : a.name => a if contains(keys(a), "secret_properties") && a[0].certificate_policy.secret_properties != null }
        content {
          content_type = lookup(each.value, "secret_properties_content_type")
        }
      }

      dynamic "x509_certificate_properties" {
        for_each = { for a in var.key_vault.*.certificate : a.name => a if contains(keys(a), "x509_certificate_properties") && a[0].certificate_policy.x509_certificate_properties != null }
        content {
          key_usage          = lookup(each.value, "key_usage")
          validity_in_months = lookup(each.value, "validity_in_months")
          subject            = lookup(each.value, "subject")
          extended_key_usage = lookup(each.value, "extended_key_usage")

          dynamic "subject_alternative_names" {
            for_each = { for a in var.key_vault.*.certificate : a.name => a if contains(keys(a), "subject_alternative_names") && a[0].certificate_policy.*.x509_certificate_properties.subject_alternative_names != null }
            content {
              dns_names = lookup(each.value, "dns_names")
              emails    = lookup(each.value, "emails")
              upns      = lookup(each.value, "upns")
            }
          }
        }
      }
    }
  }
}

resource "azurerm_key_vault_certificate_contacts" "this" {
  for_each     = { for a in var.key_vault : a.name => a if contains(keys(a), "contacts") && a.contacts != null }
  key_vault_id = azurerm_key_vault.this[each.key].id

  contact {
    email = lookup(each.value, "email")
    name  = lookup(each.value, "name")
    phone = lookup(each.value, "phone")
  }
}

resource "azurerm_key_vault_certificate_issuer" "this" {
  for_each      = { for a in var.key_vault : a.name => a if contains(keys(a), "issuer") && a.issuer != null }
  key_vault_id  = azurerm_key_vault.this[each.key].id
  name          = lookup(each.value, "name")
  provider_name = lookup(each.value, "provider_name")
  org_id        = lookup(each.value, "org_id")
  account_id    = lookup(each.value, "account_id")
  password      = lookup(each.value, "password")

  admin {
    email_address = lookup(each.value, "email_address")
    first_name    = lookup(each.value, "first_name")
    last_name     = lookup(each.value, "last_name")
    phone         = lookup(each.value, "phone")
  }
}

resource "azurerm_key_vault_key" "this" {
  for_each        = { for b in var.key_vault_key : b.name => b }
  key_opts        = each.value.key_opts
  key_type        = each.value.key_type
  key_vault_id    = azurerm_key_vault.this[0].id
  name            = each.value.name
  key_size        = each.value.key_size
  curve           = each.value.curve
  not_before_date = each.value.not_before_date
  expiration_date = each.value.expiration_date
  tags            = merge(var.tags, each.value.tags)

  dynamic "rotation_policy" {
    for_each = { for b in var.key_vault_key : b.name => b if contains(keys(b), "expire_after") || contains(keys(b), "notify_before_expiry") }
    content {
      expire_after         = each.value.expire_after
      notify_before_expiry = each.value.notify_before_expiry

      dynamic "automatic" {
        for_each = { for b in var.key_vault_key : b.name => b if contains(keys(b), "time_after_creation") || contains(keys(b), "time_before_expiry") }
        content {
          time_after_creation = each.value.time_after_creation
          time_before_expiry  = each.value.time_before_expiry
        }
      }
    }
  }
}

resource "azurerm_key_vault_managed_hardware_security_module" "this" {
  for_each                                  = { for c in var.managed_hardware_security_module : c.name => c }
  admin_object_ids                          = [data.azurerm_client_config.this.object_id]
  location                                  = data.azurerm_resource_group.this.location
  name                                      = each.value.name
  resource_group_name                       = data.azurerm_resource_group.this.name
  sku_name                                  = each.value.sku_name
  tenant_id                                 = data.azurerm_client_config.this.tenant_id
  purge_protection_enabled                  = each.value.purge_protection_enabled
  soft_delete_retention_days                = each.value.soft_delete_retention_days
  public_network_access_enabled             = each.value.public_network_access_enabled
  security_domain_key_vault_certificate_ids = each.value.security_domain_key_vault_certificate_ids
  security_domain_quorum                    = each.value.security_domain_quorum
  tags                                      = merge(var.tags, each.value.tags)

  network_acls {
    bypass         = each.value.network_acls_bypass
    default_action = each.value.network_acls_default_action
  }
}

resource "azurerm_key_vault_managed_hardware_security_module_key" "this" {
  for_each        = { for c in var.managed_hardware_security_module : c.name => c if contains(keys(c), "key") && c.key != null }
  name            = lookup(each.value, "name")
  key_opts        = lookup(each.value, "key_opts")
  key_type        = lookup(each.value, "key_type")
  managed_hsm_id  = azurerm_key_vault_managed_hardware_security_module.this[each.key].id
  curve           = lookup(each.value, "curve")
  expiration_date = lookup(each.value, "expiration_date")
  key_size        = lookup(each.value, "key_size")
  not_before_date = lookup(each.value, "not_before_date")
  tags            = merge(var.tags, lookup(each.value, "tags"))
}

resource "azurerm_key_vault_managed_hardware_security_module_role_definition" "this" {
  for_each       = { for c in var.managed_hardware_security_module : c.name => c if contains(keys(c), "role_definition") && c.role_definition != null }
  name           = lookup(each.value, "name")
  managed_hsm_id = azurerm_key_vault_managed_hardware_security_module.this[each.key].id
  description    = lookup(each.value, "description")
  role_name      = lookup(each.value, "role_name")

  permission {
    actions          = lookup(each.value, "actions")
    not_actions      = lookup(each.value, "not_actions")
    data_actions     = lookup(each.value, "data_actions")
    not_data_actions = lookup(each.value, "not_data_actions")
  }
}

resource "azurerm_key_vault_managed_hardware_security_module_role_assignment" "this" {
  for_each           = { for c in var.managed_hardware_security_module : c.name => c }
  managed_hsm_id     = azurerm_key_vault_managed_hardware_security_module.this[0].id
  name               = join("-", [each.value.name, "role"])
  principal_id       = data.azurerm_client_config.this.object_id
  role_definition_id = data.azurerm_key_vault_managed_hardware_security_module_role_definition.this[0].managed_hsm_id
  scope              = data.azurerm_key_vault_managed_hardware_security_module_role_definition.this[0].assignable_scopes
}

resource "azurerm_key_vault_managed_storage_account" "this" {
  for_each                     = { for a in var.key_vault : a.name => a if contains(keys(a), "managed_storage_account") && a.managed_storage_account != null }
  key_vault_id                 = azurerm_key_vault.this[each.key].id
  name                         = lookup(each.value, "name")
  storage_account_id           = lookup(each.value, "storage_account_id")
  storage_account_key          = lookup(each.value, "storage_account_key")
  regenerate_key_automatically = lookup(each.value, "regenerate_key_automatically")
  regeneration_period          = lookup(each.value, "regeneration_period")
  tags                         = merge(var.tags, lookup(each.value, "tags"))
}

resource "azurerm_key_vault_managed_storage_account_sas_token_definition" "this" {
  for_each                   = { for a in var.managed_storage_account_sas_token_definition : a.name => a }
  managed_storage_account_id = azurerm_key_vault_managed_storage_account.this[0].id
  name                       = each.value.name
  sas_template_uri           = each.value.sas_template_id
  sas_type                   = each.value.sas_type
  validity_period            = each.value.validity_period
  tags                       = merge(var.tags, each.value.tags)
}

resource "azurerm_key_vault_secret" "this" {
  for_each        = { for a in var.secret : a.name => a }
  key_vault_id    = azurerm_key_vault.this[0].id
  name            = each.value.name
  value           = each.value.value
  content_type    = each.value.content_type
  not_before_date = each.value.not_before_date
  expiration_date = each.value.expiration_date
  tags            = merge(var.tags, each.value.tags)
}