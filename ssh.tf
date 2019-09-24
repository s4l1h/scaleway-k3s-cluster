resource "scaleway_ssh_key" "k3s" {
  depends_on = ["scaleway_server.master"]
  key        = "${local.ssh_public}"
}
