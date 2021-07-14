drop database if exists `FinalExam`;
create database if not exists `FinalExam`;

use `FinalExam`;
drop table if exists `Student`;
create table if not exists `Student`(
    `ID` tinyint primary key auto_increment,
    `Name` varchar(50) unique key ,
    `Age` int,
    `Gender` varchar(20)unique key
);

drop table if exists `Subject`;
create table if not exists `Subject`(
    `ID`tinyint primary key auto_increment,
    `Name` varchar(50)unique key
);

drop table if exists `StudentSubjec`;
create table if not exists `StudentSubjec`(
    `StudentID`tinyint primary key auto_increment,
    `SubjectID` int,
    `Mark` int,
    `Date` date
);


/*insert*/
INSERT INTO `finalexam`.`student` (`ID`, `Name`, `Age`, `Gender`) VALUES ('1', 'Le Van Hai', '23', 'nam');
INSERT INTO `finalexam`.`student` (`ID`, `Name`, `Age`, `Gender`) VALUES ('2', 'hoang manh cuong', '20', 'nam');
INSERT INTO `finalexam`.`student` (`ID`, `Name`, `Age`, `Gender`) VALUES ('3', 'le thi xuan', '18', 'nu');

INSERT INTO `finalexam`.`studentsubjec` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('1', '2', '8', '20-10-2020');
INSERT INTO `finalexam`.`studentsubjec` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('2', '5', '9', '21-11-2020');
INSERT INTO `finalexam`.`studentsubjec` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('3', '4', '10', '22-08-2020');

INSERT INTO `finalexam`.`subject` (`ID`, `Name`) VALUES ('1', 'le van hai');
INSERT INTO `finalexam`.`subject` (`ID`, `Name`) VALUES ('2', 'hoang thi thu');
INSERT INTO `finalexam`.`subject` (`ID`, `Name`) VALUES ('3', 'bui cong hoan');