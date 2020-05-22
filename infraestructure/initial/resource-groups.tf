resource "azurerm_resource_group" "global-eastus2" {
  name     = "${data.consul_keys.input.var.country}-${element(split(",", data.consul_keys.input.var.name), 0)}-${element(split(",", data.consul_keys.input.var.region), 0)}-${data.consul_keys.input.var.environment}"
  location = "${element(split(",", data.consul_keys.input.var.region), 0)}"

  tags = {
    environment = "${data.consul_keys.input.var.environment}"
  }
}

resource "azurerm_resource_group" "global-westus2" {
  name     = "${data.consul_keys.input.var.country}-${element(split(",", data.consul_keys.input.var.name), 0)}-${element(split(",", data.consul_keys.input.var.region), 1)}-${data.consul_keys.input.var.environment}"
  location = "${element(split(",", data.consul_keys.input.var.region), 1)}"

  tags = {
    environment = "${data.consul_keys.input.var.environment}"
  }
}

resource "azurerm_resource_group" "eastus2-labs" {
  name     = "${data.consul_keys.input.var.country}-${element(split(",", data.consul_keys.input.var.name), 1)}-${element(split(",", data.consul_keys.input.var.region), 0)}-${data.consul_keys.input.var.environment}"
  location = "${element(split(",", data.consul_keys.input.var.region), 0)}"

  tags = {
    environment = "${data.consul_keys.input.var.environment}"
  }
}

resource "azurerm_resource_group" "westus2-labs" {
  name     = "${data.consul_keys.input.var.country}-${element(split(",", data.consul_keys.input.var.name), 1)}-${element(split(",", data.consul_keys.input.var.region), 1)}-${data.consul_keys.input.var.environment}"
  location = "${element(split(",", data.consul_keys.input.var.region), 1)}"

  tags = {
    environment = "${data.consul_keys.input.var.environment}"
  }
}