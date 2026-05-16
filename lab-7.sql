--1. Create trigger for blocking student deletion. 
	
	Create or Alter
	Trigger TR_Blocking_Student_Deletion
	on Student
	Instead of Delete
	As
	Begin
		Print 'Not allowed to delete student...!'
	End

	delete from Student
	where StudentID = 20

	Select * from STUDENT

	Drop trigger TR_Blocking_Student_Deletion

--2. Create trigger for making course read-only.
	
	Create or Alter
	Trigger TR_Read_Only_Course
	On Course
	Instead of insert,delete,update
	As
	Begin
		Print 'Only read data of course table.not allowed to insert,update or delete operation on course table'
	End

	Update COURSE
	set CourseCredits = 5
	where CourseID = 'CS101'

	drop trigger TR_Read_Only_Course

--3. Create trigger for preventing faculty removal.

	Create or Alter
	Trigger TR_Blocking_Faculty_Deletion
	on Faculty
	Instead of Delete
	As
	Begin
		Print 'Not allowed to delete Faculty...!'
	End

	Delete from FACULTY
	Where FacultyID = 101

	Drop trigger TR_Blocking_Faculty_Deletion

--4. Create instead of trigger to log all operations on COURSE (INSERT/UPDATE/DELETE) into Log table. 
--(Example: INSERT/UPDATE/DELETE operations are blocked for you in course table)

	
	Create or Alter
	Trigger TR_Read_Only_Course_Log
	On Course
	Instead of insert,delete,update
	As
	Begin
		Print 'Only read data of course table.not allowed to insert,update or delete operation on course table'

		insert into Log
		values ('INSERT/UPDATE/DELETE operations are blocked for you in course table',GETDATE())
	End

	Update COURSE
	set CourseCredits = 5
	where CourseID = 'CS101'

	Select * from log

	drop trigger TR_Read_Only_Course_Log

--5. Create trigger to Block student to update their enrollment year and print message ‘students are not 
--allowed to update their enrollment year’ 
	
	Create or Alter
	Trigger TR_Block_update_enrollmentYear
	On Student
	Instead of Update
	As
	Begin

		if UPDATE(stuEnrollmentYear)
			print 'students are not allowed to update their enrollment year'
	End

	update STUDENT
	set StuEnrollmentYear = 2025
	where StudentID = 1

	update STUDENT
	set StuDepartment = 'cse'
	where StudentID = 1

	drop trigger TR_Block_update_enrollmentYear

--6. Create trigger for student age validation (Min 18).
	
	Create or Alter
	Trigger tr_Age_validation
	On Student
	Instead Of Insert
	As
	Begin
		Declare @StuID int,
				@StuName varchar(50),
				@StuEmail varchar(50),
				@StuPhone varchar(10),
				@StuDepartment varchar(50),
				@StuDateOfBirth date,
				@StuEnrollmentYear int

		Select 
			@StuID = StudentID,
			@StuName = StuName,
			@StuEmail = StuEmail,
			@StuPhone = StuPhone,
			@StuDepartment = StuDepartment,
			@StuDateOfBirth = StuDateOfBirth,
			@StuEnrollmentYear = StuEnrollmentYear
		From inserted

		If DATEDIFF(year,@StuDateOfBirth,GETDATE()) > 17
			Insert into Student
			values (@StuID,@StuName,@StuEmail,@StuPhone,@StuDepartment,@StuDateOfBirth,@StuEnrollmentYear)
		End
		
		Select * from STUDENT

		Insert Into STUDENT
		Values (31,'Raj Patel','raj@univ.edu','9876543210','CSE','2024-05-15',2021)

		Select * from STUDENT

		Drop Trigger tr_Age_validation
--Part – B 
--7. Create trigger for unique faculty’s email check. 
--8. Create trigger for preventing duplicate enrollment. 
--Part - C 
--9. Create trigger to Allow enrolment in month from Jan to August, otherwise print message enrolment 
--closed. 
--10. Create trigger to Allow only grade change in enrollment (block other updates)