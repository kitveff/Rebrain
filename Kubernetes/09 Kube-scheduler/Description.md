## Планирование и размещение pods: Kube-scheduler

## Задание

```
Создайте deployment с именем my-app, классом guaranteed и количеством реплик – 3. Все поды должны заехать на третью ноду.
Скорее всего, вы столкнётесь с ошибками размещения подов на третьей ноде. Устраните эти проблемы, так чтобы любой под мог на неё заехать (2 штуки)

```

# Steps:

```sh
# Добавляем taint (запрещаем все поды, кроме тех, у которых есть toleration)
kubectl taint nodes kuberorc-v3-6-3-lngzz dedicated=third-node:NoSchedule

# Добавляем label (чтобы удобнее было выбирать ноду)
kubectl label nodes kuberorc-v3-6-3-lngzz dedicated=third-node

nano my-app-deployment.yml

kubectl apply -f my-app-deployment.yml

#Смотрим события 
kubectl get events --sort-by='.metadata.creationTimestamp'


```