---1. Вывести список тех, кто учится на одном курсе с Семеном

Select * from students
join connects on connects.id_student=students.id and students.name<>N'Семен'
join courses on courses.id=connects.id_course
join forms on forms.id=courses.id_form
join themes on themes.id=courses.id_theme
join (Select Themes.name as course, forms.name as course_type from students
	join connects on connects.id_student=students.id and students.name=N'Семен'
	join courses on courses.id=connects.id_course
	join forms on forms.id=courses.id_form
	join themes on themes.id=courses.id_theme) spisok on spisok.course=themes.name and spisok.course_type=forms.name

---2. Вывести список курсов, по которым начитано большее количество
---часов

Select * from themes
join courses on courses.id=themes.id and courses.progress_hours=(
Select max(courses.progress_hours) from courses)
join forms on forms.id=courses.id_form

---3. Вывести список курсов, на которых учится наибольшее количество
---студентов

Select Course_name from 
		(Select themes.name as 'Course_name', count (distinct students.phone) as 'maximum_quantity' from themes
		join courses on courses.id_theme=themes.id
		join connects on connects.id_course=courses.id
		join students on students.id=connects.id_student
		group by themes.name) new
	---после этого селекта вижу максимальное значение =7, поэтому подставляю его
		where new.maximum_quantity=7
		
---4. Вывести список тех, кто учится на одном курсе с Романом, но младше
---его

Select * from students
join connects on connects.id_student=students.id and students.name<>N'Роман'
join courses on courses.id=connects.id_course
join forms on forms.id=courses.id_form
join themes on themes.id=courses.id_theme
join (Select Themes.name as course, forms.name as course_type from students
	join connects on connects.id_student=students.id and students.name=N'Роман'
	join courses on courses.id=connects.id_course
	join forms on forms.id=courses.id_form
	join themes on themes.id=courses.id_theme) spisok on spisok.course=themes.name 
	and spisok.course_type=forms.name and students.br_date>'19971207'
	

---5. Найти курсы, на которых количество лекций и лабораторных столько
---же, сколько и на курсе IM

Select * from themes
join courses on themes.id=courses.id_theme and courses.lect_hours=

(Select lect_hours from courses
join themes on themes.id=courses.id_theme
where themes.name='im')
and courses.labs_hours=
(Select labs_hours from courses
join themes on themes.id=courses.id_theme
where themes.name='im')

---6. Найти курсы, где число человек больше, чем на курсе Ruby
Select themes.name, count (distinct students.phone) as 'quantity'  from themes
join courses on courses.id_theme=themes.id
join connects on connects.id_course=courses.id
join students on students.id=connects.id_student
group by themes.name
having count (distinct students.phone)>
	
	(Select quantity from
	(Select themes.name, count (distinct students.phone) as 'quantity'  from themes
	join courses on courses.id_theme=themes.id
	join connects on connects.id_course=courses.id
	join students on students.id=connects.id_student
	group by themes.name) neww	
	where neww.name='Ruby')

---7. Найти количество студентов, у которых месяц рождения такой же как
---Cемена, в результирующей выборке так же вывести номер месяца рождения
---Семена (Семен один любой)


Select count(*), (Select month(br_date) from students where name=N'Семен') as 'br_month' from students
where month(br_date)=(Select month(br_date) from students
where name=N'Семен') and name<>N'Семен'

---Select (Select month(br_date) from students where name=N'Семен') as 'br_month'

---(Select month(br_date) from students
---where name=N'Семен')

---8. Найти сопровождающих, роль или роли которых совпадают с ролью
---или ролями Андрея (один любой Андрей)

Select roles.name, persones.name, persones.phone, persones.br_date from roles
join missions on missions.id_role=roles.id
join persones on persones.id=missions.id_persone

join (Select roles.name from roles
	join missions on missions.id_role=roles.id
	join persones on persones.id=missions.id_persone
	where persones.name=N'Андрей') newww on roles.name=newww.name
