--Part – A 
--1. Create a cursor Course_Cursor to fetch all rows from COURSE table and display them. 
	

	Declare @CourseId varchar(10),@CourseName varchar(100),@CourseCredits int,@CourseDepartment varchar(50),@CourseSemester int
	Declare Course_Cursor Cursor
	For
		Select
			CourseId,
			CourseName,
			CourseCredits,
			CourseDepartment,
			CourseSemester
		From Course

	Open Course_Cursor

	Fetch Next
	From Course_Cursor Into @CourseId,@CourseName,@CourseCredits,@CourseDepartment,@CourseSemester

	While @@FETCH_STATUS = 0
		Begin
			
			Print concat(@CourseId,' ',@CourseName,' ',@CourseCredits,' ',@CourseDepartment,' ',@CourseSemester)
			Fetch Next
			From Course_Cursor Into @CourseId,@CourseName,@CourseCredits,@CourseDepartment,@CourseSemester
		End
	
	Close Course_Cursor
	Deallocate Course_Cursor

--2. Create a cursor Student_Cursor_Fetch to fetch records in form of StudentID_StudentName (Example: 
--1_Raj Patel). 

	Declare @StudentId int,@StuName varchar(50)
	
	Declare Student_Cursor_Fetch Cursor
	For
		Select
			StudentId,
			StuName
		From STUDENT

	Open Student_Cursor_Fetch

	Fetch Next
	From Student_Cursor_Fetch Into @StudentId,@StuName

	While @@FETCH_STATUS = 0
		Begin
			Print concat(@StudentId,'_',@StuName)
			Fetch Next
			From Student_Cursor_Fetch Into @StudentId,@StuName
		End
	Close Student_Cursor_Fetch
	Deallocate Student_Cursor_Fetch


--3. Create a cursor to find and display all courses with Credits greater than 3. 

	Declare @CourseId3 varchar(10),@CourseName3 varchar(100),@CourseCredits3 int,@CourseDepartment3 varchar(50),@CourseSemester3 int
	Declare Course_Cursor Cursor
	For
		Select
			CourseId,
			CourseName,
			CourseCredits,
			CourseDepartment,
			CourseSemester
		From Course
		Where CourseCredits > 3

	Open Course_Cursor

	Fetch Next
	From Course_Cursor Into @CourseId3,@CourseName3,@CourseCredits3,@CourseDepartment3,@CourseSemester3

	While @@FETCH_STATUS = 0
		Begin
			
			Print concat(@CourseId3,' ',@CourseName3,' ',@CourseCredits3,' ',@CourseDepartment3,' ',@CourseSemester3)
			Fetch Next
			From Course_Cursor Into @CourseId3,@CourseName3,@CourseCredits3,@CourseDepartment3,@CourseSemester3
		End
	
	Close Course_Cursor
	Deallocate Course_Cursor

--4. Create a cursor to display all students who enrolled in year 2021 or later.

	Declare @StudentId4 int,@StuName4 varchar(100),@StuEmail4 varchar(50),@StuPhone4 varchar(15),@StuDepartment4 varchar(50),@StuDateOfBirth4 date,@StuEnrollmentYear4	int

	Declare Student4_Cursor Cursor
	For
		Select
			StudentId,
			StuName,
			StuEmail,
			StuPhone,
			StuDepartment,
			StuDateOfBirth,
			StuEnrollmentYear
		From STUDENT
		Where StuEnrollmentYear > 2021

	Open Student4_Cursor

	Fetch Next
	From Student4_Cursor Into @StudentId4,@StuName4,@StuEmail4,@StuPhone4,@StuDepartment4,@StuDateOfBirth4,@StuEnrollmentYear4

	While @@FETCH_STATUS = 0

		Begin
			Print concat(@StudentId4,'-',@StuName4,'-',@StuEmail4,'-',@StuPhone4,'-',@StuDepartment4,'-',@StuDateOfBirth4,'-',@StuEnrollmentYear4)
			Fetch Next
			From Student4_Cursor Into @StudentId4,@StuName4,@StuEmail4,@StuPhone4,@StuDepartment4,@StuDateOfBirth4,@StuEnrollmentYear4
		End
	
	Close Student4_Cursor
	Deallocate Student4_Cursor


--5. Create a cursor Course_CursorUpdate that retrieves all courses and increases Credits by 1 for courses
--with Credits less than 4. 
	
	Select * from Course

	Declare @CourseId5 varchar(10),@CourseCredits5 int

	Declare Course_CursorUpdate Cursor
	For
		Select
			CourseId,
			CourseCredits
		From COURSE
		Where CourseCredits < 4

	Open Course_CursorUpdate

	Fetch Next
	From Course_CursorUpdate Into @CourseId5,@CourseCredits5

	While @@FETCH_STATUS = 0
		Begin
			Update COURSE
			Set CourseCredits = CourseCredits + 1
			Where CourseID = @CourseId5

			Fetch Next
			From Course_CursorUpdate Into @CourseId5,@CourseCredits5
		End
	
	close Course_CursorUpdate
	Deallocate Course_CursorUpdate

--6. Create a Cursor to fetch Student Name with Course Name (Example: Raj Patel is enrolled in Database 
--Management System) 

	Declare @StuName6 varchar(50),@CourseName6 varchar(100)

	Declare Student6_Cursor Cursor
	For
		Select
			StuName,
			CourseName

		From ENROLLMENT E join STUDENT S
		on E.StudentID = S.StudentID

		join COURSE C
		On C.CourseID = E.CourseID

	Open Student6_Cursor

	Fetch Next
	From Student6_Cursor Into @StuName6,@CourseName6

	While @@FETCH_STATUS = 0
		Begin
			Print @StuName6 + 'is enrolled in '+@CourseName6
			Fetch Next
			From Student6_Cursor Into @StuName6,@CourseName6
		End
	
	close Student6_Cursor
	Deallocate Student6_Cursor

--7. Create a cursor to insert data into new table if student belong to ‘CSE’ department. (create new table 
--CSEStudent with relevant columns) 

	Create Table CSEStudent(
		StudentID INT, 
		StuName VARCHAR(100), 
		StuEmail VARCHAR(100),
		StuPhone VARCHAR(15),
		StuDepartment VARCHAR(50),
		StuDateOfBirth DATE,
		StuEnrollmentYear INT
	)

	Declare @StudentId7 int,@StuName7 varchar(100),@StuEmail7 varchar(50),@StuPhone7 varchar(15),@StuDepartment7 varchar(50),@StuDateOfBirth7 date,@StuEnrollmentYear7	int

	Declare Student7_Cursor Cursor
	For
		Select
			StudentId,
			StuName,
			StuEmail,
			StuPhone,
			StuDepartment,
			StuDateOfBirth,
			StuEnrollmentYear
		From STUDENT
		Where StuDepartment = 'CSE'

	Open Student7_Cursor

	Fetch Next
	From Student7_Cursor Into @StudentId7,@StuName7,@StuEmail7,@StuPhone7,@StuDepartment7,@StuDateOfBirth7,@StuEnrollmentYear7

	While @@FETCH_STATUS = 0

		Begin
			
			Insert Into CSEStudent
			Values (@StudentId7,@StuName7,@StuEmail7,@StuPhone7,@StuDepartment7,@StuDateOfBirth7,@StuEnrollmentYear7)

			Fetch Next
			From Student7_Cursor Into  @StudentId7,@StuName7,@StuEmail7,@StuPhone7,@StuDepartment7,@StuDateOfBirth7,@StuEnrollmentYear7
		End
	
	Close Student7_Cursor
	Deallocate Student7_Cursor

	Select * from CSEStudent

	Select * from ENROLLMENT

	insert into ENROLLMENT
	values (2,'IT201','2022-01-05',NULL,'Completed')

--Part – B 
--8. Create a cursor to update all NULL grades to 'F' for enrollments with Status 'Completed' 

	Declare @EnrollmentID8 int
	Declare Enrollment8_Cursor Cursor
	For
		Select
			EnrollmentID
		From ENROLLMENT
		Where Grade is null And EnrollmentStatus = 'Completed'

	Open Enrollment8_Cursor

	Fetch Next
	From Enrollment8_Cursor into @EnrollmentID8

	While @@FETCH_STATUS = 0
		Begin
			Update ENROLLMENT
			Set Grade = 'F'
			Where EnrollmentID = @EnrollmentID8

			Fetch Next
			From Enrollment8_Cursor into @EnrollmentID8
		End

	Close Enrollment8_Cursor
	Deallocate Enrollment8_Cursor

--9. Cursor to show Faculty with Course they teach (EX: Dr. Sheth teaches Data structure)

	Declare @FacultyName9 varchar(100) , @CourseName9 varchar(100)
	Declare Faculty9_Cursor Cursor
	For
		Select
			FacultyName,
			CourseName
		From COURSE_ASSIGNMENT CA join COURSE C
		on Ca.CourseID = C.CourseID
	
		join FACULTY F
		on CA.FacultyID = F.FacultyID

	Open Faculty9_Cursor

	Fetch Next
	From Faculty9_Cursor Into @FacultyName9,@CourseName9

	While @@FETCH_STATUS = 0
		Begin
			Print Concat(@FacultyName9,' teches ',@CourseName9)

			Fetch Next
			From Faculty9_Cursor Into @FacultyName9,@CourseName9
		End

	Close Faculty9_Cursor
	Deallocate Faculty9_Cursor



--Part – C 
--10. Cursor to calculate total credits per student (Example: Raj Patel has total credits = 15)

	Declare @StuName10 varchar(100),@credits10 int
	Declare Student10_cursor cursor
	For
		Select
			StuName,
			sum(courseCredits)
		From ENROLLMENT E join STUDENT S
		on E.StudentID = S.StudentID
		join COURSE C
		on E.CourseID = C.CourseID
		Group by StuName

	Open Student10_cursor

	Fetch Next
	From Student10_cursor into @StuName10,@credits10

	While @@FETCH_STATUS = 0
		Begin
			Print concat(@StuName10,' has total credits = ',@credits10)
			Fetch Next
			From Student10_cursor into @StuName10,@credits10
		End
	Close Student10_cursor
	Deallocate Student10_cursor