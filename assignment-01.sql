DROP DATABASE IF EXISTS asssignment_01;
CREATE DATABASE asssignment_01;
use asssignment_01;
CREATE TABLE Department(
	DepartmentID INT PRIMARY KEY auto_increment,
    DepartmentName VARCHAR(50)
);
CREATE TABLE `Position`(
	PositionID INT PRIMARY KEY auto_increment,
    PositionName VARCHAR(50)
);
CREATE TABLE Account(
	AccountID INT PRIMARY KEY auto_increment,
    Email VARCHAR(50) UNIQUE,
    Username VARCHAR(50),
    FullName VARCHAR(50),
    DepartmentID INT, foreign key (DepartmentID) references Department(DepartmentID),
    PositionID INT, foreign key (PositionID) references `Position`(PositionID),
    CreateDate DATE
);
CREATE TABLE `Group`(
	GroupID INT PRIMARY KEY auto_increment,
    GroupName VARCHAR(50),
    CreatorID INT, foreign key (CreatorID) references Account(AccountID),
    CreateDate DATE
);
CREATE TABLE GroupAccount(
	GroupID INT, foreign key (GroupID) references `Group`(GroupID),
    AccountID INT, foreign key (AccountID) references Account(AccountID),
    PRIMARY KEY (GroupID, AccountID),
    JoinDate DATE
);
CREATE TABLE TypeQuestion(
	TypeID INT PRIMARY KEY auto_increment,
    TypeName VARCHAR(50)
);
CREATE TABLE CategoryQuestion(
	CategoryID INT PRIMARY KEY auto_increment,
    CategoryName VARCHAR(50)
);
CREATE TABLE Question(
	QuestionID INT PRIMARY KEY auto_increment,
    Content VARCHAR(500),
    CategoryID INT, foreign key (CategoryID) references CategoryQuestion(CategoryID),
    TypeID INT, foreign key (TypeID) references TypeQuestion(TypeID),
    CreatorID INT, foreign key (CreatorID) references Account(AccountID),
    CreateDate DATE
);
CREATE TABLE Answer(
	AnswerID INT PRIMARY KEY auto_increment,
    Content VARCHAR(500),
    QuestionID INT, foreign key (QuestionID) references Question(QuestionID),
    isCorrect BIT
);
CREATE TABLE Exam(
	ExamID INT PRIMARY KEY auto_increment,
    CodeExam VARCHAR(10),
    Title VARCHAR(50),
    CategoryID INT, foreign key (CategoryID) references CategoryQuestion(CategoryID),
    Duration TIME,
    CreatorID INT, foreign key (CreatorID) references Account(AccountID),
    CreateDate DATE
);
CREATE TABLE ExamQuestion(
	ExamID INT, foreign key (ExamID) references Exam(ExamID),
    QuestionID INT, foreign key (QuestionID) references Question(QuestionID),
    PRIMARY KEY(ExamID, QuestionID)
);
-- Inserting into Department table
INSERT INTO Department (DepartmentName) VALUES 
('Marketing'),
('Human Resources'),
('Finance'),
('IT'),
('Operations');

-- Inserting into Position_ table
INSERT INTO `Position` (PositionName) VALUES 
('Manager'),
('Assistant Manager'),
('Team Lead'),
('Developer'),
('Analyst');

-- Inserting into Account table
INSERT INTO Account (Email, Username, FullName, DepartmentID, PositionID, CreateDate) VALUES 
('john.doe@example.com', 'johndoe', 'John Doe', 1, 1, '2024-05-10'),
('jane.smith@example.com', 'janesmith', 'Jane Smith', 2, 2, '2024-05-10'),
('alex.jones@example.com', 'alexjones', 'Alex Jones', 3, 3, '2024-05-10'),
('emily.white@example.com', 'emilywhite', 'Emily White', 4, 4, '2024-05-10'),
('michael.brown@example.com', 'michaelbrown', 'Michael Brown', 5, 5, '2024-05-10');

-- Inserting into Group_ table
INSERT INTO `Group` (GroupName, CreatorID, CreateDate) VALUES 
('Marketing Team', 1, '2024-05-10'),
('HR Committee', 2, '2024-05-10'),
('Finance Group', 3, '2024-05-10'),
('IT Department', 4, '2024-05-10'),
('Operations Team', 5, '2024-05-10');

-- Inserting into GroupAccount table
INSERT INTO GroupAccount (GroupID, AccountID, JoinDate) VALUES 
(1, 1, '2024-05-10'),
(2, 2, '2024-05-10'),
(3, 3, '2024-05-10'),
(4, 4, '2024-05-10'),
(5, 5, '2024-05-10');

-- Inserting into TypeQuestion table
INSERT INTO TypeQuestion (TypeName) VALUES 
('Multiple Choice'),
('True/False'),
('Short Answer'),
('Essay'),
('Matching');

-- Inserting into CategoryQuestion table
INSERT INTO CategoryQuestion (CategoryName) VALUES 
('History'),
('Science'),
('Mathematics'),
('Literature'),
('Computer Science');

-- Inserting into Question table
INSERT INTO Question (Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES 
('Who was the first president of the United States?', 1, 1, 1, '2024-05-10'),
('Water is composed of which two elements?', 2, 2, 2, '2024-05-10'),
('What is the value of pi (π)?', 3, 3, 3, '2024-05-10'),
('Who wrote the novel "Pride and Prejudice"?', 4, 4, 4, '2024-05-10'),
('What is an example of a high-level programming language?', 5, 5, 5, '2024-05-10');

-- Inserting into Answer table
INSERT INTO Answer (Content, QuestionID, isCorrect) VALUES 
('George Washington', 1, 1),
('Oxygen and Hydrogen', 2, 1),
('3.14159', 3, 1),
('Jane Austen', 4, 1),
('Python', 5, 1);

-- Inserting into Exam table
INSERT INTO Exam (CodeExam, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES 
('EXM001', 'History Quiz', 1, '01:00:00', 1, '2024-05-10'),
('EXM002', 'Science Test', 2, '00:45:00', 2, '2024-05-10'),
('EXM003', 'Mathematics Exam', 3, '01:30:00', 3, '2024-05-10'),
('EXM004', 'Literature Assessment', 4, '01:15:00', 4, '2024-05-10'),
('EXM005', 'Computer Science Quiz', 5, '01:00:00', 5, '2024-05-10');

-- Inserting into ExamQuestion table
INSERT INTO ExamQuestion (ExamID, QuestionID) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Inserting into Department table
INSERT INTO Department (DepartmentName) VALUES 
('Sales'),
('Customer Service'),
('Research and Development'),
('Legal'),
('Supply Chain');

-- Inserting into Position_ table
INSERT INTO `Position` (PositionName) VALUES 
('Sales Representative'),
('Customer Service Representative'),
('Research Analyst'),
('Legal Counsel'),
('Supply Chain Manager');

-- Inserting into Account table
INSERT INTO Account (Email, Username, FullName, DepartmentID, PositionID, CreateDate) VALUES 
('lisa.johnson@example.com', 'lisajohnson', 'Lisa Johnson', 1, 1, '2024-05-10'),
('peter.wilson@example.com', 'peterwilson', 'Peter Wilson', 2, 2, '2024-05-10'),
('sarah.miller@example.com', 'sarahmiller', 'Sarah Miller', 3, 3, '2024-05-10'),
('david.anderson@example.com', 'davidanderson', 'David Anderson', 4, 4, '2024-05-10'),
('jennifer.clark@example.com', 'jenniferclark', 'Jennifer Clark', 5, 5, '2024-05-10');

-- Inserting into Group_ table
INSERT INTO `Group` (GroupName, CreatorID, CreateDate) VALUES 
('Sales Team', 6, '2024-05-10'),
('Customer Support', 7, '2024-05-10'),
('Research Department', 8, '2024-05-10'),
('Legal Team', 9, '2024-05-10'),
('Supply Chain Group', 10, '2024-05-10');

-- Inserting into GroupAccount table
INSERT INTO GroupAccount (GroupID, AccountID, JoinDate) VALUES 
(6, 6, '2024-05-10'),
(7, 7, '2024-05-10'),
(8, 8, '2024-05-10'),
(9, 9, '2024-05-10'),
(10, 10, '2024-05-10');

-- Inserting into TypeQuestion table
INSERT INTO TypeQuestion (TypeName) VALUES 
('Fill in the Blank'),
('Multiple Response'),
('Coding'),
('Diagrammatic'),
('Behavioral');

-- Inserting into CategoryQuestion table
INSERT INTO CategoryQuestion (CategoryName) VALUES 
('Art'),
('Geography'),
('Politics'),
('Economics'),
('Languages');

-- Inserting into Question table
INSERT INTO Question (Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES 
('Who painted the Mona Lisa?', 6, 6, 6, '2024-05-10'),
('What is the capital of France?', 7, 7, 7, '2024-05-10'),
('Who is the current president of the United States?', 8, 8, 8, '2024-05-10'),
('What is the law of supply and demand?', 9, 9, 9, '2024-05-10'),
('How many official languages does the United Nations have?', 10, 10, 10, '2024-05-10');

-- Inserting into Answer table
INSERT INTO Answer (Content, QuestionID, isCorrect) VALUES 
('Leonardo da Vinci', 6, 1),
('Paris', 7, 1),
('Joe Biden', 8, 1),
('It describes the relationship between the availability of a good or service and its demand.', 9, 1),
('6', 10, 1);

-- Inserting into Exam table
INSERT INTO Exam (CodeExam, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES 
('EXM006', 'Art Quiz', 6, '00:45:00', 6, '2024-05-10'),
('EXM007', 'Geography Test', 7, '01:00:00', 7, '2024-05-10'),
('EXM008', 'Politics Exam', 8, '01:30:00', 8, '2024-05-10'),
('EXM009', 'Economics Assessment', 9, '01:15:00', 9, '2024-05-10'),
('EXM010', 'Languages Quiz', 10, '01:00:00', 10, '2024-05-10');

-- Inserting into ExamQuestion table
INSERT INTO ExamQuestion (ExamID, QuestionID) VALUES 
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);