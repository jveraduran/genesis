data "azurerm_client_config" "current-b" {}

resource "azurerm_key_vault" "main-b" {
  name                = "${data.consul_keys.input.var.country}-${data.consul_keys.input.var.environment}-${element(split(",", data.consul_keys.input.var.regions),1)}"
  location            = "${element(split(",", data.consul_keys.input.var.regions),1)}"
  resource_group_name = "${element(split(",", data.consul_keys.input.var.resource-groups),1)}"
  tenant_id           = "${data.azurerm_client_config.current-b.tenant_id}"

  sku {
    name = "premium"
  }

  network_acls {
    default_action              = "Deny"
    bypass                      = "None"
    ip_rules                    = ["200.29.181.148"]
    virtual_network_subnet_ids  = ["${data.consul_keys.input.var.subnet-id-a}","${data.consul_keys.input.var.subnet-id-b}"]
  }

  access_policy {
    tenant_id = "${data.azurerm_client_config.current-b.tenant_id}"
    object_id = "${data.azurerm_client_config.current-b.service_principal_object_id}"

    key_permissions = [
      "backup", 
      "create",
      "decrypt",
      "delete",
      "encrypt",
      "get",
      "import",
      "list",
      "purge",
      "recover",
      "restore",
      "sign",
      "unwrapKey",
      "update",
      "verify",
      "wrapKey"
    ]

    secret_permissions = [
    ]
  }

    tags = {
    environment = "${data.consul_keys.input.var.environment}"
  }
}

resource "azurerm_key_vault_key" "key-b" {
  name      = "${data.consul_keys.input.var.country}-${data.consul_keys.input.var.environment}-${element(split(",", data.consul_keys.input.var.regions),1)}"
  vault_uri = "${azurerm_key_vault.main-b.vault_uri}"
  key_type  = "RSA-HSM"
  key_size  = 4096

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

resource "azurerm_management_lock" "key-vault-b" {
  name       = "azure-${element(split(",", data.consul_keys.input.var.regions),1)}${(substr(data.consul_keys.input.var.environment, 0, 3))}"
  scope      = "${azurerm_key_vault.main-b.id}"
  lock_level = "CanNotDelete"
  notes      = "Bloqueado para prevenir accidentes de borrado"
}