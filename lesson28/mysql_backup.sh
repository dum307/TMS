#!/bin/bash

# Путь к директории бэкапа
BACKUP_DIR="/opt/mysql_backup"

# Проверяем существует ли директория бэкапа, если нет - создаем её
if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p $BACKUP_DIR
fi

# Имя файла бэкапа с текущей датой
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
FILENAME="db_backup_$DATE.sql"

# Команда для создания бэкапа базы данных
mysqldump testdb > $BACKUP_DIR/$FILENAME
