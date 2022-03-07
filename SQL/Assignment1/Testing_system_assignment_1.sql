create database testing_system_assignment_1;

use testing_system_assignment_1;

/* cau1 */
 create table department(
 departmentID int not null auto_increment,
 departmentName varchar(100),
 primary key (departmentID)
 );
 /* cau2 */
 create table `position`(
 positionID int not null auto_increment,
 positionName enum('Dev','Test','Scrum Master','PM'),
 primary key (positionID)
 );
/* cau3 */
create table `account`(
accountID int not null auto_increment,
email char (100),
username varchar (100),
fullname varchar(150),
departmentID int,
positionID int,
createDate date,
primary key (accountID),
foreign key (departmentID) references department (departmentID),
foreign key (positionID) references position (positionID)
);
/*cau4*/
create table `group` (
groupID int not null auto_increment,
groupName varchar (100),
creatorID int,
createDate date,
primary key (groupID)
);
/* cau5 */
create table `groupaccount`(
groupID int,
accountID int,
joinDate date,
foreign key ( groupID ) references `group`(groupID),
foreign key ( accountID ) references `account`(accountID)
);
/*cau6*/
create table `typequestion`(
typeID int not null auto_increment,
typeName enum('essay','multiple-choice'),
primary key (typeID)
);
/*cau7*/
create table `categoryquestion`(
categoryID int not null auto_increment,
categoryName enum('jave','net','sql','postman','ruby'),
primary key (categoryID)
);
/*cau8*/
create table `question`(
questionID int not null auto_increment,
content text,
categoryID int,
typeID int,
creatorID int,
createDate date,
primary key (questionID),
foreign key (categoryID) references categoryquestion(categoryID),
foreign key (typeID) references typequestion(typeID)
);
/*cau9*/
create table `answer`(
answerID int not null auto_increment,
content text,
questionID int,
isCorrext bool,
primary key (answerID),
foreign key (questionID) references question(questionID)
);
/* cau10*/
create table `exam` (
examID int not null auto_increment,
`code` char(15),
title varchar(100),
categoryID int,
duration datetime,
creatorID int,
createDate date,
primary key(examID),
foreign key ( categoryID ) references categoryquestion (categoryID)
);
/*cau11*/
create table `examquestion`(
examID int,
questionID int,
foreign key ( examID ) references exam(examID),
foreign key ( questionID ) references question(questionID)
);



