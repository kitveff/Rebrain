# Compose: хранение логов в EFK

## Задание

```
Инициализируйте swarm на трёх нодах. Выведите список нод.
В репозитории dkr-30-voting используйте docker-compose.yml из DKR_30-решения и создайте новую ветку с именем dkr-35-swarm. 
Соберите и загрузите образы в registry.rebrainme.com.
Измените docker-compose.yml на использование образа из registry и добавьте директиву для запуска сервиса nginx в двух экземплярах.
Запустите стек из файла docker-compose.yml.
Выведите список стеков.
Выведите список сервисов.
Выполните команду curl -4 -i localhost/ping на одном из хостов; сервис nginx должен проксировать запрос и вернуть ответ от сервиса voting.
```

# Steps:

```sh
1. sudo docker swarm init --advertise-addr 158.160.47.104
docker swarm join --token SWMTKN-1-0kd6wcpseljfzythvnyux3ryfvj2ugq89q4wp0slxyrgrtk2h8-2se67pvueeuylj80f7uclivja 158.160.47.104:2377 на второй и третьей ноде
2. docker node ls
3. sudo docker login registry.rebrainme.com/devops_users_repos/5222/dkr-30-voting
4. sudo docker-compose build
5. sudo docker tag dkr-30-voting_voting registry.rebrainme.com/devops_users_repos/5222/dkr-30-voting/voting:latest
6. sudo docker stack deploy -c docker-compose.yml voting-stack --with-registry-auth
7. docker stack ls
9. docker service ls
10. docker ps
```