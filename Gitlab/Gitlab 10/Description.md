# Практическое задание
## Gitlab CI: Packages and Registries

## Задание

```
Напишите CI/CD-конвейер, в котором будут следующие стадии для кода из репозитория с примером на Node.js:

сборка пакета в пакетном менеджере npm и загрузка его в реестр пакетов;
сборка Docker-образа (для примера будем считать его базовым) и размещение его в Container registry;
сборка образа из базового с его предварительным скачиванием из регистра и добавление в этот образ пакета, созданного на первой стадии.

```

# Steps:

```sh
# Установка GitLab Runner
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
sudo apt-get install -y gitlab-runner

sudo systemctl enable --now docker

gitlab-runner register  --url https://gitlab.rebrainme.com  --token glrt-xWdTH_zWy4s1JX9-aYN7

sudo gitlab-runner register \
  --non-interactive \
  --url "https://gitlab.rebrainme.com/" \
  --registration-token "glrt-xWdTH_zWy4s1JX9-aYN7" \
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