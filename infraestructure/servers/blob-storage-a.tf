resource "azurerm_storage_account" "storage-a" {
    name = "${data.consul_keys.input.var.country}${element(split(",", data.consul_keys.input.var.regions),0)}${(substr(data.consul_keys.input.var.environment, 0, 3))}"
    resource_group_name = "${element(split(",", data.consul_keys.input.var.resource-groups),0)}"

    location = "${element(split(",", data.consul_keys.input.var.regions),0)}"
    account_tier = "Standard"
    account_replication_type = "RAGRS"
    account_kind = "BlobStorage"

    network_rules {
        default_action              = "Deny"
        ip_rules                    = ["200.29.181.148"]
        virtual_network_subnet_ids  = ["${data.consul_keys.input.var.subnet-id-a}"]
    }

    tags = {
    environment = "${data.consul_keys.input.var.environment}"
  }
}
resource "azurerm_storage_container" "container-a" {
    name                  = "${data.consul_keys.input.var.country}${element(split(",", data.consul_keys.input.var.regions),0)}${(substr(data.consul_keys.input.var.environment, 0, 3))}"
    resource_group_name   = "${element(split(",", data.consul_keys.input.var.resource-groups),0)}"
    storage_account_name  = "${azurerm_storage_account.storage-a.name}"
    container_access_type = "private"
}

resource "azurerm_management_lock" "lock-storage-a" {
  name       = "${data.consul_keys.input.var.country}${element(split(",", data.consul_keys.input.var.regions),0)}${(substr(data.consul_keys.input.var.environment, 0, 3))}"
  scope      = "${azurerm_storage_account.storage-a.id}"
  lock_level = "CanNotDelete"
  notes      = "Bloqueado para prevenir accidentes de borrado"
}