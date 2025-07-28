data "azurerm_client_config" "this" {}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_key_vault_managed_hardware_security_module" "this" {
  for_each            = { for c in var.managed_hardware_security_module : c.name => c }
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_key_vault_managed_hardware_security_module_role_definition" "this" {
  for_each       = { for c in var.managed_hardware_security_module : c.name => c if contains(keys(c), "role_definition") && c.role_definition != null }
  managed_hsm_id = data.azurerm_key_vault_managed_hardware_security_module.this[each.key].id
  name           = lookup(each.value, "name")
}