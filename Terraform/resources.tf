resource "digitalocean_droplet" "vps" {
  count     = var.vps_count
  name      = "${var.vps_name}-${count.index + 1}"
  region    = "nyc1"
  size      = var.vps_size
  image     = var.vps_image
  ssh_keys  = [data.digitalocean_ssh_key.rebrain_ssh_key.id, digitalocean_ssh_key.self_ssh_pub_key.id]
  backups   = false
  tags = [var.user_email, var.task_name]
  connection {
    type     = "ssh"
    user     = var.vps_user
    private_key = file(var.private_key)
    host     = self.ipv4_address
    }

  provisioner "remote-exec" {
    inline = [
      "echo '${var.vps_user}:${random_password.password[count.index].result}' | sudo chpasswd"
    ]
  }
}

resource "random_password" "password" {
  count = var.vps_count
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


data "digitalocean_ssh_key" "rebrain_ssh_key" {
  name = "REBRAIN.SSH.PUB.KEY"
}

resource "digitalocean_ssh_key" "self_ssh_pub_key" {
  name = "self_ssh_key"
  public_key = file(var.pub_key)
}

resource "aws_route53_record" "devops_dns_record" {
  count   = var.vps_count
  name    = "${var.devs[count.index]["self_login"]}-${var.devs[count.index]["prefix"]}"
  type    = "A"
  zone_id = data.aws_route53_zone.get_zone.zone_id
  allow_overwrite = true

  ttl = 300

  records = [
    local.vps_ip[count.index]
  ]
}

data "aws_route53_zone" "get_zone" {
  name   = "devops.rebrain.srwx.net"
}
resource "local_file" "file_info" {
    count = var.vps_count
    content = local.info
    filename = "./infra"
}