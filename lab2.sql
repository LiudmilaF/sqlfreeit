--- ??????? ???????

create table studs (
id int primary key not null identity,
name nvarchar(40) not null,
phone int not null,
br_date date,
desired nvarchar(150),
course  nvarchar(40),
type_course nvarchar(40) not null default 'none',
lect_hours int not null,
labs_hours int not null,
str_date date)

----- ?????????
insert into studs 
(name,phone,br_date,desired, course,type_course,lect_hours, labs_hours,str_date)values 
(N'????', 337302952,'20000105','C#, JS,  IM, Ruby', 'C#', 'full', 30,60, '20200730'),
(N'?????', 447758172,'19971207','C#, JS', 'C#','full', 30,60, '20200730'),
(N'?????????',445036950,'19931007','C#, Java','Java','express', 0,60, '20200803'),
(N'????',335171515,'20010129','C#, Java', 'C#', 'full', 30,60, '20200730'),
(N'????',335665262,'19960117','BA, IM','IM', 'full', 10,24, '20200803'),
(N'????', 297698996,'19990107','C#, JS, SQL, BA, IM, Ruby',  'C#', 'express', 0,60, '20200803'),
(N'????',292542686,'19961227','C#, Java',  'C#','express', 0,60, '20200803'),
(N'?????????',447035175,'19890907','C#, JS, SQL, BA, IM, Ruby', 'C#','express', 0,60,'20200803'),
(N'??????',292751237,'19930807','Java, BA', 'Java', 'full', 30,60,'20200801'),
(N'???', 295666092,'19950607','Java', 'Java', 'full', 30,60,'20200801'),
(N'??????????',295036950,'19890107','Java, IM', 'Java', 'full', 30,60,'20200801'),
(N'????',335580629,'19980116', 'C#,Python', 'C#', 'full', 30,60, '20200730'),
(N'??????',445513335,'19991117',' IM','IM','full', 10,24, '20200803'),
(N'????????',337711379,'19920307','Java','Java','express', 0,60, '20200803'),
(N'?????',447698996,'19940125', 'Ruby','Ruby', 'full', 10,24, '20200804'),
(N'??????',297718719,'19890123', 'Java,Python','Java', 'full', 30,60,'20200801'), 
(N'?????' ,335075429,'20030505','BA','BA', 'express', 12,0, '20200804'),
(N'???????',295665262,'19890227','BA, IM','BA', 'express', 12,0, '20200804'),
(N'???????',335666092,'19940215','Python',null,'none',0,0,null),
(N'??????',297758172,'19971007','Java,JS, SQL', 'SQL', 'full', 12,30, '20200801')

---1. ??????? ?????????? ? ????????? (???, ???? ????????, ???????) 
---? ????? ??????? ????? "?"; ??? "?"; ? ????? ??????????? ? ???????

Select name, br_date, phone from studs
where name like N'%?%' or name like N'%?%'

---2. ??????? ???????? ? ?????????(?????, ???????????? ?????, ??? ?????,
---???? ??????), ??????? ?????? ?? ?????? C#, Java ??? JS

Select name, course, type_course, str_date from studs
where course like 'c#' or course like 'Java' or course like 'JS'

---3. ??????? ???????? ? ?????????, ??????? ?????? ?? ??????? ?? ?????,
---??? ????? ?????

Select name, phone, br_date, desired from studs
---where course<>desired
where desired like '%,%'

---4. ??????? ???????? ? ?????????, ????? ??????? ???????? ??? ??????,
---??? ?????? ??????? ???????? (?? ?? ????? ?????? ????????), ??? ???? ???? ??
---???? ????? 'a';

Select name, phone, br_date, desired from studs
where name not like N'____' and name like N'%?%'

---5. ????? ???? ????????? ???????? ?? BA, ????????????? ?????????? ?? ???? ???

Select name, phone, br_date, desired from studs
where course like 'BA'
order by name

---6. ??????? ?????????? ? ?????????, ??????? ?????? ?? ??????? ? ?? Java, ? ?? 
---SQL, ??? ???? ?? ??????? ?????? 25 ??? (???????????? ????? ???????? ? ???????)

Select name, phone, br_date, desired from studs
where desired like '%Java%' and desired like '%sql%' 

---7. ??????? ?????????? ? ????????? (?????, ???? ????????), ??????? ???????? ? 
---?????, ????, ????????

Select name, br_date from studs
where month(br_date)=3 or month(br_date)=6 or month(br_date)=9 

---8. ?????? ?????????? ? ??????, ?????????? ???????????? ????? ? ??????? 30 ????? ? ?????

Select course, type_course, lect_hours, labs_hours, str_date from studs
where labs_hours>=30 

---9. ??????? ?????????? ? ??????, ??????? ??? ????????.

Select course, type_course, lect_hours, labs_hours, str_date from studs
where str_date is not null

---10. ??????? ?????????? ? ???, ????? ???? ?????? ???????? ?????????

Select distinct course from studs
where course is not null

---11. ??????? ?????????? ? ?????????, ??????? ??????? ?????? ??????.

Select name, phone, br_date, desired from studs
where getdate()<str_date

---12. ??????? ?????????? ? ??????, ? ??????? ????? ???????????? ???????
---?????? ????? ????????????.

Select course, type_course, lect_hours, labs_hours, str_date from studs
where lect_hours>labs_hours

---13. ??????? ?????? ?????????, ??????? ?????? ????????? ? ????.

Select name, phone, br_date, desired from studs
where month(str_date)=7

---14. ??????? ?????? ????????? ????????? ?????? 25 ???.

---Select name, phone, br_date, desired, datediff(year,br_date, getdate()) as N'???????' from studs

Select name, phone, br_date, desired from studs
where datediff(year,br_date, getdate())>25

---15. ??????? ?????? ?????????, ??? ????????? ??????? 33, 
---????????????? ????????? ?? ???? ???????? ????????

Select name, phone, br_date, desired from studs
where phone>'330000000' and phone<'340000000'
order by br_date

