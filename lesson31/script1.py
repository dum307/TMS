#!/usr/bin/python3

def multiply():
    try:
        num1 = int(input("Введите первое число: "))
        num2 = int(input("Введите второе число: "))
        result = num1 * num2
        if result % 2 == 0:
            return 0
        else:
            return 1
    except ValueError:
        print("Ошибка: введены не цифры")
        return None

result = multiply()
if result is not None:
    print(result)
