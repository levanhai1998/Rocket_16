
use Testing_System_Assignment_1;

######Insert data bảng `Department`
# cách 1 điền đầy đủ cả thông tin
# cách này dễ bị lỗi [1062] nếu `DepartmentId` insert đã tồn tại trong bảng vì đây là khóa chính ko được trùng lập


#Cách 2 chỉ điền tên phòng ban, để ID tự tăng
INSERT INTO Department(DepartmentName)
VALUES ('Phòng Sale');
INSERT INTO Department(DepartmentName)
VALUES ('Phòng Dev 1');
INSERT INTO Department(DepartmentName)
VALUES ('Phòng Dev 2');

#Cách 3 insert nhiều data cùng 1 lúc
INSERT INTO Department(DepartmentName)
VALUES ('Phòng Bảo vệ'),
       ('Phòng Nhân sự'),
       ('Phòng Giám Đốc'),
       ('Phòng Kỹ thuật'),
       ('Phòng Thư ký'),
       ('Phòng Tạp vụ'),
       ('Phòng Phó Giám Đốc');

##### INSERT data bảng `position`
#Giá trị `PositionName` chỉ nhận các giá trị được gắn trong Enum vì đây là kiểu tự định nghĩa.
#`PositionName` ENUM ('Dev 1', 'Dev 2', 'Tester', 'PM', 'Mentor', 'Scrum Master', 'Giám đốc', 'Thư ký')
# ALTER TABLE `Position` CHANGE COLUMN `PositionName` `PositionName` ENUM ('Dev 1', 'Dev 2', 'Tester', 'PM', 'Mentor', 'Scrum Master', 'Giám đốc', 'Thư ký', 'Developer');

INSERT INTO `Position`(PositionName)
VALUES ('Dev 1'),
       ('Dev 2'),
       ('Giám đốc'),
       ('Tester'),
       ('PM'),
       ('Mentor'),
       ('Developer'),
       ('Scrum Master');

##### INSERT DATA bảng `Account`
DELETE
FROM `Account`;
INSERT INTO `Account`(Email, UserName, FullName, DepartmentId, PositionID, CreateDate)
VALUES ('email_vti1@gmail.com', 'acountvti1', 'Nguyễn Văn A', 4, 1, NOW()),
       ('email_vti2@gmail.com', 'acountvti2', 'Trinh Hoai Lam', 2, 1, '2021-02-26'),
       ('email_vti3@gmail.com', 'acountvti3', 'Nguyễn Thu Hoai', 4, 2, '2021-01-01'),
       ('email4@gmail.com', 'acountvti4', 'Trương Văn Bình', 2, 5, '2021-06-30'),
       ('email_vti5@gmail.com', 'acountvti5', 'Dương Chi Tai', 3, 3, '2021-01-01'),
       ('email6@gmail.com', 'acountvti6', 'Nguyễn Thế Hải', 9, 3, '2021-01-02'),
       ('email7@gmail.com', 'acountvti7', 'Dương Chí Dũng', 7, 1, NOW()),
       ('email8@gmail.com', 'acountvti8', 'Cao Hữu Đạt', 4, 2, NOW()),
       ('email9@gmail.com', 'acountvti9', 'Nguyễn văn B', 4, 4, '2021-05-01'),
       ('email10@gmail.com', 'acountvti10', 'Mai Anh Tài', 3, 5, '2021-06-06');
INSERT INTO `Account` (Email, UserName, FullName, DepartmentId, PositionID, CreateDate)
VALUES ('email11@gmail.com', 'acountvti11', 'Dao Van Bo', 1, 2, '2021-05-05');

INSERT INTO `Group` (GroupName, CreatorID, CreateDate)
VALUES ('Testing System', 1, '2019-03-05'),
       ('Development', 9, '2020-03-07'),
       ('VTI Sale 01', 2, '2020-03-09'),
       ('VTI Sale 02', 9, '2020-03-10'),
       ('VTI Development', 3, '2021-01-10'),
       ('VTI Sale 05', 1, '2021-03-10'),
       ('VTI Sale 03', 9, '2020-03-28'),
       ('VTI Creator', 6, '2020-04-06'),
       ('VTI Marketing 01', 5, '2020-04-07'),
       ('Management', 5, '2020-04-08'),
       ('Chat with love', 1, '2020-04-09'),
       ('Vi Ti Ai', 10, '2020-04-10');

/* DELETE FROM GroupAccount; */
INSERT INTO `GroupAccount` (GroupID, AccountID, JoinDate)
VALUES (1, 1, '2019-03-05'),
       (1, 2, '2020-03-07'),
       (1, 10, '2020-03-07'),
       (1, 8, '2020-03-07'),
       (3, 3, '2020-03-09'),
       (3, 4, '2020-03-10'),
       (5, 5, '2020-03-28'),
       (1, 3, '2020-04-06'),
       (1, 9, NOW()),
       (8, 3, NOW()),
       (1, 7, '2020-04-09'),
       (10, 10, '2020-04-10');

INSERT INTO TypeQuestion (TypeName)
VALUES ('Essay'),
       ('Multiple-Choice');

INSERT INTO CategoryQuestion (CategoryName)
VALUES ('Java'),
       ('ASP.NET'),
       ('ADO.NET'),
       ('SQL'),
       ('Postman'),
       ('Ruby'),
       ('Python'),
       ('C++'),
       ('C Sharp'),
       ('PHP');

INSERT INTO Question (Content, CategoryID, TypeID, CreatorID, CreateDate)
VALUES (N'Câu hỏi về Java', 1, '1', '2', '2020-04-05'),
       (N'Câu Hỏi về PHP', 10, '2', '2', '2020-04-05'),
       (N'Hỏi về C#', 9, '2', '3', '2020-04-06'),
       (N'Hỏi về Ruby', 6, '1', '4', '2020-04-06'),
       (N'Hỏi về Postman', 5, '1', '5', '2020-04-06'),
       (N'Hỏi về ADO.NET', 3, '2', '6', '2020-04-06'),
       (N'Hỏi về ASP.NET', 2, '1', '7', '2020-04-06'),
       (N'Hỏi về C++', 8, '1', '8', '2020-04-07'),
       (N'Hỏi về SQL', 4, '2', '9', '2020-04-07'),
       (N'Hỏi về Python', 7, '1', '10', '2020-04-07');
/* DELETE FROM Answer; */
INSERT INTO Answer (Content, QuestionID, isCorrect)
VALUES (N'Trả lời 01', 1, 0),
       (N'Trả lời 02', 1, 1),
       (N'Trả lời 03', 1, 0),
       (N'Trả lời 04', 1, 1),
       (N'Trả lời 05', 2, 1),
       (N'Trả lời 06', 3, 1),
       (N'Trả lời 07', 4, 0),
       (N'Trả lời 08', 8, 0),
       (N'Trả lời 09', 9, 1),
       ('Trả lời 10', 10, 1),
       ('Trả lời 11', 2, 0),
       ('Trả lời 12', 2, 0),
       ('Trả lời 13', 2, 1),
       ('Trả lời 14', 3, 1),
       ('Trả lời 15', 3, 1);

INSERT INTO Exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate)
VALUES ('VTIQ001', N'Đề thi C#', 1, 60, '5', '2019-04-05'),
       ('VTIQ002', N'Đề thi PHP', 10, 60, '2', '2019-04-05'),
       ('VTIQ003', N'Đề thi C++', 9, 120, '2', '2019-04-07'),
       ('VTIQ004', N'Đề thi Java', 6, 60, '3', '2020-04-08'),
       ('VTIQ005', N'Đề thi Ruby', 5, 120, '4', '2020-04-10'),
       ('VTIQ006', N'Đề thi Postman', 3, 60, '6', '2020-04-05'),
       ('VTIQ007', N'Đề thi SQL', 2, 60, '7', '2020-04-05'),
       ('VTIQ008', N'Đề thi Python', 8, 60, '8', '2020-04-07'),
       ('VTIQ009', N'Đề thi ADO.NET', 4, 90, '9', '2020-04-07'),
       ('VTIQ010', N'Đề thi ASP.NET', 7, 90, '10', '2020-04-08');


INSERT INTO ExamQuestion(ExamID, QuestionID)
VALUES (1, 5),
       (2, 10),
       (3, 4),
       (4, 3),
       (5, 7),
       (6, 10),
       (7, 2),
       (8, 10),
       (9, 9),
       (10, 8);