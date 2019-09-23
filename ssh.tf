resource "scaleway_ssh_key" "k3s" {
  key = local.ssh_public
}
