DROP DATABASE IF EXISTS `Testing_System_Assignment_4`;
CREATE DATABASE `Testing_System_Assignment_4`;
USE `Testing_System_Assignment_1`;

-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT A.Email, A.Username , A.FullName, D.DepartmentName
FROM `Account` A
INNER JOIN Department D ON A.DepartmentID = D.DepartmentID;
-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày '2018-12-05'
SELECT *
FROM `Account`
WHERE CreateDate < '2020-12-20';
-- Question 3: Viết lệnh để lấy ra tất cả các developer 
SELECT  A.* , P.PositionName
FROM	`Account` A
JOIN	`Position` P
ON		A.PositionID = P.PositionID
WHERE	P.PositionName = 'Dev';
-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >1 nhân viên
SELECT 		D.DepartmentName, COUNT(A.DepartmentID) AS 'Số lượng' 
FROM 		`Account` A
JOIN		`Department` D
ON			A.DepartmentID = D.DepartmentID
GROUP BY	D.DepartmentName
HAVING		COUNT(A.DepartmentID) > 1;
-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT		Q.*,COUNT(EQ.QuestionID)
FROM		`Question` Q
JOIN		`ExamQuestion` EQ
ON			Q.QuestionID = EQ.QuestionID
GROUP BY	Q.Content
HAVING		COUNT(EQ.QuestionID) = (SELECT MAX(COUNTQ)
									FROM 
                                    (SELECT 	COUNT(Q.Content) AS COUNTQ
									FROM		`Question` Q
									JOIN		`ExamQuestion` EQ
									ON			Q.QuestionID = EQ.QuestionID
									GROUP BY	Q.Content)AS MAXcontent);
-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT 		CQ.*,COUNT(Q.CategoryID) AS 'Số lần'
FROM		`CategoryQuestion` CQ
JOIN		`Question` Q
ON			CQ.CategoryID = Q.CategoryID
GROUP BY	Q.Content;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam

SELECT 		EQ.*, COUNT(EQ.QuestionID) AS 'SO LUONG'
FROM		`Question` Q
JOIN		`ExamQuestion` EQ
ON			Q.QuestionID = EQ.QuestionID
GROUP BY	EQ.QuestionID
HAVING		COUNT(EQ.QuestionID);

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
 SELECT		A.*,COUNT(A.QuestionID) AS 'SO LUONG'
 FROM		`Question` Q
 JOIN		`Answer` A
 ON			Q.QuestionID = A.QuestionID
 GROUP BY	A.Content
 HAVING		COUNT(A.QuestionID) = (SELECT MAX(COUNTQ)
									FROM (SELECT		COUNT(A.QuestionID) AS COUNTQ
											FROM		`Question` Q
											JOIN		`Answer` A
											ON			Q.QuestionID = A.QuestionID
                                            GROUP BY	A.Content)AS MaxQuestion);

-- Question 9: Thống kê số lượng account trong mỗi group 
SELECT 	G.*, COUNT(GA.GroupID) AS 'SO LUONG ACCOUNT'
FROM	`Group` G
JOIN	`GroupAccount` GA
ON 		G.GroupID =  GA.GroupID
GROUP BY	GA.GroupID;

-- Question 10: Tìm chức vụ có ít người nhất

SELECT 		P.*, COUNT(A.PositionID)
FROM		`Position` P
JOIN		`Account` A
ON			P.PositionID = A.PositionID
GROUP BY	A.PositionID
HAVING		COUNT(A.PositionID) = (SELECT MIN(COUNTP)
									FROM	(SELECT COUNT(A.PositionID) AS COUNTP
											FROM		`Position` P
											JOIN		`Account` A
											ON			P.PositionID = A.PositionID
											GROUP BY	A.PositionID)AS MinPosition);	
-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT P.*,COUNT(A.PositionID) AS 'SO LUONG'
FROM	`Account` A
JOIN	`Position` P
ON		P.PositionID = A.PositionID
GROUP BY	A.PositionID;

SELECT P.*,COUNT(A.PositionID) AS 'SO LUONG'
FROM	`Account` A
JOIN	`Position` P
USING	(PositionID)
JOIN	`Department` D
USING 	(DepartmentID)
GROUP BY	A.PositionID;
/* Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
  question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …*/

SELECT	*
FROM	`Question` Q
JOIN	`Answer` A
ON		Q.QuestionID = A.QuestionID;


-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm

SELECT 		TQ.*, COUNT(Q.TypeID) AS ' Số Lượng'
FROM		`TypeQuestion` TQ
JOIN		`Question` Q
ON 			TQ.TypeID = Q.TypeID
GROUP BY 	Q.TypeID;	

-- Question 14:Lấy ra group không có account nào

SELECT		*
FROM		`Group` G
LEFT JOIN	`GroupAccount` GA
ON			G.GroupID = GA.GroupID
WHERE		GA.GroupID IS NULL;
-- Question 15: Lấy ra group không có account nào

SELECT 	*
FROM	`Group`
WHERE	GroupID NOT IN (SELECT GroupID
						FROM	`GroupAccount` );

-- Question 16: Lấy ra question không có answer nào

SELECT		*
FROM		`Question` Q
LEFT JOIN	`Answer` A
USING 		(QuestionID)
WHERE		A.QuestionID IS NULL;

/*Question 17: 
a) Lấy các account thuộc nhóm thứ 1
b) Lấy các account thuộc nhóm thứ 2
c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau*/

SELECT 	A.*
FROM	`Account` A
JOIN	`GroupAccount` GA
USING	(AccountID)
WHERE	GA.GroupID = 1

UNION

SELECT 	A.*
FROM	`Account` A
JOIN	`GroupAccount` GA
USING	(AccountID)
WHERE	GA.GroupID = 2;

/*Question 18: 
a) Lấy các group có lớn hơn 5 thành viên
b) Lấy các group có nhỏ hơn 7 thành viên
c) Ghép 2 kết quả từ câu a) và câu b)*/

SELECT 	G.*,COUNT(GA.AccountID) AS ' Thành Viên '
FROM	`Group` G
JOIN	`GroupAccount` GA
ON		G.GroupID = GA.GroupID
GROUP BY	GA.GroupID
HAVING	COUNT(GA.AccountID) > 3

UNION

SELECT 	G.*,COUNT(GA.AccountID) AS ' Thành Viên '
FROM	`Group` G
JOIN	`GroupAccount` GA
ON		G.GroupID = GA.GroupID
GROUP BY	GA.GroupID
HAVING	COUNT(GA.AccountID) < 2;