DROP DATABASE IF EXISTS testing_system_assignment_5;
CREATE DATABASE testing_system_assignment_5;

USE testing_system_assignment_5;

DROP TABLE IF EXISTS Department;

CREATE TABLE Department (
    DepartmentID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName NVARCHAR(30) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS Position;
CREATE TABLE `Position` (
    PositionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
    AccountID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(50) NOT NULL UNIQUE KEY,
    Username VARCHAR(50) NOT NULL UNIQUE KEY,
    FullName NVARCHAR(50) NOT NULL,
    DepartmentID TINYINT UNSIGNED NOT NULL,
    PositionID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT NOW(),
    FOREIGN KEY (DepartmentID)
        REFERENCES Department (DepartmentID),
    FOREIGN KEY (PositionID)
        REFERENCES `Position` (PositionID)
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
    GroupID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName NVARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID TINYINT UNSIGNED,
    CreateDate DATETIME DEFAULT NOW(),
    FOREIGN KEY (CreatorID)
        REFERENCES `Account` (AccountId)
);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount (
    GroupID TINYINT UNSIGNED NOT NULL,
    AccountID TINYINT UNSIGNED NOT NULL,
    JoinDate DATETIME DEFAULT NOW(),
    PRIMARY KEY (GroupID , AccountID),
    FOREIGN KEY (GroupID)
        REFERENCES `Group` (GroupID),
    FOREIGN KEY (AccountID)
        REFERENCES `Account` (AccountID)
);

DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
    TypeID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName ENUM('Essay', 'Multiple-Choice') NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion (
    CategoryID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS Question;
CREATE TABLE Question (
    QuestionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content NVARCHAR(100) NOT NULL,
    CategoryID TINYINT UNSIGNED NOT NULL,
    TypeID TINYINT UNSIGNED NOT NULL,
    CreatorID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT NOW(),
    FOREIGN KEY (CategoryID)
        REFERENCES CategoryQuestion (CategoryID),
    FOREIGN KEY (TypeID)
        REFERENCES TypeQuestion (TypeID),
    FOREIGN KEY (CreatorID)
        REFERENCES `Account` (AccountId)
);

DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer (
    AnswerID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content NVARCHAR(100) NOT NULL,
    QuestionID TINYINT UNSIGNED NOT NULL,
    isCorrect BIT DEFAULT 1,
    FOREIGN KEY (QuestionID)
        REFERENCES Question (QuestionID)
);

DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam (
    ExamID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code` CHAR(10) NOT NULL,
    Title NVARCHAR(50) NOT NULL,
    CategoryID TINYINT UNSIGNED NOT NULL,
    Duration TINYINT UNSIGNED NOT NULL,
    CreatorID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT NOW(),
    FOREIGN KEY (CategoryID)
        REFERENCES CategoryQuestion (CategoryID),
    FOREIGN KEY (CreatorID)
        REFERENCES `Account` (AccountId)
);

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion (
    ExamID TINYINT UNSIGNED NOT NULL,
    QuestionID TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (QuestionID)
        REFERENCES Question (QuestionID),
    FOREIGN KEY (ExamID)
        REFERENCES Exam (ExamID),
    PRIMARY KEY (ExamID , QuestionID)
);

-- Add data
INSERT INTO Department(DepartmentName)
VALUES
(N'Marketing' ),
(N'Sale' ),
(N'B???o v???' ),
(N'Nh??n s???' ),
(N'K??? thu???t' ),
(N'T??i ch??nh' ),
(N'Ph?? gi??m ?????c'),
(N'Gi??m ?????c' ),
(N'Th?? k??' ),
(N'No person' ),
(N'B??n h??ng' );

INSERT INTO Position (PositionName )
VALUES ('Dev' ),
('Test' ),
('Scrum Master'),
('PM' );

INSERT INTO `Account`(Email , Username, FullName , DepartmentID , PositionID,CreateDate)
VALUES ('thanhson@108gmail.com','soncon'    ,'Nguy???n Thanh S??n' , '5' , '1','2020-03-05'),
('manhanh@gmail.com'    ,'manhanh'   ,'Tr???n Th??? M???nh'     , '1' , '2','2020-03-05'),
 ('hunhtep@gmail.com'    ,'hungtep'   ,'Nguy???n M???nh H??ng', '2' , '2' ,'2020-03-07'),
 ('quangco@gmail.com'    ,'quangco'   ,'Nguy???n Duy Quang', '3' , '4' ,'2020-03-08'),
('truongchum@gmail.com' ,'truongchum','Nghi??m V??n Tr?????ng', '4' , '4' ,'2020-03-10'),
('dungbay@gmail.com'    ,'dungbay'   ,'Nghi??m V??n D??ng' , '6' , '3' ,'2020-04-05'),
('huyxuan@gmail.com'    ,'huyxuan'   ,'Ng?? Xu??n Huy', '2' , '2' , NULL ),
 ('dadao@gmail.com'      ,'dadao'     ,'Nguy???n Th??? Da Dao', '8' , '1' ,'2020-04-07'),
('hahung@gmail.com'     ,'hahung'    ,'Nguy???n Th??? H??'  , '2' , '2' ,'2020-04-07'),
('haihoan@gmail.com'    ,'haihung'   ,'??o??n V??n H???i' , '10' , '1' ,'2020-04-09'),
('hoa@gmail.com' , 'hoa' ,'Nguy???n Th??? Hoa', '10' , '1' , DEFAULT),
('minh@gmail.com' , 'minh','L?? Minh12' , '10' , '1' , DEFAULT); 

INSERT INTO `Group` ( GroupName , CreatorID , CreateDate)
VALUES (N'Testing System' , 5,'2019-03-05'),
(N'Development' , 1,'2020-03-07'),
(N'VTI Sale 01' , 2 ,'2020-03-09'),
(N'VTI Sale 02' , 3 ,'2020-03-10'),
(N'VTI Sale 03' , 4 ,'2020-03-28'),
(N'VTI Creator' , 6 ,'2020-04-06'),
(N'VTI Marketing 01' , 7 ,'2020-04-07'),
(N'Management' , 8 ,'2020-04-08'),
(N'Chat with love' , 9 ,'2020-04-09'),
(N'Vi Ti Ai' , 10 ,'2020-04-10');

INSERT INTO `GroupAccount` ( GroupID , AccountID , JoinDate )
VALUES ( 1 , 1,'2019-03-05'),
( 1 , 2,'2020-03-07'),
( 3 , 3,'2020-03-09'),
( 3 , 4,'2020-03-10'),
( 5 , 5,'2020-03-28'),
( 1 , 3,'2020-04-06'),
( 1 , 7,'2020-04-07'),
( 8 , 3,'2020-04-08'),
( 1 , 9,'2020-04-09'),
( 10 , 10,'2020-04-10');

INSERT INTO TypeQuestion (TypeName )
VALUES ('Essay' ),
('Multiple-Choice' );

INSERT INTO CategoryQuestion (CategoryName )
VALUES ('Java' ),
('ASP.NET' ),
('ADO.NET' ),
('SQL' ),
('Postman' ),
('Ruby' ),
('Python' ),
('C++' ),
('C Sharp' ),
('PHP' );

INSERT INTO Question (Content , CategoryID, TypeID , CreatorID, CreateDate )
VALUES (N'C??u h???i v??? Java' , 1 ,'1' , '2' ,'2020-04-05'),
(N'C??u H???i v??? PHP' , 10 ,'2' , '2' ,'2020-04-05'),
(N'H???i v??? C#' , 9 ,'2' , '3' ,'2020-04-06'),
(N'H???i v??? Ruby' , 6 ,'1' , '4' ,'2020-04-06'),
(N'H???i v??? Postman' , 5 ,'1' , '5' ,'2020-04-06'),
(N'H???i v??? ADO.NET' , 3 ,'2' , '6' ,'2020-04-06'),
(N'H???i v??? ASP.NET' , 2 ,'1' , '7' ,'2020-04-06'),
(N'H???i v??? C++' , 8 ,'1' , '8' ,'2020-04-07'),
(N'H???i v??? SQL' , 4 ,'2' , '9' ,'2020-04-07'),
(N'H???i v??? Python' , 7 ,'1' , '10' ,'2020-04-07');

INSERT INTO Answer ( Content , QuestionID , isCorrect )
VALUES (N'Tr??? l???i 01' , 1 , 0),
(N'Tr??? l???i 02' , 1 , 1),
(N'Tr??? l???i 03', 1 , 0 ),
(N'Tr??? l???i 04', 1 , 1 ),
(N'Tr??? l???i 05', 2 , 1 ),
(N'Tr??? l???i 06', 3 , 1 ),
(N'Tr??? l???i 07', 4 , 0 ),
(N'Tr??? l???i 08', 8 , 0 ),
(N'Tr??? l???i 09', 9 , 1 ),
(N'Tr??? l???i 10', 10 , 1 );

INSERT INTO Exam (`Code` , Title , CategoryID, Duration , CreatorID , CreateDate )
VALUES ('VTIQ001' , N'????? thi C#' ,1 , 60 , '5' ,'2019-04-05'),
('VTIQ002' , N'????? thi PHP' ,10 , 60 , '2' ,'2019-04-05'),
('VTIQ003' , N'????? thi C++' , 9 ,120 , '2' ,'2019-04-07'),
('VTIQ004' , N'????? thi Java' , 6 , 60, '3' ,'2020-04-08'),
('VTIQ005' , N'????? thi Ruby' , 5 , 120, '4' ,'2020-04-10'),
('VTIQ006' , N'????? thi Postman' , 3 ,60 , '6' ,'2020-04-05'),
('VTIQ007' , N'????? thi SQL' , 2 ,60 , '7' ,'2020-04-05'),
('VTIQ008' , N'????? thi Python' , 8 ,60 , '8' ,'2020-04-07'),
('VTIQ009' , N'????? thi ADO.NET' , 4 ,90 , '9' ,'2020-04-07'),
('VTIQ010' , N'????? thi ASP.NET' , 7 ,90 , '10' ,'2020-04-08');

INSERT INTO ExamQuestion(ExamID , QuestionID )
VALUES ( 1 , 5 ),
( 2 , 10 ),
( 3 , 4 ),
( 4 , 3 ),
( 5 , 7 ),
( 6 , 10 ),
( 7 , 2 ),
( 8 , 10 ),
( 9 , 9 ),
( 10 , 8 );

#Question 1: T???o view c?? ch???a danh s??ch nh??n vi??n thu???c ph??ng ban sale
CREATE OR REPLACE VIEW vw_DSNV_Sale AS
SELECT A.*, D.DepartmentName
FROM `account` A
INNER JOIN department D ON A.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sale';

SELECT * FROM vw_DSNV_Sale;

#Question 2: T???o view c?? ch???a th??ng tin c??c account tham gia v??o nhi???u group nh???t


#Question 3: T???o view c?? ch???a c??u h???i c?? nh???ng content qu?? d??i (content qu?? 300 t??? ???????c coi l?? qu?? d??i) v?? x??a n?? ??i

CREATE OR REPLACE VIEW vw_ContenTren15Tu AS
SELECT *
FROM Question
WHERE LENGTH(Content) > 15;
SELECT *
FROM vw_ContenTren15Tu;
DELETE FROM vw_ContenTren15Tu;

#Question 4: T???o view c?? ch???a danh s??ch c??c ph??ng ban c?? nhi???u nh??n vi??n nh???t
CREATE OR REPLACE VIEW vw_MaxNV
AS
SELECT D.DepartmentName, count(A.DepartmentID) AS SL
FROM account A
INNER JOIN `department` D ON D.DepartmentID = A.DepartmentID
GROUP BY A.DepartmentID
HAVING count(A.DepartmentID) = (SELECT MAX(countDEP_ID) AS maxDEP_ID FROM(SELECT count(A1.DepartmentID) AS countDEP_ID FROM account A1 
                                                                     GROUP BY A1.DepartmentID) AS TB_countDepID);
SELECT * FROM vw_MaxNV;

#Question 5: T???o view c?? ch???a t???t c??c c??c c??u h???i do user h??? Nguy???n t???o
WITH cte_Que5 AS(
SELECT Q.CategoryID, Q.Content, A.FullName AS Creator FROM question Q
INNER JOIN `account` A ON A.AccountID = Q.CreatorID
WHERE SUBSTRING_INDEX( A.FullName, ' ', 1 ) = 'Nguy???n')
SELECT * FROM cte_Que5;