provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

module "keyvault" {
  source              = "../../"
  resource_group_name = "rg-test"
  key_vault = [
    {
      name                        = "examplekeyvault"
      enabled_for_disk_encryption = true
      soft_delete_retention_days  = 7
      purge_protection_enabled    = false
      sku_name                    = "standard"
      access_policy = [
        {
          key_permissions = [
            "Get",
          ]
          secret_permissions = [
            "Get",
          ]
        }
      ]
    }
  ]
}