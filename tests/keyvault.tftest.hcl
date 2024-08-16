run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "key_vault_with_keys_and_secrets" {
  command = plan

  variables {
    resource_group_name = "rg-kv-test-1"
    tags = {
      test      = "true"
      terraform = "true"
    }
    key_vault = [{
      id                          = 0
      name                        = "examplekeyvault"
      enabled_for_disk_encryption = true
      soft_delete_retention_days  = 7
      purge_protection_enabled    = false
      sku_name                    = "Standard"
      access_policy = [
        {
          key_permissions = [
            "Get",
          ]
          secret_permissions = [
            "Get",
          ]
          storage_permissions = [
            "Get",
          ]
        }
      ]
    }]
    access_policy = [
      {
        id            = 0
        key_vault_id  = 0
        key_permissions = [
          "Get", "List", "Encrypt", "Decrypt"
        ]
        secret_permissions = [
          "Get",
        ]
      }
    ]
    key_vault_key = [{
      id           = 0
      name         = "generated-certificate"
      key_vault_id = 0
      key_type     = "RSA"
      key_size     = 2048
      key_opts = [
        "decrypt",
        "encrypt",
        "sign",
        "unwrapKey",
        "verify",
        "wrapKey",
      ]
    }]
    secret = [{
      id            = 0
      name          = "secret-sauce"
      value         = "szechuan"
      key_vault_id  = 0
    }]
  }
}

run "hardware_security_module" {
  command = plan

  resource_group_name = "rg-kv-test-1"
  tags = {
    test      = "true"
    terraform = "true"
  }
  managed_hardware_security_module = [{
    id                          = 0
    name                        = "KVHSM-test"
    purge_protection_enabled    = false
    soft_delete_retention_days  = 90
  }]
  managed_hardware_security_module_key = [{
    id             = 0
    name           = "example"
    managed_hsm_id = 0
    key_type       = "EC-HSM"
    curve          = "P-521"
    key_opts       = ["sign"]
  }]
  managed_hardware_security_module_role_assignment = [{
    id                 = 0
    name               = "a9dbe818-56e7-5878-c0ce-a1477692c1d6"
    managed_hsm_id     = 0
    role_definition_id = 0
  }]
  managed_hardware_security_module_role_definition = [{
    id             = 0
    name           = "7d206142-bf01-11ed-80bc-00155d61ee9e"
    vault_base_id  = 0
    description    = "desc foo"
  }]
}