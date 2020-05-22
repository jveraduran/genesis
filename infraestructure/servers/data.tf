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

variable "consul_remote_path" {
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
    name = "vnet-name-a"
    path = "${var.consul_remote_path}/output/eastus2/networking/vnet-name"
  }
  key {
    name = "vnet-name-b"
    path = "${var.consul_remote_path}/output/westus2/networking/vnet-name"
  }
  key {
    name = "subnet-name-a"
    path = "${var.consul_remote_path}/output/eastus2/networking/subnet-name"
  }
  key {
    name = "subnet-name-b"
    path = "${var.consul_remote_path}/output/westus2/networking/subnet-name"
  }
  key {
    name = "subnet-id-a"
    path = "${var.consul_remote_path}/output/eastus2/networking/subnet-id"
  }
  key {
    name = "subnet-id-b"
    path = "${var.consul_remote_path}/output/westus2/networking/subnet-id"
  }
}
