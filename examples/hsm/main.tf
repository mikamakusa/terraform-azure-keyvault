provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

data "azurerm_client_config" "current" {}

module "HSM" {
  source              = "../../"
  resource_group_name = "rg-test"
  managed_hardware_security_module = [
    {
      name                       = "exampleKVHsm"
      sku_name                   = "Standard_B1"
      purge_protection_enabled   = false
      soft_delete_retention_days = 90
      key = [
        {
          name                     = "example"
          sku_name                 = "Standard_B1"
          tenant_id                = data.azurerm_client_config.current.tenant_id
          admin_object_ids         = [data.azurerm_client_config.current.object_id]
          purge_protection_enabled = false
        }
      ]
      role_definition = [
        {
          name        = "7d206142-bf01-11ed-80bc-00155d61ee9e"
          description = "desc foo"
          data_actions = [
            "Microsoft.KeyVault/managedHsm/keys/read/action",
          ]
        }
      ]
    }
  ]
}