# Практическое задание
## Gitlab CI: Runners

## Задание

```
В своем репозитории на gitlab.rebrainme.com создайте подгруппу devops и два проекта ci-project и ci-project2, как в прошлом задании.
Создайте раннер в проекте ci-project, установите на виртуальной машине в облаке или локально Гитлаб раннер с shell и docker исполнителями. После регистрации убедитесь в его доступности в консоли. Для раннера используйте дополнительный тег project-runner.
В группе devops создайте групповой раннер, также установите его и подключите. Групповой раннер так же должен быть с docker и shell исполнителями. Для раннера используйте дополнительный тег group-runner.
Убедитесь, что групповой раннер доступен по всех проектах группы.
```

# Steps:

```sh
token_shell=glrt-XfamamdxX34Pvomy384E
token_docker=glrt-JHu2z7uXWzHYuwYkzbxB


# Загрузим исполняемый код раннера
sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

# Выдадим разрешения на запуск
sudo chmod +x /usr/local/bin/gitlab-runner

# Создадим пользователя для GitLab Runner
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

# Установим раннер как сервис
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start

sudo gitlab-runner register  --url https://gitlab.com  --token "glrt-XfamamdxX34Pvomy384E"

gitlab-runner register  --url https://gitlab.rebrainme.com  --token glrt-JHu2z7uXWzHYuwYkzbxB

group_token_shell = glrt-yU38Hd6iT2A3xFZxroEF
gitlab-runner register  --url https://gitlab.rebrainme.com  --token glrt-yU38Hd6iT2A3xFZxroEF

group_token_docker = glrt-wjDM-V9uur_bL1qj6Hsm
gitlab-runner register  --url https://gitlab.rebrainme.com  --token glrt-wjDM-V9uur_bL1qj6Hsm
```