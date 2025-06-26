# Практическое задание
## Gitlab CI: Cache and Artifacts

## Задание

```
Создайте собственный репозиторий с проектом (можно склонировать код проекта из примера).
Добавьте использование механизма кэширования в конвейер (подробности можете найти в официальной документации).
Убедитесь, что при использовании кэша скорость повторной сборки образа стала выше. Для этого запустите два раза подряд конвейер сначала без кэша, а затем с настроенным кэшем (тоже дважды).
В качестве ответа предоставьте скриншоты с запуском конвейеров без кэширования и с включенным кэшем, а также ссылку на репозитории или файл конвейера.

```

# Steps:

```sh
# Установка GitLab Runner
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
sudo apt-get install -y gitlab-runner

sudo systemctl enable --now docker

gitlab-runner register  --url https://gitlab.rebrainme.com  --token glrt-5AkoGa6PUcHeYqdLRnRX

sudo gitlab-runner register \
  --non-interactive \
  --url "https://gitlab.rebrainme.com/" \
  --registration-token "glrt-5AkoGa6PUcHeYqdLRnRX" \
  --executor "docker" \
  --docker-image "alpine:latest" \
  --description "Docker Runner" \
  --tag-list "docker-privileged" \
  --docker-privileged \
  --docker-volumes "/var/run/docker.sock:/var/run/docker.sock"

  
# Установка Docker
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl enable --now docker

docker pull l4mbada/rebrain:nginx-latest

docker run -p 8080:80 l4mbada/rebrain:nginx-latest

```