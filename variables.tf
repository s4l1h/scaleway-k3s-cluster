variable "scw_org" {}

variable "scw_token" {}

variable "prefix" {}

variable "region" {
  default = "par1"
}
variable "instance_agents_type" {
  default = "DEV1-S"
}
variable "instance_agents_count" {
  default = "2"
}

variable "instance_master_type" {
  default = "DEV1-S"
}

variable "instance_image" {
  default = {
    architecture = "x86_64"
    name         = "Ubuntu Bionic"
  }
}

# SSH
variable "ssh_user" {
  description = "SSH user name to use for remote exec connections,"
  default     = "root"
}

variable "ssh_port" {
  description = "SSH user name to use for remote exec connections,"
  default     = "22"
}
variable "ssh_public_key_file" {
  description = "SSH public key file for remote exec connections,"
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key_file" {
  description = "SSH private key file for remote exec connections,"
  default     = "~/.ssh/id_rsa"
}

locals {
  ssh_public  = "${fileexists(var.ssh_public_key_file) ? trimspace(file(var.ssh_public_key_file)) : ""}"
  ssh_private = "${fileexists(var.ssh_private_key_file) ? file(var.ssh_private_key_file) : ""}"
}
