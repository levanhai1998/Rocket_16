DROP DATABASE IF EXISTS `Testing_System_Assignment_2`;
CREATE DATABASE IF NOT EXISTS `Testing_System_Assignment_2`;
USE Testing_System_Assignment_1;
/* Question 2 : lấy ra tất cả các phòng ban*/

# Cách 2
select *
from Department;
/* Question 3: lấy ra id của phòng ban "Sale" */

select DepartmentID
from Department
where DepartmentName = 'Sale';


select *
from Account
where character_length(FullName) = (select max(character_length(FullName)) from Account);


update Account
set DepartmentID=3
where AccountID = 3;
-- Q5 get account info that having longest full name and departmentID = 3
select *
from Account
         inner join Department D on Account.DepartmentID = D.DepartmentID
where character_length(FullName) = (select max(character_length(FullName)) from Account)
  and D.DepartmentID = 3;

-- Q6 get group's name created before 20/12/2019
select GroupName
from `Group`
where CreateDate < '2019-12-20';

-- Q7 get question's id which having more than or equal 4 answer
select Q.QuestionID
from Question Q
         inner join Answer A on Q.QuestionID = A.QuestionID
group by QuestionID
having count(AnswerID) >= 4;

-- Q8 get  made thi co th thi >=60p va dc tao truoc 20/12/2019
-- reconfig
update Exam
set Duration = null;
alter table Exam
    drop column Duration;
alter table Exam
    add column Duration tinyint unsigned after CategoryID;
update Exam
set Exam.Duration=90;
-- q8 exam thoi gian >=60p and ngay tao truowc 20/12/2019
select *
from Exam
where Exam.Duration >= 60
  and CreateDate < '2019-12-20';

-- Q9 lay 5group tao gam nhat
select *
from `Group`
order by CreateDate desc
limit 5;


-- Q10 dem so nhan vien co departmentid=2
select count(AccountID)
from Account
where DepartmentID = 2;

-- Q11 lay nhan vien ten bat dau =D ket thuc =o
select *
from Account
where FullName like 'D%o';

-- Q12 xoa exam tao truoc 23/12/2019
delete
from Exam
where CreateDate < '2019-12-23';

-- Q13 xoas queation noi dung bat dau = cau hoi
delete
from Question
where Content like 'câuhỏi%';

-- Q14 update
update Account
set Email    = 'loc.nguyenba@vti.com.vn',
    FullName = N'Nguyễn Bá Lộc'
where AccountID = 5;

-- Q15
update GroupAccount set GroupID=4 where AccountID=5;