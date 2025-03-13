# Docker Context

## Задание

```
С машины node1 сгенерируйте ssh-ключ при помощи команды ssh-keygen.
Настройте авторизацию по ключам с node1 на node2, node3 – при помощи команды ssh-copy-id user@NODEIP. Добавьте пользователя user в группу docker на всех машинах командой:

sudo usermod -aG docker user

Выведите текущий список контекстов на машине при помощи команды docker context ls.
При помощи команды docker context создайте контексты node2, node3 для управления соответствующими нодами.
Выведите текущий список контекстов на машине при помощи команды docker context ls.
Переключитесь на контекст node2:
Выполните команду docker pull образа nginx:stable;
Выполните команду docker images.
Переключитесь на контекст default и выполните команду docker images. Убедитесь, что на текущей машине нет загруженных образов.
Переключитесь на контекст node3:
Запустите контейнер с redis;
Выполните команду docker ps. Убедитесь, что ваш контейнер стартован.
Переключитесь на контекст default и выполните команду docker ps. Убедитесь, что на текущей машине нет запущенных контейнеров.
```

# Steps:

```sh
ssh-keygen -t rsa -b 4096 -C "user@node1"

ssh-copy-id user@<IP-адрес-node2>

ssh-copy-id user@<IP-адрес-node3>

На всех машинах (node1, node2, node3) do:
sudo usermod -aG docker user

newgrp docker

docker context ls

docker context create node2 --docker "host=ssh://user@158.160.95.61"
docker context create node3 --docker "host=ssh://user@158.160.20.118"

docker context ls

docker context use node2

docker pull nginx:stable

docker images

docker context use default

docker images

docker context use node3

docker run -d --name redis-container redis:alpine

docker context use default

docker ps
```