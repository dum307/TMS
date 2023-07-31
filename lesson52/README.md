# Домашнее задание Kubernetes 5

Создать Helm Chart для развертывания Wordpress в составе:
- mysql (statefulset), должнен использоваться PV
- NetworkPolicy, ограничивающий входящий трафик для mysql pods только с wordpress pods
- wordpress (deployment), должнен использоваться PV
- hpa (wordpress)
- ingress
- все конфигурации и секреты должны передаваться через configMaps и secrets

Предварительно в кластере должны быть развернуты:
- CNI с поддержкой NetworkPolicy
- PVs
- Ingress-controller

**В шаблонах манифестов не должно быть хардкода**

Развернуть Helm Chart в namespace dev
------------------------------------------------------------------

## Запуск проекта:

```
helm install -f variables.yaml wordpress wordpress-chart/
```

## Проверка:

```
$ curl -I http://192.168.58.2:30275
HTTP/1.1 302 Found
Date: Mon, 31 Jul 2023 14:48:07 GMT
Content-Type: text/html; charset=UTF-8
Connection: keep-alive
X-Powered-By: PHP/8.0.28
Expires: Wed, 11 Jan 1984 05:00:00 GMT
Cache-Control: no-cache, must-revalidate, max-age=0
X-Redirect-By: WordPress
Location: http://192.168.58.2:30275/wp-admin/install.php
```