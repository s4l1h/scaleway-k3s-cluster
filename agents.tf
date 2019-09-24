#Agents Server
resource "scaleway_server" "agent" {
  count               = "${var.instance_agents_count}"
  image               = "${data.scaleway_image.image.id}"
  type                = "${var.instance_agents_type}"
  name                = "${var.prefix}-agent-${count.index}"
  security_group      = "${scaleway_security_group.allow_all.id}"
  dynamic_ip_required = true
}


resource "null_resource" "join_node" {
  depends_on = ["data.external.join_token"]

  count = "${var.instance_agents_count}"
  connection {
    type        = "ssh"
    host        = "${element(scaleway_server.agent.*.public_ip, count.index)}"
    user        = "${var.ssh_user}"
    port        = "${var.ssh_port}"
    private_key = "${local.ssh_private}"
  }

  provisioner "remote-exec" {
    inline = [
      # "apt-get update",
      # "DEBIAN_FRONTEND=noninteractive apt-get upgrade --yes",
      # "DEBIAN_FRONTEND=noninteractive apt-get install open-iscsi --yes",
      "${data.template_file.agent.rendered}"
    ]
  }
}


data "template_file" "agent" {
  template = "${file("files/agent_install.sh")}"
  vars = {
    server_ip = "${scaleway_server.master.public_ip}"
    token     = "${data.external.join_token.result.token}"
  }
}

data "external" "join_token" {
  depends_on = ["null_resource.copy_configs"]
  program    = ["./files/fetch-token.sh"]
}
