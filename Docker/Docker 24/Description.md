# Compose: запуск Compose со сборкой образа

## Задание

```
В решении не должна быть использована  директива container_name. Она позволяет указать
произвольное имя сервису, но накладывает дополнительные ограничения: т. к. имена сервисов должны быть уникальными, использование директивы приводит к невозможности масштабирования сервиса.

Склонируйте репозиторий voting в свой аккаунт на gitlab.rebrainme.com с именем dkr-30-voting.
Напишите docker-compose.yml файл, который бы собирал приложение, запускал его и все требуемые зависимости:
nginx проксирует запросы на voting и доступен на хосте на порту 20000.
Пример конфигурационного файла находится в папке nginx, смонтируйте его в /etc/nginx/conf.d/default.conf.

Используйте alpine-версию образа.

voting собирается из репозитория.
mysql — база данных, к которой подключается voting. В качестве базового образа для сервиса необходимо использовать mysql:5.7
redis — in-memory хранилище для кэша.
Запустите сервис с именем проекта rbm30.
Сконфигурируйте приложение, выполнив команды из раздела Migration и Seeding в README репозитория.
Обратитесь к сервису по localhost:20000/polls (в ответе вы должны увидеть json-объект).
Загрузите новые файлы в репозиторий.
```

# Steps:

```sh
1. git clone https://gitlab.rebrainme.com/devops_users_repos/5222/dkr-30-voting.git
2. nano docker-compose.yml
3. docker-compose -p rbm30 up -d
4. sudo docker ps -a
5. sudo docker exec -it $id sh
6. php artisan migrate --force
7. php artisan db:seed --force
8. curl localhost:20000/polls
```