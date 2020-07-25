--+ 1)Создать представление статистики о продажах во всех автосалонах,
--+ которое будет содержать данные
--+ - Наименование автосалона
--+ - Количество продаж
--+ - Сумма продаж
--+ - Количество клиентов

create view Statistic_data
as 
select shop_name, count(car) as 'Количество продаж', 
sum(price) as 'Сумма продаж',
count(distinct id_client) as 'Количество клиентов' from shops
join sales on sales.id_shop_address=shops.id
join cars on cars.id=sales.id_car
group by shop_name

--+ 2) Создать представления (2 отдельных) с данными о продажах в салоне
--+ Иномарка и 4 колеса

create view Statistic_data_Inomarka
as 
select shop_name, count(car) as 'Количество продаж', 
sum(price) as 'Сумма продаж',
count(distinct id_client) as 'Количество клиентов' from shops
join sales on sales.id_shop_address=shops.id and shop_name=N'Иномарка'
join cars on cars.id=sales.id_car
group by shop_name

create view Statistic_data_4_kolesa
as 
select shop_name, count(car) as 'Количество продаж', 
sum(price) as 'Сумма продаж',
count(distinct id_client) as 'Количество клиентов' from shops
join sales on sales.id_shop_address=shops.id and shop_name=N'4 колеса'
join cars on cars.id=sales.id_car
group by shop_name

--+ 3) Создать представление, которое будет содержать информацию о
--+ клиентах, которые сделали покупки во всех автосалонах (запрос
--+ должен быть независим от текущего числа автосалонов, т.е. должен
--+ работать даже если число автосалонов изменится)