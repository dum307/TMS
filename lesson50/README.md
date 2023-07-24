# Домашнее задание Kubernetes 3

1. Развернуть кластер Kubernetes с несколькими узлами.
2. Выполнить развертывание любого приложения в кластере с сервисом типа:
- NodePort
- ClusterIP + Ingress
------------------------------------------------------------------

## Подготовка кластера:

### Развернём кластер Kubernetes из трёх нод
```
st-admin@tms:~$minikube start --nodes 3 -p tms
```

```
st-admin@tms:~$ kubectl get nodes 
NAME      STATUS   ROLES           AGE   VERSION
tms       Ready    control-plane   32m   v1.26.3
tms-m02   Ready    worker          31m   v1.26.3
tms-m03   Ready    worker          30m   v1.26.3
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

```
st-admin@tms:~/TMS/lesson50$ minikube -p tms service list
|---------------|------------------------------------|--------------|---------------------------|
|   NAMESPACE   |                NAME                | TARGET PORT  |            URL            |
|---------------|------------------------------------|--------------|---------------------------|
| default       | bar-service                        | No node port |                           |
| default       | foo-service                        | No node port |                           |
| default       | kubernetes                         | No node port |                           |
| default       | nodeport-service                   |           80 | http://192.168.67.2:30007 |
| ingress-nginx | ingress-nginx-controller           | http/80      | http://192.168.67.2:31374 |
|               |                                    | https/443    | http://192.168.67.2:31218 |
| ingress-nginx | ingress-nginx-controller-admission | No node port |                           |
| kube-system   | kube-dns                           | No node port |                           |
|---------------|------------------------------------|--------------|---------------------------|
```

## Краткое описание приложений

В конфигурации описаны три приложения с именами bar, foo, nodeport.

Приложения bar и foo доступны через ingress по путям:
- http://192.168.67.2:31374/bar
- http://192.168.67.2:31374/foo

Приложение nodeport доступно через сервис типа NodePort по пути:
- http://192.168.67.2:30007

## Проверка работы

* Приложение bar:
```
st-admin@tms:~/TMS/lesson50$ curl http://192.168.67.2:31374/bar
APP: bar PODNAME: bar-deployment-55b9d88984-445v9
st-admin@tms:~/TMS/lesson50$ curl http://192.168.67.2:31374/bar
APP: bar PODNAME: bar-deployment-55b9d88984-sn9sg
```


* Приложение foo:
```
st-admin@tms:~/TMS/lesson50$ curl http://192.168.67.2:31374/foo
APP: foo PODNAME: foo-deployment-5ff7cfd956-cjdh4
st-admin@tms:~/TMS/lesson50$ curl http://192.168.67.2:31374/foo
APP: foo PODNAME: foo-deployment-5ff7cfd956-mj5s7
```

* Приложение nodeport:

```
st-admin@tms:~/TMS/lesson50$ curl http://192.168.67.2:30007
APP: nodeport PODNAME: nodeport-deployment-6dcc79dcdb-9jjjb
st-admin@tms:~/TMS/lesson50$ curl http://192.168.67.2:30007
APP: nodeport PODNAME: nodeport-deployment-6dcc79dcdb-qbz2x
```