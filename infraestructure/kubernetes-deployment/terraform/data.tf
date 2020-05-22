provider "azurerm" {
 version = "=1.39.0"
}
terraform {
  backend "consul" {}
}

provider "consul" {
  scheme = "https"
}
variable "consul_base_path" {
  type = "string"
}

variable "consul_remote_path" {
  type = "string"
}

variable "vault_base_path" {
  type = "string"
}
resource "random_string" "id" {
  length  = 6
  lower   = true
  upper   = false
  number  = false
  special = false
}

data "consul_keys" "input" {
  key {
    name = "cluster-name"
    path = "${var.consul_base_path}/input/cluster-name"
  }
  key {
    name = "environment"
    path = "${var.consul_base_path}/input/environment"
  }

  key {
    name = "main-resource-group"
    path = "${var.consul_base_path}/input/main-resource-group"
  }

  key {
    name = "vnet-name"
    path = "${var.consul_remote_path}/output/eastus2/networking/vnet-name"
  }
  key {
    name = "subnet-name"
    path = "${var.consul_remote_path}/output/eastus2/networking/subnet-name"
  }
  key {
    name = "image-resource-group"
    path = "${var.consul_base_path}/input/image-resource-group"
  }
  key {
    name = "k8s-image-name"
    path = "${var.consul_base_path}/input/k8s-image-name"
  }
  key {
    name = "bastion-image-name"
    path = "${var.consul_base_path}/input/bastion-image-name"
  }
  key {
    name = "worker-count"
    path = "${var.consul_base_path}/input/worker-count"
  }
  key {
    name = "manager-count"
    path = "${var.consul_base_path}/input/manager-count"
  }
  key {
    name = "bastion-vm-size"
    path = "${var.consul_base_path}/input/bastion-vm-size"
  }
  key {
    name = "manager-vm-size"
    path = "${var.consul_base_path}/input/manager-vm-size"
  }
  key {
    name = "worker-vm-size"
    path = "${var.consul_base_path}/input/worker-vm-size"
  }
  key {
    name = "lb-probe-port"
    path = "${var.consul_base_path}/input/lb-probe-port"
  }
  key {
    name = "lb-probe-request-path"
    path = "${var.consul_base_path}/input/lb-probe-request-path"
  }
  key {
    name = "lb-rule-port-http"
    path = "${var.consul_base_path}/input/lb-rule-port-http"
  }
  key {
    name = "lb-rule-port-https"
    path = "${var.consul_base_path}/input/lb-rule-port-https"
  }
}

data "vault_generic_secret" "ssh-public-key" {
    path = "${var.vault_base_path}"
}






