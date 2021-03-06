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
                            (N'B???o v???'      ),
                            (N'Nh??n s???'     ),
                            (N'K??? thu???t'    ),
                            (N'T??i ch??nh'   ),
                            (N'Ph?? gi??m ?????c'),
                            (N'Gi??m ?????c'    ),
                            (N'Th?? k??'      ),
                            (N'B??n h??ng'    );
		
INSERT INTO position        (PositionName  )
VALUES 
                            ('Dev'         ),
                            ('Test'        ),
                            ('Scrum Master'),
                            ('PM'          );
                            
INSERT INTO `account`      (Email                  ,Username    ,Fullname         ,DepartmentID,PositionID,CreateDate)
VALUES 
					       ('thanhson@108gmail.com','soncon'    ,'Nguy???n Thanh S??n' ,1         ,1         ,'2012-12-10'),
                           ('manhanh@gmail.com'    ,'manhanh'   ,'Tr???n Th??? M???nh'    ,4         ,1         ,'2015-03-02'),
                           ('hunhtep@gmail.com'    ,'hungtep'   ,'Nguy???n M???nh H??ng' ,6         ,3         ,'2018-02-01'),
						   ('quangco@gmail.com'    ,'quangco'   ,'Nguy???n Duy Quang' ,1         ,3         ,'2010-02-03'),
                           ('truongchum@gmail.com' ,'truongchum','Nghi??m V??n Tr?????ng',5         ,2         ,'2018-02-05'),
                           ('dungbay@gmail.com'    ,'dungbay'   ,'Nghi??m V??n D??ng'  ,2         ,4         ,'2019-11-10'),
                           ('huyxuan@gmail.com'    ,'huyxuan'   ,'Ng?? Xu??n Huy'     ,5         ,1         ,'2017-12-12'),
                           ('dadao@gmail.com'      ,'dadao'     ,'Nguy???n Th??? Da Dao',2         ,3         ,'2016-02-20'),
                           ('hahung@gmail.com'     ,'hahung'    ,'Nguy???n Th??? H??'    ,1         ,2         ,'2016-02-09'),
                           ('haihoan@gmail.com'    ,'haihung'   ,'??o??n V??n H???i'     ,4         ,2         ,'2017-12-11');
                           
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
						   (N'C??u h???i v??? Java'   ,1         ,1     ,1        ,'2020-01-01'),
                           (N'C??u h???i v??? C#?'    ,3         ,2     ,2        ,'2020-01-01'),
                           (N'C??u h???i v??? C++'    ,2         ,2     ,3        ,'2020-01-01'),
                           (N'C??u h???i v??? PHP'    ,1         ,1     ,4        ,'2020-01-02'),
                           (N'C??u h???i v??? Sql'    ,5         ,2     ,5        ,'2020-01-02'),
                           (N'C??u h???i v??? Ruby'   ,6         ,1     ,6        ,'2020-01-02'),
                           (N'C??u h???i v??? Python' ,7         ,2     ,7        ,'2020-01-02'),
                           (N'C??u h???i v??? ASP.NET',8         ,2     ,8        ,'2020-01-03'),
                           (N'C??u h???i v??? ADO.NET',9         ,2     ,9        ,'2020-01-03'),
                           (N'C??u h???i v??? Postman',10        ,1     ,2        ,'2020-01-03');
                           
INSERT INTO answer         (Content      ,QuestionID,IsCorrext)
VALUES 
                           (N'Tr??? l???i 01',11         ,0        ),
                           (N'Tr??? l???i 02',12         ,1        ),
                           (N'Tr??? l???i 03',15         ,1        ),
                           (N'Tr??? l???i 04',14         ,1        ),
                           (N'Tr??? l???i 05',18         ,1        ),
                           (N'Tr??? l???i 06',20         ,1        ),
                           (N'Tr??? l???i 07',17         ,0        ),
                           (N'Tr??? l???i 08',16         ,0        ),
                           (N'Tr??? l???i 09',19         ,0        ),
                           (N'Tr??? l???i 10',13         ,1        );
                           
INSERT INTO exam           (`Code`,Title           ,CategoryID,Duration   ,CreatorID,CreateDate )
VALUES 
						   ('S100',N'????? thi C#'     ,   1     ,'2022-03-03',    1   ,'2020-01-01'),
                           ('S101',N'????? thi C++'    ,   5     ,'2022-03-03',    5   ,'2020-01-01'),
                           ('S102',N'????? thi Java'   ,   4     ,'2022-03-03',    4   ,'2020-01-01'),
                           ('S103',N'????? thi Sql'    ,   7     ,'2022-03-03',    2   ,'2020-01-01'),
                           ('S104',N'????? thi ADO.NET',   2     ,'2022-03-04',    3   ,'2020-01-01'),
                           ('S105',N'????? thi Python' ,   3     ,'2022-03-04',    5   ,'2020-01-01'),
                           ('S106',N'????? thi Postman',  10     ,'2022-03-04',    1   ,'2020-01-01'),
                           ('S107',N'????? thi Ruby'   ,   9     ,'2022-03-05',    1   ,'2020-01-01'),
                           ('S108',N'????? thi ASP.NRT',   6     ,'2022-03-05',    4   ,'2020-01-01'),
                           ('S109',N'????? thi NET'    ,   8     ,'2022-03-05',    1   ,'2020-01-01');
                           
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
Question 1: Vi???t l???nh ????? l???y ra danh s??ch nh??n vi??n v?? th??ng tin ph??ng ban c???a h???*/

SELECT   A.Username, A.Fullname, D.departmentName
FROM `account` A
INNER JOIN department D ON A.DepartmentID=D.departmentID;

/*Question 2: Vi???t l???nh ????? l???y ra th??ng tin c??c account ???????c t???o sau ng??y 20/12/2010*/

SELECT   *
FROM     `account`
WHERE     CreateDate > (2010 - 12 - 20);
/*Question 3: Vi???t l???nh ????? l???y ra t???t c??? c??c developer*/

SELECT A.Fullname, P.PositionName
FROM `account` A
INNER JOIN position P ON A.PositionID=P.PositionID
WHERE P.PositionName = 'Dev';


/*Question 4: Vi???t l???nh ????? l???y ra danh s??ch c??c ph??ng ban c?? >3 nh??n vi??n*/

SELECT D.DepartmentName, COUNT(a.DepartmentID) AS SL FROM account A
INNER JOIN department D ON a.DepartmentID=D.DepartmentID
GROUP BY A.DepartmentID
HAVING COUNT(A.DepartmentID)>3;

/*Question 5: Vi???t l???nh ????? l???y ra danh s??ch c??u h???i ???????c s??? d???ng trong ????? thi nhi???u
nh???t*/

SELECT E.QuestionID,Q.Content 
FROM examquestion E
INNER JOIN  question Q ON Q.QuestionID = E.QuestionID
GROUP BY E.QuestionID
HAVING count(E.QuestionID) = (SELECT MAX(countQues) AS maxcountQues FROM (
SELECT COUNT(E.QuestionID) AS countQues FROM examquestion E
GROUP BY E.QuestionID) AS countTable);

/*Question 6: Th??ng k?? m???i category Question ???????c s??? d???ng trong bao nhi??u Question*/

SELECT cq.CategoryID, cq.CategoryName, count(q.CategoryID) FROM categoryquestion cq
JOIN question q ON cq.CategoryID = q.CategoryID
GROUP BY q.CategoryID;

/*Question 7: Th??ng k?? m???i Question ???????c s??? d???ng trong bao nhi??u Exam*/

SELECT q.QuestionID, q.Content , count(eq.QuestionID) FROM examquestion eq
RIGHT JOIN question q ON q.QuestionID = eq.QuestionID
GROUP BY q.QuestionID;

/*Question 8: L???y ra Question c?? nhi???u c??u tr??? l???i nh???t*/

SELECT Q.QuestionID, Q.Content, count(A.QuestionID) FROM answer A
INNER JOIN question Q ON Q.QuestionID = A.QuestionID
GROUP BY A.QuestionID
HAVING count(A.QuestionID) = (SELECT max(countQues) FROM
(SELECT count(B.QuestionID) AS countQues FROM answer B
GROUP BY B.QuestionID) AS countAnsw);

/*Question 9: Th???ng k?? s??? l?????ng account trong m???i group*/

SELECT G.GroupID, COUNT(GA.AccountID) AS 'SO LUONG'
FROM GroupAccount GA
JOIN `group` G ON GA.GroupID = G.GroupID
GROUP BY G.GroupID
ORDER BY G.GroupID ASC;

/*Question 10: T??m ch???c v??? c?? ??t ng?????i nh???t*/

SELECT P.PositionID, P.PositionName, count( A.PositionID) AS SL FROM account A
INNER JOIN position P ON A.PositionID = P.PositionID
GROUP BY A.PositionID
HAVING count(A.PositionID)= (SELECT MIN(minP) FROM(
SELECT count(B.PositionID) AS minP FROM account B
GROUP BY B.PositionID) AS minPA);

/*Question 11: Th???ng k?? m???i ph??ng ban c?? bao nhi??u dev, test, scrum master, PM*/

SELECT d.DepartmentID,d.DepartmentName, p.PositionName, count(p.PositionName) FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
INNER JOIN position p ON a.PositionID = p.PositionID
GROUP BY d.DepartmentID, p.PositionID;

/*Question 12: L???y th??ng tin chi ti???t c???a c??u h???i bao g???m: th??ng tin c?? b???n c???a
question, lo???i c??u h???i, ai l?? ng?????i t???o ra c??u h???i, c??u tr??? l???i l?? g??, ...*/

SELECT Q.QuestionID, Q.Content, A.FullName, TQ.TypeName AS Author, ANS.Content FROM question Q
INNER JOIN categoryquestion CQ ON Q.CategoryID = CQ.CategoryID
INNER JOIN typequestion TQ ON Q.TypeID = TQ.TypeID
INNER JOIN account A ON A.AccountID = Q.CreatorID
INNER JOIN Answer AS ANS ON Q.QuestionID = ANS.QuestionID
ORDER BY Q.QuestionID ASC

/*Question 13: L???y ra s??? l?????ng c??u h???i c???a m???i lo???i t??? lu???n hay tr???c nghi???m*/

SELECT TQ.TypeID, TQ.TypeName, COUNT(Q.TypeID) AS SL FROM question Q
INNER JOIN typequestion TQ ON Q.TypeID = TQ.TypeID
GROUP BY Q.TypeID;

/*Question 14:L???y ra group kh??ng c?? account n??o*/

SELECT * FROM `group` g
LEFT JOIN groupaccount ga ON g.GroupID = ga.GroupID
WHERE GA.AccountID IS NULL;

/*Question 15: L???y ra group kh??ng c?? account n??o*/

SELECT * FROM groupaccount ga
RIGHT JOIN `group` g ON ga.GroupID = g.GroupID
WHERE ga.AccountID IS NULL;

/*Question 16: L???y ra question kh??ng c?? answer n??o*/                       
                         
SELECT q.QuestionID FROM answer a
RIGHT JOIN question q on a.QuestionID = q.QuestionID
WHERE a.AnswerID IS NULL;                         

/*Question 17
a) L???y c??c account thu???c nh??m th??? 1*/
SELECT A.FullName FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 1;

/*b) L???y c??c account thu???c nh??m th??? 2*/

SELECT A.FullName FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 2;

/*c) Gh??p 2 k???t qu??? t??? c??u a) v?? c??u b) sao cho kh??ng c?? record n??o tr??ng nhau*/

SELECT A.FullName
FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 1
UNION
SELECT A.FullName
FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 2;
                      
                      
                           


