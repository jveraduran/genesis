module "kubernetes-vms-deployment" {
  source = "git::https://github.com/jveraduran/azure-k8s-vm-module.git"

  name-suffix           = "${random_string.id.result}"
  cluster-name          = "${data.consul_keys.input.var.cluster-name}"
  environment           = "${data.consul_keys.input.var.environment}"
  main-resource-group   = "${data.consul_keys.input.var.main-resource-group}"
  vnet-name             = "${data.consul_keys.input.var.vnet-name}"
  subnet-name           = "${data.consul_keys.input.var.subnet-name}"
  images-resource-group = "${data.consul_keys.input.var.image-resource-group}"
  k8s-image-name        = "${data.consul_keys.input.var.k8s-image-name}"
  bastion-image-name    = "${data.consul_keys.input.var.bastion-image-name}"
  ssh-public-key        = "${data.vault_generic_secret.ssh-public-key.data["id_rsa_pub"]}"
  worker-count          = "${data.consul_keys.input.var.worker-count}"
  manager-count         = "${data.consul_keys.input.var.manager-count}"
  lb-address-pool-id    = "${module.kubernetes-loadbalancer-deployment.lb_address_pool_id}"
  bastion-vm-size       = "${data.consul_keys.input.var.bastion-vm-size}"
  manager-vm-size       = "${data.consul_keys.input.var.manager-vm-size}"
  worker-vm-size        = "${data.consul_keys.input.var.worker-vm-size}"
}
module "kubernetes-loadbalancer-deployment" {
  source = "git::https://github.com/jveraduran/azure-k8s-lb-module.git"

  name-suffix           = "${random_string.id.result}"
  main-resource-group   = "${data.consul_keys.input.var.main-resource-group}"
  cluster-name          = "${data.consul_keys.input.var.cluster-name}"
  environment           = "${data.consul_keys.input.var.environment}"
  lb-probe-port         = "${data.consul_keys.input.var.lb-probe-port}"
  lb-probe-request-path = "${data.consul_keys.input.var.lb-probe-request-path}"
  lb-rule-port-http     = "${data.consul_keys.input.var.lb-rule-port-http}"
  lb-rule-port-https    = "${data.consul_keys.input.var.lb-rule-port-https}"
}