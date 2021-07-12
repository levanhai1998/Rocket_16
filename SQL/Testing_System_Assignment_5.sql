DROP DATABASE IF EXISTS `Testing_System_Assignment_5`;
CREATE DATABASE IF NOT EXISTS `Testing_System_Assignment_5`;
USE Testing_System_Assignment_2;

drop view if exists PM;
create view PM as 
(
select accountID,fullname,departmentName
from `account` A
join department D
on A.departmentID = D.departmentID
where departmentName ='phong sale');

select * from PM;
