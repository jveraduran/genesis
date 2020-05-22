resource "consul_keys" "output_eastus2" {
  key {
    path  = "${var.consul_base_path}/output/eastus2/networking/vnet-name"
    value = "${azurerm_virtual_network.vnet-a.name}"
  }
  key {
    path  = "${var.consul_base_path}/output/eastus2/networking/subnet-name"
    value = "${azurerm_subnet.subnet-a.name}"
  }
  key {
    path  = "${var.consul_base_path}/output/eastus2/networking/subnet-id"
    value = "${azurerm_subnet.subnet-a.id}"
  }
}

resource "consul_keys" "output_westus2" {
  key {
    path  = "${var.consul_base_path}/output/westus2/networking/vnet-name"
    value = "${azurerm_virtual_network.vnet-b.name}"
  }
  key {
    path  = "${var.consul_base_path}/output/westus2/networking/subnet-name"
    value = "${azurerm_subnet.subnet-b.name}"
  }
  key {
    path  = "${var.consul_base_path}/output/westus2/networking/subnet-id"
    value = "${azurerm_subnet.subnet-b.id}"
  }
}
