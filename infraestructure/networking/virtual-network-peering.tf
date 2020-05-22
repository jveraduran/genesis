resource "azurerm_virtual_network_peering" "east-to-west" {
  name                         = "peering-${element(split(",", data.consul_keys.input.var.regions), 0)}-to-${element(split(",", data.consul_keys.input.var.regions), 1)}"
  resource_group_name          = "${element(split(",", data.consul_keys.input.var.resource-groups), 0)}"
  virtual_network_name         = "${azurerm_virtual_network.vnet-a.name}"
  remote_virtual_network_id    = "${azurerm_virtual_network.vnet-b.id}"
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false
}

resource "azurerm_virtual_network_peering" "west-to-east" {
  name                         = "peering-${element(split(",", data.consul_keys.input.var.regions), 1)}-to-${element(split(",", data.consul_keys.input.var.regions), 0)}"
  resource_group_name          = "${element(split(",", data.consul_keys.input.var.resource-groups), 1)}"
  virtual_network_name         = "${azurerm_virtual_network.vnet-b.name}"
  remote_virtual_network_id    = "${azurerm_virtual_network.vnet-a.id}"
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false
}