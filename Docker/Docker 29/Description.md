# Swarm: запускаем сервис, доступный извне

## Задание

```
В репозитории dkr-30-voting из предыдущих заданий создайте новую ветку с именем dkr-37-routing-mesh.
Измените docker-compose.yml-файл, добавив директиву для routing mesh сервиса nginx на порт 8080 внешнего адреса каждой ноды.
Запустите обновлённый стек.
При помощи команды curl с опцией i обратитесь к каждой ноде по внешнему адресу и порту по пути /ping.
Загрузите новую ветку с изменениями в репозиторий.
```

# Steps:

```sh
git checkout -b dkr-37-routing-mesh

git swarm init

docker swarm join --token SWMTKN-1-0kd6wcpseljfzythvnyux3ryfvj2ugq89q4wp0slxyrgrtk2h8-2se67pvueeuylj80f7uclivja 158.160.47.104:2377 на второй и третьей ноде

sudo docker-compose build

sudo docker stack deploy -c docker-compose.yml voting-stack --with-registry-auth

curl -i http://<IP-адрес-node1>:8080/ping
curl -i http://<IP-адрес-node2>:8080/ping
curl -i http://<IP-адрес-node3>:8080/ping
```