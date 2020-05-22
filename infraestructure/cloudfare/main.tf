resource "cloudflare_record" "main" {
  zone_id = "${data.consul_keys.input.var.cloudfare-zone-id}"
  name    = "test.${data.consul_keys.input.var.root-domain}"
  value   = "192.168.0.1"
  type    = "A"
  ttl     = 120
}