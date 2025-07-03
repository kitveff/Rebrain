locals {
  vps_ip = digitalocean_droplet.vps[*].ipv4_address
}

locals {
  info = templatefile(
    "./template.tpl", 
    { 
      vps_addreses = digitalocean_droplet.vps.*.ipv4_address
      dns_names    = aws_route53_record.devops_dns_record.*.fqdn 
      passwords    = random_password.password.*.result 
    }
  )
}