variable "vps_name" {
  type    = string
  default = "vps-ansible12"
}

variable "vps_disk_size" {
  type    = string
  default = "25"
}
variable "vps_filesystem" {
  type    = string
  default = "ext4"
}
variable "vps_size" {
  type    = string
  default = "s-1vcpu-1gb"
}
variable "vps_image" {
  type    = string
  default = "ubuntu-20-04-x64"
}

variable "do_token" {
  type = string
}

variable "task_name" {
  type = string
}

variable "user_email" { 
  type = string
}

variable "pub_key" {
  type = string
  default = "/mnt/c/id_rsa.pub"
  # default = "/mnt/c/ssh_pub_key/id_rsa.pub"
}

variable "login" {
  type = string
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "private_key" {
  type = string
  # default = "/mnt/c/users/akwhi/.ssh/id_rsa"
  default = "/mnt/c/Users/KITVEFF/.ssh/id_rsa"
}

variable "vps_user" {
  type = string
}

variable "vps_count" {
  default = 2
}