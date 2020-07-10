--переходим в нее (делаем ее активной)
use freeIT
--- создаем таблицу. Таблица teachers уже есть, поэтому создаю с другим именем: teachersS: 
create table teachersS (
phone int not null,
name nvarchar(40) not null,
br_date date,
course nvarchar(40) not null,
type_course  nvarchar(40),
role_in_course nvarchar(40) not null,
str_date date  not null,
lect_hours int,
labs_hours int,
progress_hours int,
primary key (phone,course, type_course,role_in_course,str_date)
)
--- заполняем
insert into teachersS values
(296465763, N'Андрей','19951012', 'C#','full', 'teacher','20200730',30,60,5),
(296465763, N'Андрей','19951012', 'C#','full', 'mentor','20200730',30,60,5),
(293542536, N'Сергей','19970115', 'C#','full', 'helper','20200730',30,60,5),
(293542536, N'Сергей','19970115', 'C#','express', 'teacher','20200803',0,60,2),
(293542536, N'Сергей','19970115', 'C#','express', 'mentor','20200803',0,60,2),
(337885561, N'Евгений','19930425', 'Python','full', 'helper','00010101',null,null,null),
(333522596, N'Светлана','19910605', 'IM','full', 'teacher','20200803',10,24,4),
(333522596, N'Светлана','19910605', 'IM','full', 'mentor','20200803',10,24,4),
(446522891, N'Татьяна','19920815', 'IM','full', 'helper','20200803',10,24,4),
(446522891, N'Татьяна','19920815', 'IM','full', 'mentor','20200803',10,24,4), 
(337865529, N'Анатолий','19900915', 'BA','express', 'teacher','20200804',12,0,1), 
(335587921, N'Константин','19890327', 'BA','express', 'mentor','20200804',12,0,1), 
(299887925, N'Катерина','19910323', 'SQL','full', 'teacher','20200801',12,30,6), 
(448689653, N'Иван','19930313', 'SQL','full', 'helper','20200801',12,30,6), 
(298965356, N'Григорий','19900313', 'Ruby','full', 'helper','20200804',10,24,8), 
(298965356, N'Николай','19950317', 'Ruby','full', 'teacher','20200804',10,24,8), 
(298965356, N'Николай','19950317', 'Java','full', 'helper','20200803',30,60,8), 
(298965356, N'Николай','19950317', 'Java','express', 'helper','20200801',0,60,8), 
(339465689, N'Михаил','19940213', 'Java','full', 'teacher','20200803',30,60,8),
(339465689, N'Михаил','19940213', 'Java','full', 'mentor','20200803',30,60,8),
(443946899, N'Степан','19890716', 'Java','express', 'teacher','20200801',0,60,8),
(443946899, N'Степан','19890716', 'Java','express', 'mentor','20200801',0,60,8)

---1. Определить, какое количество человек сопровождает куры по Java и C# с учетом
---типа курса (любая роль)

select course, type_course,
count(distinct (phone)) as 'количество сопровождающих' from teacherss
where course like 'java'or course like 'c#'
group by course, type_course

---2. Определить курсы с учетом типа, прогресс по которым составил более 5 часов

select course, type_course, progress_hours from teacherss
where progress_hours>5
group by course, type_course, progress_hours

---3. Определить количество преподавателей рожденных в каждом месяце года

select count(month(br_date)) as 'январь' from teacherss
where role_in_course='teacher' and month(br_date)=1
select count(month(br_date)) as 'февраль' from teacherss
where role_in_course='teacher' and month(br_date)=2
select count(month(br_date)) as 'март' from teacherss
where role_in_course='teacher' and month(br_date)=3
select count(month(br_date)) as 'апрель' from teacherss
where role_in_course='teacher' and month(br_date)=4
select count(month(br_date)) as 'май' from teacherss
where role_in_course='teacher' and month(br_date)=5
select count(month(br_date)) as 'июнь' from teacherss
where role_in_course='teacher' and month(br_date)=6
select count(month(br_date)) as 'июль' from teacherss
where role_in_course='teacher' and month(br_date)=7
select count(month(br_date)) as 'август' from teacherss
where role_in_course='teacher' and month(br_date)=8
select count(month(br_date)) as 'сентябрь' from teacherss
where role_in_course='teacher' and month(br_date)=9
select count(month(br_date)) as 'октябрь' from teacherss
where role_in_course='teacher' and month(br_date)=10
select count(month(br_date)) as 'ноябрь' from teacherss
where role_in_course='teacher' and month(br_date)=11
select count(month(br_date)) as 'декабрь' from teacherss
where role_in_course='teacher' and month(br_date)=12

---4. Определить курсы, средний возраст сопровождающих на которых менее 23

select course,  avg(datediff(year,br_date, getdate())) as 'средний возраст' from teacherss
group by course
having avg(datediff(year,br_date, getdate()))<23

---5. Определить средний возраст студентов на каждом курсе на конец года

select course,  avg(datediff(year,br_date, '20201231')) as 'средний возраст' from studs
group by course

---6. Определить средний возраст студентов на каждом курсе на текущий момент

select course,  avg(datediff(year,br_date, getdate())) as 'средний возраст' from studs
group by course

---7. Определить количество helper - ов на каждом курсе 

select course, count(role_in_course) as 'количество helper-ов' from teacherss
where role_in_course='helper'
group by course

---8. Какой курс имеет mentor-ов большее одного

select course, count(role_in_course) 'количество mentor-ов' from teacherss
where role_in_course='mentor'
group by course
having count(role_in_course)>1

---9. Для курсов формата full определить отношение числа лекций к числу часов практики

select course, type_course, lect_hours, labs_hours, (lect_hours/labs_hours)
as 'отношение' from teacherss
where type_course='full' and labs_hours>0
group by course, type_course, lect_hours, labs_hours

---в отношении отбрасывается остаток, поэтому везде значение ноль(
---пробовала с округлением - тоже не получилось:
select course, type_course, lect_hours, labs_hours, 
round((lect_hours/labs_hours),2,1) as 'отношение' from teacherss
where type_course='full' and labs_hours>0
group by course, type_course, lect_hours, labs_hours

---10. Определить число лекторов в проекте

select count(role_in_course) from teacherss
where role_in_course='teacher'
group by role_in_course

---11. Найти сопровождающих, которые задействованы более, чем в одном курсе

select name, phone,  count(distinct (course)) as 'количество курсов' from teacherss
group by name, phone, course
having count(distinct (course))>1

---12. Определить среднее распределение лабораторных часов на одного сопровождающего,
---mentor-ы в этом не участвуют

select course, type_course, role_in_course, sum(labs_hours) as 'количество лаб-х часов', 
count(role_in_course) as 'количество сопровождающих', 
sum(labs_hours)/count(role_in_course) as 'среднее распределение' from teacherss
where role_in_course='helper'
group by course,type_course, role_in_course
having count(course)>=1

---13. Вывести список курсов, у которых лабораторных часов больше, чем лекционных 
---в 2 раза и более

select course, type_course, lect_hours, labs_hours, 
(labs_hours/lect_hours) as 'отношение' from teacherss
where lect_hours>0
group by course, type_course, lect_hours, labs_hours
having labs_hours/lect_hours>=2

---14. Найти курсы, на которых число студентов с кодом 29 и восьмеркой в номере больше двух. 

select course, count(name) as 'число студентов' from studs
where phone>=290000000 and phone<300000000 and phone like '%8%'
group by course
having count(name)>2





