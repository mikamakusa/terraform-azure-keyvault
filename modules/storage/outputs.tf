output "storage_account_id" {
  value = try(
    azurerm_storage_account.this.*.id
  )
}

output "storage_account_name" {
  value = try(
    azurerm_storage_account.this.*.name
  )
}