# Swarm: собираем логи кластера через EFK

## Задание

```
В репозитории из предыдущего задания (dkr-30-voting) добавьте Compose-файл /home/user/dkr-30-voting/efk.yml с описанием стека EFK с:
Elasticsearch хранит данные на диске GlusterFS (можно не подключать плагин gluster для docker);
Elasticsearch ограничен по памяти 1G;
установкой Fluentd на каждую ноду, чтобы он слушал на localhost (изучите директиву deploy и mode);
доступом к Kibana через Traefik с Basic Auth rebrainme:DockerRocks!.
Запустите данный стек.
Перепишите все остальные docker-compose на отправку логов через fluentd на localhost (/home/user/dkr-30-voting/docker-compose.yml).
Перевыложьте все стеки.
При помощи curl обратитесь к сервису по доменному имени, указанному для traefik, и по endpoint /polls и выведите время запроса.
Проверьте наличие логов в kibana.
Закоммитьте изменения в ветку dkr-42.
```

# Steps:

```sh
git checkout -b dkr-42

git swarm init

docker swarm join --token SWMTKN-1-0kd6wcpseljfzythvnyux3ryfvj2ugq89q4wp0slxyrgrtk2h8-2se67pvueeuylj80f7uclivja 158.160.47.104:2377 на второй и третьей ноде

sudo apt-get install apache2-utils
htpasswd -nbB rebrainme DockerRocks! + Экранировать символ "$" с помощью "$"

vi efk.yml
vi traefik-compose.yml
vi fluentd/Dockerfile

mkdir -p fluentd/conf
vi fluentd/conf/fluentd.conf

sudo docker build -t custom-fluentd:latest ./fluentd

sudo docker network create --driver=overlay --attachable voting-network
sudo docker stack deploy -c traefik-compose.yml traefik

sudo docker stack deploy -c efk.yml efk

sudo docker stack deploy -c docker-compose.yml voting-stack

curl -i http://voting.158.160.94.185.nip.io/polls
```