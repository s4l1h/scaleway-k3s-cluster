# Master server
resource "scaleway_server" "master" {
  image               = "${data.scaleway_image.image.id}"
  type                = "${var.instance_master_type}"
  name                = "${var.prefix}-master"
  security_group      = "${scaleway_security_group.allow_all.id}"
  dynamic_ip_required = true

}

resource "null_resource" "copy_configs" {
  depends_on = ["scaleway_server.master"]
  connection {
    type        = "ssh"
    host        = "${scaleway_server.master.public_ip}"
    user        = "${var.ssh_user}"
    port        = "${var.ssh_port}"
    private_key = "${local.ssh_private}"
  }

  provisioner "remote-exec" {
    inline = [
      # "apt-get update",
      # "DEBIAN_FRONTEND=noninteractive apt-get upgrade --yes",
      # "DEBIAN_FRONTEND=noninteractive apt-get install open-iscsi --yes",
      "${data.template_file.master.rendered}"
    ]
  }
  # download /etc/rancher/k3s/k3s.yaml to ./data/k3s.yaml
  provisioner "local-exec" {
    command = "scp -i ${var.ssh_private_key_file} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${var.ssh_user}@${scaleway_server.master.public_ip}:/etc/rancher/k3s/k3s.yaml ./data/k3s.yaml"
  }
  provisioner "local-exec" {
    command = "sed -i '' 's/127.0.0.1/${scaleway_server.master.public_ip}/g' ./data/k3s.yaml"
  }
  # download /var/lib/rancher/k3s/server/node-token to ./data/node-token
  provisioner "local-exec" {
    command = "scp -i ${var.ssh_private_key_file} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${var.ssh_user}@${scaleway_server.master.public_ip}:/var/lib/rancher/k3s/server/node-token ./data/node-token"
  }

  provisioner "local-exec" {
    when       = "destroy"
    command    = "rm ./data/k3s.yaml;rm ./data/node-token"
    on_failure = "continue"
  }
}

data "template_file" "master" {
  template = "${file("files/server_install.sh")}"
  vars = {
    server_ip = "${scaleway_server.master.public_ip}"
  }
}
