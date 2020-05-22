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
    name = "regions"
    path = "${var.consul_base_path}/input/regions"
  }
  key {
    name = "resource-groups"
    path = "${var.consul_base_path}/input/resource-groups"
  }
  key {
    name = "address-spaces"
    path = "${var.consul_base_path}/input/address-spaces"
  }
  key {
    name = "address-prefixes"
    path = "${var.consul_base_path}/input/address-prefixes"
  }
}