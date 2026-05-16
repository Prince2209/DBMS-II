--UDF


--Part-A

--1. Write a scalar function to print "Welcome to DBMS Lab".

	CREATE OR ALTER FUNCTION FN_PRINT_MSG()
	RETURNS VARCHAR(100)
	AS
	BEGIN
		RETURN 'Welcome to DBMS Lab'
	END

	SELECT dbo.FN_PRINT_MSG()

--2. Write a scalar function to calculate simple interest.

	CREATE OR ALTER FUNCTION FN_INTEREST(
		@P DECIMAL(8,2),
		@R DECIMAL(8,2),
		@N DECIMAL(8,2)
	)
	RETURNS DECIMAL(8,2)
	AS
	BEGIN
		RETURN (@P * @R * @N)/100
	END

	SELECT dbo.FN_INTEREST(100,4,1)

--3. Function to Get Difference in Days Between Two Given Dates

	CREATE OR ALTER FUNCTION FN_DAYS(
		@D1 DATE,
		@D2 DATE
	)
	RETURNS INT
	AS
	BEGIN
		RETURN DATEDIFF(DAY,@D1,@D2)
	END

	SELECT dbo.FN_DAYS('2025-12-2','2025-12-12')

--4. Write a scalar function which returns the sum of Credits for two given CourseIDs.

	CREATE OR ALTER FUNCTION FN_SUM_CREDITS(
		@C1 VARCHAR(10),
		@C2 VARCHAR(10)
	)
	RETURNS INT
	AS
	BEGIN
		DECLARE @SUM INT
		SET @SUM = (
			SELECT SUM(CourseCredits)
			FROM COURSE
			WHERE CourseID = @C1 OR CourseID = @C2
		)
		RETURN @SUM
	END

	SELECT dbo.FN_SUM_CREDITS('CS201','IT101')

--5. Write a function to check whether the given number is ODD or EVEN.

	CREATE OR ALTER FUNCTION FN_CHECK_ODD_EVEN(
		@N1 INT
	)
	RETURNS VARCHAR(10)
	AS
	BEGIN
		RETURN CASE 
				WHEN @N1%2 = 0 THEN 'EVEN' 
				ELSE 'ODD'
				END
	END

	SELECT dbo.FN_CHECK_ODD_EVEN(5)

--6. Write a function to print number from 1 to N. (Using while loop)

	CREATE OR ALTER FUNCTION FN_PRINT_NUM(
		@N1 INT
	)
	RETURNS VARCHAR(100)
	AS
	BEGIN
		DECLARE @I INT,@A VARCHAR(100)
		SET @I=1
		SET @A='' 
		WHILE @I <= @N1
			BEGIN
				SET @A = @A + CAST(@I AS VARCHAR) + ' '
				SET @I = @I + 1
			END
			RETURN @A
	END

	SELECT dbo.FN_PRINT_NUM(10)

--7. Write a scalar function to calculate factorial of total credits for a given CourseID.
	
	CREATE OR ALTER FUNCTION FN_FACTORIAL(
		@C1 VARCHAR(10)
	)
	RETURNS INT
	AS
	BEGIN
		DECLARE @ANS INT,@N1 INT
		SET @ANS = 1
		SET @N1 = (
			SELECT CourseCredits
			FROM COURSE
			WHERE CourseID = @C1
		)
		WHILE @N1 > 1
			BEGIN 
				SET @ANS = @ANS * @N1
				SET @N1 = @N1 - 1
			END
			RETURN @ANS
	END

	SELECT dbo.FN_FACTORIAL('CS201')

--8. Write a scalar function to check whether a given EnrollmentYear is in the past, current or future (Case statement)

	CREATE OR ALTER FUNCTION FN_CHECKENROLLMENTYEAR(
		@EnrollmentYear INT
	)
	RETURNS VARCHAR(10)
	AS
	BEGIN
		DECLARE @RESULT VARCHAR(10)

		SET @RESULT =
			CASE
				WHEN @EnrollmentYear < YEAR(GETDATE()) THEN 'Past'
				WHEN @EnrollmentYear = YEAR(GETDATE()) THEN 'Current'
				WHEN @EnrollmentYear > YEAR(GETDATE()) THEN 'Future'
			END

		RETURN @RESULT
	END

	SELECT dbo.FN_CHECKENROLLMENTYEAR(2022)

--9. Write a table-valued function that returns details of students whose names start with a given letter.
	
	CREATE OR ALTER FUNCTION FN_STUDENTSDETAILS(
		@StartLetter VARCHAR(10)
	)
	RETURNS TABLE
	AS
	RETURN (
		SELECT *
		FROM STUDENT
		WHERE StuName LIKE @StartLetter + '%'
	)

	SELECT *
	FROM dbo.FN_STUDENTSDETAILS('A')


--10. Write a table-valued function that returns unique department names from the STUDENT table.

	CREATE OR ALTER FUNCTION FN_UNIQUE_DEPT()
	RETURNS TABLE
	AS
	RETURN (
		SELECT DISTINCT StuDepartment
		FROM STUDENT
		WHERE StuDepartment IS NOT NULL
	)

	SELECT *
	FROM dbo.FN_UNIQUE_DEPT()


--Part-B


--11. Write a scalar function that calculates age in years given a DateOfBirth.

	
--12. Write a scalar function to check whether given number is palindrome or not.

	
--13. Write a scalar function to calculate the sum of Credits for all courses in the 'CSE' department.

	
--14. Write a table-valued function that returns all courses taught by faculty with a specific designation.

	

--Part - C


--15. Write a scalar function that accepts StudentID and returns their total enrolled credits (sum of credits from all active enrollments).

	
--16. Write a scalar function that accepts two dates (joining date range) and returns the count of faculty who joined in that period.

	