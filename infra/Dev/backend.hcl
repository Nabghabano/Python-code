terraform {
  backend "azurerm" {
    resource_group_name  = "grafana"
    storage_account_name = " mystorage1512233 "
    container_name       = "terraform-state-container"
    key                  = "terraform.tfstate"
  }
}
