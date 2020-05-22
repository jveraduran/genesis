resource "consul_keys" "output" {
  key {
    path  = "${var.consul_base_path}/output/bastion-ip"
    value = "${module.kubernetes-vms-deployment.bastion_ip}"
  }

  key {
    path  = "${var.consul_base_path}/output/worker-ips"
    value = "${data.consul_keys.input.var.worker-count == "0" ? "" : module.kubernetes-vms-deployment.worker_ips}"
  }

  key {
    path  = "${var.consul_base_path}/output/manager-ips"
    value = "${module.kubernetes-vms-deployment.manager_ips}"
  }

  key {
    path  = "${var.consul_base_path}/output/name-suffix"
    value = "${random_string.id.result}"
  }

  key {
    path  = "${var.consul_base_path}/output/loadbalancer-public-ip"
    value = "${module.kubernetes-loadbalancer-deployment.load_balancer_ip}"
  }
}
