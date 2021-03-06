CREATE DATABASE IF NOT EXISTS testing_system_assignment_3;

USE testing_system_assignment_3;


CREATE TABLE department (
    DepartmentID              INT NOT NULL AUTO_INCREMENT,
    DepartmentName            VARCHAR(100),
    PRIMARY KEY (DepartmentID)
);

CREATE TABLE `position` (
    PositionID                INT NOT NULL AUTO_INCREMENT,
    PositionName              ENUM('Dev', 'Test', 'Scrum Master', 'PM'),
    PRIMARY KEY (PositionID)
);

CREATE TABLE `account` (
    AccountID                  INT NOT NULL AUTO_INCREMENT,
    Email                      CHAR(100),
    Username                   VARCHAR(100),
    Fullname                   VARCHAR(150),
    DepartmentID               INT,
    PositionID                 INT,
    CreateDate                 DATE,
    PRIMARY KEY (AccountID),
    FOREIGN KEY (DepartmentID) REFERENCES department (DepartmentID),
    FOREIGN KEY (PositionID)   REFERENCES position (PositionID)
);

CREATE TABLE `group` (
    GroupID                    INT NOT NULL AUTO_INCREMENT,
    GroupName                  VARCHAR(100),
    CreatorID                  INT,
    CreateDate                 DATE,
    PRIMARY KEY (GroupID)
);

CREATE TABLE `groupaccount` (
    GroupID                    INT,
    AccountID                  INT,
    JoinDate                   DATE,
    FOREIGN KEY (GroupID)      REFERENCES `group` (GroupID),
    FOREIGN KEY (AccountID)    REFERENCES `account` (AccountID)
);

CREATE TABLE `typequestion` (
    TypeID                     INT NOT NULL AUTO_INCREMENT,
    TypeName                   ENUM('Essay', 'Multiple-choice'),
    PRIMARY KEY (TypeID)
);

CREATE TABLE `categoryquestion` (
    CategoryID                INT NOT NULL AUTO_INCREMENT,
    CategoryName              ENUM('Java', 'Net', 'Sql', 'Postman', 'Ruby'),
    PRIMARY KEY (CategoryID)
);

CREATE TABLE `question` (
    QuestionID               INT NOT NULL AUTO_INCREMENT,
    Content                  TEXT,
    CategoryID               INT,
    TypeID                   INT,
    CreatorID                INT,
    CreateDate               DATE,
    PRIMARY KEY (QuestionID),
    FOREIGN KEY (CategoryID) REFERENCES categoryquestion (CategoryID),
    FOREIGN KEY (TypeID)     REFERENCES typequestion (TypeID)
);

CREATE TABLE `answer` (
    AnswerID                 INT NOT NULL AUTO_INCREMENT,
    Content                  TEXT,
    QuestionID               INT,
    IsCorrext                ENUM('True','False'),
    PRIMARY KEY (AnswerID),
    FOREIGN KEY (QuestionID) REFERENCES question (QuestionID)
);

CREATE TABLE `exam` (
    ExamID                   INT NOT NULL AUTO_INCREMENT,
    `code`                   CHAR(15),
    Title                    VARCHAR(100),
    CategoryID               INT,
    Duration                 DATETIME,
    CreatorID                INT,
    CreateDate               DATE,
    PRIMARY KEY (ExamID),
    FOREIGN KEY (CategoryID) REFERENCES categoryquestion (CategoryID)
);

CREATE TABLE `examquestion` (
    ExamID                   INT,
    QuestionID               INT,
    FOREIGN KEY (ExamID)     REFERENCES exam (ExamID),
    FOREIGN KEY (QuestionID) REFERENCES question (QuestionID)
);
-- Add data
INSERT INTO department (DepartmentName)
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
		
INSERT INTO position        (PositionName)
VALUES 
                            ('Dev'         ),
                            ('Test'        ),
                            ('Scrum Master'),
                            ('PM'          );
                            
INSERT INTO `account` (Email,Username,Fullname,DepartmentID,PositionID,CreateDate)
VALUES 
					       ('thanhson@108gmail.com','soncon','Nguy???n Thanh S??n',1,1,'2012-12-10'    ),
                           ('manhanh@gmail.com','manhanh','Tr???n Th??? M???nh',4,1,'2015-03-02'          ),
                           ('hunhtep@gmail.com','hungtep','Nguy???n M???nh H??ng',6,3,'2018-02-01'       ),
						   ('quangco@gmail.com','quangco','Nguy???n Duy Quang',1,3,'2020-02-03'       ),
                           ('truongchum@gmail.com','truongchum','Nghi??m V??n Tr?????ng',5,2,'2018-02-05'),
                           ('dungbay@gmail.com','dungbay','Nghi??m V??n D??ng',2,4,'2019-11-10'        ),
                           ('huyxuan@gmail.com','huyxuan','Ng?? Xu??n Huy',5,1,'2017-12-12'           ),
                           ('dadao@gmail.com','dadao','Nguy???n Th??? Da Dao',2,3,'2020-02-20'          ),
                           ('hahung@gmail.com','hahung','Nguy???n Th??? H??',1,2,'2016-02-09'            ),
                           ('haihoan@gmail.com','haihung','??o??n V??n H???i',4,2,'2020-12-11'           );
                           
INSERT INTO `group` (GroupName,CreatorID,CreateDate)
VALUES                      
						   ('GroupDev',1,'2015-02-02' ),
                           ('GroupPM',3,'2018-10-10'  ),
                           ('GroupPC',6,'2020-02-05'  ),
                           ('GroupChat',7,'2021-10-15'),
                           ('GroupName',2,'2022-01-01'),
                           ('GroupTeam',4,'2011-11-11'),
                           ('GroupBan',5,'2022-02-22' ),
                           ('GroupTest',2,'2019-12-21'),
                           ('GroupBy',2,'2020-10-10'  ),
                           ('GroupSon',1,'2022-02-03' );
                           
INSERT INTO groupaccount (GroupID,AccountID,JoinDate)
VALUES 
                           (2,1,'2022-02-28'),
                           (1,3,'2022-02-25'),
                           (3,2,'2022-02-23'),
                           (4,5,'2022-02-28'),
                           (5,7,'2022-02-01'),
                           (7,4,'2022-03-28'),
                           (6,8,'2022-10-28'),
                           (8,6,'2022-02-20'),
                           (9,10,'2022-11-28'),
                           (10,9,'2022-02-28');
                           
INSERT INTO typequestion (TypeName)
VALUES                   
						   ('Multiple-choice'),
                           ('Essay'          ),
                           ('Multiple-choice'),
                           ('Multiple-choice'),
                           ('Essay'          ),
                           ('Essay'          ),
                           ('Essay'          ),
                           ('Multiple-choice'),
                           ('Essay'          ),
                           ('Essay'          );
                           
INSERT INTO categoryquestion(CategoryName)
VALUES 
						   ('Java'   ),
                           ('Java'   ),
                           ('Sql'    ),
                           ('Net'    ),
                           ('Sql'    ),
                           ('Ruby'   ),
                           ('Sql'    ),
                           ('Net'    ),
                           ('Postman'),
                           ('Ruby'   );
	
INSERT INTO question (Content,CategoryID,TypeID,CreatorID,CreateDate)
VALUES 
						   ('B???n h???c ng??nh g???',11,1,1,'2020-01-01'      ),
                           ('B???n h???c m??n g???',12,2,2,'2020-01-01'        ),
                           ('B???n h???c ??? ????u?',13,3,3,'2020-01-01'         ),
                           ('B???n h???c l???i m??n g???',14,4,5,'2020-01-01'    ),
                           ('B???n h???c xong ch??a?',15,1,5,'2020-01-01'     ),
                           ('B???n h???c h???c l???i m??n g???',16,5,1,'2020-01-01'),
                           ('B???n h???c m??n g???',17,7,2,'2020-01-01'        ),
                           ('B???n h???c ng??nh g???',18,8,3,'2020-01-01'      ),
                           ('B???n h???c xong ch??a?',19,9,5,'2020-01-01'     ),
                           ('B???n h???c ng??nh g???',20,10,4,'2020-01-01'     );
                           
INSERT INTO answer (Content,QuestionID,IsCorrext)
VALUES 
                           ('T??i h???c CNTT',21,'True' ),
                           ('T??i h???c CNTT',24,'False'),
                           ('T??i h???c CNTT',25,'False'),
                           ('T??i ch??a xong',29,'True'),
                           ('T??i h???c ??? HN',23,'True' ),
                           ('T??i h???c CNTT',22,'False'),
                           ('T??i h???c CNTT',26,'True' ),
                           ('T??i h???c CNTT',28,'True' ),
                           ('T??i h???c CNTT',30,'True'),
                           ('T??i h???c IT',27,'False'  );
                           
INSERT INTO exam (`Code`,Title,CategoryID,Duration,CreatorID,CreateDate)
VALUES 
						   (100,'Thi h???c k???',11,'2022-03-03',1,'2020-01-01'),
                           (101,'Thi h???c k???',15,'2022-03-03',5,'2020-01-01'),
                           (102,'Thi h???c k???',14,'2022-03-03',4,'2020-01-01'),
                           (103,'Thi h???c k???',17,'2022-03-03',2,'2020-01-01'),
                           (102,'Thi h???c k???',12,'2022-03-03',3,'2020-01-01'),
                           (103,'Thi h???c k???',13,'2022-03-03',5,'2020-01-01'),
                           (101,'Thi h???c k???',20,'2022-03-03',1,'2020-01-01'),
                           (100,'Thi h???c k???',19,'2022-03-03',1,'2020-01-01'),
                           (103,'Thi h???c k???',16,'2022-03-03',2,'2020-01-01'),
                           (102,'Thi h???c k???',18,'2022-03-03',1,'2020-01-01');
                           
INSERT INTO examquestion(ExamID,QuestionID)
VALUES
                           (1,22),
                           (3,21),
                           (2,27),
                           (4,26),
                           (6,23),
                           (8,24),
                           (5,29),
                           (9,30),
                           (7,25),
                           (10,28);
                            
/*Question 2: l???y ra t???t c??? c??c ph??ng ban*/

SELECT DepartmentName 
FROM department;

/*Question 3: l???y ra id c???a ph??ng ban "Sale"*/

SELECT DepartmentID
FROM department
WHERE DepartmentName=N'Sale';

/*Question 4: l???y ra th??ng tin account c?? full name d??i nh???t*/

SELECT 
*FROM `account`
WHERE LENGTH (FullName)=(SELECT MAX(LENGTH(FullName)) FROM `Account`)
 ORDER BY Fullname DESC;
 
/*Question 5: L???y ra th??ng tin account c?? full name d??i nh???t v?? thu???c ph??ng ban c?? id = 3*/

SELECT 
*FROM `account`
WHERE LENGTH (FullName)=(SELECT MAX(LENGTH(FullName)) FROM `Account`) AND DepartmentID=3
 ORDER BY Fullname DESC;
 
 /*Question 6: L???y ra t??n group ???? tham gia tr?????c ng??y 20/12/2019*/
 
 SELECT * FROM `group`
 WHERE CreateDate <'2019-12-20';
 
/*Question 7: L???y ra ID c???a question c?? >= 4 c??u tr??? l???i*/
SELECT QuestionID, COUNT(QuestionID) AS so_luong
FROM `answer`
GROUP BY questionID
HAVING COUNT (QuestionID) >=4;

/*Question 8: L???y ra c??c m?? ????? thi c?? th???i gian thi >= 60 ph??t v?? ???????c t???o tr?????c ng??y 20/12/2019*/
SELECT `Code` 
FROM Exam
WHERE Duration >= 60 AND CreateDate < '2019-12-20';
/*Question 9: L???y ra 5 group ???????c t???o g???n ????y nh???t*/
SELECT * 
FROM `Group`
ORDER BY CreateDate DESC 
LIMIT 5;
/*Question 10: ?????m s??? nh??n vi??n thu???c department c?? id = 2*/
SELECT departmentID, COUNT(AccountID) AS SL 
FROM `Account`
WHERE DepartmentID = 2;

/*Question 11: L???y ra nh??n vi??n c?? t??n b???t ?????u b???ng ch??? "D" v?? k???t th??c b???ng ch??? "o"*/
SELECT Fullname 
FROM `Account`
WHERE (SUBSTRING_INDEX(FullName, ' ', -1)) LIKE 'D%o' ;
/*Question 12: X??a t???t c??? c??c exam ???????c t???o tr?????c ng??y 20/12/2019*/
DELETE 
FROM Exam WHERE CreateDate < '2019-12-20';
/*Question 13: X??a t???t c??? c??c question c?? n???i dung b???t ?????u b???ng t??? "c??u h???i"*/
DELETE 
FROM `question`
WHERE (SUBSTRING_INDEX(Content,' ',2)) ='c??u h???i';
/*Question 14: Update th??ng tin c???a account c?? id = 5 th??nh t??n "Nguy???n B?? L???c" v?? email th??nh loc.nguyenba@vti.com.vn */

UPDATE 		`Account` 
SET 		Fullname 	= 	N'Nguy???n B?? L???c', 
			Email 		= 	'th??nh loc.nguyenba@vti.com.vn'
WHERE 		AccountID = 5;
/*Question 15: update account c?? id = 5 s??? thu???c group c?? id = 4*/
                           
 UPDATE 		`GroupAccount` 
SET 		AccountID = 5 
WHERE 		GroupID = 4;                         
                           
                           
                           
                      
                      
                           


