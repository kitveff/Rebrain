## Планирование и размещение pods: Kube-scheduler

## Задание

```
Создайте deployment с именем nginx-ds в namespace default c образом nginx:alpine3.17 и количеством реплик 3.
Поставьте на паузу rollout.
Примените обновление (поменяйте образ на nginx:alpine3.18).
Изучите выводы команд (kubectl describe).
Включите rollout.
Изучите выводы команд (kubectl describe).

```

# Steps:

```sh
#Создание Deployment
kubectl create deployment nginx-ds --image=nginx:alpine3.17 --replicas=3 -n default

#Проверка созданного Deployment
kubectl get deployment nginx-ds -n default
kubectl get pods -n default -l app=nginx-ds

#Постановка rollout на паузу
kubectl rollout pause deployment/nginx-ds -n default

#Обновление образа
kubectl set image deployment/nginx-ds nginx=nginx:alpine3.18 -n default

#Изучение состояния Deployment
kubectl describe deployment nginx-ds -n default

#Возобновление rollout
kubectl rollout resume deployment/nginx-ds -n default

#Проверка завершения обновления
kubectl rollout status deployment/nginx-ds -n default

#Изучение обновленного Deployment
kubectl describe deployment nginx-ds -n default

#образ в Pods
kubectl describe pods -n default -l app=nginx-ds | grep Image:

```