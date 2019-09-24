resource "cloudflare_record" "agent" {
  count  = "${var.instance_agents_count}"
  domain = "${var.cloudflare_zone}"
  name   = "${var.prefix}-agent-${count.index}"
  value  = "${element(var.agents.*.public_ip, count.index)}"
  type   = "A"
  ttl    = 1
}
resource "cloudflare_record" "agent_private" {
  count  = "${var.instance_agents_count}"
  domain = "${var.cloudflare_zone}"
  name   = "${var.prefix}-agent-private-${count.index}"
  value  = "${element(var.agents.*.private_ip, count.index)}"
  type   = "A"
  ttl    = 1
}
output "agents_zone" {
  value = ["${cloudflare_record.agent.*.hostname}"]
}
output "agents_zone_private" {
  value = ["${cloudflare_record.agent_private.*.hostname}"]
}
