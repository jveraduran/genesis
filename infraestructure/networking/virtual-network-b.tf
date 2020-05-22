# Virtual Network Variables

resource "azurerm_virtual_network" "vnet-b" {
  name                = "${data.consul_keys.input.var.country}-${data.consul_keys.input.var.environment}-${element(split(",", data.consul_keys.input.var.regions), 1)}"
  location            = "${element(split(",", data.consul_keys.input.var.regions), 1)}"
  resource_group_name = "${element(split(",", data.consul_keys.input.var.resource-groups), 1)}"
  address_space       = ["${element(split(",", data.consul_keys.input.var.address-spaces), 1)}"]
}

resource "azurerm_subnet" "subnet-b" {
  name                      = "${data.consul_keys.input.var.country}-${data.consul_keys.input.var.environment}-${element(split(",", data.consul_keys.input.var.regions), 1)}"
  resource_group_name       = "${element(split(",", data.consul_keys.input.var.resource-groups), 1)}"
  virtual_network_name      = "${azurerm_virtual_network.vnet-b.name}"
  address_prefix            = "${element(split(",", data.consul_keys.input.var.address-prefixes), 1)}"
  service_endpoints         = ["Microsoft.Storage", "Microsoft.KeyVault"]
}
