resource "cloudflare_record" "agent" {
  count  = "${var.instance_agents_count}"
  domain = "${var.cloudflare_zone}"
  name   = "${var.prefix}-agent-${count.index}"
  value  = "${element(scaleway_server.agent.*.public_ip, count.index)}"
  # value = "${element(scaleway_server.agent.*.private_ip, count.index)}"
  type = "A"
  ttl  = 1
}
