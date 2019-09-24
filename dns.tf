# module "dns" {
#   source           = "./dns"
#   cloudflare_email = "${var.cloudflare_email}"
#   cloudflare_token = "${var.cloudflare_token}"
#   cloudflare_zone  = "${var.cloudflare_zone}"

#   master                = "${scaleway_server.master}"
#   agents                = "${scaleway_server.agent}"
#   prefix                = "${var.prefix}"
#   instance_agents_count = "${var.instance_agents_count}"
# }

# # Cloudflare
# variable "cloudflare_email" {}

# variable "cloudflare_token" {}

# variable "cloudflare_zone" {}
