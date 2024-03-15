#!/bin/bash

# Проверяем наличие установленной утилиты pwgen
if ! command -v pwgen &> /dev/null; then
    echo "Ошибка: Утилита pwgen не установлена."
    echo "Для установки на Ubuntu Server 22.04 LTS используйте: sudo apt install pwgen"
    echo "Для установки на ALT Linux Server 10 используйте: sudo apt-get install pwgen"
    exit 1
fi

# Проверяем количество переданных аргументов
if [ "$#" -ne 2 ]; then
    echo "Ошибка: Некорректное количество аргументов."
    echo "Использование: $0 <префикс_логина> <количество_пользователей>"
    exit 1
fi

prefix=$1
user_count=$2

# Проверяем, что количество пользователей является целым числом
if ! [[ "$user_count" =~ ^[0-9]+$ ]]; then
    echo "Ошибка: Количество пользователей должно быть целым числом."
    echo "Использование: $0 <префикс_логина> <количество_пользователей>"
    exit 1
fi

# Создаем файл users.csv или перезаписываем его
> users.csv

# Генерируем пользователей с паролями и записываем в файл
for ((i=1; i<=user_count; i++)); do
    password=$(pwgen -1 8)  # Генерируем пароль с помощью утилиты pwgen
    echo "${prefix}_${i},${password}" >> users.csv
done

exit 0

