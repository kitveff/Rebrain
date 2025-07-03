Role Name
------------
Nginx

A brief description of the role goes here.
-------------
Устанавливает сервис nginx на ВПС  
Создает файл nginx.conf на основе шаблона nginx.conf.j2  
Создает 2 конфигурационных файла для виртуалхостов на основе шаблона virtualhosts.conf.j2

Requirements
------------

Role Variables
------------
vars/main.yml: vhosts

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.
------------
group_vars/all: server_name

Dependencies
------------

Example Playbook
------------
- name: Nginx  
  hosts: do_vps  
  roles: 
    - role: '../roles/nginx'


Author Information
------------
Kitaev A. <avkitay4@mts.ru>