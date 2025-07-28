## KEY VAULT ##

output "key_vault" {
  value = {
    for a in azurerm_key_vault.this : a => {
      id   = a.id
      name = a.name
    }
  }
}

## KEY VAULT ACCESS POLICY ##

output "access_policy" {
  value = {
    for a in azurerm_key_vault_access_policy.this : a => {
      id = a.id
    }
  }
}

## CERTIFICATE ##

output "certificate" {
  value = {
    for a in azurerm_key_vault_certificate.this : a => {
      id   = a.id
      name = a.name
    }
  }
}

output "certificate_issuer" {
  value = {
    for a in azurerm_key_vault_certificate_issuer.this : a => {
      id   = a.id
      name = a.name
    }
  }
}

output "certificate_contacts" {
  value = {
    for a in azurerm_key_vault_certificate_contacts.this : a => {
      id = a.id
    }
  }
}

output "certificate_attribute" {
  value = {
    for a in azurerm_key_vault_certificate.this : a => {
      id                      = a.id
      name                    = a.name
      tags                    = a.tags
      certificate             = a.certificate
      certificate_not_before  = a.certificate_attribute[0].not_before
      certificate_expires     = a.certificate_attribute[0].expires
      certificate_data        = a.certificate_data
      certificate_data_base64 = a.certificate_data_base64
      certificate_policy      = a.certificate_policy
    }
  }
}

## KEY VAULT KEY

output "key_vault_key" {
  value = {
    for a in azurerm_key_vault_key.this : a => {
      id      = a.id
      name    = a.name
      tags    = a.tags
      version = a.version
    }
  }
}

## MANAGED HSM ##

output "managed_hsm" {
  value = {
    for a in azurerm_key_vault_managed_hardware_security_module.this : a => {
      id       = a.id
      name     = a.name
      tags     = a.tags
      hsm_uri  = a.hsm_uri
      sku_name = a.sku_name
    }
  }
}

output "managed_hsm_key" {
  value = {
    for a in azurerm_key_vault_managed_hardware_security_module_key.this : a => {
      id   = a.id
      name = a.name
      tags = a.tags
    }
  }
}

output "managed_hsm_role_assignment" {
  value = {
    for a in azurerm_key_vault_managed_hardware_security_module_role_assignment.this : a => {
      id          = a.id
      name        = a.name
      scope       = a.scope
      resource_id = a.resource_id
    }
  }
}

output "managed_hsm_role_defintion" {
  value = {
    for a in azurerm_key_vault_managed_hardware_security_module_role_definition.this : a => {
      id        = a.id
      name      = a.name
      role_name = a.role_name
    }
  }
}

## MANAGED STORAGE ACCOUNT ##

output "managed_storage_account_id" {
  value = {
    for a in azurerm_key_vault_managed_storage_account.this : a => {
      id   = a.id
      name = a.name
      tags = a.tags
    }
  }
}

output "managed_storage_account" {
  value = {
    for a in azurerm_key_vault_managed_storage_account.this : a => {
      id           = a.id
      name         = a.name
      tags         = a.tags
      key_vault_id = a.key_vault_id
    }
  }
}

output "managed_storage_account_sas_token_definition_id" {
  value = {
    for a in azurerm_key_vault_managed_storage_account_sas_token_definition.this : a => {
      id                         = a.id
      name                       = a.name
      tags                       = a.tags
      managed_storage_account_id = a.managed_storage_account_id
      sas_template_uri           = a.sas_template_uri
      sas_type                   = a.sas_type
      secret_id                  = a.secret_id
      validity_period            = a.validity_period
    }
  }
}

output "managed_storage_account_sas_token_definition_name" {
  value = {
    for a in azurerm_key_vault_managed_storage_account_sas_token_definition.this : a => {
      id                         = a.id
      name                       = a.name
      tags                       = a.tags
      validity_period            = a.validity_period
      secret_id                  = a.secret_id
      sas_type                   = a.sas_type
      sas_template_uri           = a.sas_template_uri
      managed_storage_account_id = a.managed_storage_account_id
    }
  }
}

## SECRET ##

output "secret" {
  value = {
    for a in azurerm_key_vault_secret.this : a => {
      id      = a.id
      name    = a.name
      value   = sensitive(a.value)
      version = a.version
    }
  }
}