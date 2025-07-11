## Поды (pods)

## Задание

```
Запустите под с параметрами: имя nginx, образ nginx:stable-alpine3.17, имя контейнера mynginx.
Используя утилиту kubectl, добавьте вашему поду аннотацию “iddqd=true”.
Используя утилиту kubectl, добавьте вашему поду лейбл “blacklabel=true”.
Изучите флаги команды kubectl get pods и сделайте вызов команды так, чтобы получить все метки, присвоенные вашему поду.
Изучите флаг --output и получите ip-адрес пода и имя ноды, на которой он запущен.
Используя знания из п. 6, модифицируйте команду kubectl api-resources, чтобы узнать, какие действия (”VERBS”), с точки зрения API, возможны над подами

```

# Steps:

```sh

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: mynginx
    image: nginx:stable-alpine3.17
EOF

kubectl annotate pod nginx iddqd=true

kubectl label pod nginx blacklabel=true

kubectl get pods nginx --show-labels

kubectl get pod nginx -o custom-columns=NAME:.metadata.name,IP:.status.podIP,NODE:.spec.nodeName

kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n default

```