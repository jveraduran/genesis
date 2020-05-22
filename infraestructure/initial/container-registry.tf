resource "azurerm_container_registry" "container-registry-eastus2" {
  name                     = "${data.consul_keys.input.var.country}${element(split(",", data.consul_keys.input.var.name), 0)}${element(split(",", data.consul_keys.input.var.region), 0)}"
  resource_group_name      = "${azurerm_resource_group.global-eastus2.name}"
  location                 = "${azurerm_resource_group.global-eastus2.location}"
  sku                      = "${data.consul_keys.input.var.container-registry-sku}"
  admin_enabled            = true

  tags = {
    environment = "${data.consul_keys.input.var.environment}"
  }
}

resource "azurerm_container_registry" "container-registry-westus2" {
  name                     = "${data.consul_keys.input.var.country}${element(split(",", data.consul_keys.input.var.name), 0)}${element(split(",", data.consul_keys.input.var.region), 1)}"
  resource_group_name      = "${azurerm_resource_group.global-westus2.name}"
  location                 = "${azurerm_resource_group.global-westus2.location}"
  sku                      = "${data.consul_keys.input.var.container-registry-sku}"
  admin_enabled            = true

  tags = {
    environment = "${data.consul_keys.input.var.environment}"
  }
}

resource "consul_keys" "output-eastus2" {
  key {
    path  = "${var.consul_base_path}/output/eastus2/login-server"
    value = "${azurerm_container_registry.container-registry-eastus2.login_server}"
  }
  key {
    path  = "${var.consul_base_path}/output/eastus2/admin-username"
    value = "${azurerm_container_registry.container-registry-eastus2.admin_username}"
  }
  key {
    path  = "${var.consul_base_path}/output/eastus2/admin-password"
    value = "${azurerm_container_registry.container-registry-eastus2.admin_password}"
  }
}

resource "consul_keys" "output-westus2" {
  key {
    path  = "${var.consul_base_path}/output/westus2/login-server"
    value = "${azurerm_container_registry.container-registry-westus2.login_server}"
  }
  key {
    path  = "${var.consul_base_path}/output/westus2/admin-username"
    value = "${azurerm_container_registry.container-registry-westus2.admin_username}"
  }
  key {
    path  = "${var.consul_base_path}/output/westus2/admin-password"
    value = "${azurerm_container_registry.container-registry-westus2.admin_password}"
  }
}