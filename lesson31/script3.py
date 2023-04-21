#!/usr/bin/python3

def print_list_elements(lst):
    """
    Функция принимает список lst и выводит каждый элемент списка на новой строке.
    """
    for elem in lst:
        print(elem)

# Запрос ввода списка у пользователя
input_str = input("Введите элементы списка через пробел: ")
my_list = input_str.split()

# Вызов функции для печати элементов списка
print_list_elements(my_list)
