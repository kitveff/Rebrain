%{for i, dns in dns_names ~}
${i+1}: ${dns} ${vps_addreses[i]} ${passwords[i]}
%{ endfor ~}