resource "scaleway_security_group" "allow_all" {
  name        = "${var.prefix}-master-allow-all"
  description = "allow all traffic"
}

resource "scaleway_security_group_rule" "all_accept" {
  security_group = "${scaleway_security_group.allow_all.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
}
