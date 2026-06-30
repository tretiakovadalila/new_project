#!/bin/bash

# Создание новых папок
mkdir -p data_script/raw 

mkdir -p data_script/processed data_script/archive

# Перемещение файла в новую папку для сырых данных с переименованием
mv customers_script.csv data_script/raw/customers.csv

# Перемещение папки с обработанными данными
mv data_script/raw/customers.csv data_script/processed/customers_processed.csv

# Копирование файла в архив
cp data_script/processed/customers_processed.csv data_script/archive/

# Резервное копирование папки с файлами
cp -r data_script/ backup/

# Удаление лишних файлов
rm data_script/archive/customers_processed.csv 
rm -r backup
