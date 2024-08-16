module "storage" {
  source  = "../terraform-azure-storage"
  account = var.storage_account
}