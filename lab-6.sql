--Trigger (After trigger)


--Table : Log(LogMessage varchar(100), logDate Datetime)

CREATE TABLE LOG(
	LogMessage varchar(100), 
	logDate Datetime
)

--Part – A


--1. Create trigger for printing appropriate message after student registration.

	CREATE OR ALTER TRIGGER TR_AFTER_STUDENT_REGISTRATION
	ON STUDENT
	AFTER INSERT
	AS
	BEGIN
		PRINT 'STUDENT REGISTERED'
	END

	INSERT INTO STUDENT VALUES (12,'PRINCE PATEL','PRINCE@GMAIL.COM','1234567899','CSE','2006-09-22',2024,NULL)

	DROP TRIGGER TR_AFTER_STUDENT_REGISTRATION

--2. Create trigger for printing appropriate message after faculty deletion.

	CREATE OR ALTER TRIGGER TR_AFTER_FACULTY_DELETION
	ON FACULTY
	AFTER DELETE
	AS
	BEGIN
		PRINT 'FACULTY DELETED'
	END

	DELETE 
	FROM FACULTY
	WHERE FacultyID = 111

	INSERT INTO FACULTY VALUES (111,'PROF. PATEL','ABC@GMAIL.COM','CSE','Professor','2001-09-09')

	DROP TRIGGER TR_AFTER_FACULTY_DELETION

--3. Create trigger for monitoring all events on course table. (print only appropriate message)

	CREATE OR ALTER TRIGGER TR_AFTER_COURSE_MONITORING
	ON COURSE
	AFTER INSERT,UPDATE,DELETE
	AS
	BEGIN
		PRINT 'ALL EVENTS MONITORING IN COURSE TABLE'
	END

	UPDATE COURSE
	SET CourseDepartment = 'MNC'
	WHERE CourseID = 'IT201'

	DROP TRIGGER TR_AFTER_COURSE_MONITORING

--4. Create trigger for logging data on new student registration in Log table.

	CREATE OR ALTER TRIGGER TR_AFTER_STUDENT_REGISTRATION_IN_LOG
	ON STUDENT
	AFTER INSERT
	AS
	BEGIN
		INSERT INTO LOG VALUES(
			'NEW STUDENT REGISTERED',
			GETDATE()
		)
	END

	INSERT INTO STUDENT VALUES(13,'Arjun Verma','arjun@univ.edu',9876543216,'MECH','2003-04-08',2021,NULL)
	
	SELECT * FROM LOG

	DROP TRIGGER TR_AFTER_STUDENT_REGISTRATION_IN_LOG 

--5. Create trigger for auto-uppercasing faculty names.

	CREATE OR ALTER TRIGGER TR_AFTER_FACULTY_UPPERCASE
	ON FACULTY
	AFTER INSERT,UPDATE
	AS
	BEGIN
		UPDATE FACULTY
		SET FacultyName = UPPER(FacultyName)
		WHERE FacultyID IN (SELECT FacultyID FROM inserted)
	END

	INSERT INTO FACULTY VALUES(108,'Prof. Nair','nair@univ.edu','CSE','Assistant Prof','2019-07-20')

	DROP TRIGGER TR_AFTER_FACULTY_UPPERCASE

--6. Create trigger for calculating faculty experience (Note: Add required column in faculty table)

	ALTER TABLE FACULTY
	ADD EXPERIENCE INT

	CREATE OR ALTER TRIGGER TR_AFTER_FACULTY_EXPERIENCE
	ON FACULTY
	AFTER INSERT,UPDATE
	AS
	BEGIN
		DECLARE @FID INT,@JDATE DATE

		SELECT 
			@FID = FACULTYID,
			@JDATE = FACULTYJOININGDATE
		FROM INSERTED

		UPDATE FACULTY
		SET EXPERIENCE = DATEDIFF(YEAR,@JDATE,GETDATE())
		WHERE FacultyID = @FID
	END
	
	SELECT * FROM FACULTY

	DROP TRIGGER TR_AFTER_FACULTY_EXPERIENCE

--Part – B


--7. Create trigger for auto-stamping enrollment dates.

	
--8. Create trigger for logging data After course assignment - log course and faculty detail.

	


--Part - C


--9. Create trigger for updating student phone and print the old and new phone number.

	
--10. Create trigger for updating course credit log old and new credits in log table

	