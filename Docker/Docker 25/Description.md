# Compose: хранение логов в EFK

## Задание

```
В репозитории из предыдущего задания (dkr-30-voting) создайте новую ветку с именем dkr-31-voting-efk.
Измените docker-compose.yml-файл, добавив следующее:
добавьте EFK-стек;
Fluentd должен быть доступен с хоста;
Kibana должна быть доступна с хоста;
остальные сервисы должны отправлять логи в fluentd через fluentd log driver.
Запустите сервис с именем проекта rbm31.
Сконфигурируйте приложение, выполнив команды из раздела Migration и Seeding в README репозитория.
Обратитесь к сервису по localhost:20000/polls (вы должны увидеть json-объект).
Откройте Kibana в браузере и проверьте, что логи запроса присутствуют.
Загрузите новую ветку с изменениями в репозиторий.
```

# Steps:

```sh
1. git clone https://gitlab.rebrainme.com/devops_users_repos/5222/dkr-30-voting.git
2. nano docker-compose.yml
3. mkdir fluentd
4. mkdir fluentd/conf
5. vi fluentd/conf/fluentd.conf
6. vi fluentd Dockerfile
3. docker-compose -p rbm31 up -d
4. sudo docker ps -a
5. sudo docker exec -it $id sh
6. php artisan migrate --force
7. php artisan db:seed --force
8. curl localhost:20000/polls
```