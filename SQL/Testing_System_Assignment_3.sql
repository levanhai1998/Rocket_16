USE `Testing_System_Assignment_2`;

-- Câu 1
SELECT * FROM `Department`;
SELECT * FROM `Positions`;
SELECT * FROM `Accountt`;
SELECT * FROM `Groupp`;
SELECT * FROM `GroupAccount`;
SELECT * FROM `TypeQuestion`;
SELECT * FROM `CategoryQuestion`;
SELECT * FROM `Question`;
SELECT * FROM `Answer`;
SELECT * FROM `Exam`;
SELECT * FROM `ExamQuetion`;

-- Câu 2
SELECT DepartmentName FROM Department;

-- Câu 3
SELECT DepartmentId, DepartmentName FROM Department WHERE DepartmentName = 'Kế toán';

-- Câu 4
SELECT * FROM `Account`;
SELECT MAX(character_length(FullName)) FROM `Account`;
SELECT FullName FROM `Account` WHERE character_length(FullName) = (SELECT MAX(character_length(FullName)) FROM `Account`);

-- Câu 5
SELECT FullName FROM `Account` WHERE character_length(FullName) = (SELECT MAX(character_length(FullName)) FROM `Account` WHERE DepartmentId = 1);

-- Câu 6
SELECT * FROM `Group`;
SELECT GroupName FROM `Group` WHERE CreateDate > '2021/05/30';

