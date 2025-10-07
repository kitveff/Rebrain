## Configmaps and secrets

## Задание

```
Изучите документацию по downwardAPI
Создайте imagepullsecret с именем regcred из логина pull-creds и пароля gldt-LUE7NKmJu3F55r_fxsZC для регистри registry.rebrainme.com.
Создайте под с именем nginx, который использует данный imagepullsecret и образ image: registry.rebrainme.com/workshops/middle/kubernetes-local/newplatform_autochecks/nginx:latest.
Создайте конфигмап с именем nginx-config и содержимым из файла nginx.conf (файл можно выгрузить из любого пода с nginx командой kubectl exec $podname -- cat /etc/nginx/nginx.conf > nginx.conf) и измените число worker_process в этом файле на 4.
Создайте секрет creds с типом basic-auth username=rebrain password=secret
Модифицируйте под- смонтируйте:
Конфигмап nginx-config как файл /etc/nginx/nginx.conf (т.е., по сути, ваше монтирование должно полностью заменить файл. Если ваш контейнер не стартует, скорее всего вы замонтировали всю директорию и почитайте про subPath).
Секрет creds должен будет создать 2 env-переменных COOL_USER COOL_PASSWORD
Используйте downwardAPI. Смонтируйте внутрь пода имя ноды, на которой он находится в переменную MY_NODE.
Проверьте работоспособность ваших подов и наличие переменных.

```

# Steps:

```sh

kubectl create secret docker-registry regcred \
  --docker-server=registry.rebrainme.com \
  --docker-username=pull-creds \
  --docker-password=gldt-LUE7NKmJu3F55r_fxsZC

nano nginx-pod.yaml

kubectl apply -f nginx-pod.yaml


```