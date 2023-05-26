# Домашнее задание
- Создать Pipeline Shared Library "deploy" и использовать ее в пайплайне деплоя.
- Реализовать свою конфигурацию Jenkins Configuration as a Code. После развертывания должен содержать две джобы:
    "CI" - multibranch pipeline (запускается вебхуком из git или вручную)
    "CD" - pipeline (запускается после успешного выполнения "CI" или вручную)

# Запуск проекта 
1. Запускаем скрипт **jenkins-server-build.sh**, который билдит наш **jenkins server** и заливает имедж в репозиторий.
2. Запускаем **docker compose**, который поднимает весь наш проект.

# Краткое описание работы проетка
При запуске Docker compose поднимается **Jenkins server** и подгружает конфигурацию из директории **casc_configs**.
Файл **casc_configs/seedjob.groovy** описывает конфигурацию джобов:
- создаётся папка **"lesson38"**
![folder](https://s1.hostingkartinok.com/uploads/images/2023/05/6abfbdd9046a4a0aead3b085fbe13613.jpg)
- в ней создаются две джобы **"CI"** и **"CD"**
![jobs](https://s1.hostingkartinok.com/uploads/images/2023/05/7402c5773a63df1a3123de219d4611d9.png)
- в джобе **"CI"** настроено автоматическое сканирование репозитория с интервалом в **1 минуту**, и в случае наличия изменений в ветке, запускает джоб
- джоб **"CD"** вызывается из джоба **"CI"** после того как имеджи запушены в репозиторий
- имеджи, которые были запушены в репозиторий созраняются с файл **/tmp/pushedImages.json**, который используется в джобе **"CD"**
- также в **"CD"** реализована проверка: если файл **/tmp/pushedImages.json** существует, запускать деплой, если не существует, пропустить этам деплоя. после деплоя файл **/tmp/pushedImages.json** удаляется и очищается рабочее пространство
![CI](https://s1.hostingkartinok.com/uploads/images/2023/05/05a547e27ec35f79af8469600c27252c.png)
![CI_LESSON38](https://s1.hostingkartinok.com/uploads/images/2023/05/f1a247d582d0eae59d648086760a92bc.png)
![CD](https://s1.hostingkartinok.com/uploads/images/2023/05/ab9b650829575237ef7e0aededa78a4c.png)
![CD_LESSON38](https://s1.hostingkartinok.com/uploads/images/2023/05/79d2320d7b2f8f5a07276d6d8bb91efb.png)
### [Лог выполнения "CI"](log_CI.txt) 
### [Лог выполнения "CD"](log_CD.txt)