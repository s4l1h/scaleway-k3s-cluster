resource "cloudflare_record" "master" {
  domain = "${var.cloudflare_zone}"
  name   = "${var.prefix}"
  value  = "${scaleway_server.master.public_ip}"
  type   = "A"
  ttl    = 1
}
