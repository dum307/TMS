#!/usr/bin/python3

import os

def print_files_in_directory(path):
    try:
        if not os.path.exists(path):
            print(f"Путь '{path}' не существует.")
            return
        if not os.path.isdir(path):
            print(f"Путь '{path}' не является каталогом.")
            return
        if not os.listdir(path):
            print(f"Каталог '{path}' пуст.")
            return

        for filename in os.listdir(path):
            file_path = os.path.join(path, filename)
            if os.path.isdir(file_path):
                print_files_in_directory(file_path)
            else:
                print(file_path)
    except Exception as e:
        print(f"Возникла ошибка: {e}")

path = input("Введите путь к каталогу: ")
print_files_in_directory(path)
