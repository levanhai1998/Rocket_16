drop database if exists `FinalExam`;
create database if not exists `FinalExam`;

use `FinalExam`;
drop table if exists `Student`;
create table if not exists `Student`(
    `ID` tinyint primary key auto_increment,
    `Name` varchar(50) unique key ,
    `Age` tinyint,
    `Gender` varchar(20)
);

drop table if exists `Subject`;
create table if not exists `Subject`(
    `ID`tinyint primary key auto_increment,
    `Name` varchar(50)unique key
);

drop table if exists `StudentSubjec`;
create table if not exists `StudentSubjec`(
    `StudentID`tinyint primary key auto_increment,
    `SubjectID` tinyint,
    `Mark` tinyint,
    `Date` date
);


/*insert*/
INSERT INTO `finalexam`.`student` (`ID`, `Name`, `Age`, `Gender`) VALUES ('1', 'Le Van Hai', '23', 'nam');
INSERT INTO `finalexam`.`student` (`ID`, `Name`, `Age`, `Gender`) VALUES ('2', 'hoang manh cuong', '20', 'nam');
INSERT INTO `finalexam`.`student` (`ID`, `Name`, `Age`, `Gender`) VALUES ('3', 'le thi xuan', '18', 'nu');

INSERT INTO `finalexam`.`studentsubjec` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('1', '2', '8', '2020-02-20');
INSERT INTO `finalexam`.`studentsubjec` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('2', '5', '9', '2020-02-10');
INSERT INTO `finalexam`.`studentsubjec` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('3', '4', '10', '2020-03-23');

INSERT INTO `finalexam`.`subject` (`ID`, `Name`) VALUES ('1', 'toan');
INSERT INTO `finalexam`.`subject` (`ID`, `Name`) VALUES ('2', 'ly');
INSERT INTO `finalexam`.`subject` (`ID`, `Name`) VALUES ('3', 'hoa');


/*2. Viết lệnh để
a) Lấy tất cả các môn học không có bất kì điểm nào*/

select  A.name
from `subject` A
join `student` B on A.ID = B.ID
join `studentsubjec` C on B.id = C.StudentID
where mark is null;

--  b) Lấy danh sách các môn học có ít nhất 2 điểm

select  A.name
from `subject` A
join `student` B on A.ID = B.ID
join `studentsubjec` C on B.id = C.StudentID
where mark >2 ;


/*3. Tạo view có tên là "StudentInfo" lấy các thông tin về học sinh bao gồm:
Student ID,Subject ID, Student Name, Student Age, Student Gender,  Subject Name, Mark, Date
(Với cột Gender show 'Male' để thay thế cho 0, 'Female' thay thế cho 1 và 'Unknow' thay thế cho null)*/

create or replace view StudentInfo as
select *
from `subject` A
join `student` B on A.ID = B.ID
where gender ='male ';







/*4. Không sử dụng On Update Cascade & On Delete Cascade
a) Tạo trigger cho table Subject có tên là SubjectUpdateID:
Khi thay đổi data của cột ID của table Subject, thì giá trị tương
ứng với cột SubjectID của table StudentSubject cũng thay đổi
theo*/
drop trigger if exists trigger_Subject;
 DELIMITER $$
 create trigger trigger_Subject
 before update on `Subject`
 for each row
 begin
       UPDATE `StudentSubject`
        SET     SubjectID = NEW.id
        WHERE   SubjectID = OLD.id;
     end$$
     delimiter ;
UPDATE `finalexam`.`subject` SET `ID` = '5' WHERE (`ID` = '3');

/*b) Tạo trigger cho table Student có tên là StudentDeleteID:
Khi xóa data của cột ID của table Student, thì giá trị tương ứng với
cột SubjectID của table StudentSubject cũng bị xóa theo*/

drop trigger if exists trigger_StudentDeleteID;
 DELIMITER $$
 create trigger trigger_StudentDeleteID
 before delete on `Student`
 for each row
 begin
      DELETE
        FROM `StudentSubject`
        WHERE StudentID = OLD.ID;
     end$$
     delimiter ;
DELETE FROM `Student` WHERE ID =1;