use `Testing_System_Assignment_1`;
--

-- q1
delimiter //
drop procedure if exists sp_show_account_in_department;
create procedure sp_show_account_in_department(in department_name varchar(50))
begin
    select D.DepartmentName,
           A.AccountId,
           Email,
           UserName,
           FullName,
           A.DepartmentId,
           PositionID,
           CreateDate
    from Account A
             join Department D on A.DepartmentId = D.DepartmentID
    where DepartmentName like concat('%', department_name, '%');
end //
delimiter ;

call sp_show_account_in_department('dev 2');

-- q2
delimiter //
drop procedure if exists sp_show_num_of_acc_in_group;
create procedure sp_show_num_of_acc_in_group()
begin
    select count(AccountID) as numOfMember, G.GroupID, G.GroupName
    from `Group` G
             join GroupAccount GA on G.GroupID = GA.GroupID
    group by G.GroupID;
end //
delimiter ;

call sp_show_num_of_acc_in_group();

-- q3
delimiter //
drop procedure if exists sp_num_of_question_created_in_this_month;
create procedure sp_num_of_question_created_in_this_month()
begin
    select count(QuestionID) as numOfQuestion, T.TypeID, TypeName
    from TypeQuestion T
             join Question Q on Q.TypeID = T.TypeID
    where month(CreateDate) = month(now())
      and year(CreateDate) = year(now())
    group by T.TypeID;
end //
delimiter ;

call sp_num_of_question_created_in_this_month();

-- q4
delimiter //
drop procedure if exists sp_typeID_max_num_question;
create procedure sp_typeID_max_num_question(out type_id int unsigned)
begin
    select T.TypeID
    into type_id
    from TypeQuestion T
             join Question Q on T.TypeID = Q.TypeID
    group by Q.TypeID
    order by count(QuestionID)
    limit 1;
end //
delimiter ;
-- q5
set @a = 0;
call sp_typeID_max_num_question(@a);
select @a;

select TypeName
from TypeQuestion
where TypeID = @a;

set @a = null;

-- q6
delimiter //
drop procedure if exists sp_find_by_name;
create procedure sp_find_by_name(in keyword char(50))
begin
    select GroupID as ID, GroupName as Name
    from `Group` G
    where GroupName like concat('%', keyword, '%')
    union
    select AccountID as ID, FullName as Name
    from Account
    where FullName like concat('%', keyword, '%');
end //
delimiter ;

call sp_find_by_name('a');

-- q7
delimiter //
drop procedure if exists sp_create_acc;
create procedure sp_create_acc(in full_name varchar(50), in email_in varchar(50))
begin
    declare user_name char(50);
    declare position_id int;
    select PositionID into position_id from Position where PositionName like '%dev%' limit 1;
    set user_name = substring_index(email_in, '@', 1);
    insert into Account(email, username, fullname, PositionID, createdate)
    values (email_in, user_name, full_name, position_id, curdate());
    select 'thanh cong';
end //
delimiter ;

delete
from Account
where Email = 'cuongbuilh@gmail.com';
call sp_create_acc('bui van cuong', 'cuongbuilh@gmail.com');
select *
from Account
where Email = 'cuongbuilh@gmail.com';
#-- -------------------------------------
set @str = 'asdfds@gmail.com';
select substring_index(@str, '@', 1);
-- ------


-- q8
delimiter //
drop procedure if exists sp_max_content;
create procedure sp_max_content(in keyword enum ('essay','multiple-choice'))
begin
    declare max_length int;
    set max_length = (select max(character_length(Content))
                      from Question
                               join TypeQuestion TQ on Question.TypeID = TQ.TypeID
                      where TypeName like concat('%', keyword, '%'));

    select character_length(Content) as ContentLength,
           TypeName,
           QuestionID,
           Content,
           CategoryID,
           Q.TypeID,
           CreatorID,
           CreateDate
    from Question Q
             join TypeQuestion T on Q.TypeID = Q.TypeID
    where TypeName like concat('%', keyword, '%')
      and character_length(Content) = max_length;
end //
delimiter ;

call sp_max_content('multiple-choice');


-- q9
delimiter //
drop procedure if exists sp_delete_exam_by_id;
create procedure sp_delete_exam_by_id(in exam_id int unsigned)
begin
    if exists(select * from Exam where ExamID = exam_id)
    then
        begin
            delete from Exam where ExamID = exam_id;
        end;
    end if;
end //
delimiter ;

begin work;
select *
from Exam;
call sp_delete_exam_by_id(9);
rollback;


-- q10
delimiter //
drop procedure if exists sp_delete_old_exam;
create procedure sp_delete_old_exam()
begin
    declare done int default false;
    declare num_of_del int unsigned;
    declare _id int unsigned;
    declare _date date;
    declare cur cursor for select ExamID, CreateDate from Exam;
    declare continue handler for not found set done = true;

    set num_of_del = 0;

    open cur;
    read_loop:
    loop
        fetch cur into _id,_date;
        -- leave loop
        if done then
            leave read_loop;
        end if;
        -- check date
        if timestampdiff(year, _date, curdate()) >= 3 then
            call sp_delete_exam_by_id(_id);
            set num_of_del = num_of_del + 1;
        end if;
    end loop;
    close cur;
    select num_of_del;
end //
delimiter ;

insert into Exam(createdate)
VALUES ('2009-12-12');
begin work;
select *
from Exam;
call sp_delete_old_exam();
rollback;


-- q11
delimiter //
drop procedure if exists sp_delete_department;
create procedure sp_delete_department(in department_name varchar(50))
begin
    declare _departmentID int unsigned;
    select DepartmentId
    into _departmentID
    from Department
    where DepartmentName = department_name
    limit 1;

    if (_departmentID is not null) then
        update Account set DepartmentId=null where DepartmentId = _departmentID;
        delete from Department where DepartmentID = _departmentID;
    end if;

end //

begin work;
call sp_delete_department('Phòng Sale');
select *
from Department;
select FullName, DepartmentID
from Account;
rollback;


-- q12
insert into Question(CreateDate, CreatorID)
values (curdate(), 1);

delimiter //
drop procedure if exists sp_show_created_question_in_year;
create procedure sp_show_created_question_in_year()
begin
    declare cur_month int default 1;
    declare _name varchar(50) default ('');
    declare _num int unsigned default (0);
    declare continue handler for not found set cur_month = -1;

    drop temporary table if exists result;
    create temporary table result
    (
        month_name    nvarchar(50),
        numOfQuestion int unsigned default 0
    );

    month_loop :
    loop
        if (cur_month > 12 or cur_month < 1) then
            leave month_loop;
        end if;
        -- create name
        set _name = concat('tháng  ', cur_month);
        -- count num
        select count(QuestionID)
        into _num
        from Question
        where year(CreateDate) = year(curdate())
          and month(CreateDate) = cur_month;
        -- insert result
        insert into result value (_name, _num);
        -- select _name,_num;
        set cur_month = cur_month + 1;
    end loop;

    select month_name as title, numOfQuestion as number from result;
    drop temporary table if exists result;
end //
delimiter //


call sp_show_created_question_in_year();



-- q13
-- select date_sub(curdate(),interval 1 month );
delimiter //
drop procedure if exists sp_six_months;
create procedure sp_six_months()
begin
    declare curr_date date;
    declare step_date date;
    declare iter int default 0;
    declare _title nvarchar(50);
    declare _result nvarchar(50);
    declare _num int;
    set curr_date = current_date();

    drop temporary table if exists result;
    create temporary table result
    (
        title  nvarchar(50),
        result nvarchar(50)
    );

    set iter = 0;
    while iter < 6
        do
            set step_date = subdate(curr_date, interval iter month);
            set _title = concat('date: ', month(step_date), ' - ', year(step_date));

            set _num = (select count(QuestionID)
                        from Question
                        where year(CreateDate) = year(curr_date)
                          and month(CreateDate) = month(step_date));


            set _result = case _num
                              when 0 then 'không có câu hỏi nào trong tháng'
                              else _num
                end;

            insert into result values (_title, _result);
            set iter = iter + 1;
        end while;

    select title as tiltle, result as result from result;
    drop temporary table if exists result;
end //
delimiter ;

call sp_six_months();