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