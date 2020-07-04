create database freeIT
use freeit

Задание 1
create table STUDENTS (
STUD_ID int not null identity primary key,
Name_ nvarchar (40) not null,
Surname nvarchar (40) not null,
Middlename nvarchar (40) not null,
Date_of_birth date not null,
GR_ID int not null
)

create table TEACHERS (
TEACH_ID int not null identity primary key,
Name nvarchar (40) not null,
Surname nvarchar (40) not null,
Middlename nvarchar (40) not null
)

create table GROUPS (
GROUP_ID int not null identity primary key,
Gr_Name nvarchar (40) not null,
Course int not null
)

create table PLANS (
GR_ID int not null,
TEACH_ID int not null,
SUBJ_ID int not null,
primary key (GR_ID, TEACH_ID, SUBJ_ID)
)

create table SUBJECTS (
SUBJ_ID int not null primary key,
Subj_Name nvarchar (40) not null,
Subj_hours int not null
)

Задание 2
alter table STUDENTS add CONSTRAINT FK_to_t1 foreign key (c24)
references t1(c11);

alter table Students add foreign key (gr_ID) references Groups(group_id);
alter table Plans add foreign key (teach_ID) references Teachers(Teach_id);
alter table Subjects drop Subj_ID;
alter table Subjects add primary key(Subj_Name); 
alter table Plans add foreign key (subj_ID) references Subjects(Subj_Name);
alter table Plans add foreign key (gr_ID) references Groups(group_id);

Задание 3

insert into Students values ('П.','Федоренко','Р','25.12.1997','ПО135'),
('О.','Зингел',' ','25.12.1985','ПО135'),
('П.','Михеенок','Г.','05.02.1993','ПО134'),
('Н','Савицкаян',' ','22.09.1987','ПО235'),
('М','Ковальчук','Е','17.06.1992','ПО235'),
('Н','Заболотная','Г.','18.06.1992','ПО335'),
('Т','Кавриго','Р','13.05.1992','ПО335')

insert into Teachers values ('Н', 'Сафроненко',' '),
('Н.','Зайцева','У.'),
('П.','Листопад','Г.'),
('Н','Сафроненко',' '),
('К.','Клюев','Н.'),
('П.','Рогачевский','Н.'),
('Н.','Макаров','Г.')

insert into Groups values ('ПО135','П.','1'),
('ПО135','О.','1'),
('ПО134','П.','1'),
('ПО235','Н.','2'),
('ПО235','М.','2'),
('ПО335','Н.','3'),
('ПО335','Т.','3'),
('ПО335','Н.','3')

{insert into Plans values ('ПО135','П.','1'),} сделать когда заполнятся таблицы без ошибок

insert into SUBJECTS values ('Физика','200'),
('Математика','70'),
('Основы алгоритмизации','120'),
('Проектирование БД','130'),
('Средства визуального программирования','90'),
('Объектно ориентированное программирование','70')

Задание 4

Insert into Students values ('П.','Федоренко','Р','25.12.1997','134')

{Обновить Groups и Plans?}

insert into Students values 
('О.','Зингел',' ','25.12.1985','134')

{Обновить Groups и Plans?}

Задание 5

Delete from STUDENTS where Gr_ID=ПО135

Задание 6

Update Subjects Set Subj_hours=230