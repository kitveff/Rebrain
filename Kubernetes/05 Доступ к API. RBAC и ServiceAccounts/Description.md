## Доступ к API. RBAC и ServiceAccounts

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
https://kubernetes.io/ru/docs/reference/kubectl/cheatsheet/

kubectl create namespace test-rbac

# Создаем сервисные аккаунты
kubectl create serviceaccount test-user -n test-rbac
kubectl create serviceaccount test-admin -n test-rbac

# Создаем токены для сервисных аккаунтов
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: test-user-token
  namespace: test-rbac
  annotations:
    kubernetes.io/service-account.name: test-user
type: kubernetes.io/service-account-token
EOF

kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: test-admin-token
  namespace: test-rbac
  annotations:
    kubernetes.io/service-account.name: test-admin
type: kubernetes.io/service-account-token
EOF


#Create role
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: test-role
  namespace: test-rbac
rules:
- apiGroups: [""]
  resources: ["serviceaccounts"]
  verbs: ["get", "list", "watch", "create", "update", "patch"]
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
EOF


kubectl create rolebinding test-binding \
  --role=test-role \
  --serviceaccount=test-rbac:test-user \
  --namespace=test-rbac

 kubectl create rolebinding admin-binding \
  --clusterrole=cluster-admin \
  --serviceaccount=test-rbac:test-admin \
  --namespace=test-rbac

#получаем токен для test-user:  
USER_TOKEN=$(kubectl get secret test-user-token -n test-rbac -o jsonpath='{.data.token}' | base64 --decode)

#получаем текущий кластер
CURRENT_CLUSTER=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}')

#добавляем учетные данные в kubeconfig
kubectl config set-credentials test-user --token=$USER_TOKEN

#добавляем контекст
kubectl config set-context sa-context \
  --cluster=$CURRENT_CLUSTER \
  --namespace=test-rbac \
  --user=test-user

#проверяем доступ
kubectl --context sa-context -n test-rbac get serviceaccounts




```