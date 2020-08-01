--+ 1) создать хп по подсчету числа салонов, числа клиентов, числа
--+продаж, и числа машин в текущий момент
go
create procedure count_1 
as 
select count(*) as N'числo салонов' from shops
select count(*) as N'числo клиентов' from clients
select count(*) as N'числo машин' from cars
go

exec count_1 

--+ 2) Создать хранимую процедуру подсчета количества продаж по
--+ месяцам, суммы продаж по месяцам и числа клиентов по месяцам для
--+ заданного автосалона. Результат вывести в теле процедуры.
--+ Обработать ошибку неверного ввода наименования автосалона

go
create procedure count_2 (@shop_n nvarchar(20))
as

select count(*) as 'количествo продаж в январе' from sales 
		join shops on shops.id=sales.id_shop_address and month(sale_date)=1 and shop_name=@shop_n
go

exec count_2 'all cars'
