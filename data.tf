data "scaleway_image" "image" {
  architecture = "${var.instance_image.architecture}"
  name         = "${var.instance_image.name}"
}
