resource "azurerm_storage_account" "storage-b" {
    name = "${data.consul_keys.input.var.country}${element(split(",", data.consul_keys.input.var.regions),1)}${(substr(data.consul_keys.input.var.environment, 0, 3))}"
    resource_group_name = "${element(split(",", data.consul_keys.input.var.resource-groups),1)}"

    location = "${element(split(",", data.consul_keys.input.var.regions),1)}"
    account_tier = "Standard"
    account_replication_type = "RAGRS"
    account_kind = "BlobStorage"

    network_rules {
        default_action              = "Deny"
        ip_rules                    = ["200.29.181.148"]
        virtual_network_subnet_ids  = ["${data.consul_keys.input.var.subnet-id-b}"]
    }

    tags = {
    environment = "${data.consul_keys.input.var.environment}"
  }
}
resource "azurerm_storage_container" "container-b" {
    name                  = "${data.consul_keys.input.var.country}${element(split(",", data.consul_keys.input.var.regions),1)}${(substr(data.consul_keys.input.var.environment, 0, 3))}"
    resource_group_name   = "${element(split(",", data.consul_keys.input.var.resource-groups),1)}"
    storage_account_name  = "${azurerm_storage_account.storage-b.name}"
    container_access_type = "private"
}

resource "azurerm_management_lock" "lock-storage-b" {
  name       = "${data.consul_keys.input.var.country}${element(split(",", data.consul_keys.input.var.regions),1)}${(substr(data.consul_keys.input.var.environment, 0, 3))}"
  scope      = "${azurerm_storage_account.storage-b.id}"
  lock_level = "CanNotDelete"
  notes      = "Bloqueado para prevenir accidentes de borrado"
}