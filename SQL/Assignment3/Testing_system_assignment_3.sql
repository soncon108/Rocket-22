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
                            (N'Bảo vệ'      ),
                            (N'Nhân sự'     ),
                            (N'Kỹ thuật'    ),
                            (N'Tài chính'   ),
                            (N'Phó giám đốc'),
                            (N'Giám đốc'    ),
                            (N'Thư ký'      ),
                            (N'Bán hàng'    );
		
INSERT INTO position        (PositionName)
VALUES 
                            ('Dev'         ),
                            ('Test'        ),
                            ('Scrum Master'),
                            ('PM'          );
                            
INSERT INTO `account` (Email,Username,Fullname,DepartmentID,PositionID,CreateDate)
VALUES 
					       ('thanhson@108gmail.com','soncon','Nguyễn Thanh Sơn',1,1,'2012-12-10'    ),
                           ('manhanh@gmail.com','manhanh','Trần Thế Mạnh',4,1,'2015-03-02'          ),
                           ('hunhtep@gmail.com','hungtep','Nguyễn Mạnh Hùng',6,3,'2018-02-01'       ),
						   ('quangco@gmail.com','quangco','Nguyễn Duy Quang',1,3,'2020-02-03'       ),
                           ('truongchum@gmail.com','truongchum','Nghiêm Văn Trường',5,2,'2018-02-05'),
                           ('dungbay@gmail.com','dungbay','Nghiêm Văn Dũng',2,4,'2019-11-10'        ),
                           ('huyxuan@gmail.com','huyxuan','Ngô Xuân Huy',5,1,'2017-12-12'           ),
                           ('dadao@gmail.com','dadao','Nguyễn Thị Da Dao',2,3,'2020-02-20'          ),
                           ('hahung@gmail.com','hahung','Nguyễn Thị Hà',1,2,'2016-02-09'            ),
                           ('haihoan@gmail.com','haihung','Đoàn Văn Hải',4,2,'2020-12-11'           );
                           
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
						   ('Bạn học ngành gì?',11,1,1,'2020-01-01'      ),
                           ('Bạn học môn gì?',12,2,2,'2020-01-01'        ),
                           ('Bạn học ở đâu?',13,3,3,'2020-01-01'         ),
                           ('Bạn học lại môn gì?',14,4,5,'2020-01-01'    ),
                           ('Bạn học xong chưa?',15,1,5,'2020-01-01'     ),
                           ('Bạn học học lại môn gì?',16,5,1,'2020-01-01'),
                           ('Bạn học môn gì?',17,7,2,'2020-01-01'        ),
                           ('Bạn học ngành gì?',18,8,3,'2020-01-01'      ),
                           ('Bạn học xong chưa?',19,9,5,'2020-01-01'     ),
                           ('Bạn học ngành gì?',20,10,4,'2020-01-01'     );
                           
INSERT INTO answer (Content,QuestionID,IsCorrext)
VALUES 
                           ('Tôi học CNTT',21,'True' ),
                           ('Tôi học CNTT',24,'False'),
                           ('Tôi học CNTT',25,'False'),
                           ('Tôi chưa xong',29,'True'),
                           ('Tôi học ở HN',23,'True' ),
                           ('Tôi học CNTT',22,'False'),
                           ('Tôi học CNTT',26,'True' ),
                           ('Tôi học CNTT',28,'True' ),
                           ('Tôi học CNTT',30,'True'),
                           ('Tôi học IT',27,'False'  );
                           
INSERT INTO exam (`Code`,Title,CategoryID,Duration,CreatorID,CreateDate)
VALUES 
						   (100,'Thi học kỳ',11,'2022-03-03',1,'2020-01-01'),
                           (101,'Thi học kỳ',15,'2022-03-03',5,'2020-01-01'),
                           (102,'Thi học kỳ',14,'2022-03-03',4,'2020-01-01'),
                           (103,'Thi học kỳ',17,'2022-03-03',2,'2020-01-01'),
                           (102,'Thi học kỳ',12,'2022-03-03',3,'2020-01-01'),
                           (103,'Thi học kỳ',13,'2022-03-03',5,'2020-01-01'),
                           (101,'Thi học kỳ',20,'2022-03-03',1,'2020-01-01'),
                           (100,'Thi học kỳ',19,'2022-03-03',1,'2020-01-01'),
                           (103,'Thi học kỳ',16,'2022-03-03',2,'2020-01-01'),
                           (102,'Thi học kỳ',18,'2022-03-03',1,'2020-01-01');
                           
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
                            
/*Question 2: lấy ra tất cả các phòng ban*/

SELECT DepartmentName 
FROM department;

/*Question 3: lấy ra id của phòng ban "Sale"*/

SELECT DepartmentID
FROM department
WHERE DepartmentName=N'Sale';

/*Question 4: lấy ra thông tin account có full name dài nhất*/

SELECT 
*FROM `account`
WHERE LENGTH (FullName)=(SELECT MAX(LENGTH(FullName)) FROM `Account`)
 ORDER BY Fullname DESC;
 
/*Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3*/

SELECT 
*FROM `account`
WHERE LENGTH (FullName)=(SELECT MAX(LENGTH(FullName)) FROM `Account`) AND DepartmentID=3
 ORDER BY Fullname DESC;
 
 /*Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019*/
 
 SELECT * FROM `group`
 WHERE CreateDate <'2019-12-20';
 
/*Question 7: Lấy ra ID của question có >= 4 câu trả lời*/
SELECT QuestionID, COUNT(QuestionID) AS so_luong
FROM `answer`
GROUP BY questionID
HAVING COUNT (QuestionID) >=4;

/*Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019*/
SELECT `Code` 
FROM Exam
WHERE Duration >= 60 AND CreateDate < '2019-12-20';
/*Question 9: Lấy ra 5 group được tạo gần đây nhất*/
SELECT * 
FROM `Group`
ORDER BY CreateDate DESC 
LIMIT 5;
/*Question 10: Đếm số nhân viên thuộc department có id = 2*/
SELECT departmentID, COUNT(AccountID) AS SL 
FROM `Account`
WHERE DepartmentID = 2;

/*Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"*/
SELECT Fullname 
FROM `Account`
WHERE (SUBSTRING_INDEX(FullName, ' ', -1)) LIKE 'D%o' ;
/*Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019*/
DELETE 
FROM Exam WHERE CreateDate < '2019-12-20';
/*Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"*/
DELETE 
FROM `question`
WHERE (SUBSTRING_INDEX(Content,' ',2)) ='câu hỏi';
/*Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn */

UPDATE 		`Account` 
SET 		Fullname 	= 	N'Nguyễn Bá Lộc', 
			Email 		= 	'thành loc.nguyenba@vti.com.vn'
WHERE 		AccountID = 5;
/*Question 15: update account có id = 5 sẽ thuộc group có id = 4*/
                           
 UPDATE 		`GroupAccount` 
SET 		AccountID = 5 
WHERE 		GroupID = 4;                         
                           
                           
                           
                      
                      
                           


