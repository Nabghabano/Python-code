output "grafanaresourcegroup" {
  value = [azurerm_resource_group.grafana_rg[*].id]
}

output "networkresourcegroup" {
  value = [azurerm_resource_group.networking_rg[*].id]
}

output "strorageresourcegroup" {
  value = [azurerm_resource_group.networking_rg[*].id]
}
