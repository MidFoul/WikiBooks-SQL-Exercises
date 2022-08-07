------targil bait 2
-----SQR SERVER ****
----1
-----a

drop table Manufacturers
use [CourseDegree]
CREATE TABLE Manufacturers (
    Code int PRIMARY KEY NOT NULL,
    [Name] varchar(255)
);


drop table Products
CREATE TABLE Products (
    Code int PRIMARY KEY NOT NULL,
    [Name] varchar(255),
	Price real,
	Manufacturer int FOREIGN KEY REFERENCES Manufacturers(Code)
);

-----a


----b
truncate table products

INSERT INTO Products (Code, [Name], Price, Manufacturer)
Values (1, 'Hard drive', 240, 5),
	   (2, 'Memory', 120, 6),
	   (3, 'Zip drive', 150, 4),
	   (4, 'Floppy disk', 5, 6),
	   (5, 'Monitor', 240, 1),
	   (6, 'DVD drive', 180, 2),
	   (7, 'CD drive', 90, 2),
	   (8, 'Printer', 270, 3),
	   (9, 'Toner Cartage', 66, 3),
	   (10, 'DVD vurner', 180, 2)


	
INSERT INTO Manufacturers (Code, [Name])
Values (1, 'Sony'),
	   (2, 'Creative Labs'),
	   (3, 'Hewlett-Packard'),
	   (4, 'lomega'),
	   (5, 'Fujitsu'),
	   (6, 'Winchester')

----b



----c
select [Name]
from Products

----d 
select [Name], Price
from Products

---e
select [Name], Price
from Products
where price <=200

----f
select [Name], Price
from Products
where price between 60 and 120

----g
select name, concat(price*100, 'cents') as [price in cents] 
from products;

----h
select avg(price) as [avg]
from products;



----i
select avg(price) as [avg]
from products where  Manufacturer = 2;


----j
select [name], price 
from products 
where price>=180 order by price desc, name asc;
----k
select a.*, b.[name] 
from products a join Manufacturers b 
on a.manufacturer = b.code;
----l
select a.name, a.price, b.name 
from products a join Manufacturers b 
on a.manufacturer = b.code;
----m
SELECT AVG(Price) as [avg], Manufacturer
FROM Products
GROUP BY Manufacturer;
---n
select avg(a.price) as [avg], b.name 
from Products a join Manufacturers b 
on a.manufacturer = b.code
group by b.name;
---o
select avg(a.price) as [avg], b.name 
from Manufacturers b join Products a 
on b.code = a.Manufacturer
group by b.name
having avg(a.price)>=150;
----p
select name, price from Products 
where price = (select min(price)from products);
----q
 SELECT A.Name, A.Price, F.Name
   FROM Products A, Manufacturers F
   WHERE A.Manufacturer = F.Code
     AND A.Price =
     (
       SELECT MAX(A.Price)
         FROM Products A
         WHERE A.Manufacturer = F.Code
     )

----r
select *
from(
Select m.Name, Avg(p.price) as p_price, COUNT(p.Manufacturer) as m_count
FROM Manufacturers m, Products p
WHERE p.Manufacturer = m.code
GROUP BY p.Manufacturer, price, m.Name
)a
where p_price >= 150 and m_count >= 2


----s
insert into Products values (11, 'Loudspeakers', 70, 2);
----t
update products
set name = 'Laser Printer'
where code=8;
----u
update products
set price=price*0.9;
-----v
update products
set price = price * 0.9
where price >= 120; 





-----2
----a

 CREATE TABLE Departments (
   Code INTEGER PRIMARY KEY NOT NULL,
   [Name] VARCHAR (255) NOT NULL ,
   Budget REAL NOT NULL 
 );
 

 CREATE TABLE Employees (
   SSN INTEGER PRIMARY KEY NOT NULL,
   [Name] TEXT NOT NULL ,
   LastName VARCHAR (255) NOT NULL ,
   Department INTEGER NOT NULL , 
   CONSTRAINT fk_Departments_Code FOREIGN KEY(Department) 
   REFERENCES Departments(Code)
 );


---b
INSERT INTO Departments(Code,[Name],Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','O''Donnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);


---c
SELECT LastName 
FROM Employees;


---d.
SELECT DISTINCT LastName 
FROM Employees;
---e.
SELECT * 
FROM Employees 
WHERE LastName = 'Smith';
---f.
SELECT * 
FROM Employees
WHERE LastName IN ('Smith' , 'Doe');
--g.
SELECT * 
FROM Employees 
WHERE Department = 14;
--h.
SELECT * 
FROM Employees
WHERE Department IN (37,77);
--i.
SELECT * FROM Employees
WHERE LastName LIKE 'S%';
--j.
SELECT SUM(Budget) 
FROM Departments;
--k.
SELECT Department, COUNT(*)
FROM Employees
GROUP BY Department;
--l.
SELECT *
FROM Employees E INNER JOIN Departments D
ON E.Department = D.Code;
--m.
SELECT E.Name, LastName, D.Name AS DepartmentsName, Budget
FROM Employees E INNER JOIN Departments D
ON E.Department = D.Code;
--n.
SELECT Name, LastName FROM Employees
WHERE Department IN
(SELECT Code FROM Departments WHERE Budget > 60000);
--o.
SELECT *
FROM Departments
WHERE Budget >
(
    SELECT AVG(Budget)
    FROM Departments
  );
--p.
SELECT D.Name FROM Departments D
WHERE 2 < 
(
   SELECT COUNT(*) 
     FROM Employees
     WHERE Department = D.Code
);
--q.
SELECT Name, LastName 
FROM Employees 
WHERE Department IN (
  SELECT Code 
  FROM Departments 
  WHERE Budget = (
    SELECT TOP 1 Budget 
    FROM Departments 
    WHERE Budget IN (
      SELECT DISTINCT TOP 2 Budget 
      FROM Departments 
     ORDER BY Budget ASC
    ) 
    ORDER BY Budget DESC
  ))
--r. 
INSERT INTO Departments
VALUES ( 11 , 'Quality Assurance' , 40000);
--s.
INSERT INTO Employees
VALUES ( '847219811' , 'Mary' , 'Moore' , 11);
--t.
UPDATE Departments SET Budget = Budget * 0.9;
--u.
UPDATE Employees SET Department = 14 WHERE Department = 77;
--v.
DELETE FROM Employees WHERE Department = 14;
--w.
DELETE FROM Employees
  WHERE Department IN
  (
    SELECT Code FROM Departments
      WHERE Budget >= 60000
  );
--x.	
DELETE FROM Employees;





----Q3

---a

 CREATE TABLE Pieces (
  Code INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL
  );


 CREATE TABLE Providers (
  Code VARCHAR(40) 
  PRIMARY KEY NOT NULL,  
  Name TEXT NOT NULL 
  );

 CREATE TABLE Provides (
  Piece INTEGER, 
  FOREIGN KEY (Piece) REFERENCES Pieces(Code),
  Provider VARCHAR(40), 
  FOREIGN KEY (Provider) REFERENCES Providers(Code),  
  Price INTEGER NOT NULL,
  PRIMARY KEY(Piece, Provider) 
  );
----b

 INSERT INTO Providers(Code, Name) VALUES('HAL','Clarke Enterprises');
 INSERT INTO Providers(Code, Name) VALUES('RBT','Susan Calvin Corp.');
 INSERT INTO Providers(Code, Name) VALUES('TNBC','Skellington Supplies');
 


 INSERT INTO Pieces(Code, Name) VALUES(1,'Sprocket');
 INSERT INTO Pieces(Code, Name) VALUES(2,'Screw');
 INSERT INTO Pieces(Code, Name) VALUES(3,'Nut');
 INSERT INTO Pieces(Code, Name) VALUES(4,'Bolt');
 

 INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'HAL',10);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'RBT',15);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'HAL',20);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'RBT',15);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'TNBC',14);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'RBT',50);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'TNBC',45);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'HAL',5);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'RBT',7);


--c.
 SELECT Name FROM Pieces;
--d.
 SELECT * FROM Providers;
--e.
SELECT Piece, AVG(Price)
FROM Provides
GROUP BY Piece;
--f
SELECT Name
FROM Providers 
WHERE Code IN
(SELECT Provider FROM Provides WHERE Piece = 1);
--g.
 SELECT Pieces.Name
   FROM Pieces INNER JOIN Provides
   ON Pieces.Code = Provides.Piece
     AND Provides.Provider = 'HAL';
--h.
 SELECT Pieces.Name, Providers.Name, Price
   FROM Pieces INNER JOIN Provides ON Pieces.Code = Piece
               INNER JOIN Providers ON Providers.Code = Provider
   WHERE Price =
   (
     SELECT MAX(Price) FROM Provides
     WHERE Piece = Pieces.Code
   );
--i.
INSERT INTO Provides 
  VALUES (1, 'TNBC', 7);
--j.
 UPDATE Provides SET Price = Price + 1;
--k.
 DELETE FROM Provides
   WHERE Provider = 'RBT'
     AND Piece = 4;
--l.
 DELETE FROM Provides
   WHERE Provider = 'RBT';







   ----Q4
   ----A
  create table Scientists (
  SSN int,
  Name Char(30) not null,
  Primary Key (SSN)
);

Create table Projects (
  Code Char(4),
  Name Char(50) not null,
  Hours int,
  Primary Key (Code)
);
	
create table AssignedTo (
  Scientist int not null,
  Project char(4) not null,
  Primary Key (Scientist, Project),
  Foreign Key (Scientist) references Scientists (SSN),
  Foreign Key (Project) references Projects (Code)
);


-----B
 INSERT INTO Scientists(SSN,Name) 
  VALUES(123234877,'Michael Rogers'),
    (152934485,'Anand Manikutty'),
    (222364883, 'Carol Smith'),
    (326587417,'Joe Stevens'),
    (332154719,'Mary-Anne Foster'),	
    (332569843,'George ODonnell'),
    (546523478,'John Doe'),
    (631231482,'David Smith'),
    (654873219,'Zacary Efron'),
    (745685214,'Eric Goldsmith'),
    (845657245,'Elizabeth Doe'),
    (845657246,'Kumar Swamy');

 INSERT INTO Projects ( Code,Name,Hours)
 VALUES ('AeH1','Winds: Studying Bernoullis Principle', 156),
       ('AeH2','Aerodynamics and Bridge Design',189),
       ('AeH3','Aerodynamics and Gas Mileage', 256),
       ('AeH4','Aerodynamics and Ice Hockey', 789),
       ('AeH5','Aerodynamics of a Football', 98),
       ('AeH6','Aerodynamics of Air Hockey',89),
       ('Ast1','A Matter of Time',112),
       ('Ast2','A Puzzling Parallax', 299),
       ('Ast3','Build Your Own Telescope', 6546),
       ('Bte1','Juicy: Extracting Apple Juice with Pectinase', 321),
       ('Bte2','A Magnetic Primer Designer', 9684),
       ('Bte3','Bacterial Transformation Efficiency', 321),
       ('Che1','A Silver-Cleaning Battery', 545),
       ('Che2','A Soluble Separation Solution', 778);

 INSERT INTO AssignedTo ( Scientist, Project)
   VALUES (123234877,'AeH1'),
    (152934485,'AeH3'),
    (222364883,'Ast3'),	   
    (326587417,'Ast3'),
    (332154719,'Bte1'),
    (546523478,'Che1'),
    (631231482,'Ast3'),
    (654873219,'Che1'),
    (745685214,'AeH3'),
    (845657245,'Ast1'),
    (845657246,'Ast2'),
    (332569843,'AeH4');

--c.	List all the scientists' names, their projects' names, and the hours worked by that scientist on each project, in alphabetical order of project name, then scientist name.
SELECT   S.Name, P.Name, P.Hours
FROM     Scientists S 
         INNER JOIN AssignedTo A ON S.SSN=A.Scientist
         INNER JOIN Projects P ON A.Project=P.Code
ORDER BY P.Name ASC, S.Name ASC;
--d.	Select the project names which are not assigned yet
select *
from Projects left join AssignedTo 
on Projects.Code = AssignedTo.Project
where Scientist is null

