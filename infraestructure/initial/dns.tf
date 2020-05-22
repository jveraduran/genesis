resource "azurerm_dns_zone" "eastus2" {
  name                = "${data.consul_keys.input.var.root-domain}"
  resource_group_name = "${azurerm_resource_group.global-eastus2.name}"
  zone_type           = "Public"
}

resource "azurerm_dns_zone" "westus2" {
  name                = "${data.consul_keys.input.var.root-domain}"
  resource_group_name = "${azurerm_resource_group.global-westus2.name}"
  zone_type           = "Public"
}