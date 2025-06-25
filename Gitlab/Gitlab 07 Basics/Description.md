# Практическое задание
## GitLab CI: Basics

## Задание

```
Создайте собственный репозиторий с проектом (можно склонировать код проекта из примера).
Установите и настройте раннер с Docker Executor на работу в привилегированном режиме на своей виртуальной машине. Вы можете использовать VirtualBox (подробнее можно прочесть здесь) для создания раннера. Он понадобится вам в дальнейшем, поэтому мы не предлагаем использование динамических виртуальных машин. Альтернативно вы можете использовать виртуальные машины в вашем собственном аккаунте любого облачного провайдера (Яндекс, Cloud.ru, DigitalOcean…).
Запустите конвейер и убедитесь, что он работает без ошибок.
```

# Steps:

```sh
# Установка Docker
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl enable --now docker

# Установка GitLab Runner
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
sudo apt-get install -y gitlab-runner

gitlab-runner register  --url https://gitlab.rebrainme.com  --token glrt-KXopyxdFCVbvyeez5XHE

sudo gitlab-runner register \
  --non-interactive \
  --url "https://gitlab.rebrainme.com/" \
  --registration-token "glrt-KXopyxdFCVbvyeez5XHE" \
  --executor "docker" \
  --docker-image "alpine:latest" \
  --description "Docker Runner" \
  --tag-list "docker-privileged" \
  --docker-privileged \
  --docker-volumes "/var/run/docker.sock:/var/run/docker.sock"

В корень репозитория файл .gitlab-ci.yml:

# укажем специальные переменные variables для корректной работы докера в докере
# (этот режим потребуется для сборки образа)
variables:
  DOCKER_HOST: tcp://docker:2375
  DOCKER_TLS_CERTDIR: ""

stages:  
  - linter # отвечает за проверку Dockerfile на ошибки
  - audit  # проводит аудит кода проекта на уязвимости      
  - build  # собирает образ и размещает его в регистре (здесь: регистр Gitlab)

docker-lint-job:   
  stage: linter           # стадия (из определённых выше)
  image: docker:24.0.5    # используемый образ
  services:               # позволяет запустить другой контейнер
    - docker:24.0.5-dind 
  script:                 # код команды для выполнения
    - docker run --rm -i ghcr.io/hadolint/hadolint < Dockerfile

yarn-audit-job:
  stage: audit
  image: node:16-alpine 
  script:
    - yarn install && yarn audit --level high
  allow_failure: true     # идём дальше, даже если есть ошибки

build-job:       
  stage: build
  image: docker:24.0.5
  services:
    - docker:24.0.5-dind
  script:
    - docker login -u gitlab-ci-token -p ${CI_JOB_TOKEN} ${CI_REGISTRY}
    - docker build -t ${CI_REGISTRY_IMAGE}/$CI_PROJECT_PATH_SLUG:$CI_COMMIT_REF_SLUG.$CI_PIPELINE_ID .
    - docker push ${CI_REGISTRY_IMAGE}/$CI_PROJECT_PATH_SLUG:$CI_COMMIT_REF_SLUG.$CI_PIPELINE_ID


```