provider "azurerm" {
  version = "=1.39.0"
}

terraform {
  backend "consul" {}
}

provider "consul" {
  scheme = "http"
}

provider "cloudflare" {
  version     = "~> 2.0"
  email       = "${data.consul_keys.input.var.cloudfare-email}"
  api_key     = "${data.consul_keys.input.var.cloudfare-api-key}"
  account_id  = "${data.consul_keys.input.var.cloudfare-account-id}"
}
variable "consul_base_path" {
  type = "string"
}
data "consul_keys" "input" {
  key {
    name = "cloudfare-email"
    path = "${var.consul_base_path}/input/cloudfare-email"
  }
  key {
    name = "cloudfare-api-key"
    path = "${var.consul_base_path}/input/cloudfare-api-key"
  }
  key {
    name = "cloudfare-account-id"
    path = "${var.consul_base_path}/input/cloudfare-account-id"
  }
  key {
    name = "cloudfare-zone-id"
    path = "${var.consul_base_path}/input/cloudfare-zone-id"
  }
  key {
    name = "root-domain"
    path = "${var.consul_base_path}/input/root-domain"
  }
}
