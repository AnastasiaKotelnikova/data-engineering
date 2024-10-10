# Интеграция и трансформация данных - ETL и ELT

В качестве практики установила Pentaho Data Integration. Поскольу программа не очень актуальна на 2024 год, решила сразу сосредоточиться на Apache Airflow. 

Ниже примеры работы с Pentaho:

1. Данный job загружает файл sample-superstore.xls, если он еще не загружен, затем соединяет 3 таблицы в файл csv. Следующие 2 трансформации разделяют с помощью фильтрации таблицы по штатам и обрабатывают строки.

![](https://github.com/AnastasiaKotelnikova/data-engineering/blob/dfda58e69740adb0199cad17732d957b405f88dd/DE-101/Module4/Practice/Pentaho_job%201.PNG)

2. Второй job делает трансформацию 3 таблиц (Staging и Dimension Tables) и создает таблицу фактов.

![](https://github.com/AnastasiaKotelnikova/data-engineering/blob/dfda58e69740adb0199cad17732d957b405f88dd/DE-101/Module4/Superstore/Pentaho_job%202.PNG)
