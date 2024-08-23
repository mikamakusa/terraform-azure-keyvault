module "storage" {
  source              = "./modules/terraform-azure-storage"
  resource_group_name = var.resource_group_name
  account             = var.storage_account
}