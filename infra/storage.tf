#create resource group for storage 
resource "azurerm_resource_group" "storage_rg" {
  name     = var.storageresourcegroup
  location = var.location
}


# Create storage account
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storageaccount
  resource_group_name      = "storage"
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = var.logs
  location            = var.location
  resource_group_name = "storage"
  sku                 = "PerGB2018"
}
 # checking NSG logs 
resource "azurerm_log_analytics_solution" "example" {
  solution_name         = "logs checking "
  location              = "eastus"
  resource_group_name   = "rg151"
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "logs analytics"
  }
}
# for sending logs to storage 

resource "azurerm_log_analytics_data_export_rule" "example" {
  name                    = "dataExport1"
  resource_group_name     = "storage"
  workspace_resource_id   = azurerm_log_analytics_workspace.law.id
  destination_resource_id = azurerm_storage_account.storage_account.id
  table_names             = ["Heartbeat"]
  enabled                 = true
}



resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = "example"
  target_resource_id =  azurerm_network_security_group.example.id
  storage_account_id = azurerm_storage_account.storage_account.id

  enabled_log {
    category = "NetworkSecurityGroupEvent"


    retention_policy {
      enabled = true
      days    = 7
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}


resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.main11.id
  network_security_group_id = azurerm_network_security_group.example.id

}



