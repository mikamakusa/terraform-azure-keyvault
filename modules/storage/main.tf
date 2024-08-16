/*resource "azurerm_hpc_cache" "this" {
  count                                      = length(var.hpc_cache)
  cache_size_in_gb                           = lookup(var.hpc_cache[count.index], "cache_size_in_gb")
  location                                   = ""
  name                                       = lookup(var.hpc_cache[count.index], "name")
  resource_group_name                        = ""
  sku_name                                   = lookup(var.hpc_cache[count.index], "sku_name")
  subnet_id                                  = ""
  mtu                                        = lookup(var.hpc_cache[count.index], "mtu")
  key_vault_key_id                           = try(element(module.storage_key_vault.*.key_vault_key_id, lookup(var.hpc_cache[count.index], "key_vault_key_id")))
  automatically_rotate_key_to_latest_enabled = lookup(var.hpc_cache[count.index], "automatically_rotate_key_to_latest_enabled")
  tags                                       = merge(var.tags, lookup(var.hpc_cache[count.index], "tags"))

  dynamic "default_access_policy" {
    for_each = ""
    content {}
  }

  dynamic "directory_active_directory" {
    for_each = ""
    content {}
  }

  dynamic "directory_flat_file" {
    for_each = ""
    content {}
  }

  dynamic "directory_ldap" {
    for_each = ""
    content {}
  }

  dynamic "dns" {
    for_each = ""
    content {}
  }

  dynamic "identity" {
    for_each = ""
    content {}
  }
}*/

resource "azurerm_storage_account" "this" {
  count                             = length(var.account)
  account_replication_type          = lookup(var.account[count.index], "account_replication_type")
  account_tier                      = lookup(var.account[count.index], "account_tier")
  location                          = data.azurerm_resource_group.this.location
  name                              = lookup(var.account[count.index], "name")
  resource_group_name               = data.azurerm_resource_group.this.name
  account_kind                      = lookup(var.account[count.index], "account_kind")
  access_tier                       = lookup(var.account[count.index], "access_tier")
  cross_tenant_replication_enabled  = lookup(var.account[count.index], "cross_tenant_replication_enabled")
  edge_zone                         = lookup(var.account[count.index], "edge_zone")
  https_traffic_only_enabled        = lookup(var.account[count.index], "https_traffic_only_enabled")
  min_tls_version                   = lookup(var.account[count.index], "min_tls_version")
  allow_nested_items_to_be_public   = lookup(var.account[count.index], "allow_nested_items_to_be_public")
  shared_access_key_enabled         = lookup(var.account[count.index], "shared_access_key_enabled")
  public_network_access_enabled     = lookup(var.account[count.index], "public_network_access_enabled")
  default_to_oauth_authentication   = lookup(var.account[count.index], "default_to_oauth_authentication")
  is_hns_enabled                    = lookup(var.account[count.index], "is_hns_enabled")
  nfsv3_enabled                     = lookup(var.account[count.index], "nfsv3_enabled")
  large_file_share_enabled          = lookup(var.account[count.index], "large_file_share_enabled")
  local_user_enabled                = lookup(var.account[count.index], "local_user_enabled")
  queue_encryption_key_type         = lookup(var.account[count.index], "queue_encryption_key_type")
  table_encryption_key_type         = lookup(var.account[count.index], "table_encryption_key_type")
  infrastructure_encryption_enabled = lookup(var.account[count.index], "infrastructure_encryption_enabled")
  sftp_enabled                      = lookup(var.account[count.index], "sftp_enabled")
  dns_endpoint_type                 = lookup(var.account[count.index], "dns_endpoint_type")
  tags                              = merge(var.tags, lookup(var.account[count.index], "tags"))

  dynamic "azure_files_authentication" {
    for_each = lookup(var.account[count.index], "azure_files_authentication") == null ? [] : ["azure_files_authentication"]
    iterator = azure
    content {
      directory_type                 = lookup(azure.value, "directory_type")
      default_share_level_permission = lookup(azure.value, "default_share_level_permission")

      dynamic "active_directory" {
        for_each = (lookup(azure.value, "directory_type") == "AD" || lookup(azure.value, "active_directory") != null) ? ["active_directory"] : []
        content {
          domain_guid         = lookup(active_directory.value, "domain_guid")
          domain_name         = lookup(active_directory.value, "domain_name")
          domain_sid          = lookup(active_directory.value, "domain_sid")
          storage_sid         = lookup(active_directory.value, "storage_sid")
          forest_name         = lookup(active_directory.value, "forest_name")
          netbios_domain_name = lookup(active_directory.value, "netbios_domain_name")
        }
      }
    }
  }

  dynamic "blob_properties" {
    for_each = lookup(var.account[count.index], "blob_properties") == null ? [] : ["blob_properties"]
    iterator = blob
    content {
      versioning_enabled            = lookup(blob.value, "versioning_enabled")
      change_feed_enabled           = lookup(blob.value, "change_feed_enabled")
      change_feed_retention_in_days = lookup(blob.value, "change_feed_retention_in_days")
      default_service_version       = lookup(blob.value, "default_service_version")
      last_access_time_enabled      = lookup(blob.value, "last_access_time_enabled")

      dynamic "cors_rule" {
        for_each = lookup(blob.value, "cors_rule") == null ? [] : ["cors_rule"]
        content {
          allowed_headers    = lookup(cors_rule.value, "allowed_headers")
          allowed_methods    = lookup(cors_rule.value, "allowed_methods")
          allowed_origins    = lookup(cors_rule.value, "allowed_origins")
          exposed_headers    = lookup(cors_rule.value, "exposed_headers")
          max_age_in_seconds = lookup(cors_rule.value, "max_age_in_seconds")
        }
      }

      dynamic "container_delete_retention_policy" {
        for_each = lookup(blob.value, "container_delete_retention_policy_days") != null ? ["container_delete_retention_policy"] : []
        content {
          days = lookup(blob.value, "container_delete_retention_policy_days")
        }
      }

      dynamic "delete_retention_policy" {
        for_each = lookup(blob.value, "delete_retention_policy") == null ? [] : ["delete_retention_policy"]
        content {
          days                     = lookup(delete_retention_policy.value, "days")
          permanent_delete_enabled = lookup(delete_retention_policy.value, "permanent_delete_enabled")
        }
      }

      dynamic "restore_policy" {
        for_each = lookup(blob.value, "restore_policy_days") != null ? ["restore_policy"] : []
        content {
          days = lookup(blob.value, "restore_policy_days")
        }
      }
    }
  }

  dynamic "custom_domain" {
    for_each = lookup(var.account[count.index], "custom_domain_name") != null ? ["custom_domain"] : []
    content {
      name          = lookup(var.account[count.index], "custom_domain_name")
      use_subdomain = lookup(var.account[count.index], "use_subdomain")
    }
  }

  dynamic "customer_managed_key" {
    for_each = lookup(var.account[count.index], "customer_managed_key") == null ? [] : ["customer_managed_key"]
    content {
      user_assigned_identity_id = lookup(customer_managed_key.value, "user_assigned_identity_id")
    }
  }

  dynamic "identity" {
    for_each = lookup(var.account[count.index], "identity") == null ? [] : ["identity"]
    content {
      type         = lookup(identity.value, "type")
      identity_ids = lookup(identity.value, "identity_ids")
    }
  }

  dynamic "immutability_policy" {
    for_each = lookup(var.account[count.index], "immutability_policy") == null ? [] : ["immutability_policy"]
    iterator = immutability
    content {
      allow_protected_append_writes = lookup(immutability.value, "allow_protected_append_writes")
      period_since_creation_in_days = lookup(immutability.value, "period_since_creation_in_days")
      state                         = lookup(immutability.value, "state")
    }
  }

  dynamic "network_rules" {
    for_each = lookup(var.account[count.index], "network_rules") == null ? [] : ["network_rules"]
    content {
      default_action             = lookup(network_rules.value, "default_action")
      bypass                     = lookup(network_rules.value, "bypass")
      ip_rules                   = lookup(network_rules.value, "ip_rules")
      virtual_network_subnet_ids = lookup(network_rules.value, "virtual_network_subnet_ids")

      dynamic "private_link_access" {
        for_each = lookup(network_rules.value, "private_link_access") == null ? [] : ["private_link_access"]
        content {
          endpoint_resource_id = lookup(private_link_access.value, "endpoint_resource_id")
          endpoint_tenant_id   = lookup(private_link_access.value, "endpoint_tenant_id")
        }
      }
    }
  } /*

  dynamic "queue_properties" {
    for_each = ""
    content {}
  }

  dynamic "routing" {
    for_each = ""
    content {}
  }

  dynamic "sas_policy" {
    for_each = ""
    content {
      expiration_period = ""
    }
  }

  dynamic "share_properties" {
    for_each = ""
    content {}
  }

  dynamic "static_website" {
    for_each = ""
    content {}
  }*/
}