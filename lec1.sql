create database freeIT
use freeit
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

alter table STUDENTS add CONSTRAINT FK_to_t1 foreign key (c24)
references t1(c11);

alter table Students add foreign key (gr_ID) references Groups(group_id);
alter table Plans add foreign key (teach_ID) references Teachers(Teach_id);
alter table Subjects drop Subj_ID;
alter table Subjects add primary key(Subj_Name); 
alter table Plans add foreign key (subj_ID) references Subjects(Subj_Name);
alter table Plans add foreign key (gr_ID) references Groups(group_id);

insert into Students values ('П.', 'Федоренко','Р', '25.12.1997','ПО135'),
('О.', 'Зингел',' ', '25.12.1985','ПО135'),
('П.', 'Михеенок','Г.', '05.02.1993','ПО134'),
('Н', 'Савицкаян',' ', '22.09.1987','ПО235'),
('М', 'Ковальчук','Е', '17.06.1992','ПО235'),
('Н', 'Заболотная','Г.', '18.06.1992','ПО335'),
('Т', 'Кавриго','Р', '13.05.1992','ПО335')
