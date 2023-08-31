use Unibase;

select * from Advisor;
select * from Course;
select * from Department;
select * from Lectureroom;
select * from Prereq;
select * from Professor;
select * from Section;
select * from Student;
select * from Takes;
select * from Teaches
select * from Time_slot;
--Query1:Search a student tuple by name 
select * from Student 
 where [name] = 'Eddie Cheever';

 --Query2: Search a professor by dept_name and office
 select * from Professor
 where dept_name = 'Robotics'
and office = 'Rook';
-- Query 3: find the max salary of Instructors department wise
select * from Professor
where salary in (select max(salary) from Professor group by dept_name);
--Query 4: find courses where credits is greater than 3 
select * from course where dept_name in ('Business','Biology') AND credits >= 3;
---Query 5: Top 5 credits of students 
select top 5 *
from student 
order by total_cred desc;
--Query 6: the names of all the courses which were offered in Fall 2009 or Spring 2010 semester
select b.title
from Section a
join course b on a.course_id = b.course_id where a.semester in ('FALL','SPRING') and a.year in
(2009,2010);
-- Query 7:find the building name, room number, course title and department when courseID is given as input
 select course.course_id,course.title, course.dept_name, Lectureroom.room_number,Lectureroom.building
from course, Section, Lectureroom
where course.course_id = section.course_id AND
Lectureroom.room_number = section.room_number
AND course.course_id = '138';
-- Query 8 : ascending order of the names of professor
select distinct  name
from Professor order by name

-- Query 9: monthly salary of all professor  and rename the salary column to monthly salary column and Annual Salary Column and return the list
select ID, name, round(salary/12,2)as 'Monthly Salary',salary as 'Annual Salary'from Professor

--Query 10 : Number of students in each department
select dept_name, count(student.ID) as 'Number of students' from student
group by dept_name;

--Query 11 Inner join of two tables section and Takes
SELECT Section.building,section.sec_t_ID, Takes.semester, Section.sec_id
FROM Section
INNER JOIN Takes ON section.course_id=Takes.course_id;

-- Query 12 : Classes on Mondays and in the building queen 
select  course.course_id,course.title,section.room_number,section.building,time_slot.day,Time_Slot.start_time
from course, section,time_slot
where course.course_id = section.course_id and Section.building = 'Queen'
AND day = 'M';

--Query 13: To find total grade of a student 
select student_id,sum(credits * grade) as 'total'
from
(select takes.ID as 'student_id', course.title,course.credits as 'credits',grade =
Case takes.grade
when 'A+' then 1
when 'B+' then 2
when 'C+' then 3
when 'D' then 4
else 0
end from takes,course,section where takes.sec_id = section.sec_id AND
section.course_id = course.course_id AND takes.ID= '226414') t2
group by student_id;

--Query 14 : top 5 salaries of professors
select  top 5  * from Professor order by salary desc;

--Query 15 : Average salary of each department 
  select dept_name,avg(salary) as Avg_Salary
     from Professor  
     group by dept_name ;
-- Query 16: find  courses that require Prerequisites
select course.course_id, prereq.prereq_id from prereq, course 
where prereq.course_id = course.course_id;

-- Query 17 : list of students name , credits from math 
select name, total_cred from student where dept_name = 'Math'


-- Query 18 : names of all the professors whose department is in King
select a.name
from Professor a
join Department b on a.dept_name = b.dept_name where building = 'King';


-- Query 19 : Number of 2,3,4 credit courses in each department 
Select dept_name,credits,count(1) no_of_courses
from COURSE
group by dept_name,credits
order by credits desc;


--Query 20 : find advisor of a student
select Professor.name as 'Professor Name', student.name as 'Student Name', student.ID from Professor,student 
where Professor.dept_name = student.dept_name and student.id='226414';
