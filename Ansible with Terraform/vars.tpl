%{for i, dns in dns_names ~}
server_name_${i+1}: ${dns}
ip_${i+1}: ${vps_ip[i]}
%{ endfor ~}
