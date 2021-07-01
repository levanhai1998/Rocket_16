drop database if exists `Testing_System_Assignment_1`;
create database if not exists `Testing_System_Assignment_1`;

use `Testing_System_Assignment_1`;

-- Table 1:Department
drop table if exists `Department`;
create table if not exists `Department`(
	`DepartmentID` tinyint primary key auto_increment,
    `Departmentname` varchar(50)
);

-- Table 2: Position
create table if not exists `Position`(
	`PositionID` tinyint primary key auto_increment,
    `PositionName` varchar(50)
);

-- Table 3: Account
create table if not exists `Account`(
	`AccountID` tinyint primary key auto_increment,
    `Email` varchar(50) unique key,
    `Username` varchar(50) unique key,
    `Fullname` varchar(50),
    `DepartmentID` tinyint unique key,
    `PositionID` tinyint unique key,
    `CreateDate` date
);

-- Table 4: Group
create table if not exists `Group`(
	`GroupID` tinyint primary key auto_increment,
    `GroupName` varchar(50),
    `CreatorID` tinyint unique key,
    `CreateDate:` date
);

-- Table 5: GroupAccount
create table if not exists `GroupAccount`(
	`GroupID` tinyint primary key auto_increment,
    `AccountID` tinyint unique key,
    `JoinDate` date
);

-- Table 6: TypeQuestion
create table if not exists `TypeQuestion`(
	`TypeID` tinyint primary key auto_increment,
    `TypeName` varchar(50)
);

-- Table 7: CategoryQuestion
create table if not exists `CategoryQuestion`(
	`CategoryID` tinyint primary key auto_increment,
    `CategoryName` varchar(50)
);

-- Table 8: Question
create table if not exists `Question`(
	`QuestionID` tinyint primary key auto_increment,
    `Content` varchar(50) unique key,
    `CategoryID` tinyint unique key,
    `TypeID` tinyint unique key,
    `CreatorID` tinyint unique key,
    `CreateDate` date
);

-- Table 9: Answer
create table if not exists `Answer`(
	`AnswerID` tinyint primary key auto_increment,
    `content` varchar(50),
    `QuestionID` tinyint unique key,
    `isCorrect` enum('trus', 'false')
);

-- able 10: Exam
create table if not exists `Exam`(
	`ExamID` tinyint primary key auto_increment,
    `code` varchar(50) unique key,
    `Title` varchar(50) unique key,
    `CategoryID` tinyint unique key,
    `Duration` tinyint,
    `CreatorID` tinyint unique key,
    `CreateDate` date
);

create table if not exists `ExamQuestion`(
	`ExamID` tinyint primary key auto_increment,
    `QuestionID` tinyint unique key
);