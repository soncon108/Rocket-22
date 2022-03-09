DROP DATABASE IF EXISTS testing_system_assignment_4;
CREATE DATABASE IF NOT EXISTS testing_system_assignment_4;

USE testing_system_assignment_4;


CREATE TABLE department (
    DepartmentID              TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName            NVARCHAR(30) NOT NULL UNIQUE KEY
);

CREATE TABLE `position` (
    PositionID                TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName              ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL UNIQUE KEY
);

CREATE TABLE `account` (
    AccountID                  TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email                      VARCHAR(50) NOT NULL UNIQUE KEY,
    Username                   VARCHAR(100) NOT NULL UNIQUE KEY,
    Fullname                   NVARCHAR(50) NOT NULL,
    DepartmentID               TINYINT UNSIGNED NOT NULL,
    PositionID                 TINYINT UNSIGNED NOT NULL,
    CreateDate                 DATETIME DEFAULT NOW(),
    FOREIGN KEY (DepartmentID) REFERENCES department (DepartmentID),
    FOREIGN KEY (PositionID)   REFERENCES position (PositionID)
);

CREATE TABLE `group` (
    GroupID                    TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName                  NVARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID                  TINYINT UNSIGNED,
    CreateDate                 DATETIME DEFAULT NOW(),
    FOREIGN KEY(CreatorID)     REFERENCES `account`(AccountID)
);

CREATE TABLE `groupaccount` (
    GroupID                    TINYINT UNSIGNED NOT NULL,
    AccountID                  TINYINT UNSIGNED NOT NULL,
    JoinDate                   DATETIME DEFAULT NOW(),
    PRIMARY KEY (GroupID,AccountID),
    FOREIGN KEY (GroupID)      REFERENCES `group` (GroupID),
    FOREIGN KEY (AccountID)    REFERENCES `account` (AccountID)
);

CREATE TABLE `typequestion` (
    TypeID                     TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName                   ENUM('Essay', 'Multiple-choice') NOT NULL UNIQUE KEY
);

CREATE TABLE `categoryquestion` (
    CategoryID                TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName              NVARCHAR(50) NOT NULL UNIQUE KEY
);

CREATE TABLE `question` (
    QuestionID               TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content                  NVARCHAR(100) NOT NULL,
    CategoryID               TINYINT UNSIGNED NOT NULL,
    TypeID                   TINYINT UNSIGNED NOT NULL,
    CreatorID                TINYINT UNSIGNED NOT NULL,
    CreateDate               DATETIME DEFAULT NOW(),
    FOREIGN KEY (CategoryID) REFERENCES categoryquestion (CategoryID),
    FOREIGN KEY (TypeID)     REFERENCES typequestion (TypeID),
    FOREIGN KEY (CreatorID)     REFERENCES `account` (AccountID)
);

CREATE TABLE `answer` (
    AnswerID                 TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content                  NVARCHAR(100) NOT NULL,
    QuestionID               TINYINT UNSIGNED NOT NULL,
    IsCorrext                BIT DEFAULT 1,
    FOREIGN KEY (QuestionID) REFERENCES question (QuestionID)
);

CREATE TABLE `exam` (
    ExamID                   TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `code`                   CHAR(15) NOT NULL,
    Title                    NVARCHAR(50) NOT NULL,
    CategoryID               TINYINT UNSIGNED NOT NULL,
    Duration                 DATETIME DEFAULT NOW(),
    CreatorID                TINYINT UNSIGNED NOT NULL,
    CreateDate               DATETIME DEFAULT NOW(),
    FOREIGN KEY (CategoryID) REFERENCES categoryquestion (CategoryID),
	FOREIGN KEY (CreatorID)  REFERENCES `account`(AccountID)
);

CREATE TABLE `examquestion` (
    ExamID                   TINYINT UNSIGNED NOT NULL,
    QuestionID               TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY ( ExamID,QuestionID),
    FOREIGN KEY (ExamID)     REFERENCES exam (ExamID),
    FOREIGN KEY (QuestionID) REFERENCES question (QuestionID)
);
-- Add data
INSERT INTO department      (DepartmentName )
VALUES                        
                            (N'Marketing'   ),
                            (N'Sale'        ),
                            (N'Bảo vệ'      ),
                            (N'Nhân sự'     ),
                            (N'Kỹ thuật'    ),
                            (N'Tài chính'   ),
                            (N'Phó giám đốc'),
                            (N'Giám đốc'    ),
                            (N'Thư ký'      ),
                            (N'Bán hàng'    );
		
INSERT INTO position        (PositionName  )
VALUES 
                            ('Dev'         ),
                            ('Test'        ),
                            ('Scrum Master'),
                            ('PM'          );
                            
INSERT INTO `account`      (Email                  ,Username    ,Fullname         ,DepartmentID,PositionID,CreateDate)
VALUES 
					       ('thanhson@108gmail.com','soncon'    ,'Nguyễn Thanh Sơn' ,1         ,1         ,'2012-12-10'),
                           ('manhanh@gmail.com'    ,'manhanh'   ,'Trần Thế Mạnh'    ,4         ,1         ,'2015-03-02'),
                           ('hunhtep@gmail.com'    ,'hungtep'   ,'Nguyễn Mạnh Hùng' ,6         ,3         ,'2018-02-01'),
						   ('quangco@gmail.com'    ,'quangco'   ,'Nguyễn Duy Quang' ,1         ,3         ,'2010-02-03'),
                           ('truongchum@gmail.com' ,'truongchum','Nghiêm Văn Trường',5         ,2         ,'2018-02-05'),
                           ('dungbay@gmail.com'    ,'dungbay'   ,'Nghiêm Văn Dũng'  ,2         ,4         ,'2019-11-10'),
                           ('huyxuan@gmail.com'    ,'huyxuan'   ,'Ngô Xuân Huy'     ,5         ,1         ,'2017-12-12'),
                           ('dadao@gmail.com'      ,'dadao'     ,'Nguyễn Thị Da Dao',2         ,3         ,'2016-02-20'),
                           ('hahung@gmail.com'     ,'hahung'    ,'Nguyễn Thị Hà'    ,1         ,2         ,'2016-02-09'),
                           ('haihoan@gmail.com'    ,'haihung'   ,'Đoàn Văn Hải'     ,4         ,2         ,'2017-12-11');
                           
INSERT INTO `group`        (GroupName  ,CreatorID,CreateDate)
VALUES                      
						   ('GroupDev' ,1        ,'2015-02-02'),
                           ('GroupPM'  ,3        ,'2018-10-10'),
                           ('GroupPC'  ,6        ,'2020-02-05'),
                           ('GroupChat',7        ,'2011-10-15'),
                           ('GroupName',2        ,'2019-01-01'),
                           ('GroupTeam',4        ,'2021-11-11'),
                           ('GroupBan' ,5        ,'2020-02-22'),
                           ('GroupTest',2        ,'2019-12-21'),
                           ('GroupBy'  ,2        ,'2020-10-10'),
                           ('GroupSon' ,1        ,'2021-02-03');
                           
INSERT INTO groupaccount   (GroupID,AccountID,JoinDate    )
VALUES 
                           (2      ,1        ,'2022-04-28'),
                           (1      ,3        ,'2022-05-25'),
                           (3      ,2        ,'2022-02-23'),
                           (10     ,1        ,'2022-02-28'),
                           (1      ,7        ,'2022-02-01'),
                           (7      ,4        ,'2022-03-28'),
                           (4      ,8        ,'2022-10-28'),
                           (8      ,4        ,'2022-02-20'),
                           (4      ,10       ,'2022-11-28'),
                           (2      ,4        ,'2022-02-28');
                           
INSERT INTO typequestion   (TypeName         )
VALUES                   
                           ('Essay'          ),
                           ('Multiple-choice');
                           
                           
INSERT INTO categoryquestion(CategoryName)
VALUES 
							('Java'      ),
                            ('ASP.NET'   ),
                            ('Sql'       ),
                            ('Net'       ),
                            ('Postman'   ),
                            ('C++'       ),
                            ('C#'        ),
                            ('Python'    ),
                            ('Ruby'      ),
                            ('PHP'       );
	
INSERT INTO question       (Content              ,CategoryID,TypeID,CreatorID,CreateDate  )
VALUES 
						   (N'Câu hỏi về Java'   ,1         ,1     ,1        ,'2020-01-01'),
                           (N'Câu hỏi về C#?'    ,3         ,2     ,2        ,'2020-01-01'),
                           (N'Câu hỏi về C++'    ,2         ,2     ,3        ,'2020-01-01'),
                           (N'Câu hỏi về PHP'    ,1         ,1     ,4        ,'2020-01-02'),
                           (N'Câu hỏi về Sql'    ,5         ,2     ,5        ,'2020-01-02'),
                           (N'Câu hỏi về Ruby'   ,6         ,1     ,6        ,'2020-01-02'),
                           (N'Câu hỏi về Python' ,7         ,2     ,7        ,'2020-01-02'),
                           (N'Câu hỏi về ASP.NET',8         ,2     ,8        ,'2020-01-03'),
                           (N'Câu hỏi về ADO.NET',9         ,2     ,9        ,'2020-01-03'),
                           (N'Câu hỏi về Postman',10        ,1     ,2        ,'2020-01-03');
                           
INSERT INTO answer         (Content      ,QuestionID,IsCorrext)
VALUES 
                           (N'Trả lời 01',11         ,0        ),
                           (N'Trả lời 02',12         ,1        ),
                           (N'Trả lời 03',15         ,1        ),
                           (N'Trả lời 04',14         ,1        ),
                           (N'Trả lời 05',18         ,1        ),
                           (N'Trả lời 06',20         ,1        ),
                           (N'Trả lời 07',17         ,0        ),
                           (N'Trả lời 08',16         ,0        ),
                           (N'Trả lời 09',19         ,0        ),
                           (N'Trả lời 10',13         ,1        );
                           
INSERT INTO exam           (`Code`,Title           ,CategoryID,Duration   ,CreatorID,CreateDate )
VALUES 
						   ('S100',N'Đề thi C#'     ,   1     ,'2022-03-03',    1   ,'2020-01-01'),
                           ('S101',N'Đề thi C++'    ,   5     ,'2022-03-03',    5   ,'2020-01-01'),
                           ('S102',N'Đề thi Java'   ,   4     ,'2022-03-03',    4   ,'2020-01-01'),
                           ('S103',N'Đề thi Sql'    ,   7     ,'2022-03-03',    2   ,'2020-01-01'),
                           ('S104',N'Đề thi ADO.NET',   2     ,'2022-03-04',    3   ,'2020-01-01'),
                           ('S105',N'Đề thi Python' ,   3     ,'2022-03-04',    5   ,'2020-01-01'),
                           ('S106',N'Đề thi Postman',  10     ,'2022-03-04',    1   ,'2020-01-01'),
                           ('S107',N'Đề thi Ruby'   ,   9     ,'2022-03-05',    1   ,'2020-01-01'),
                           ('S108',N'Đề thi ASP.NRT',   6     ,'2022-03-05',    4   ,'2020-01-01'),
                           ('S109',N'Đề thi NET'    ,   8     ,'2022-03-05',    1   ,'2020-01-01');
                           
INSERT INTO examquestion(ExamID,QuestionID)
VALUES
                           (1,12),
                           (3,11),
                           (2,17),
                           (4,16),
                           (6,13),
                           (8,14),
                           (5,19),
                           (9,20),
                           (7,15),
                           (10,18);
                            
/*Exercise 1: Join
Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ*/

SELECT   A.Username, A.Fullname, D.departmentName
FROM `account` A
INNER JOIN department D ON A.DepartmentID=D.departmentID;

/*Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010*/

SELECT   *
FROM     `account`
WHERE     CreateDate > (2010 - 12 - 20);
/*Question 3: Viết lệnh để lấy ra tất cả các developer*/

SELECT A.Fullname, P.PositionName
FROM `account` A
INNER JOIN position P ON A.PositionID=P.PositionID
WHERE P.PositionName = 'Dev';


/*Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên*/

SELECT D.DepartmentName, COUNT(a.DepartmentID) AS SL FROM account A
INNER JOIN department D ON a.DepartmentID=D.DepartmentID
GROUP BY A.DepartmentID
HAVING COUNT(A.DepartmentID)>3;

/*Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều
nhất*/

SELECT E.QuestionID,Q.Content 
FROM examquestion E
INNER JOIN  question Q ON Q.QuestionID = E.QuestionID
GROUP BY E.QuestionID
HAVING count(E.QuestionID) = (SELECT MAX(countQues) AS maxcountQues FROM (
SELECT COUNT(E.QuestionID) AS countQues FROM examquestion E
GROUP BY E.QuestionID) AS countTable);

/*Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question*/

SELECT cq.CategoryID, cq.CategoryName, count(q.CategoryID) FROM categoryquestion cq
JOIN question q ON cq.CategoryID = q.CategoryID
GROUP BY q.CategoryID;

/*Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam*/

SELECT q.QuestionID, q.Content , count(eq.QuestionID) FROM examquestion eq
RIGHT JOIN question q ON q.QuestionID = eq.QuestionID
GROUP BY q.QuestionID;

/*Question 8: Lấy ra Question có nhiều câu trả lời nhất*/

SELECT Q.QuestionID, Q.Content, count(A.QuestionID) FROM answer A
INNER JOIN question Q ON Q.QuestionID = A.QuestionID
GROUP BY A.QuestionID
HAVING count(A.QuestionID) = (SELECT max(countQues) FROM
(SELECT count(B.QuestionID) AS countQues FROM answer B
GROUP BY B.QuestionID) AS countAnsw);

/*Question 9: Thống kê số lượng account trong mỗi group*/

SELECT G.GroupID, COUNT(GA.AccountID) AS 'SO LUONG'
FROM GroupAccount GA
JOIN `group` G ON GA.GroupID = G.GroupID
GROUP BY G.GroupID
ORDER BY G.GroupID ASC;

/*Question 10: Tìm chức vụ có ít người nhất*/

SELECT P.PositionID, P.PositionName, count( A.PositionID) AS SL FROM account A
INNER JOIN position P ON A.PositionID = P.PositionID
GROUP BY A.PositionID
HAVING count(A.PositionID)= (SELECT MIN(minP) FROM(
SELECT count(B.PositionID) AS minP FROM account B
GROUP BY B.PositionID) AS minPA);

/*Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM*/

SELECT d.DepartmentID,d.DepartmentName, p.PositionName, count(p.PositionName) FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
INNER JOIN position p ON a.PositionID = p.PositionID
GROUP BY d.DepartmentID, p.PositionID;

/*Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...*/

SELECT Q.QuestionID, Q.Content, A.FullName, TQ.TypeName AS Author, ANS.Content FROM question Q
INNER JOIN categoryquestion CQ ON Q.CategoryID = CQ.CategoryID
INNER JOIN typequestion TQ ON Q.TypeID = TQ.TypeID
INNER JOIN account A ON A.AccountID = Q.CreatorID
INNER JOIN Answer AS ANS ON Q.QuestionID = ANS.QuestionID
ORDER BY Q.QuestionID ASC

/*Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm*/

SELECT TQ.TypeID, TQ.TypeName, COUNT(Q.TypeID) AS SL FROM question Q
INNER JOIN typequestion TQ ON Q.TypeID = TQ.TypeID
GROUP BY Q.TypeID;

/*Question 14:Lấy ra group không có account nào*/

SELECT * FROM `group` g
LEFT JOIN groupaccount ga ON g.GroupID = ga.GroupID
WHERE GA.AccountID IS NULL;

/*Question 15: Lấy ra group không có account nào*/

SELECT * FROM groupaccount ga
RIGHT JOIN `group` g ON ga.GroupID = g.GroupID
WHERE ga.AccountID IS NULL;

/*Question 16: Lấy ra question không có answer nào*/                       
                         
SELECT q.QuestionID FROM answer a
RIGHT JOIN question q on a.QuestionID = q.QuestionID
WHERE a.AnswerID IS NULL;                         

/*Question 17
a) Lấy các account thuộc nhóm thứ 1*/
SELECT A.FullName FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 1;

/*b) Lấy các account thuộc nhóm thứ 2*/

SELECT A.FullName FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 2;

/*c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau*/

SELECT A.FullName
FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 1
UNION
SELECT A.FullName
FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 2;
                      
                      
                           


