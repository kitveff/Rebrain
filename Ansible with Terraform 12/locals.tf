locals {
  vps_ip = digitalocean_droplet.vps[*].ipv4_address
}


locals {
  info = templatefile(
    "./inventory.tpl", 
    { 
      ips = local.vps_ip
    }
  )
}
