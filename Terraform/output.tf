output "digitalocean_droplet" {
  value = [digitalocean_droplet.vps[*].name, digitalocean_droplet.vps[*].ipv4_address]
}
output "random_password" {
  value = [for passwd in random_password.password[*].result : nonsensitive(passwd)]
}