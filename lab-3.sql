--Advanced Stored Procedure


--Part – A 


--1.	Create a stored procedure that accepts a date and returns all faculty members who joined on that date.

	CREATE OR ALTER PROC PR_DIS_FACULTY
	@DATE DATE
	AS
	BEGIN
		SELECT FacultyName
		FROM FACULTY
		WHERE FacultyJoiningDate = @DATE
	END

	EXEC PR_DIS_FACULTY '2010-07-15'

--2.	Create a stored procedure for ENROLLMENT table where user enters either StudentID and returns EnrollmentID, EnrollmentDate, Grade, and Status.

	CREATE OR ALTER PROC PR_STU_INFO
	@STUID INT
	AS
	BEGIN
		SELECT EnrollmentID,EnrollmentDate,EnrollmentStatus,Grade
		FROM ENROLLMENT
		WHERE StudentID = @STUID
	END

	EXEC PR_STU_INFO 1

--3.	Create a stored procedure that accepts two integers (min and max credits) and returns all courses whose credits fall between these values.

	CREATE OR ALTER PROC PR_CREDIT
	@MIN INT,
	@MAX INT
	AS
	BEGIN
		SELECT CourseName
		FROM COURSE
		WHERE CourseCredits BETWEEN @MIN AND @MAX
	END

	EXEC PR_CREDIT 2,4

--4.	Create a stored procedure that accepts Course Name and returns the list of students enrolled in that course.

	CREATE OR ALTER PROC PR_COURSE_ENROLL
	@CNAME VARCHAR(50)
	AS
	BEGIN
		SELECT STUDENT.StuName
		FROM STUDENT JOIN ENROLLMENT
		ON STUDENT.StudentID = ENROLLMENT.StudentID
		JOIN COURSE
		ON ENROLLMENT.CourseID = COURSE.CourseID
		WHERE COURSE.CourseName = @CNAME
	END

	EXEC PR_COURSE_ENROLL 'Programming Fundamentals'

--5.	Create a stored procedure that accepts Faculty Name and returns all course assignments.

	CREATE OR ALTER PROC PR_FAC_COURSE
	@FACNAME VARCHAR(50)
	AS
	BEGIN
		SELECT *
		FROM FACULTY JOIN COURSE_ASSIGNMENT
		ON FACULTY.FacultyID = COURSE_ASSIGNMENT.FacultyID
		WHERE FACULTY.FacultyName = @FACNAME
	END

	EXEC PR_FAC_COURSE 'Dr. Sheth'

--6.	Create a stored procedure that accepts Semester number and Year, and returns all course assignments with faculty and classroom details.

	CREATE OR ALTER PROC PR_FAC_CLASS_COURSE
	@SEM INT,
	@YEAR INT
	AS
	BEGIN
		SELECT FACULTY.FacultyName,COURSE_ASSIGNMENT.ClassRoom
		FROM FACULTY JOIN COURSE_ASSIGNMENT
		ON FACULTY.FacultyID = COURSE_ASSIGNMENT.FacultyID
		WHERE COURSE_ASSIGNMENT.Semester = @SEM AND COURSE_ASSIGNMENT.Year = @YEAR
	END

	EXEC PR_FAC_CLASS_COURSE 5,2024

--Part – B



--7.	Create a stored procedure that accepts the first letter of Status ('A', 'C', 'D') and returns enrollment details.

	CREATE OR ALTER PROC PR_STATUS_ENROLL_DETAILS
	@STATUS VARCHAR(10)
	AS
	BEGIN
		SELECT STUDENT.StuName,COURSE.CourseName,ENROLLMENT.Grade,ENROLLMENT.EnrollmentStatus
		FROM ENROLLMENT JOIN STUDENT
		ON ENROLLMENT.StudentID = STUDENT.StudentID
		JOIN COURSE
		ON COURSE.CourseID = ENROLLMENT.CourseID
		WHERE ENROLLMENT.EnrollmentStatus LIKE @STATUS + '%' 
	END

	EXEC PR_STATUS_ENROLL_DETAILS 'A'

--8.	Create a stored procedure that accepts either Student Name OR Department Name and returns student data accordingly.

	CREATE OR ALTER PROC PR_STU_DATA
	@STUNAME VARCHAR(50) = NULL,
	@DEPT VARCHAR(50) = NULL
	AS
	BEGIN
		SELECT *
		FROM STUDENT
		WHERE StuName = @STUNAME OR StuDepartment = @DEPT 
	END
	
	EXEC PR_STU_DATA @DEPT = 'CSE'
--9.	Create a stored procedure that accepts CourseID and returns all students enrolled grouped by enrollment status with counts.

	CREATE OR ALTER PROC PR_COUNT_STATUS
	@COURSEID VARCHAR(10)
	AS
	BEGIN
		SELECT EnrollmentStatus, COUNT(CourseID)
		FROM ENROLLMENT
		WHERE CourseID = @COURSEID
		GROUP BY EnrollmentStatus
	END

	EXEC PR_COUNT_STATUS 'CS101'
--Part – C



--10.	Create a stored procedure that accepts a year as input and returns all courses assigned to faculty in that year with classroom details.

	CREATE OR ALTER PROC PR_YEAR_ALL_COURSE
	@YEAR INT
	AS
	BEGIN
		SELECT COURSE.CourseName,COURSE_ASSIGNMENT.ClassRoom FROM COURSE JOIN COURSE_ASSIGNMENT
		ON COURSE.CourseID = COURSE_ASSIGNMENT.CourseID
		WHERE COURSE_ASSIGNMENT.Year = @YEAR
	END

	EXEC PR_YEAR_ALL_COURSE 2024

--11.	Create a stored procedure that accepts From Date and To Date and returns all enrollments within that range with student and course details.

	CREATE OR ALTER PROC PR_ENROLL_DATE
	@FROM_DATE DATE,
	@END_DATE DATE
	AS
	BEGIN
		SELECT STUDENT.StudentID,COURSE.CourseName,ENROLLMENT.EnrollmentDate,ENROLLMENT.Grade,ENROLLMENT.EnrollmentStatus FROM STUDENT JOIN ENROLLMENT
		ON STUDENT.StudentID = ENROLLMENT.StudentID
		JOIN COURSE
		ON ENROLLMENT.CourseID = COURSE.CourseID
		WHERE ENROLLMENT.EnrollmentDate BETWEEN @FROM_DATE AND @END_DATE
	END

	EXEC PR_ENROLL_DATE '2021-07-01','2022-01-05'

--12.	Create a stored procedure that accepts FacultyID and calculates their total teaching load (sum of credits of all courses assigned).

	CREATE OR ALTER PROC PR_COUNT_LOAD
	@FACID INT
	AS
	BEGIN
		SELECT SUM(CourseCredits) AS LOAD FROM COURSE_ASSIGNMENT JOIN COURSE
		ON COURSE.CourseID = COURSE_ASSIGNMENT.CourseID
		JOIN FACULTY
		ON COURSE_ASSIGNMENT.FacultyID = FACULTY.FacultyID
		WHERE FACULTY.FacultyID = @FACID
	END

	EXEC PR_COUNT_LOAD 101
