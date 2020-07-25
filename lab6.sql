--+1. Создайтe БД motocars и в ней таблицу all_sales (все в скрипте motocars.sql)
--+2. Выполните нормализацию БД с учетом того, что все автосалоны работают “с
--+одного склада” (т.е. цена у машины с одним наименованием везде одинакова и
--+никогда не меняется). Покупатель может сделать покупку двух одинаковых
--+машин в одном автосалоне в один день и это должны быть две разные покупки
--+3. создайте необходимые таблицы и связи между ними

create table clients (
id int primary key not null identity,
client_name nvarchar (40) not null)

create table shops (
id int primary key not null identity,
shop_name nvarchar (40) not null,
shop_address nvarchar (40) not null)

create table cars (
id int primary key not null identity,
car nvarchar (40) not null,
price int not null)

create table sales (
id int primary key not null identity,
id_client int not null,
id_shop_address int not null,
id_car int not null,
sale_date date)

--+4. заполните созданные таблицы на основании данных all_sales

insert into clients
select distinct client_name from all_sales

insert into shops
select distinct shop_name, shop_address from all_sales

insert into cars
select distinct car, price from all_sales

insert into sales
select clients.id as id_client, shops.id as id_shop_address,
cars.id as id_cars, sale_date from all_sales
join clients on clients.client_name=all_sales.client_name
join shops on shops.shop_address=all_sales. shop_address
join cars on cars.car=all_sales.car

--+5 используя созданные таблицы выполните следующие запросы
--+a) Определите, в каком из автосалонов Петров приобрел машину 2018-01-05

Select shop_name, shop_address, sale_date, client_name from shops
join sales on sales.id_shop_address=shops.id and sale_date='2018-01-05'
join clients on clients.id=sales.id_client and clients.client_name=N'Петров'

--+b) Вывести перечень автомобилей, даты и места их приобретения клиентов
--+Лебедева и Егорова, отсортируйте по имени клиента

Select client_name, car, sale_date, shop_name, shop_address from clients
join sales on sales.id_client=clients.id
join shops on shops.id=sales.id_shop_address
join cars on cars.id=sales.id_car
where client_name=N'Лебедев' or client_name=N'Егоров'
order by client_name

--+c) Вывести суммы продаж в феврале всех автосалонов

select shop_address, sum(price) from shops
join sales on sales.id_shop_address=shops.id and month(sale_date)=2
join cars on cars.id=sales.id_car
group by shop_address

--+d) Определить салон(салоны), выполнивший наибольшее число продаж за
--+весь период

select * from (
				select shop_name, shop_address, count(price) as 'sales_count' from shops
				join sales on sales.id_shop_address=shops.id
				join cars on cars.id=sales.id_car
				group by shop_name, shop_address) new
				where sales_count=(

									select max(sales_count) from (
									select shop_name, shop_address, count(price) as 'sales_count' from shops
									join sales on sales.id_shop_address=shops.id
									join cars on cars.id=sales.id_car
									group by shop_name, shop_address) new)

--+e) Определить, каких автомобилей (названия) было продано больше всего в
--+автосалоне Иномарка

Select top (1) with ties max(sold), new.car, shop_name from 
				(Select car, shop_name, count(price) as 'sold' from cars
				join sales on sales.id_car=cars.id
				join shops on shops.id=sales.id_shop_address and shop_name=N'Иномарка'
				group by car, shop_name) new
group by car, shop_name
order by max(sold) desc

--+f) Определите число уникальных клиентов салона Automall
Select count(*) from
				(Select distinct client_name, shop_name from clients
				join sales on sales.id_client=clients.id
				join shops on shops.id=sales.id_shop_address
				where shop_name='Automall') new

--+g) Сколько продаж (количество) было сделано в салоне "4 колеса" в марте

select count(*) as 'количество продаж' from (
				Select sales.id, shop_name,sale_date from shops 
				join sales on sales.id_shop_address=shops.id and
				shops.shop_name=N'4 колеса' and month(sale_date)=3) new



