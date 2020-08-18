CREATE TABLE Person
    (
    PID VARCHAR(4), --PXXX
    Fname VARCHAR(20) NOT NULL ,
    Lname VARCHAR(20) NOT NULL,
    date_of_birth varchar(8) NOT NULL,--YYYYMMDD format NOTO THAT ENROLLMENT DATE IS MMDDYYYY FORMAT
    street VARCHAR(20),
    city VARCHAR(20),
    zip NUMERIC(5),
    cell_PhoneNumber NUMERIC(10) NOT NULL,  --1234567890
    home_Phone_Number NUMERIC(10), 
    gender CHAR(6),--male or female
    CONSTRAINT check_ID CHECK( substr( PID, 1, 1 ) = 'P'  AND
                           to_number( substr( PID, 2, 3 ) ) BETWEEN 0 AND 999 ),
    CONSTRAINT check_DOB CHECK ( TO_DATE(date_of_birth,'YYYYMMDD') < TO_DATE('20040101','YYYYMMDD') ),
    CONSTRAINT check_Gender CHECK (gender = 'female' OR gender = 'male'),
    CONSTRAINT Person_Key PRIMARY KEY (PID)
    );
----------------------------------------------------------------


CREATE TABLE Employee 
    (
    EmployeeID VARCHAR(4),
    FOREIGN KEY (EmployeeID) REFERENCES Person(PID)
        ON DELETE CASCADE,
    CONSTRAINT Employee_Key PRIMARY KEY (EmployeeID)
    );

CREATE TABLE Emp_Type
    (
    EmpID VARCHAR(4),
    Employee_Type VARCHAR(20),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmployeeID)
        ON DELETE CASCADE,
    CONSTRAINT Emp_Type_Key PRIMARY KEY (EmpID)
    );
----------------------------------------------------------------
CREATE TABLE Member
    (
    MemberID VARCHAR(4),
        FOREIGN KEY (MemberID) REFERENCES Person(PID)
        ON DELETE CASCADE, 
    CONSTRAINT Member_Key PRIMARY KEY (MemberID)
    );


CREATE TABLE Mem_Type
    (
    memID VARCHAR(4),
    Member_Type VARCHAR(10),
    FOREIGN KEY (memID) REFERENCES Member(MemberID)
        ON DELETE CASCADE,
    CONSTRAINT Member_Type_Key PRIMARY KEY (memID)
    );

CREATE TABLE Guest
    (
    GoldID VARCHAR(4),
    GuestID VARCHAR(3),
    street VARCHAR(20),
    city VARCHAR(20),
    zip NUMERIC(5),
    cell_PhoneNumber NUMERIC(10) NOT NULL,
    FOREIGN KEY (GoldID) REFERENCES Member(MemberID)
        ON DELETE CASCADE, 
    CONSTRAINT Guest_Key PRIMARY KEY (GoldID, GuestID)
    );
    
----------------------------------------------------------------
CREATE TABLE Author
    (
    AuthorID VARCHAR(4),
    FOREIGN KEY (AuthorID) REFERENCES Person(PID)
        ON DELETE CASCADE,
    CONSTRAINT Author_Key PRIMARY KEY (AuthorID)
    );

CREATE TABLE Written
    (
    AID VARCHAR(4),
    BID VARCHAR(4),
    FOREIGN KEY (AID) REFERENCES Author(AuthorID)
        ON DELETE CASCADE, 
    FOREIGN KEY (BID) REFERENCES Books(BookID)
        ON DELETE CASCADE,    
    CONSTRAINT Written_Key PRIMARY KEY (AID, BID)
    );
----------------------------------------------------------------
CREATE TABLE Publisher
    (
    PID VARCHAR(4),
    FOREIGN KEY (PID) REFERENCES Person(PID)
        ON DELETE CASCADE, 
    CONSTRAINT Publisher_Key PRIMARY KEY (PID)
    );
----------------------------------------------------------------

CREATE TABLE Books
    (
    BookID VARCHAR(4),
    Title VARCHAR(40) NOT NULL,
    PubID VARCHAR(4) NOT NULL,
    ClassT VARCHAR(1) NOT NULL,
    CONSTRAINT check_BID CHECK( substr( BookID, 1, 1 ) = 'B'  AND to_number( substr( BookID, 2, 3 ) ) BETWEEN 0 AND 999 ),
    FOREIGN KEY (PubID) REFERENCES Publisher(PID)
        ON DELETE CASCADE,
    CONSTRAINT check_ClassT CHECK (ClassT = '1' OR ClassT = '2'),
    CONSTRAINT Books_Key PRIMARY KEY (BookID)
    );
----------------------------------------------------------------
CREATE TABLE BorrowedBookDetails
    (
    BID VARCHAR(4),
    EID VARCHAR(4),
    MID VARCHAR(4),
    FOREIGN KEY (BID) REFERENCES Books(BookID)
        ON DELETE CASCADE,
    FOREIGN KEY (EID) REFERENCES Employee(EmployeeID)
        ON DELETE CASCADE,
    FOREIGN KEY (MID) REFERENCES Member(MemberID)
        ON DELETE CASCADE,
    CONSTRAINT BorrowedBookDetails_Key PRIMARY KEY (BID, EID, MID)
    );

CREATE TABLE BookTrans
    (
    BID VARCHAR(4),
    EID VARCHAR(4),
    MID VARCHAR(4),
    borrowedDate varchar(8) NOT NULL,--MMDDYYYY format
    dueDate varchar(8) NOT NULL,--MMDDYYYY format
    returnedDate varchar(8),--MMDDYYYY format
    FOREIGN KEY (BID, EID, MID) REFERENCES BorrowedBookDetails(BID, EID, MID)
        ON DELETE CASCADE,
    CONSTRAINT BookTrans_Key PRIMARY KEY (BID)    
    );

CREATE TABLE Fee
    (
    BFID VARCHAR(4),
    fee VARCHAR(15),
    FOREIGN KEY (BFID) REFERENCES BookTrans(BID)
        ON DELETE CASCADE,
    CONSTRAINT Fee_Key PRIMARY KEY (BFID) 
    );
----------------------------------------------------------------
--FILLING UP THE DB
----------------------------------------------------------------
--MEMBERS -id start with P000
------------------------------------------------
--GOLD MEMBER
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender ) 
VALUES ('P001', 'Jo', 'Go', 20001010, 'UTD','Richardson', 12345, 2141114444, NULL, 'female' );

INSERT INTO Member (MemberID)
VALUES('P001');

INSERT INTO Mem_Type (memID, Member_Type)
VALUES('P001','Gold');

--GOLD MEMBER
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P002', 'Rose', 'English', 19991010, 'UTD','Frisco', 43431, 2141114334, NULL, 'female' );

INSERT INTO Member (MemberID)
VALUES('P002');

INSERT INTO Mem_type
VALUES('P002','Gold');

--SILVER
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P003', 'John', 'Smith', 20000909, 'Campbell','Richardson', 12345, 2141555544, NULL, 'female' );

INSERT INTO Member (MemberID)
VALUES('P003');

INSERT INTO Mem_type
VALUES('P003','Silver');

--SILVER
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P004', 'James', 'Bond', 19950110, 'Coit','Dallas', 75621, 4341114444, NULL, 'male' );

INSERT INTO Member (MemberID)
VALUES('P004');

INSERT INTO Mem_type
VALUES('P004','Silver');

--SILVER
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P005', 'Janice', 'Chan', 19941015, 'UTD','Richardson', 12345, 2149994444, NULL, 'female' );

INSERT INTO Member (MemberID)
VALUES('P005');

INSERT INTO Mem_type
VALUES('P005','Silver');


--GOLD
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P006', 'Ra', 'Si', 19980202, 'UTD','Richardson', 12345, 2141166666, NULL, 'female' );

INSERT INTO Member (MemberID)
VALUES('P006');

INSERT INTO Mem_type
VALUES('P006','Gold');

--GOLD
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P007', 'Ha', 'Ng', 20000404, 'UTD','Richardson', 12345, 5555514444, NULL, 'female' );

INSERT INTO Member (MemberID)
VALUES('P007');

INSERT INTO Mem_type
VALUES('P007','Gold');

--EMPLOYEES -id start with P020
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P028', 'Mansi', 'Singh', 19970710, 'Renner','Richardson', 12344, 2141224444, NULL, 'male' );

INSERT INTO Employee (EmployeeID)
VALUES('P028');

INSERT INTO Emp_type
VALUES('P028','Library Supervisor');

--update hire date
update person
set enrollmentdate = '01012000'
where person.pid = 'P028';
------------------------------
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P029', 'Lily', 'Parks', 20020507, 'UTD','Richardson', 12345, 2141119994, NULL, 'female' );

INSERT INTO Employee (EmployeeID)
VALUES('P029');

INSERT INTO Emp_type
VALUES('P029','Receptionist');

--update hire date
update person
set enrollmentdate = '01012010'
where person.pid = 'P029';
------------------------------
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P020', 'Pi', 'Smith', 20011020, 'UTD','Richardson', 12345, 2131114444, NULL, 'male' );

INSERT INTO Employee (EmployeeID)
VALUES('P020');

INSERT INTO Emp_type
VALUES('P020','Cataloging Manager');

--update hire date
update person
set enrollmentdate = '01012020'
where person.pid = 'P020';

--PUBLISHERS -id start with P050

INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P051', 'Peguin', 'James', 19901210, 'UTD','Richardson', 12345, 2141114448, NULL, 'female' );

INSERT INTO Publisher (PID)
VALUES('P051');
-----------------
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P052', 'Packet', 'Ro', 19900101, 'UTD','Richardson', 12345, 2188114444, NULL, 'female' );

INSERT INTO Publisher (PID)
VALUES('P052');

--Guests -GuestID starts with 120
INSERT INTO Guest (GoldID, GuestID, street, city, zip, cell_PhoneNumber)
VALUES ('P001', '123', 'Renner', 'Richardson', 75080, 4719001299);

INSERT INTO Guest (GoldID, GuestID, street, city, zip, cell_PhoneNumber)
VALUES ('P002', '125', 'Waterview', 'Richardson', 75080, 4719001888);

--AUTHORS -id starts in P100
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P100', 'J.K.', 'Rowling', 19650730, 'Yate Road','Yate', 55555, 2141231234, 2141231235, 'female' );

INSERT INTO Author (AuthorID)
VALUES('P100');
--------------
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P101', 'Scott', 'Fitzgerald', 18960824, 'Hollywood Road','Los Angeles', 90210, 2141230000, 2141230001, 'male' );

INSERT INTO Author (AuthorID)
VALUES('P101');
--------------
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P102', 'Mark', 'Twain', 18351130, 'Redding Road','Redding', 90000, 2143210000, NULL, 'male' );

INSERT INTO Author (AuthorID)
VALUES('P102');
--------------
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P103', 'Charles', 'Dickens', 18120207, 'Hills Road','Gads Hill Place', 45451, 2149990000, NULL, 'male' );

INSERT INTO Author (AuthorID)
VALUES('P103');
--------------
INSERT INTO Person (PID, Fname,Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender )
VALUES ('P104', 'Carol', 'Lewis', 18150209, 'Mount Road','New York', 45477, 2149990077, NULL, 'male' );

INSERT INTO Author (AuthorID)
VALUES('P104');

------------------------------------------------
--BOOKS (Publisher id can be P051 or P052 . Class can be 1 or 2.)
------------------------------------------------
--JK Rowling
INSERT INTO Books (BookID, Title, PubID, ClassT)
VALUES('B001','The Philosophers Stone','P051','1');

INSERT INTO Books (BookID, Title, PubID, ClassT)
VALUES('B111','The Philosophers Stone','P051','1');

INSERT INTO Written (AID, BID)
VALUES ('P100','B001');

INSERT INTO Written (AID, BID)
VALUES ('P100','B111');

----------------------
INSERT INTO Books (BookID, Title, PubID, ClassT)
VALUES('B002','The Chamber of Secrets','P051','1');

INSERT INTO Written (AID, BID)
VALUES ('P100','B002');
----------------------
INSERT INTO Books (BookID, Title, PubID, ClassT)
VALUES('B003','The Prisoner of Azkaban','P051','1');

INSERT INTO Written (AID, BID)
VALUES ('P100','B003');
----------------------
INSERT INTO Books (BookID, Title, PubID, ClassT)
VALUES('B004','The Goblet of Fire','P051','1');

INSERT INTO Written (AID, BID)
VALUES ('P100','B004');
----------------------
INSERT INTO Books (BookID, Title, PubID, ClassT)
VALUES('B005','The Order of the Phoenix','P051','1');

INSERT INTO Written (AID, BID)
VALUES ('P100','B005');
----------------------
INSERT INTO Books (BookID, Title, PubID, ClassT)
VALUES('B006','The Half-Blood Prince','P051','1');

INSERT INTO Written (AID, BID)
VALUES ('P100','B006');
----------------------
INSERT INTO Books (BookID, Title, PubID, ClassT)
VALUES('B007','The Deathly Hallows','P051','1');

INSERT INTO Written (AID, BID)
VALUES ('P100','B007');
----------------------
--Scot
INSERT INTO Books (BookID, Title, PubID, ClassT)
VALUES('B008','The Great Gatsby','P052','2');

INSERT INTO Written (AID, BID)
VALUES ('P101','B008');
----------------------
--Mark
INSERT INTO Books (BookID, Title, PubID, ClassT)
VALUES('B009','The Adventures of Tom Sawyer','P052','2');

INSERT INTO Written (AID, BID)
VALUES ('P102','B009');
----------------------
--Charles
INSERT INTO Books (BookID, Title, PubID, ClassT)
VALUES('B010','Oliver Twist','P052','2');

INSERT INTO Written (AID, BID)
VALUES ('P103','B010');
----------------------
--Carol
INSERT INTO Books (BookID, Title, PubID, ClassT)
VALUES('B011','Alice''s Adventures in Wonderland','P052','2');

INSERT INTO Written (AID, BID)
VALUES ('P104','B011');

INSERT INTO Books (BookID, Title, PubID, ClassT)
VALUES('B012','Alice''s Adventures in Wonderland 2','P052','2');

INSERT INTO Written (AID, BID)
VALUES ('P104','B012');
----------------------
--BorrowedBookDetails
--BID= B001-B011 (B001-007 are harry potter), EID = P029, MID = P001-007 (3,4,5 are silver)
------------------------------------------------
INSERT INTO BorrowedBookDetails (BID, EID, MID) 
VALUES ('B001','P029','P001');
INSERT INTO BorrowedBookDetails (BID, EID, MID) 
VALUES ('B111','P029','P001');

INSERT INTO BorrowedBookDetails (BID, EID, MID) 
VALUES ('B002','P029','P001');

INSERT INTO BorrowedBookDetails (BID, EID, MID) 
VALUES ('B003','P029','P002');

INSERT INTO BorrowedBookDetails (BID, EID, MID) 
VALUES ('B004','P029','P002');

INSERT INTO BorrowedBookDetails (BID, EID, MID) 
VALUES ('B005','P029','P003');

INSERT INTO BorrowedBookDetails (BID, EID, MID) 
VALUES ('B006','P029','P004');

INSERT INTO BorrowedBookDetails (BID, EID, MID) 
VALUES ('B012','P029','P005');

INSERT INTO BorrowedBookDetails (BID, EID, MID) 
VALUES ('B007','P029','P001');

INSERT INTO BorrowedBookDetails (BID, EID, MID) 
VALUES ('B008','P029','P006');

INSERT INTO BorrowedBookDetails (BID, EID, MID) 
VALUES ('B009','P029','P006');

INSERT INTO BorrowedBookDetails (BID, EID, MID) 
VALUES ('B010','P029','P007');

INSERT INTO BorrowedBookDetails (BID, EID, MID) 
VALUES ('B011','P029','P007');

------------------------------------------------
--Popluating the BookTrans table 
--dates are on YYYYMMDD string format
------------------------------------------------
INSERT INTO BookTrans (BID, EID, MID, borrowedDate, dueDate, returnedDate)
VALUES ('B001','P029','P001', '04262020', '05162020', NULL);--not turned in yet

INSERT INTO BookTrans (BID, EID, MID, borrowedDate, dueDate, returnedDate)
VALUES ('B111','P029','P001', '04262010', '05162010', '05102010');

INSERT INTO BookTrans (BID, EID, MID, borrowedDate, dueDate, returnedDate)
VALUES ('B002','P029','P001', '01262020', '02162020', '02202020');--late

INSERT INTO BookTrans (BID, EID, MID, borrowedDate, dueDate, returnedDate)
VALUES ('B003','P029','P002', '02252020', '03152020', '03102020');--regular

INSERT INTO BookTrans (BID, EID, MID, borrowedDate, dueDate, returnedDate)
VALUES ('B004','P029','P002', '03262020', '04162020', NULL);-- not turned in yet

INSERT INTO BookTrans (BID, EID, MID, borrowedDate, dueDate, returnedDate) 
VALUES ('B005','P029','P003', '04262020', '05162020', '05202020');--late

INSERT INTO BookTrans (BID, EID, MID, borrowedDate, dueDate, returnedDate)
VALUES ('B006','P029','P004', '02252020', '03152020', '03102020');--regular

INSERT INTO BookTrans (BID, EID, MID, borrowedDate, dueDate, returnedDate)
VALUES ('B012','P029','P005', '02252020', '03152020', '03102020');--regular

INSERT INTO BookTrans (BID, EID, MID, borrowedDate, dueDate, returnedDate)
VALUES ('B007','P029','P001', '05252019', '06152019', '06102019');--regular

INSERT INTO BookTrans (BID, EID, MID, borrowedDate, dueDate, returnedDate)
VALUES ('B008','P029','P006', '02252020', '03152020', '03102020'); --regular

INSERT INTO BookTrans (BID, EID, MID, borrowedDate, dueDate, returnedDate)
VALUES ('B009','P029','P006', '02262020', '03162020', '03172020');--late

INSERT INTO BookTrans (BID, EID, MID, borrowedDate, dueDate, returnedDate)
VALUES ('B010','P029','P007','01262019', '02162019', '02202019');--late

INSERT INTO BookTrans (BID, EID, MID, borrowedDate, dueDate, returnedDate)
VALUES ('B011','P029','P007', '04262020', '05162020', '05102020');--regular

------------------------------
--Populating Fee table
------------------------------
INSERT INTO Fee (BFID, fee)
VALUES ('B001','not turned in');

INSERT INTO Fee (BFID, fee)
VALUES ('B002','late');

INSERT INTO Fee (BFID, fee) 
VALUES ('B003','regular');

INSERT INTO Fee (BFID, fee)
VALUES ('B004','not turned in');

INSERT INTO Fee (BFID, fee)
VALUES ('B005','late');

INSERT INTO Fee (BFID, fee)
VALUES ('B006','regular');

INSERT INTO Fee (BFID, fee)
VALUES ('B007','regular');

INSERT INTO Fee (BFID, fee) 
VALUES ('B008','regular');

INSERT INTO Fee (BFID, fee) 
VALUES ('B009','late');

INSERT INTO Fee (BFID, fee)
VALUES ('B010','late');

INSERT INTO Fee (BFID, fee)
VALUES ('B011','regular');

INSERT INTO Fee (BFID, fee)
VALUES ('B012','regular');

------------------------------------------------
--Part E
--1. TopGoldMember- This view returns the First Name, Last Name and Date of
--membership enrollment of those members who have borrowed more than 5
--books in a week in the past year.
------------------------------------------------
-- Fname, Lname, 
CREATE VIEW TopGoldMember AS
SELECT * 
FROM BorrowedBookDetails b, Member m, Person p
WHERE (b.MID = m.memberid) AND (b.mid =  p.pid) ORDER BY m.memberid;

---store only importat attributes needed
CREATE VIEW TopGoldMemberFinal AS
select PID, Lname,  Fname, enrollmentDate,
    COUNT(BID) AS BookCount 
from topgoldmember
GROUP BY PID, Lname, Fname, enrollmentDate ORDER BY BookCount DESC;

select * 
from topgoldmemberfinal, booktrans
where topgoldmemberfinal.pid = booktrans.mid;

--get the members that have more than 5 books
SELECT *
FROM topgoldmemberfinal t
WHERE t.BookCount > 5;

------------------------------------------------
--2.PopularBooks- This view returns the details of the most borrowed books over
--the years.
------------------------------------------------
---store only importat attributes needed
CREATE VIEW PopBooks AS
SELECT * 
FROM BookTrans bt, Books b
WHERE bt.BID = b.BookID ORDER BY b.Title;


CREATE VIEW PopBooksFinal AS
select Title, PubID, ClassT,
    COUNT(Title) AS BookCount 
from PopBooks
GROUP BY Title, PubID, ClassT ORDER BY BookCount DESC;

select * 
from popbooksfinal 
where rownum =1;

----------------------------------------------------
--3.TopLatePaymentMembers- This view returns the details of the members who
--have paid the most number of late fees.
---------------------------------------------------
CREATE VIEW TopLate AS
SELECT *
FROM Member m, BorrowedBookDetails b, Fee f, Person p
WHERE p.PID = m.MemberID  AND  m.MemberID = b.MID AND b.BID = f.BFID;

CREATE VIEW TopLateFinal AS
select PID, Fname, Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender,
    COUNT(fee) as LateFees
from TopLate
GROUP BY PID, Fname, Lname, date_of_birth, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender ORDER BY LateFees DESC;

select * 
from TopLateFinal
where rownum =1;
---------------------------------------------------
--4.PotentialGoldMember- This view returns the name, phone number and ID of
--the silver members who borrowed books in every month in the past year and
--has always returned books on time.
---------------------------------------------------
CREATE VIEW PotentialGold AS
SELECT p.pid, p.fname, p.lname,p.cell_phonenumber
FROM Person p, Member m, Mem_Type mt, BorrowedBookDetails b, Fee f
WHERE (p.PID = m.MemberID AND m.MemberID = mt.memID  AND mt.memID = b.MID  AND b.BID = f.BFID) 
        AND mt.Member_Type = 'Silver' 
        AND f.fee = 'regular';

select * from PotentialGold;
---------------------------------------------------
--5. PopularAuthor- This view returns the top 5 authors of books in the library
--(Hint: Details of authors whose books have been borrowed the most)
---------------------------------------------------
--author name count
CREATE VIEW PopA AS
SELECT p.pid, p.fname, p.lname,p.cell_phonenumber, 
    COUNT(PID) AS PopAuthor
FROM Person p, Author a, Written w, Books b, Booktrans bt
WHERE (p.PID = a.AuthorID AND a.AuthorID = w.AID AND w.BID = b.BookID AND b.BookID = bt.bid)
GROUP BY p.pid, p.fname, p.lname,p.cell_phonenumber ORDER BY PopAuthor DESC
FETCH FIRST 5 ROWS ONLY;

select * 
from PopA; 

---------------------------------------------------
--Part F
--1. List the details of all the supervisors of the library in the past two months.
---------------------------------------------------
select * 
from Person p, Employee e, Emp_Type et
where (p.PID = e.EmployeeID AND e.EmployeeID = et.EmpID) 
        AND et.Employee_Type = 'Library Supervisor' 
        AND (TO_DATE(p.enrollmentdate, 'MMDDYYYY') < SYSDATE -60 );

---------------------------------------------------
--Part F
--2. Find the names of employees who are also a member and the books they have
--borrowed in the past month.
---------------------------------------------------
select p.Fname, p.Lname, bt.borroweddate
from Person p, Employee e, Member m, BorrowedBookDetails bb, BookTrans bt
where (p.PID = e.EmployeeID AND p.PID = m.memberid AND m.memberid = bb.mid AND bb.bid = bt.bid  )
      AND 
      (TO_DATE(bt.borroweddate, 'MMDDYYYY') > SYSDATE -30);
      --This will return an empty relation because there are no employees who are also members
---------------------------------------------------
--Part F
--3. Find the average number of books borrowed by the top five gold members in
--the library.
---------------------------------------------------
create view BookAvg as
select m.memberid, 
    COUNT(bb.bid) AS BookCount
from Member m, Mem_Type mt, BorrowedBookDetails bb, BookTrans bt
where (m.memberid = mt.memid AND mt.memid = bb.mid AND bb.bid = bt.bid)
group by m.memberid order by BookCount desc
fetch first 5 rows only;

select round(avg(BookCount)) from BookAvg;
---------------------------------------------------
--Part F
--4. Find the name of the publisher and the title of the most popular book.
---------------------------------------------------
select p.fname, popbooksfinal.title
from popbooksfinal, Person p
where p.PID = popbooksfinal.pubid
fetch first 1 row only;
---------------------------------------------------
--Part F
--5. Find names of books that were not borrowed in the last 5 months.
---------------------------------------------------

select title, bt.borroweddate
from Books b, BookTrans bt
where (b.bookid = bt.bid)
      and 
      not(TO_DATE(bt.borroweddate, 'MMDDYYYY') > SYSDATE -150);

---------------------------------------------------
--Part F
--6. Find the members who have borrowed all the books by the most popular
--author.
---------------------------------------------------

--this gets the most popular author
create view mostPopularAuthor as
    select * from popa
    fetch first 1 rows only;
    
select * from mostpopularauthor;

--output ND.
select * 
from member m, borrowedbookdetails bb, books b
where m.memberid = bb.mid and b.bookid = bb.bid;


---------------------------------------------------
--Part F
--7. Find the Gold Member with most number of guests.
---------------------------------------------------
select m.memberid, p.fname, p.lname,
    COUNT(guestid) as numOfGuest
from person p, member m, mem_type mt, guest g
where (p.pid = m.memberid AND m.memberid = mt.memid AND mt.memid = g.goldid)
group by m.memberid, p.fname, p.lname order by numOfGuest
fetch first 1 rows only;

---------------------------------------------------
--Part F
--8. Find the year with the maximum number of books borrowed.
---------------------------------------------------
select substr(popbooks.borroweddate, 5,4),
    count(substr(popbooks.borroweddate, 5,4)) as maxYear
from popbooks
group by substr(popbooks.borroweddate, 5,4) order by substr(popbooks.borroweddate, 5,4) desc
fetch first 1 rows only;

---------------------------------------------------
--Part F
--9. Find the names of members who borrowed the most popular books.
---------------------------------------------------
--the same person rented the same book twice
select p.fname, p.lname
from popbooksfinal pb, books b, borrowedbookdetails bb, member m, person p
where (pb.title = 'The Philosophers Stone' AND  p.pid = m.memberid AND  m.memberid = bb.mid AND bb.bid = b.bookid AND b.Title = pb.title );

---------------------------------------------------
--Part F
--10. List all the details of books issued after the most current employee was hired.
---------------------------------------------------


--get all employees from library
create view startDate as
select e.employeeid, Fname, Lname, date_of_birth,enrollmentdate, street, city, zip, cell_PhoneNumber, home_Phone_Number, gender
from person p, employee e
where p.pid = e.employeeid;


--this gets the most recent employee hired. The output is
--01/01/2020
create view startDateFinal as
select enrollmentdate 
from startdate
order by TO_DATE(enrollmentdate,'MMDDYYYY') desc
fetch first 1 rows only;


--the date the most recent employee was hired was: 01/01/2020
--we output the books that were borrowed after that.
select b.bookid, b.title,b.pubid, b.classt, bt.duedate, bt.returneddate, bt.borrowedDate
from books b, booktrans bt, startDateFinal sd
where b.bookid = bt.bid 
    and 
    (TO_DATE(sd.enrollmentdate,'MMDDYYYY') < TO_DATE(bt.borroweddate,'MMDDYYYY'));

---------------------------------------------------
--Part F
--11. List all the employees that have enrolled into Gold membership within a
--month of being employed.
---------------------------------------------------
select e.employeeid, p.fname, p.lname
from person p, employee e, member m, mem_type mt
where ( p.pid = e.employeeid and e.employeeid = m.memberid and m.memberid = mt.memid )
        and
        (member_type = 'Gold')
        and 
        (TO_DATE(p.enrollmentdate,'MMDDYYYY') > SYSDATE -30);
--this will output an empty table because there are no values that satisfy this.

---------------------------------------------------
--Part F
--12. Find the total amount of late fee paid in each month, for the last 3 months.
---------------------------------------------------

SELECT count(fee) as totalfees
FROM toplate
where fee = 'late';

---------------------------------------------------
--Part F
--13. Find the name of members who have been a silver member for over 5 years.
---------------------------------------------------
select p.fname, p.lname
from person p, member m, mem_type mt
where (p.pid = m.memberid and m.memberid = mt.memid and mt.member_type = 'Silver')
    and
        (TO_DATE(p.enrollmentdate,'MMDDYYYY') < SYSDATE - 1825 );--MMDDYYYY format for 


---------------------------------------------------
--Part F
--14. Find the names and number of books borrowed by the potential gold members
--in the last year.
---------------------------------------------------

select * from potentialgold;

create view booksBorrowed as
select pg.fname, pg.lname, b.title, b.bookid  
from potentialgold pg, person p, member m, borrowedbookdetails bb, booktrans bt, books b
where ( p.pid = pg.pid and p.pid = m.memberid and m.memberid = bb.mid and bb.bid = bt.bid and bb.bid = b.bookid  );

select fname, lname, title,
    COUNT(bookid) as bcount
from booksborrowed
group by fname, lname, title order by bcount;


---------------------------------------------------
--Practice delete all of this
--------------------------------------------------

--LIKE. We will find the books who title starts with O
select * 
from books
where title like 'O%';


---IS NULL. You cannot use =,<,> for null you need to 
--specifically check for null.
select *
from booktrans
where returneddate is null;

select *
from booktrans
where returneddate is not null;

----UNION. Returns all values in both tables.

--This will select all books with the authors name, where fname is either mark or scott
(select b.title, p.fname , p.lname
from books b, written w, author a, person p
where (b.bookid = w.bid and w.aid = a.authorid and a.authorid = p.pid)
    and
        p.fname = 'Mark')
union 
(select b.title, p.fname , p.lname
from books b, written w, author a, person p
where (b.bookid = w.bid and w.aid = a.authorid and a.authorid = p.pid)
    and
        p.fname = 'Scott');

--this is doing the exact same thing without a union..
select b.title, p.fname , p.lname
from books b, written w, author a, person p
where (b.bookid = w.bid and w.aid = a.authorid and a.authorid = p.pid)
    and
        (p.fname = 'Mark' or p.fname = 'Scott');

--UNION of different groups
--this table will get all information from employees or authors.
(select *
from employee e, person p
where e.employeeid = p.pid)
union
(select *
from author a, person p
where a.authorid = p.pid);


--INTERSECT. Returns all values that exactly the same in both tables.
--selecting all library members who are employees at the library
(select member.memberid 
from member)
intersect
(select employee.employeeid
from employee);

--NATURAL JOIN
--Joins attributes with same name and eliminates one of them from the result 
--MUST HAVE ATTRIBUTES WITH SAME NAME, does not work otherwise!!!!!!

--These two tables have 3 attributes that are same.
--It will only keep 3 of them on the output.
select *
from borrowedbookdetails natural join booktrans;

--This is joining attributes with same name 
--without using natural join.
--These two tables have 3 attributes that are same in both tables
--It will output them twice.
select *
from borrowedbookdetails bb, booktrans bt
where bb.bid = bt.bid and bb.eid = bt.eid and bb.mid = bt.mid;

--SOLUTION TO NATURAL JOIN WITH DIFFERENT ATTRIBUTE NAME
--When the attributes do not have same name but do same values
--You can rename the attribute from table and use natural join.
select * 
from employee e, emp_type et
where e.employeeid = et.empid;

select *
from employee e natural join 
    (select empid as employeeid,employee_type
    from emp_type) et;


--GROUP BY
--Group can only be used with attribute x, no other atributes
--and aggregate function on x
--and it can group by x.
-- This is optional but helps better interpret query
--ordered by aggregate function of x.

--this query will get the title and the # of time it appears
--not in order.
select title, count(title) as numOfTimes
from books
group by title;

--We will order by highest value and get
--first n rows specified.
select title, count(title) as numOfTimes
from books 
group by title order by numOfTimes desc
fetch first 3 rows only;

--Subqueries

--Return person who are receptionists
select p.fname, p.lname, p.pid
from person p
where p.pid = (select et.empid
                from emp_type et
                where et.employee_type = 'Receptionist');
                
                
--Output all books info and their fees
select bookid, b.title, f.fee 
from books b natural join (
                        select f.bfid as bookid, f.fee
                        from fee f
                        ) f;
--same query just shorter.
select bookid, b.title, f.fee 
from books b, fee f
where b.bookid = f.bfid;

--return books with same name
select b1.bookid, b1.title --* ---will give you duplicates
from books b1, books b2
where b1.title = b2.title and b1.bookid != b2.bookid;--we want to get same title but different book id
