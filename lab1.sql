Create database freeit
use freeit

Задание к лабораторной работе №1

1) Создайте следующие таблицы
таблица STUDENTS  содержащая поля
- идентификатор студента
- имя
-фамилию
-отчество
- дату рождения
-идентификатор группы
поле идентификатора студента должно быть первичным ключом в табли

create table STUDENTS (
ID int not null identity primary key,
Name nvarchar (40) not null,
Surname nvarchar (40) not null,
Middlename nvarchar (40),
Date_of_birth date not null,
Group_ID int not null
)


Таблица TEACHERS содержащая поля
- идентификатор преподавателя
- имя
-фамилию
-отчество
поле идентификатора преподавателя должно быть первичным ключом в таблице


create table TEACHERS (
ID int not null identity primary key,
Name nvarchar (40) not null,
Surname nvarchar (40) not null,
Middlename nvarchar (40)
)


Таблица GROUPS содержащая поля
- идентификатор группы
- наименование
- курс
поле идентификатора группы должно быть первичным ключом в таблице

create table GROUPS (
ID int not null identity primary key,
Group_Name nvarchar (40) not null,
Course int not null
)


4 Таблица PLAN содержащая поля
- идентификатор группы
- идентификатор преподавателя
- идентификатор предмета
Все поля образуют первичный ключ

create table PLANS (
Group_ID int not null,
TEACH_ID int not null,
SUBJ_ID int not null,
primary key (Group_ID, TEACH_ID, SUBJ_ID)
)


5 Таблица SUBJECTS содержащая поля
- идентификатор предмета
- наименование предмета
- количество часов по предмету
поле идентификатора предмета должно быть первичным ключом в таблице

create table SUBJECTS (
ID int not null identity primary key,
Subj_Name nvarchar (40) not null,
Subj_Hours int not null
)

2. Измените таблицы, создав связи между ними
- STUDENTS.идентификатор группы -- GROUPS.идентификатор группы

Alter table Students add constraint FK1 foreign key (Group_ID) references Groups(ID)

- PLAN.идентификатор преподавателя -- TEACHERS.идентификатор преподавателя

Alter table Plans add constraint FK2 foreign key (Teach_ID) references Teachers(ID)

- PLAN.идентификатор предмета --SUBJECTS.идентификатор предмета

Alter table Plans add constraint FK3 foreign key (Subj_ID) references Subjects(ID)

- PLAN.идентификатор группы --GROUPS.идентификатор группы

Alter table Plans add constraint FK4 foreign key (Group_ID) references Groups(ID)

3. Заполнить таблицы согласно данным Таблицы 1.1 и Таблицы 1.2

Так как русские буквы вызывают ошибку даже с nvarchar, то записи в таблицы веду латиницей

insert into Groups values ('PO135','1'),
('PO134','1'),
('PO235','2'),
('PO335','3')

insert into SUBJECTS values 
('Fisica','200'),
('Matematica','120'),
('Osnovy algoritmizatsii','70'),
('Proektirovanie BD','130'),
('Sredstva visualnogo proektirovanija','90'),
('Objektno orientirovannoe programirovanie','70')

insert into Teachers values ('N','Safronenko',''),
('N.','Zayceva','U.'),
('P.','Lisopad','G.'),
('K.','Kluev','N.'),
('P.','Rogachevskij','N.'),
('N.','Makarov','G.')

insert into Students values ('P.','Fedorenko','R','19971225','1'),
('O.','Zingel','','19851225','1'),
('P.','Miheenok','G.','19930205','2'),
('N','Savitskajan','','19870922','3'),
('M','Kovalchuk','E','19920617','3'),
('N','Zabolotnaja','G.','19920618','4'),
('T','Kavrigo','P','19920513','4'),
('N','Sharapo','','19920814','4')

insert into Plans values ('1','1','1'),
('1','2','2'),
('2','1','1'),
('2','2','2'),
('3','3','3'),
('3','4','4'),
('4','5','5'),
('4','6','6')

4) В таблице STUDENTS внесите изменения таким образом, чтобы все студенты учащиеся в группе ПО135 числились в группе 134.

update students set group_id=2 where group_id=1

5) Из таблицы групп удалите запись о группе по 135

delete from plans where group_id=1
delete from groups where id=1

6) в таблице SUBJECTS увеличьте количество часов на 30 для предметов   
Средства визуального программирования, Объектно-ориентированное программирование

Update Subjects set subj_hours=subj_hours+30 where id=5
Update Subjects set subj_hours=subj_hours+30 where id=6

7) в таблицу SUBJECTS добавьте столбец, в который будут внесены данные для формы контроля по предметам (по всем предметам сдаются экзамены, кроме "Основы алгоритмизации" -зачет). Обновите таблицу SUBJECTS с учетом форм контроля по предметам.

ALTER table SUBJECTS add Control nvarchar(40)

Update subjects set control='ekzamen' where id<>3
Update subjects set control='zachet' where id=3

8) Из таблиц STUDENTS и TEACHERS удалите столбцы с данными отчества.

alter table students drop column Middlename

alter table teachers drop column Middlename




