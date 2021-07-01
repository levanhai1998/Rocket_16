drop database if exists Testing_System_Assignment_2;
create database if not exists Testing_System_Assignment_2;

use Testing_System_Assignment_2;

create table if not exists Department(
	DepartmentID tinyint auto_increment primary key,
    DepartmentName varchar(50) 
);

insert into department(DepartmentName)
values 	('Marketing'),
		('Giám đốc'),
		('Bảo vệ'),
        ('Nhân sự'),
        ('Kế toán');
        
create table if not exists Positions (
	PositionID tinyint auto_increment primary key,
    PositionName enum('Dev', 'Test', 'Scrum Master', 'PM')
);
insert into Positions(PositionName)
values 	('Dev'),
		('Test'),
		('Scrum Master'),
        ('PM'),
        ('Dev');

create table if not exists Accountt(
	AccountID tinyint auto_increment primary key,
    Email varchar(255),
    Username varchar(255),
    Fullname varchar(50),
    DepartmentID tinyint,
    foreign key (DepartmentID) references Department(DepartmentID),
    PositionID tinyint,
    foreign key (PositionID) references Positions (PositionID),
    CreateDate datetime 
); 

insert into Accountt(Email, Username, Fullname, DepartmentID, PositionID, CreateDate)
values 	('levana@gmail.com', 'A', 'le van a', 1, 1, '2021/01/01 '),
		('levanb@gmail.com', 'B', 'le van b', 2, 2, '2021/02/02 '),
        ('levanc@gmail.com', 'C', 'le van c', 3, 3, '2021/03/03 '),
        ('levand@gmail.com', 'D', 'le van d', 4, 4, '2021/04/04 '),
        ('levae@gmail.com', 'E', 'le van e', 5, 5, '2021/05/01 ');

create table if not exists Groupp(
	GroupID tinyint auto_increment primary key,
    GroupName varchar(50),
    CreatorID tinyint,
    CreateDate datetime
);

insert into Groupp(GroupName, CreatorID, CreateDate)
values 	('Group1', 1, '2021/01/01 '),
		('Group2', 2, '2021/02/02 '),
        ('Group3', 3, '2021/03/03 '),
        ('Group4', 4, '2021/04/04 '),
        ('Group5', 5, '2021/05/05');

create table if not exists GroupAccount(
	GroupID tinyint ,
	foreign key (GroupID) references Groupp(GroupID), 
    AccountID tinyint,
    foreign key (AccountID) references Accountt(AccountID),
    JoinDate datetime
);

insert into GroupAccount(GroupID, AccountID, JoinDate)
values 	(1, 1, '2021/01/01 '),
		(2, 2, '2021/02/02'),
        (3, 3, '2021/03/03 '),
        (4, 4, 05/06/2021),
        (5, 5, 06/07/2021);
create table if not exists TypeQuestion(
	TypeID tinyint auto_increment primary key,
    TypeName enum('Essay', 'Multiple-Choice')
);

insert into TypeQuestion(TypeName)
values 	(1),
		(2),
        (1),
        (2),
        (2);

create table if not exists CategoryQuestion(
	CategoryID tinyint auto_increment primary key,
    CategoryName enum('JAVA', '.NET', 'SQL', 'Postman', 'Ruby')
);

insert into CategoryQuestion(CategoryName)
values 	(1),
		(2),
        (3),
        (4),
        (5);

create table if not exists Question(
	QuestionID tinyint auto_increment primary key,
    Content varchar(100),
    CategoryID tinyint,
    foreign key(CategoryID) references CategoryQuestion(CategoryID),
    TypeID tinyint,
    foreign key(TypeID) references TypeQuestion(TypeID),
    CreatorID tinyint,
    CreateDate datetime
);

insert into Question(Content, CategoryID, TypeID, CreatorID, CreateDate)
values ('Bài 1', 1, 1, 1, '2021/01/01 '),
		('Bài 2 là gì?', 2, 2, 2, '2021/02/02 '),
        ('Bài 3', 3, 3, 3, '2021/03/03 '),
        ('Bài 4', 4, 4, 4, '2021/04/04 '),
        ('Bài5', 5, 5, 5, '2021-05-05 ');

create table if not exists Answer(
	AnswerID tinyint auto_increment primary key,
    Content varchar(50) ,
    QuestionID tinyint,
    foreign key(QuestionID) references Question(QuestionID),
    isCorrect tinyint(1)
);

insert into Answer(Content, QuestionID, isCorrect)
values ('Câu hỏi 1', 1, 1),
		('Câu hỏi 2', 2, 1),
        ('Câu hỏi 3', 3, 1),
        ('Câu hỏi4', 4, 1),
        ('Câu hỏi5', 5, 1);

create table if not exists Exam(
	ExamID tinyint auto_increment primary key,
    Codee varchar(50),
    Title varchar(50),
    CategoryID tinyint,
    Duration smallint,
    CreatorID tinyint,
    CreateDate datetime
);

insert into Exam(Codee, Title, CategoryID, Duration, CreatorID, CreateDate)
values 	('01', 'a', 1, 100, 1, '2021/02/01 '),
		('02', 'b', 2, 100, 2, '2021/02/01'),
        ('03', 'c', 3, 100, 3, '2021/02/01 '),
        ('04', 'd', 4, 100, 4, '2021/02/01 '),
        ('05', 'e', 5, 100, 5, '2021/02/01 ');

create table if not exists ExamQuetion(
	ExamID tinyint ,
	foreign key(ExamID) references Exam(ExamID),
    QuestionID tinyint, 
    foreign key(QuestionID) references Question(QuestionID)
);

insert into ExamQuetion(ExamID, QuestionID)
values 	(1, 1),
		(2, 2),
		(3, 3),
		(4, 4),
		(5, 5);
