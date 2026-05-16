--Exception Handling


--Part – A


--1. Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error.

	BEGIN TRY
        DECLARE @a INT = 10
        DECLARE @b INT = 0
        DECLARE @result INT

        SET @result = @a / @b
        PRINT 'Result = ' + CAST(@result AS VARCHAR)
    END TRY

    BEGIN CATCH
        PRINT 'Error occurs is - Divide by zero error.'
    END CATCH

--2. Try to convert string to integer and handle the error using try…catch block.

    BEGIN TRY
        DECLARE @num INT
        DECLARE @str VARCHAR(10) = 'ABC'

        SET @num = CAST(@str AS INT)

        PRINT 'Converted Number = ' + CAST(@num AS VARCHAR)
    END TRY

    BEGIN CATCH
        PRINT 'Error: Cannot convert string to integer.'
    END CATCH

--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle
--exception with all error functions if any one enters string value in numbers otherwise print result.

    CREATE PROCEDURE AddNumbers
        @num1 VARCHAR(20),
        @num2 VARCHAR(20)
    AS
    BEGIN
        BEGIN TRY
            DECLARE @n1 INT
            DECLARE @n2 INT
            DECLARE @sum INT

            SET @n1 = CAST(@num1 AS INT)
            SET @n2 = CAST(@num2 AS INT)

            SET @sum = @n1 + @n2

            PRINT 'Sum = ' + CAST(@sum AS VARCHAR)
        END TRY

        BEGIN CATCH
            PRINT 'Error Message: ' + ERROR_MESSAGE()
            PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR)
            PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR)
            PRINT 'Error State: ' + CAST(ERROR_STATE() AS VARCHAR)
        END CATCH
    END

    EXEC AddNumbers '10','20'
    EXEC AddNumbers '10','ABC'

--4. Handle a Primary Key Violation while inserting data into student table and print the error details such
--as the error message, error number, severity, and state.

    CREATE TABLE Stud(
        StudentID INT PRIMARY KEY,
        Name VARCHAR(50)
    )

    BEGIN TRY
        INSERT INTO Stud VALUES (1,'Amit')
        INSERT INTO Stud VALUES (1,'Rina')
    END TRY

    BEGIN CATCH
        PRINT 'Error Message: ' + ERROR_MESSAGE()
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR)
        PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR)
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS VARCHAR)
    END CATCH

--5. Throw custom exception using stored procedure which accepts StudentID as input & that throws
--Error like no StudentID is available in database.

    CREATE PROCEDURE CheckStudent
        @StudentID INT
    AS
    BEGIN
        IF NOT EXISTS (SELECT * FROM Student WHERE StudentID = @StudentID)
            BEGIN
                THROW 50001, 'No StudentID is available in database.', 1;
            END
        PRINT 'Student exists in database.'    
    END

    EXEC CheckStudent 5

--6. Handle a Foreign Key Violation while inserting data into Enrollment table and print appropriate error
--message.

    CREATE TABLE Course(
        CourseID INT PRIMARY KEY,
        CourseName VARCHAR(50)
    )

    CREATE TABLE Enrollment(
        EnrollID INT PRIMARY KEY,
        CourseID INT,
        FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
    )

    BEGIN TRY
        INSERT INTO Enrollment VALUES (1,100)
    END TRY

    BEGIN CATCH
        PRINT 'Foreign Key Violation Occurred.'
        PRINT 'Error Message: ' + ERROR_MESSAGE()
    END CATCH
--Part – B

--7. Handle Invalid Date Format

    
--8. Procedure to Update faculty’s Email with Error Handling.

    
--9. Throw custom exception that throws error if the data is invalid.

    


--Part – C

--10. Write a script that checks if a faculty’s salary is NULL. If it is, use RAISERROR to show a message with a
--severity of 16. (Note: Do not use any table)

    