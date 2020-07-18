---1. Вывести информацию о курсах, которые проводятся в формате full

Select * from courses
join forms on courses.id_form=forms.id and forms.name='full'

---2. Вывеси информацию о курсах, на которых учатся Людмила и Семен

Select * from courses
join connects on courses.id=connects.id_course 
join students on students.id=connects.id_student and (students.name=N'Людмила' or students.name=N'Семен')

---3. Вывести информацию о сопровождающих курс, на котором учится Семен
select * from persones
join missions on missions.id_persone=persones.id
join teams on teams.id_mission=missions.id
join courses on teams.id_course=courses.id
join connects on connects.id_course=courses.id
join students on connects.id_student=students.id and students.name=N'Семен'

---4. Вывести информацию обо всех направлениях и количестве курсов
---которые по ним организованы

Select themes.name, count(themes.name) as N'количество курсов'  from forms
join courses on courses.id_form=forms.id
join themes on themes.id=courses.id_theme
group by themes.name

---5. Вывести информацию о курсах и количестве сопровождающих

select themes.name, forms.name, count(distinct persones.name) as N'количество сопровождающих',
courses.str_date, courses.lect_hours, courses.labs_hours, courses.progress_hours from themes
join courses on themes.id=courses.id_theme
join teams on courses.id=teams.id_course
join missions on missions.id=teams.id_mission
join persones on persones.id=missions.id_persone
join forms on forms.id=courses.id_form
group by themes.name, courses.str_date, courses.lect_hours, courses.labs_hours, 
courses.progress_hours, forms.name

---6. Найти сопровождающих, которые задействованы в разных курсах

select persones.name, persones.phone, persones.br_date, count (distinct themes.name) from persones
join missions on missions.id_persone=persones.id
join themes on themes.id=missions.id_theme
group by persones.name, persones.phone, persones.br_date
having count (distinct themes.name)>1

---7. На каких курах учится более 5 студентов

Select themes.name, count (distinct students.phone) from themes
join courses on courses.id_theme=themes.id
join connects on connects.id_course=courses.id
join students on students.id=connects.id_student
group by themes.name
having count (distinct students.phone)>5

---8. Вывести информацию о курсах, по которым не проводятся лекции

select themes.name, forms.name, courses.str_date, courses.lect_hours, courses.labs_hours, 
courses.progress_hours from themes
join courses on courses.id_theme=themes.id
join forms on forms.id=courses.id_form
group by themes.name, courses.str_date, courses.lect_hours, courses.labs_hours, 
courses.progress_hours, forms.name
having courses.lect_hours=0

---9. Вывести информацию обо всех сопровождающих и определить
---количество ролей в которых они выполняют сопровождение

Select persones.name, persones.phone, persones.br_date, count (roles.name) from persones
join missions on missions.id_persone=persones.id
join roles on roles.id=missions.id_role
group by persones.name, persones.phone, persones.br_date

---10. Определить количество helper-ов в проекте

Select count(roles.name) from persones
join missions on missions.id_persone=persones.id
join roles on roles.id=missions.id_role and roles.name='helper'
group by roles.name

---11. Определить количество helper-ов в каждом направлении

Select themes.name, count(roles.name) as N'количество helper-ов' from persones
join missions on missions.id_persone=persones.id
join roles on roles.id=missions.id_role and roles.name='helper'
join themes on themes.id=missions.id_theme
group by themes.name

---12. Вывести информацию о направлениях, в которых есть mentor-ы

select themes.name from themes
join missions on missions.id_theme=themes.id
join roles on roles.id=missions.id_role and roles.name='mentor'
group by themes.name

---13. Вывести информацию о направлениях и количестве mentor-ов в
---каждом из направлений

select themes.name, count(roles.name) from themes
join missions on missions.id_theme=themes.id
join roles on roles.id=missions.id_role and roles.name='mentor'
group by themes.name

---14. определить число студентов, которые учатся на курсах, в которых
---предусмотрены лекции

select count(*) from students 
join connects on connects.id_student=students.id
join courses on courses.id=connects.id_course and lect_hours>0

---15. Определить количество студентов на каждом курсе младше 27 на
---текущий момент

select themes.name, count(students.id) from students 
left join connects on connects.id_student=students.id
left join courses on courses.id=connects.id_course
left join themes on themes.id=courses.id_theme
where DATEDIFF(year,students.br_date,getdate())<27
group by themes.name
