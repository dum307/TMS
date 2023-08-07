# Домашнее задание Monitoring 1

## blackbox-exporter
Добавьте в Prometheus мониторинг сервисов ***comment***, ***post***, ***ui*** с помощью **blackbox** экспортера.

Образы для запуска демо приложения можно взять в Github Container Registry - **ghcr.io/dos12-onl**
----------------------------------------------------------------------------------------------------------------

### Установка prometheus-blackbox-exporter

* Чтобы просмотреть все настраиваемые параметры с подробными комментариями выполним команду:

```
helm show values prometheus-community/prometheus-blackbox-exporter > blackbox-srv.yaml
```

* Добавим свои параметры в файл blackbox.yaml

```
ingress:
  enabled: true
  hosts:
    - host: blackbox
      paths:
        - path: /
          pathType: ImplementationSpecific

config:
  modules:
    http_2xx:
      prober: http
      timeout: 5s
      http:
        valid_http_versions: ["HTTP/1.1", "HTTP/2.0"]
        follow_redirects: true
        preferred_ip_protocol: "ip4"
```

* Устаномим helm chart со своими параметрами

```
helm install -f blackbox.yaml blackbox prometheus-community/prometheus-blackbox-exporter
```

### Добавим джоб в конфигурацию prometheus в переменную **prometheus.prometheusSpec.additionalScrapeConfigs**

```
- job_name: 'blackbox'
metrics_path: /probe
params:
    module: [http_2xx]
static_configs:
    - targets:
    - http://ui.default.svc.cluster.local:9292
    - http://post.default.svc.cluster.local:5000
    - http://comment.default.svc.cluster.local:9292
relabel_configs:
    - source_labels: [__address__]
    target_label: __param_target
    - source_labels: [__param_target]
    target_label: instance
    - target_label: __address__
    replacement: blackbox-prometheus-blackbox-exporter.default.svc.cluster.local:9115
```

## Проверка работы

* **появившиеся таргеты**

![targets](https://s1.hostingkartinok.com/uploads/images/2023/08/f0e3d2d0ed3d57cb844bb86d3995c61f.png)


* **в конфиге появился наш созданный джоб**

![config](https://s1.hostingkartinok.com/uploads/images/2023/08/975a6101195553f707d87453443c6d5e.png)