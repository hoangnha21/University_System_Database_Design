create database Unibase;

USE Unibase;

Create Table Lectureroom
(
	building VARCHAR(50),
	room_number VARCHAR(10),
	capacity NUMERIC(4,0),
	PRIMARY KEY (building, room_number)
);

CREATE TABLE Department
(
  dept_name VARCHAR(50),
  building VARCHAR(50),
  budget NUMERIC(12,2) CHECK (budget > 0),
  PRIMARY KEY (dept_name)
);

Create Table Student
(
	ID VARCHAR(6),
	year_enrolled NUMERIC(4,0) CHECK (year_enrolled > 1701 and year_enrolled < 2100),
	Name VARCHAR(60),
	Degree VARCHAR(20),
	dept_name VARCHAR(50),
	total_cred NUMERIC(3,0) CHECK (total_cred >= 0),
	PRIMARY KEY (ID),
	FOREIGN KEY (dept_name) REFERENCES Department(dept_name) ON DELETE SET NULL
);


Create Table Professor
(
  ID VARCHAR(5),
  name VARCHAR(50) NOT NULL,
  dept_name VARCHAR(50),
  salary NUMERIC (10,2) CHECK (salary >= 0),
  office VARCHAR(50)
  PRIMARY KEY (ID),
  FOREIGN KEY (dept_name) REFERENCES Department(dept_name) ON DELETE SET NULL
);

CREATE TABLE Course
(
  course_id VARCHAR(10),
  title VARCHAR(100),
  dept_name VARCHAR(50),
  credits NUMERIC (2,0) CHECK (credits > 0),
  PRIMARY KEY (course_id),
  FOREIGN KEY (dept_name) REFERENCES Department(dept_name) ON DELETE SET NULL
);

CREATE TABLE Time_Slot
(
  time_slot_id VARCHAR(4),
  day VARCHAR(1) CHECK (day in ('M', 'T', 'W', 'R', 'F', 'S', 'U')),
  start_time TIME,
  end_time TIME,
  PRIMARY KEY (time_slot_id, day, start_time)
);

CREATE TABLE Section
(
  course_id VARCHAR(10),
  sec_id VARCHAR(10),
  semester VARCHAR(6) CHECK (semester in ('Fall', 'Winter', 'Spring', 'Summer')),
  year NUMERIC (4,0) CHECK (year > 1701 and year < 2100),
  building VARCHAR(50),
  room_number VARCHAR(10),
  sec_t_ID VARCHAR(10),
  PRIMARY KEY (course_id, sec_id, semester, year),
  FOREIGN KEY (building, room_number) REFERENCES Lectureroom(building, room_number) ON DELETE SET NULL,
  FOREIGN KEY (course_id) REFERENCES Course(course_id) ON DELETE CASCADE,
);


CREATE TABLE Teaches
(
  ID VARCHAR(5),
  course_id VARCHAR(10),
  sec_id VARCHAR(10),
  semester VARCHAR(6),
  year NUMERIC (4,0),
  PRIMARY KEY (ID, course_id, sec_id, semester, year),
  FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES Section(course_id, sec_id, semester, year) ON DELETE CASCADE,
  FOREIGN KEY (ID) REFERENCES Professor(ID) ON DELETE CASCADE,
);

CREATE TABLE Takes
(
  ID VARCHAR(6),
  course_id VARCHAR(10),
  sec_id VARCHAR(10),
  semester VARCHAR(6),
  year NUMERIC (4,0),
  grade VARCHAR(2),
  PRIMARY KEY (ID, course_id, sec_id, semester, year),
  FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES Section(course_id, sec_id, semester, year) ON DELETE CASCADE,
  FOREIGN KEY (ID) REFERENCES Student(ID) ON DELETE CASCADE
);

CREATE TABLE Advisor
(
  s_ID VARCHAR(6),
  i_ID VARCHAR(5),
  PRIMARY KEY (s_ID),
  FOREIGN KEY (s_ID) REFERENCES Student(ID) ON DELETE CASCADE,
  FOREIGN KEY (i_ID) REFERENCES Professor(ID) ON DELETE SET NULL
);

CREATE TABLE Prereq
(
  course_id VARCHAR(10),
  prereq_id VARCHAR(10),
  PRIMARY KEY (course_id, prereq_id),
  FOREIGN KEY (course_id) REFERENCES Course(course_id) ON DELETE CASCADE,
  FOREIGN KEY (prereq_id) REFERENCES Course(course_id)
);