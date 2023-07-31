# Домашнее задание Kubernetes 4

Выполнить развертывание Wordpress в namespace dev в составе:
- mysql (statefulset), должнен использоваться PV
- wordpress (deployment), должнен использоваться PV
- nginx (deployment)
- ingress
- NetworkPolicy, ограничивающий входящий трафик для mysql pods только с wordpress pods
- все конфигурации и секреты должны передаваться через configMaps и secrets

Предварительно в кластере должны быть развернуты:
- CNI с поддержкой NetworkPolicy
- PVs
- Ingress-controller
------------------------------------------------------------------

## Подготовка кластера:

### Развернём кластер Kubernetes из трёх нод и сетевым плагином calico
```
st-admin@tms:~$minikube start --nodes 3 --network-plugin=cni --cni=calico
```

```
st-admin@tms:~$ kubectl get pods -l k8s-app=calico-node -A
NAMESPACE     NAME                READY   STATUS    RESTARTS   AGE
kube-system   calico-node-t8jw4   1/1     Running   0          21h
kube-system   calico-node-v6vt9   1/1     Running   0          21h
kube-system   calico-node-x28t2   1/1     Running   0          21h
```

### Установим Ingress Controller в minikube

```
st-admin@tms:~$ minikube addons enable ingress
```

```
st-admin@tms:~$ kubectl get pods -n ingress-nginx
NAME                                        READY   STATUS      RESTARTS   AGE
ingress-nginx-admission-create-hzgpt        0/1     Completed   0          23h
ingress-nginx-admission-patch-g5r59         0/1     Completed   1          23h
ingress-nginx-controller-6cc5ccb977-r7mwp   1/1     Running     0          23h
```

### После запуска проекта посмотрим список сервисов minikube для подключения

```
st-admin@tms:~$ minikube service list
|---------------|------------------------------------|--------------|---------------------------|
|   NAMESPACE   |                NAME                | TARGET PORT  |            URL            |
|---------------|------------------------------------|--------------|---------------------------|
| default       | kubernetes                         | No node port |                           |
| default       | mysql                              | No node port |                           |
| default       | nginx                              | No node port |                           |
| default       | wordpress                          | No node port |                           |
| ingress-nginx | ingress-nginx-controller           | http/80      | http://192.168.58.2:30275 |
|               |                                    | https/443    | http://192.168.58.2:31784 |
| ingress-nginx | ingress-nginx-controller-admission | No node port |                           |
| kube-system   | kube-dns                           | No node port |                           |
|---------------|------------------------------------|--------------|---------------------------|
```

## Проверка доступности сайта

Так как адрес миникуба у меня нигде не маршрутизируется, пробросим порт с хоста с установленным миникубом к себе на локальную машину

```
ssh -L 80:192.168.58.2:30275 st-admin@192.168.7.95
```

### Скриншот
![wp](https://s1.hostingkartinok.com/uploads/images/2023/07/4a2790aa4bd93cb3ccba6a82911a10a4.png)
