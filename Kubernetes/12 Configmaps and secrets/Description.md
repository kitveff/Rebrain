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

#Создание imagePullSecret

kubectl create secret docker-registry regcred \
  --docker-server=registry.rebrainme.com \
  --docker-username=pull-creds \
  --docker-password=gldt-9J9ys4uZR9C4CvWjR71F

# Получаем nginx.conf из существующего пода (если есть)
# kubectl exec <pod-name> -- cat /etc/nginx/nginx.conf > nginx.conf

# Создаем файл nginx.conf с worker_processes 4
cat > nginx.conf << EOF
worker_processes 4;

events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    sendfile on;
    keepalive_timeout 65;

    server {
        listen 80;
        server_name localhost;

        location / {
            root /usr/share/nginx/html;
            index index.html index.htm;
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
            root /usr/share/nginx/html;
        }
    }
}
EOF

# Создаем ConfigMap
kubectl create configmap nginx-config --from-file=nginx.conf=./nginx.conf


#Создание Secret с типом basic-auth

kubectl create secret generic creds \
  --type=kubernetes.io/basic-auth \
  --from-literal=username=rebrain \
  --from-literal=password=secret

nano nginx-pod.yaml

kubectl apply -f nginx-pod.yaml

# Проверяем статус пода
kubectl get pod nginx

# Проверяем переменные окружения (особенно MY_NODE)
kubectl exec nginx -- env | grep -E "COOL_USER|COOL_PASSWORD|MY_NODE|MY_POD"

# Проверяем конфигурацию nginx
kubectl exec nginx -- cat /etc/nginx/nginx.conf

# Проверяем downwardAPI файлы
kubectl exec nginx -- ls -la /etc/pod-info/
kubectl exec nginx -- cat /etc/pod-info/pod-name
kubectl exec nginx -- cat /etc/pod-info/pod-namespace
kubectl exec nginx -- cat /etc/pod-info/labels

```