# lesson35
Домашнее задание
1. Установить Jenkins в любом варианте.
2. Установить плагин Blue Ocean, Ansible и любые другие на свой выбор.
3. Создать pipeline, который:
• запускает несколько команд в разных stage (git clone , ansible-playbook, bash)
• отправляет уведомление в telegram о результатах сборки


В качестве ansible-playbook возьмём плейбук из задания 27
Описание задания 27:
- Создать ВМ с любым веб-сервером.
- Создать домен name.local и сделать его доступным 
через /etc/hosts (или DNS, если есть).
- Создать self-signed сертификат.
- Добавить сертификат в веб-сервер и настроить 
прослушивание HTTPS.
- Создать перенаправление с HTTP на HTTPS.
- Создать перенаправление с www.name.local на 
name.local
- Сделать self-signed SSL сертификат доверенным.
Вся настройка должна выполняться либо скриптом, либо 
плейбуком.


Для работы с ansible установлен ansible plugin.
Добавлена нода для запуска ansible плейбуков с тегом 'ansible'

Скрипт pipeline представлен в jenkinsfile в репозитории.

Создадим в меню Credentials креды для отправки сообщений телеграм боту. 
Они будут включать в себя токен и id чата.
Креды используются в пайплайне.
https://drive.google.com/file/d/1M2MLaSimfL6orUdBeXwr55qnNFtZ8WlQ/view

Результат выполнения пайплайна:
https://drive.google.com/file/d/1M2mznSpG1ZOs9EKczTHxtaD3sBF-tu2w/view?usp=sharing

Полученное сообщение от телеграм бота:
https://drive.google.com/file/d/1M3mYQXGZ2T8CuRJkKt-JSsUy8drbLCb7/view?usp=sharing

Лог выполнения пайплайна:
https://drive.google.com/file/d/1M5N_GtdaOEmQiH3HLxvBSPnIWXXn9Y32/view?usp=sharing
https://drive.google.com/file/d/1M5xGZIwkYKFNt52rdiXN_rSBP0f6AH7T/view?usp=sharing
https://drive.google.com/file/d/1M793y6wqcU5KjJ0gfZkhh9eWzeZ793px/view?usp=sharing
