resource "cloudflare_record" "master" {
  domain = "${var.cloudflare_zone}"
  name   = "${var.prefix}"
  value  = "${var.master.public_ip}"
  type   = "A"
  ttl    = 1
}

resource "cloudflare_record" "master_private" {
  domain = "${var.cloudflare_zone}"
  name   = "${var.prefix}"
  value  = "${var.master.private_ip}"
  type   = "A"
  ttl    = 1
}

output "master_zone" {
  value = "${cloudflare_record.master.hostname}"
}
output "master_zone_private" {
  value = "${cloudflare_record.master_private.hostname}"
}
