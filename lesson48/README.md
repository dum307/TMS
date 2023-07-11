# Домашнее задание Kubernetes 1

1. Выполнить установку kubectl
2. Выполнить установку кластера Kubernetes в локальном окружении:
- либо minikube
- либо kind

Загрузить в репозитори скриншот выполнения команды 
```[bash]
kubectl config view
```

### Листинг выполнения команды

```
st-admin@tms:~$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /home/st-admin/.minikube/ca.crt
    extensions:
    - extension:
        last-update: Tue, 11 Jul 2023 10:22:56 UTC
        provider: minikube.sigs.k8s.io
        version: v1.30.1
      name: cluster_info
    server: https://192.168.49.2:8443
  name: minikube
contexts:
- context:
    cluster: minikube
    extensions:
    - extension:
        last-update: Tue, 11 Jul 2023 10:22:56 UTC
        provider: minikube.sigs.k8s.io
        version: v1.30.1
      name: context_info
    namespace: default
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: /home/st-admin/.minikube/profiles/minikube/client.crt
    client-key: /home/st-admin/.minikube/profiles/minikube/client.key
```