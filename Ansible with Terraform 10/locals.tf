locals {
  vps_ip = digitalocean_droplet.vps.ipv4_address
}


locals {
  info = templatefile(
    "./inventory.tpl", 
    { 
      ip = digitalocean_droplet.vps.ipv4_address
    }
  )
}
