resource "digitalocean_droplet" "vps" {
  count     = var.vps_count
  name      = "${var.vps_name}-${count.index + 1}"
  region    = "nyc1"
  size      = var.vps_size
  image     = var.vps_image
  ssh_keys  = [data.digitalocean_ssh_key.rebrain_ssh_key.id, digitalocean_ssh_key.self_ssh_pub_key.id]
  backups   = false
  tags = [var.user_email, var.task_name]
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
  name    = "${var.login}-${count.index+1}"
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

resource "local_file" "ansible_inventory" {
    content = local.info
    filename = "./Ansible/inventory"
}

resource "local_file" "group_vars" {
  count = var.vps_count
  content = templatefile("vars.tpl", 
    {
      dns_names = aws_route53_record.devops_dns_record[*].fqdn
      vps_ip = digitalocean_droplet.vps[*].ipv4_address
    }
  )
  filename = "./Ansible/group_vars/all"
}

resource "null_resource" "ansible" {
  triggers = {
    always_run = "${timestamp()}"
  }
    provisioner "local-exec" {
    command = "cd Ansible && ansible-playbook playbooks/install_nginx.yml -i inventory --vault-password-file secrets/secret_pass"
    }
  depends_on = [local_file.ansible_inventory, local_file.group_vars]
}

