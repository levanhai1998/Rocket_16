USE `Testing_System_Assignment_1`;

delimiter $$ 
create procedure printAC(IN dName VARCHAR(50))
begin
	declare idP int ; 
    select departmentid into idP from department where departmentname like dName;
    select * from `account` where DepartmentId= idP ; 
end $$
delimiter ;
call printAC('Phòng Sale'); 

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
drop procedure if exists accountgroup;
DELIMITER $$
create procedure accountgroup()
begin
select G.GroupID, GroupName,count(*) as songuoi from groupaccount GA join `group` G on  GA.groupID=G.groupID group by groupID;
end$$
delimiter ;
call accountgroup();

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
drop procedure if exists number_of_type_question ; 

delimiter $$
	create procedure number_of_type_question()
    begin
		select T.*, count(questionid) as 'so luong'
        from typequestion t
        right join question q on q.typeid= t.typeid 
        group by typeid ;
    end $$
delimiter ;
call number_of_type_question();
-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
drop procedure if exists most_questioned_type 

delimiter $$
	create procedure most_questioned_type (out type_id int unsigned) 
    begin 
		select typeid into type_id 
        from question 
        group by typeid 
        order by count(questionid) desc 
        limit 1 ;
    end $$
delimiter ; 
call most_questioned_type() ;
-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
set @minh= 0 ; 
call most_questioned_type(@minh) ;
select @minh ; 

select typename
from typequestion 
where typeid = @minh ; 
-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào
drop procedure if exists name_return;
delimiter $$
	create procedure name_return(in typein VARCHAR(50))
    begin 
		select accountid as ID, fullname as `Name`
        from `account`
        where username like concat('%',typein,'%')
        union
        select groupid as ID ,groupname as `Name`
        from `group`
        where groupname like concat('%',typein,'%');
        
	end $$
delimiter ;
call name_return('a');

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công

drop procedure account_create ;
delimiter $$
	create procedure account_create (in full_name varchar(50), email_in varchar(50) )
	begin 
		declare user_name char(50);
        declare position_id int;
        set user_name = substring_index(email_in,'@',1);
        select positionid into position_id from position where positionname like '%dev%'limit 1;
        insert into `Account`(email, username, fullname, PositionID, createdate)
        values (email_in,user_name,full_name,position_id,now());
        select 'Done';
        
	end $$
delimiter ;
begin work;
select * from `account`;
call account_create('Do Tuan Minh', 'minh@gmail.com');
rollback;
-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
drop procedure if exists most_length_type ; 
delimiter $$
	create procedure most_length_type(in typein char(50)) 
    begin
		select content
        from question
        where typeid = (select typeid from typequestion where typename like typein)
        order by character_length(content) desc
        limit 1;
    end $$
delimiter ;
call most_length_type('Multiple-Choice') ; 

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa)
drop procedure delete_exam_from_date ; 
delimiter $$
	create procedure delete_exam_from_date()
    begin
		select e.*, eq.questionid from exam e
        join examquestion eq on eq.examid = e.examid
        where year(e.createdate) = (year(now())-1);
		if exists (select * from exam where year(createdate) = (year(now())-1)) 
        then 
         begin
			delete from exam where year(createdate) = (year(now())-1) ;
         end ;
		end if; 
    end $$
    
    
delimiter ; 

begin work ; 
select * from exam ;
call delete_exam_from_date();
rollback;


-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay
drop procedure if exists question_create_monthly;
delimiter $$
	create procedure question_create_monthly()
    begin
		select monthname(createdate) as 'Thang', count(questionid) as 'So luong' from question where year(createdate) = (year(now())-1) group by month(createdate) ;
    end $$
delimiter ;

call  question_create_monthly(); 

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")

drop procedure if exists question_create_last_6_months;
delimiter $$
	create procedure question_create_last_6_months()
    begin
		select monthname(createdate) as 'Thang', count(questionid) as 'So luong' from question 
        where year(createdate) = (year(now())) and month(createdate) >= (month(now())-6) group by month(createdate) ;
    end $$
delimiter ;

call  question_create_last_6_months(); 
