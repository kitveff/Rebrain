[vps]
%{for ip in ips ~}
${ip}
%{ endfor ~}

[load_balancer]
${ips[0]}

[app_server]
${ips[1]}
