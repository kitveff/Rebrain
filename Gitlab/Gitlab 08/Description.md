# Практическое задание
## Gitlab CI: Variables

## Задание

```
Создайте конвейер CI/CD в проекте ci-project2, в котором будет собираться образ веб-сервера (nginx, apache) с заменой стартовой страницы на приветствие с текстом «Gitlab CI is working!»

Сохраните этот образ в docker-регистре (docker hub или другой ресурс, но не регистре самого Gitlab). Образ должен быть публичным.

Используйте переменные для указания необходимых учётных данных для загрузки образа во внешний регистр.

Также используйте линтер Docker файлов для проверки корректности собранного вами образа на стадии, предшествующей его загрузке.

Используйте опцию маскировки вывода переменных для чувствительных данных.

Скачайте и запустите ваш образ, чтобы убедиться в его работоспособности
```

# Steps:

```sh
# Установка GitLab Runner
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
sudo apt-get install -y gitlab-runner

sudo systemctl enable --now docker

gitlab-runner register  --url https://gitlab.rebrainme.com  --token glrt-iz92AHLe3zmAHuQwDmd6

sudo gitlab-runner register \
  --non-interactive \
  --url "https://gitlab.rebrainme.com/" \
  --registration-token "glrt-iz92AHLe3zmAHuQwDmd6" \
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