output "master_ip" {
  value = "${scaleway_server.master.public_ip}"
}
output "master_private_ip" {
  value = "${scaleway_server.master.private_ip}"
}
#/etc/rancher/k3s/k3s.yaml
output "master_kubeconfig" {
  value = fileexists("./data/k3s.yaml") ? file("./data/k3s.yaml") : ""
}
#/var/lib/rancher/k3s/server/node-token
output "master_node_token" {
  value = fileexists("./data/node-token") ? file("./data/node-token") : ""
}

