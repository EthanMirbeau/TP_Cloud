output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "load_balancer_public_ip" {
  value = azurerm_public_ip.lb_pip.ip_address
}