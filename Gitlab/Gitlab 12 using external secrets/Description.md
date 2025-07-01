# Практическое задание
## Gitlab CI: using external secrets

## Задание

```
Настройте HashiCorp Vault-сервер в окружении, которое доступно ниже.
Важное отличие: из-за особенностей работы Gitlab и платформы аутентификация с помощью JWT не работает, поэтому после настройки сервера Vault в CI/CD для подключения нужно будет использовать токен (в учебных целях). Токен вы можете создать отдельный с необходимыми правами в Vault, либо использовать root, который вы получите при проведении процедуры распечатывания (unseal). Для старта Vault на учебном инстансе, выполните команды
export VAULT_ADDR='http://127.0.0.1:8200'
nohup ./script.sh &
# начать процедуру распечатывания
vault operator init # тут получите коды и далее, перейдя по внешнему IP адресу, сможете завершить распечатывание и залогиниться
Создайте секрет, в котором будет храниться токен для доступа к удалённому Docker registry (например DoсkerHub).
Напишите конвейер (можно взять пример из блока про основы), в котором на стадии загрузки образа в регистр будет использовать секрет из HashiCorp Vault. Конвейер должен иметь стадии линтера докер-файла, получения секрета и сборки с последующей загрузкой образа.
Можно использовать отдельные стадии для получения секрета из Vault и использования его для аутентификации в Docker registry (потребуется использование артефактов для передачи токена между стадиями). Второй вариант — установить в образ для стадии сборки и загрузки образа vault.

```

# Steps:

```sh
gitlab-runner register  --url https://gitlab.rebrainme.com  --token glrt-4UPj87mdAHCCcvfA13QW

sudo gitlab-runner register \
  --url "https://gitlab.rebrainme.com/" \
  --registration-token "glrt-4UPj87mdAHCCcvfA13QW" \
  --executor "docker" \
  --docker-image "alpine:latest" \
  --description "Docker Runner" \
  --docker-privileged

export VAULT_ADDR='http://127.0.0.1:8200'
nohup ./script.sh &
vault operator init

user@gitlabtask7-hyyys:~$ vault operator init


vault policy write myproject - <<EOF
path "*" {
  capabilities = [ "read" ]
}
EOF



gitlab-runner unregister --url https://gitlab.rebrainme.com --token glrt-7yHsKM_PswJcQKv79eqj/gitlab-runner/config.toml

Initial Root Token: hvs.Sm6QWfs6nH26wMGjpprDtvpw

vault operator unseal

Dockerhub token for vault: dckr_pat_5k8iESblyxhy1mngv7ceg2pggJc

user@gitlabtask7-hyyys:~$ vault kv put docker/registry token="dckr_pat_5k8iESblyxhy1mngv7ceg2pggJc"
==== Secret Path ====
docker/data/registry

======= Metadata =======
Key                Value
---                -----
created_time       2025-07-01T12:43:46.531344551Z
custom_metadata    <nil>
deletion_time      n/a
destroyed          false
version            1



#########################################################################################
#Включите метод аутентификации
$ vault auth enable jwt
Success! Enabled jwt auth method at: jwt/

vault write auth/jwt/config \
  oidc_discovery_url="https://gitlab.rebrainme.com" \
  bound_issuer="gitlab.rebrainme.com"

#Настройте политику для доступа к секрету (в качестве примера дадим политику на чтение любых объектов (не применять в продакшне!
vault policy write myproject - <<EOF
path "*" {
  capabilities = [ "read" ]
}
EOF

vault policy write dockerhub - <<EOF
path "kv/data/dockerhub" {
  capabilities = ["read"]
}
EOF

#Настройте роль на сервере Vault, ограничив роли проектом или пространством имён, как описано в разделе документации «Настройка ролей сервера Vault»
vault write auth/jwt/role/myproject - <<EOF
{
  "role_type": "jwt",
  "policies": ["myproject"],
  "token_explicit_max_ttl": 60,
  "user_claim": "avkitay4@mts.ru",
  "bound_claims": {
    "project_id": "69249", # необходимо взять из настроек в гитлабе (ниже скрин)
    "ref": "main",
    "ref_type": "branch"
  }
}
EOF



user@gitlabtask7-isjgp:~$ vault secrets enable -path=kv kv-v2
Success! Enabled the kv-v2 secrets engine at: kv/
user@gitlabtask7-isjgp:~$ vault kv put kv/dockerhub auth_token="dckr_pat_5k8iESblyxhy1mngv7ceg2pggJc" username="l4mbada"
== Secret Path ==
kv/data/dockerhub

======= Metadata =======
Key                Value
---                -----
created_time       2025-07-01T09:25:17.298520486Z



```