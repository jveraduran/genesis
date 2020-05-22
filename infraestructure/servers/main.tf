data "azurerm_resource_group" "eastus2" {
    name                  = "${element(split(",", data.consul_keys.input.var.resource-groups),0)}"
}

data "azurerm_resource_group" "westus2" {
    name                  = "${element(split(",", data.consul_keys.input.var.resource-groups),1)}"
}

data "azurerm_virtual_network" "eastus2" {
    name                  = "${data.consul_keys.input.var.vnet-name-a}"
    resource_group_name   = "${element(split(",", data.consul_keys.input.var.resource-groups),0)}"
}

data "azurerm_virtual_network" "westus2" {
    name                  = "${data.consul_keys.input.var.vnet-name-b}"
    resource_group_name   = "${element(split(",", data.consul_keys.input.var.resource-groups),1)}"
}

data "azurerm_subnet" "eastus2" {
    name                  = "${data.consul_keys.input.var.subnet-name-a}"
    resource_group_name   = "${element(split(",", data.consul_keys.input.var.resource-groups),0)}"
    virtual_network_name  = "${data.consul_keys.input.var.vnet-name-a}"
}

data "azurerm_subnet" "westus2" {
    name                  = "${data.consul_keys.input.var.subnet-name-b}"
    resource_group_name   = "${element(split(",", data.consul_keys.input.var.resource-groups),1)}"
    virtual_network_name  = "${data.consul_keys.input.var.vnet-name-b}"
}