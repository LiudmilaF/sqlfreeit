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

create view Clients_info
as
select sales.id_client, client_name, sale_date, id_shop_address from clients
join sales on sales.id_client=clients.id

--+ 4) Найти покупателей, которые приобретали машины в автосалоне
--+ Иномарка, при этом не приобретали автомобили в салоне 4 колеса,
--+ сохранить запрос как представление
 
Create view Inomarka_only_customers
as
Select distinct id_client from clients
join sales on sales.id_client=clients.id
join shops on shops.id=sales.id_shop_address and shop_name=N'Иномарка'
except
Select distinct id_client from clients
join sales on sales.id_client=clients.id
join shops on shops.id=sales.id_shop_address and shop_name=N'4 колеса'
