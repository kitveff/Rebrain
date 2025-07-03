all:
  children:
    do_vps:
      hosts:
        vps:
          ansible_host: ${ip}
