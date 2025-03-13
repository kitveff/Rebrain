# Compose: хранение логов в EFK

## Задание

```
Инициализируйте Swarm-кластер.
Выведите список нод.
Запустите одиночный сервис из образа nginx:stable с привязкой к порту 18989.
Выведите список сервисов.
Выведите список контейнеров.
Запустите стек из файла docker-compose-unmounted.yml
version: "3"
services:
  nginx:
    image: nginx:stable
    ports:
      - 127.0.0.1:18888:80

Выведите список стеков.
Выведите список сервисов.
Выведите список контейнеров.
```

# Steps:

```sh
1. docker swarm init
2. docker node ls
3. docker service create --name nginx-service --publish published=18989,target=80 nginx:stable
4. docker service ls
5. docker ps
6. vi docker-compose-unmounted.yml
7. docker stack deploy -c docker-compose-unmounted.yml my-stack
8. docker stack ls
9. docker service ls
10. docker ps
```