# Практическое задание
## Структура API. CRD

## Задание

```
Установите kubectl и настройте autocompletion (чтобы он загружался при старте профиля). Шпаргалка по kubectl вам в помощь.
Посмотрите список нод.
Создайте неймспейс с именем my-ns.
Добавьте ему метку kubernetes=rulezz через команду kubectl label.
Сохраните манифест вашего неймспейса через команду kubectl get ........ -o yaml.
Отредактируйте файл, добавив дополнительно 2 лейбла: second="2" , third="3" — и примените ваш новый манифест. Через команду kubectl describe проверьте, что изменения применились. При помощи команды kubectl добавьте аннотации annotations=likelabels для неймспейса.
Отредактируйте манифест, удалив из него second=2, и примените. Получите ошибку
Снова сохраните неймспейс в файл. Удалите из него second=2, и примените
```

# Steps:

```sh
https://kubernetes.io/ru/docs/reference/kubectl/cheatsheet/

source <(kubectl completion bash) # настройка автодополнения в текущую сессию bash, предварительно должен быть установлен пакет bash-completion .

echo "source <(kubectl completion bash)" >> ~/.bashrc # добавление автодополнения autocomplete постоянно в командную оболочку bash.

kubectl create namespace my-ns

kubectl label namespace my-ns kubernetes=rulezz

kubectl get namespace my-ns -o yaml > my-ns.yaml

nano my-ns.yaml

kubectl apply -f my-ns.yaml

kubectl describe namespace my-ns

kubectl annotate namespace my-ns annotations=likelabels

kubectl apply -f my-ns.yaml
# Ожидаемая ошибка: The Namespace "my-ns" is invalid: metadata.labels: Invalid value: "2": field is immutable

kubectl get namespace my-ns -o yaml > my-ns-updated.yaml


```