# Домашнее задание Kubernetes 2

1. Развернуть кластер Kubernetes с несколькими узлами.
2. Выполнить развертывание любого приложения в кластере с помощью:
- Deployment
- ReplicaSet
- StatefulSet
- DaemonSet
- Job
- CronJob
------------------------------------------------------------------

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

### Deployment
```
st-admin@tms:~/TMS/lesson49$ kubectl apply -f deployment.yaml 
deployment.apps/my-deployment created
st-admin@tms:~/TMS/lesson49$ kubectl get po -owide
NAME                             READY   STATUS    RESTARTS   AGE   IP           NODE      NOMINATED NODE   READINESS GATES
my-deployment-74d8f8d7bf-7zrd7   1/1     Running   0          96s   10.244.2.3   tms-m03   <none>           <none>
my-deployment-74d8f8d7bf-8n9rm   1/1     Running   0          96s   10.244.1.3   tms-m02   <none>           <none>
my-deployment-74d8f8d7bf-kdwfg   1/1     Running   0          96s   10.244.1.2   tms-m02   <none>           <none>
my-deployment-74d8f8d7bf-wrlt9   1/1     Running   0          96s   10.244.0.3   tms       <none>           <none>
my-deployment-74d8f8d7bf-znfvh   1/1     Running   0          96s   10.244.2.2   tms-m03   <none>           <none>
st-admin@tms:~/TMS/lesson49$ kubectl get rs -owide
NAME                       DESIRED   CURRENT   READY   AGE     CONTAINERS   IMAGES       SELECTOR
my-deployment-74d8f8d7bf   5         5         5       2m23s   nginx        nginx:1.13   app=my-app,pod-template-hash=74d8f8d7bf
```

### Replicaset

```
st-admin@tms:~/TMS/lesson49$ kubectl get rs -owide
NAME            DESIRED   CURRENT   READY   AGE   CONTAINERS   IMAGES       SELECTOR
my-replicaset   5         5         5       33s   nginx        nginx:1.12   app=my-app
st-admin@tms:~/TMS/lesson49$ kubectl get pod -owide
NAME                  READY   STATUS    RESTARTS   AGE   IP           NODE      NOMINATED NODE   READINESS GATES
my-replicaset-296q7   1/1     Running   0          36s   10.244.1.5   tms-m02   <none>           <none>
my-replicaset-8whhl   1/1     Running   0          36s   10.244.0.4   tms       <none>           <none>
my-replicaset-pfgnj   1/1     Running   0          36s   10.244.2.4   tms-m03   <none>           <none>
my-replicaset-trh6d   1/1     Running   0          36s   10.244.1.4   tms-m02   <none>           <none>
my-replicaset-v8cwh   1/1     Running   0          36s   10.244.2.5   tms-m03   <none>           <none>
```

### Statefulset

```
t-admin@tms:~/TMS/lesson49$ kubectl apply -f statefulset.yaml 
service/nginx created
statefulset.apps/web created
st-admin@tms:~/TMS/lesson49$ kubectl get statefulsets.apps 
NAME   READY   AGE
web    3/3     50s
st-admin@tms:~/TMS/lesson49$ kubectl get pod -owide
NAME    READY   STATUS    RESTARTS   AGE   IP           NODE      NOMINATED NODE   READINESS GATES
web-0   1/1     Running   0          60s   10.244.1.6   tms-m02   <none>           <none>
web-1   1/1     Running   0          40s   10.244.2.6   tms-m03   <none>           <none>
web-2   1/1     Running   0          19s   10.244.0.5   tms       <none>           <none>
```

### Daemonset

```
st-admin@tms:~/TMS/lesson49$ kubectl apply -f daemonset.yaml 
daemonset.apps/node-exporter created
st-admin@tms:~/TMS/lesson49$ kubectl get pod -owide
NAME                  READY   STATUS    RESTARTS   AGE   IP             NODE      NOMINATED NODE   READINESS GATES
node-exporter-7hxsl   1/1     Running   0          39s   192.168.67.3   tms-m02   <none>           <none>
node-exporter-jf2bn   1/1     Running   0          39s   192.168.67.4   tms-m03   <none>           <none>
node-exporter-v6hhf   1/1     Running   0          39s   192.168.67.2   tms       <none>           <none>
```

### Job

```
st-admin@tms:~/TMS/lesson49$ kubectl apply -f job.yaml 
job.batch/hello created
st-admin@tms:~/TMS/lesson49$ kubectl logs pods/hello-2n8kp 
Thu Jul 20 13:24:20 UTC 2023
Hello from the Kubernetes cluster
st-admin@tms:~/TMS/lesson49$ kubectl get pod
NAME          READY   STATUS      RESTARTS   AGE
hello-2n8kp   0/1     Completed   0          91s
```


### CronJob

```
st-admin@tms:~/TMS/lesson49$ kubectl get cj
NAME    SCHEDULE      SUSPEND   ACTIVE   LAST SCHEDULE   AGE
hello   */1 * * * *   False     0        16s             4m17s
st-admin@tms:~/TMS/lesson49$ kubectl get jobs.batch
NAME             COMPLETIONS   DURATION   AGE
hello-28164351   1/1           6s         2m22s
hello-28164352   1/1           6s         82s
hello-28164353   1/1           6s         22s
st-admin@tms:~/TMS/lesson49$ kubectl get pod
NAME                   READY   STATUS      RESTARTS   AGE
hello-28164351-tk4zd   0/1     Completed   0          2m31s
hello-28164352-vshqj   0/1     Completed   0          91s
hello-28164353-489hj   0/1     Completed   0          31s
st-admin@tms:~/TMS/lesson49$ kubectl logs pods/hello-28164353-489hj
Thu Jul 20 13:53:02 UTC 2023
Hello from the Kubernetes cluster
```