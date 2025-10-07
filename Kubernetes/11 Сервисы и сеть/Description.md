## Сервисы и сети

## Задание

```
Создайте деплоймент httpd-dp в namespace default с образом httpd.
Создайте сервис http-svc-int в namespace default с типом ClusterIP, который будет смотреть на поды из п. 1.
Создайте сервис http-svc-nodeport в namespace default с типом nodePort с портом 9999, который будет смотреть на поды из п. 1.
Вы получаете ошибку при создании сервиса, разберитесь в чем может быть проблема самостоятельно. А потом задайте порт 32501 и задеплойте сервис.
Создайте сервис http-svc-ext в namespace default с типом LoadBalancer, который будет смотреть на поды из п. 1.
Самостоятельно изучите команду kubectl port-forward. Она позволит прокидывать из kubernetes порт на машину, где установлен kubectl — это может помочь вам при дебаге.

```

# Steps:

```sh
nano httpd-deployment.yaml

kubectl apply -f httpd-deployment.yaml

kubectl get po

nano all-services.yaml

kubectl apply -f all-services.yaml

kubectl get services

```