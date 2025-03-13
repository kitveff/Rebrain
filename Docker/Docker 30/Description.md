# Swarm: Labels

## Задание

```
В репозитории dkr-30-voting из предыдущих заданий создайте новую ветку с именем dkr-38-labels.
Измените docker-compose.yml файл, убрав routing mesh.
Создайте в репозитории второй файл /home/user/dkr-30-voting/traefik-compose.yml, в котором опишите стек для запуска Traefik.
Запустите стек traefik (Traefik должен принимать запросы по 80 и 443 порту и перенаправлять их на сервисы внутри swarm).
Добавьте в /home/user/dkr-30-voting/docker-compose.yml лейблы для приёма трафика через traefik на домене из nip.io (Чтобы автопроверки корректно отработали, будем использовать адреса вида voting.x.x.x.x.nip.io , kibana.x.x.x.x.nip.io. Cервис nip.io будет резолвить их в ip-адрес x.x.x.x).
Запустите новый стек из /home/user/dkr-30-voting/docker-compose.yml.
Выведите список стеков.
Выведите список сервисов.
Выведите список контейнеров на каждой ноде.
При помощи команды curl с опцией i обратитесь к каждой ноде по внешнему адресу и 80 порту по пути /ping (Для сервиса nginx должны быть 3 label, вида voting.x.x.x.x.nip.io, voting.y.y.y.y.nip.io, voting.z.z.z.z.nip.io, чтобы каждая из нод могла ответить на запрос).
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