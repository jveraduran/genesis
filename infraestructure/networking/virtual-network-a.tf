# Virtual Network Variables

resource "azurerm_virtual_network" "vnet-a" {
  name                = "${data.consul_keys.input.var.country}-${data.consul_keys.input.var.environment}-${element(split(",", data.consul_keys.input.var.regions), 0)}"
  location            = "${element(split(",", data.consul_keys.input.var.regions), 0)}"
  resource_group_name = "${element(split(",", data.consul_keys.input.var.resource-groups), 0)}"
  address_space       = ["${element(split(",", data.consul_keys.input.var.address-spaces), 0)}"]
}

resource "azurerm_subnet" "subnet-a" {
  name                      = "${data.consul_keys.input.var.country}-${data.consul_keys.input.var.environment}-${element(split(",", data.consul_keys.input.var.regions), 0)}"
  resource_group_name       = "${element(split(",", data.consul_keys.input.var.resource-groups), 0)}"
  virtual_network_name      = "${azurerm_virtual_network.vnet-a.name}"
  address_prefix            = "${element(split(",", data.consul_keys.input.var.address-prefixes), 0)}"
  service_endpoints         = ["Microsoft.Storage", "Microsoft.KeyVault"]
}
