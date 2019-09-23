# Configure the Scaleway Provider
provider "scaleway" {
  organization = "${var.scw_org}"
  token        = "${var.scw_token}"
  region       = "${var.region}"
}

# Configure Cloudflare
provider "cloudflare" {
  email = "${var.cloudflare_email}"
  token = "${var.cloudflare_token}"
}
