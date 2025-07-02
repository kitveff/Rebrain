## Установка кластера при помощи minikube

## Задание

```
Создайте неймспейс с именем test-rbac.
Создайте сервис-аккаунт с именем test-user в namespace test-rbac и токен.
Создайте сервис-аккаунт с именем test-admin в namespace test-rbac и токен.
В namespace test-rbac создайте роль test-role с правами:
На serviceaccounts все возможные права, кроме удалений.
На pods – get, list, watch.
Не должен иметь права на создание/изменение rolebindings в данном неймпсейсе.
Создайте rolebinding с именем test-binding и привяжите роль test-role к serviceaccount test-user в неймспейсе test-rbac.
В namespace test-rbac cоздайте binding с именем admin-binding для serviceaccount test-admin таким образом, чтобы он получил права на все ресурсы в текущем неймспейсе. Используйте clusterrole: cluster-admin.
Добавьте в текущий kubeconfig нового пользователя (serviceaccount test-user ) и контекст с именем sa-context . Проверьте доступ через команду kubectl --context sa-context -n test-rbac get sa.

```

# Steps:

```sh
user@vm:~$ curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
# дождёмся загрузки

# установим утилиту
user@vm:~$ sudo install minikube-linux-amd64 /usr/local/bin/minikube

# проверим корректность установки
user@vm:~$ minikube version
minikube version: v1.32.0
commit: 8220a6eb95f0a4d75f7f2d7b14cef975f050512d

# попробуем инициализировать кластер
user@vm:~$ minikube start
😄  minikube v1.32.0 on Ubuntu 22.04
👎  Unable to pick a default driver. Here is what was considered, in preference order:
💡  Alternatively you could install one of these drivers:
    ▪ docker: Not installed: exec: "docker": executable file not found in $PATH
    ▪ kvm2: Not installed: exec: "virsh": executable file not found in $PATH
    ▪ qemu2: Not installed: exec: "qemu-system-x86_64": executable file not found in $PATH
    ▪ podman: Not installed: exec: "podman": executable file not found in $PATH
    ▪ virtualbox: Not installed: unable to find VBoxManage in $PATH
# хорошая попытка, но нет. Нам нужно выбрать драйвер

Docker в качестве драйвера

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null"

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# добавим своему пользователю права для управления docker без sudo
sudo usermod -aG docker $USER && newgrp docker

# проверим работоспособность docker
docker run hello-world

minikube start --driver docker
# и ждём, пока будет выполняться установка ~ 10 минут

# запустим kubectl, чтобы пообщаться с нашим кластером
minikube kubectl -- get pods -A

# проверим, что там у нас с докером
docker ps

# запустим тестовый pod (минимальную единицу деплоя)
minikube kubectl -- run pod --image=nginx:latest

# проверим докер
docker ps

minikube addons list
#включить дополнения
minikube addons enable ingress
minikube addons enable metrics-server
```