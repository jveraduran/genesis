provider "azurerm" {
  version = "=1.39.0"
}

terraform {
  backend "consul" {}
}

provider "consul" {
  scheme = "http"
}
variable "consul_base_path" {
  type = "string"
}
data "consul_keys" "input" {
  key {
    name = "environment"
    path = "${var.consul_base_path}/input/environment"
  }
  key {
    name = "country"
    path = "${var.consul_base_path}/input/country"
  }
  key {
    name = "name"
    path = "${var.consul_base_path}/input/name"
  }
  key {
    name = "region"
    path = "${var.consul_base_path}/input/region"
  }
  key {
    name = "root-domain"
    path = "${var.consul_base_path}/input/root-domain"
  }
  key {
    name = "container-registry-sku"
    path = "${var.consul_base_path}/input/container-registry-sku"
  }
}

resource "consul_keys" "output_eastus2" {
  key {
    path  = "${var.consul_base_path}/output/eastus2/container-registry/login-server"
    value = "${azurerm_container_registry.container-registry-eastus2.login_server}"
  }
  key {
    path  = "${var.consul_base_path}/output/eastus2/container-registry/admin-username"
    value = "${azurerm_container_registry.container-registry-eastus2.admin_username}"
  }
  key {
    path  = "${var.consul_base_path}/output/eastus2/container-registry/admin-password"
    value = "${azurerm_container_registry.container-registry-eastus2.admin_password}"
  }
}

resource "consul_keys" "output_westus2" {
  key {
    path  = "${var.consul_base_path}/output/westus2/container-registry/login-server"
    value = "${azurerm_container_registry.container-registry-westus2.login_server}"
  }
  key {
    path  = "${var.consul_base_path}/output/westus2/container-registry/admin-username"
    value = "${azurerm_container_registry.container-registry-westus2.admin_username}"
  }
  key {
    path  = "${var.consul_base_path}/output/westus2/container-registry/admin-password"
    value = "${azurerm_container_registry.container-registry-westus2.admin_password}"
  }
}
