resource "digitalocean_droplet" "vps" {
  name      = "${var.vps_name}"
  region    = "nyc1"
  size      = var.vps_size
  image     = var.vps_image
  ssh_keys  = [data.digitalocean_ssh_key.rebrain_ssh_key.id, digitalocean_ssh_key.self_ssh_pub_key.id]
  backups   = false
  tags = [var.user_email, var.task_name]
}

resource "random_password" "password" {
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
  name    = "${var.login}"
  type    = "A"
  zone_id = data.aws_route53_zone.get_zone.zone_id
  allow_overwrite = true

  ttl = 300

  records = [
    local.vps_ip
  ]
}

data "aws_route53_zone" "get_zone" {
  name   = "devops.rebrain.srwx.net"
}

resource "local_file" "ansible_inventory" {
    content = local.info
    filename = "./Ansible/inventory"
}

resource "local_file" "group_vars" {
    content = templatefile("vars.tpl", 
      {
        dns_name = aws_route53_record.devops_dns_record.fqdn
        ip = digitalocean_droplet.vps.ipv4_address
      }
    )
    filename = "./Ansible/group_vars/all"
}

resource "null_resource" "ansible" {
  triggers = {
    inventory = local_file.ansible_inventory.content
    group_vars = local_file.group_vars.content        
  }
    provisioner "local-exec" {
    command = "cd ./Ansible/playbooks && ansible-playbook install_nginx.yml --vault-password-file ../secrets/secret_pass"
    }
  depends_on = [local_file.ansible_inventory, local_file.group_vars]
}

