--Part – A 

--1.	INSERT Procedures: Create stored procedures to insert records into STUDENT tables (SP_INSERT_STUDENT)

	CREATE OR ALTER PROC PR_INSERT
	@STUDENID INT,
	@STUNAME VARCHAR(100),
	@STUEMAIL VARCHAR(100),
	@STUPHONE VARCHAR(15),
	@STUDEPARTMENT VARCHAR(50),
	@STUDATEOFBIRTH DATE,
	@STUENROLLMENTYEAR INT
	AS
	BEGIN
		INSERT INTO STUDENT (STUDENTID,STUNAME,STUEMAIL,STUPHONE,STUDEPARTMENT,STUDATEOFBIRTH,STUENROLLMENTYEAR) VALUES(@STUDENID,@STUNAME,@STUEMAIL,@STUPHONE,@STUDEPARTMENT,@STUDATEOFBIRTH,@STUENROLLMENTYEAR)
	END

	EXEC PR_INSERT 10,'Harsh Parmar','harsh@univ.edu','9876543218','CSE','2005-09-18',2023
	EXEC PR_INSERT 20,'Om Patel','om@univ.edu','9876543211','IT','2002-08-22',2022

	SELECT * FROM STUDENT

--2.	INSERT Procedures: Create stored procedures to insert records into COURSE tables 
--(SP_INSERT_COURSE)

	CREATE OR ALTER PROC PR_INSERT_COURSE
	@CourseID VARCHAR(10),
	@CourseName VARCHAR(100),
	@CourseCredits INT,
	@CourseDepartment VARCHAR(50),
	@CourseSemester INT
	AS
	BEGIN
		INSERT INTO COURSE(CourseID,CourseName,CourseCredits,CourseDepartment,CourseSemester) VALUES(@CourseID,@CourseName,@CourseCredits,@CourseDepartment,@CourseSemester)
	END

	EXEC PR_INSERT_COURSE CS330,'Computer Networks',4,'CSE',5
	EXEC PR_INSERT_COURSE EC120,'Electronic Circuits',3,'ECE',2

	SELECT * FROM COURSE

--3.	UPDATE Procedures: Create stored procedure SP_UPDATE_STUDENT to update Email and Phone in STUDENT table. (Update using studentID)

	CREATE OR ALTER PROC PR_UPDATE
	@STUDENTID INT,
	@STUDENTEMAIL VARCHAR(100),
	@STUDENTPHONE VARCHAR(15)
	AS 
	BEGIN
		UPDATE STUDENT
		SET StuEmail = @STUDENTEMAIL,STUPHONE = @STUDENTPHONE 
		WHERE StudentID = @STUDENTID
	END

--4.	DELETE Procedures: Create stored procedure SP_DELETE_STUDENT to delete records from STUDENT where Student Name is Om Patel.

	CREATE OR ALTER PROC PR_DELETE
	AS 
	BEGIN
		DELETE 
		FROM STUDENT
		WHERE StuName = 'Om Patel'
	END

--5.	SELECT BY PRIMARY KEY: Create stored procedures to select records by primary key (SP_SELECT_STUDENT_BY_ID) from Student table.

	CREATE OR ALTER PROC PR_SELECT_STUDENT_BY_ID
	@STUID INT
	AS 
	BEGIN
		SELECT * 
		FROM STUDENT
		WHERE StudentID = @STUID
	END

	EXEC PR_SELECT_STUDENT_BY_ID 1

--6.	Create a stored procedure that shows details of the first 5 students ordered by EnrollmentYear.

	Create or Alter Proc PR_First_5_Student
	As
	Begin
		Select top 5 *
		from STUDENT
		order by StuEnrollmentYear
	End

	Exec PR_First_5_Student

--Part – B  

	

--7.	Create a stored procedure which displays faculty designation-wise count.
	
	Create or Alter Proc PR_Faculty_Count_Each_Designation
	As
	Begin
		Select 
			FacultyDesignation,
			count(FacultyID) as total_Faculty
		from FACULTY
		group by FacultyDesignation
	End
	
	Exec PR_Faculty_Count_Each_Designation

--8.	Create a stored procedure that takes department name as input and returns all students in that department.

	Create or Alter
	Proc PR_Student_Name_Of_Given_Department
	@StuDepartment varchar(50)

	As
	Begin
		Select *
		From STUDENT
		Where StuDepartment = @StuDepartment
	End

	Exec PR_Student_Name_Of_Given_Department 'CSE'



--Part – C 



--9.	Create a stored procedure which displays department-wise maximum, minimum, and average credits of courses.

	Create or Alter
	Proc PR_Department_Wise_Course_Credit
	As
	Begin
		Select
			CourseDepartment,
			max(CourseCredits) as Max,
			min(CourseCredits) as min,
			Avg(CourseCredits) as Avg
		From COURSE
		Group by CourseDepartment
	End

	Exec PR_Department_Wise_Course_Credit

--10.	Create a stored procedure that accepts StudentID as parameter and returns all courses the student is enrolled in with their grades.
	
	Create or Alter
	Proc PR_Student_Enrolled_Course
	@StudentID int
	As
	Begin
		Select
			S.StudentID,
			StuName,
			CourseName,
			Grade
		From ENROLLMENT E join STUDENT S
		on E.StudentID = S.StudentID

		join COURSE C
		on E.CourseID = C.CourseID
		Where S.StudentID = @StudentID
	End

	Exec PR_Student_Enrolled_Course 1

