-- show databases;
-- create database BankingDB;
-- USE bankingdb;
CREATE TABLE Customers(
	CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email varchar(100),
    Phone varchar(15),
    AccountCreationDate date
);

create table Accounts(
	AccountID int,
    AccountType varchar(20),
    Balance decimal(10,2)
);

-- to check the table structure
-- desc Accounts;

create table Transactions(
	TransactionID INT,
    TransactionDate DATE,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(20)
);
-- desc transactions;

create table Branches(
	BranchId int,
    BranchName varchar(100),
    BranchAddress varchar(200),
    BranchPhone varchar(15)
);
-- desc branches;

create table AccountBranches(
	AssignmentDate DATE
);

create table Loans(
	LoanId int,
    LoanAmount decimal(10,2),
    InterestRate decimal(5,2),
    StartDate date,
    EndDate date
);

ALTER TABLE Customers
add DateOfBirth DATE;

desc customers;

alter table customers
modify Phone varchar(20);

alter table accounts
add constraint chk_MinBalance
check (Balance >= 1000);

drop table accountbranches;

alter table accounts
add	CustomerID int;

alter table accounts
add constraint FK_Accounts_Customers
foreign key (CustomerID)
references customers(customerID);

alter table accounts
add constraint
primary key (AccountID);

desc accounts;

alter table customers
modify FirstName varchar(50) NOT null;


alter table customers
add constraint uni_email
unique (email);

desc customers;

alter table branches
add constraint pk_branchID
primary key (BranchID);
desc branches;

alter table accounts
add BranchID int;

alter table accounts
add constraint fk_branch_customer
foreign key (BranchID)
references branches(BranchID);

alter table transactions
add AccountID int;

alter table transactions
add constraint PK_transaction
primary key (TransactionID);

alter table transactions
add constraint fk_transaction_accounts
foreign key (accountID)
references accounts(accountID);


-- loans connect with customer

alter table loans
add constraint PK_LoanID
primary key (loanID);

-- drop
alter table loans
drop constraint FK_Loans_Customers;

alter table loans
add customerID int primary key;
desc loans;


alter table loans
add constraint FK_Loans_Customers
foreign key (customerID)
references customers (customerID);

select
	constraint_name,
    constraint_type
from	information_schema.table_constraints
where table_schema = 'bankingdb'
and	table_name = 'branches';

-- by using this Primary Key,Foreign Keys,Constraint names,Data types,Indexes can find 
show create table accounts;

-- in one table change one primary to another table 
-- first need to drop the fk key then pk
ALTER TABLE loans
DROP FOREIGN KEY FK_Loans_Customers;
alter table loans
drop primary key;

-- adding fk in the loans table 
alter table loans
add constraint FK_Loans_Customers
foreign key (customerID)
references customers (customerID);

-- adding pk in the loan table 
alter table loans
add constraint pk_LoanId
primary key (LoanId);

alter table customers
drop AccountCreationDate;

alter table customers
add AccountCreationDate date;

-- DML  Commands

select * from customers;
insert into customers
values(101,'Rahul', 'Sharma' , 'rahul@gmail.com', '9898989090','1998-04-15');

select * from accounts;
insert into accounts
(AccountID, CustomerID, AccountType,Balance)
values(201,101,'Savings','25000');

select * from customers;
insert into customers
values(102,'Ketan','Tiwari','ketan@gmail.com','8908098894','2000-02-22','2026-08-04');

insert into customers
(customerID,FirstName,LastName,Email,Phone,DateOfBirth,AccountCreationDate)
value
(103,'Ratan','Bhandari','ratan@gmail.com','7908098894','2000-04-22','2026-08-04'),
(104,'Amir','Rehadiya','amir@gmail.com','8908098894','2003-04-22','2026-08-04');

select * from customers;
select * from accounts;
-- to update values
update customers
set AccountCreationDate = '2025-04-23'
where customerID =101;


    -- 3 branch 5 entry
select * from branches;

insert into branches
(BranchId , BranchName , BranchAddress , BranchPhone)
values 
(01,'Nagpur Main Branch','12 Central Avenue , Sitabuldi','0712-2567890'),
(02,'Dharampeth Branch','45 West High Court Road, Dharampeth','0712-2567891'),
(03,'Pune Camp Branch','101 MG Road, Camp Area','020-26784567');

update accounts
set BranchID = '01'
where AccountID = '201';

insert into accounts
(AccountID,AccountType,Balance,CustomerID,BranchID)
values
(202,'Current',100000,'102','02'),
(203,'Saving',50000,'103','03');

insert into accounts
(AccountID,AccountType,Balance,CustomerID,BranchID)
values
(204,'Current',15000,'103','01'),
(205,'Saving',4500,'104','03');

insert into loans
(LoanId,LoanAmount,InterestRate,StartDate,EndDate,CustomerID)
values
(01,'50000',8.25,'2026-04-12','2027-04-12','101'),
(02,'56000',9.25,'2026-04-23','2028-04-23','102'),
(03,'100000',10.12,'2026-01-20','2028-01-20','103'),
(04,'200000',9.5,'2026-04-01','2028-04-01','104');

insert into transactions
(TransactionID,transactionDate,amount,transactionType,AccountID)
values
(1,'2026-04-05','5000','Credit',201),
(2,'2026-04-05','4000','Debit',202),
(3,'2026-04-05','50300','Credit',203),
(4,'2026-04-05','2000','Debit',204);


select * from accounts;
select * from loans;
select * from transactions;
select * from branches;
select * from customers;

delete from accounts
where AccountID = 204;

show create table branches;

-- github
update loans
set CustomerID = '101'
where loanID = 3001;

update loans
set CustomerID = '102'
where loanID = 3002;

update loans
set CustomerID = '103'
where loanID = 3003;

DELETE FROM loans
WHERE LoanID = 3004;

-- class work
UPDATE accounts 
SET 
    balance = balance + 5000
WHERE
    accountID = 202;

update accounts
set balance = '30000'
where accountID = 201;

UPDATE customers 
SET 
    email = 'ritesh.ramteke@gmail.com',
    phone = '8055694102'
WHERE
    customerID = 101;
    
SELECT 
    customerID,FirstName, LastName, Phone
FROM
    customers;
    
SELECT 
    *
FROM
    accounts
WHERE
    AccountType = 'Saving';
    
SELECT 
    *
FROM
    accounts
WHERE
    balance <=30000 ;
    
insert into branches
values (4, 'sadar Branch', 'Medical Square ' , 8408819296);
 insert into accounts
 values (204, 'Current' ,25000, 104, 4);
 select * from branches;
 
 select * from accounts 
 where AccountType != 'saving';
 
 select * from accounts 
 where not AccountType = 'saving';
 
 update accounts
 set AccountType = 'saving'
 where AccountID =201;
 
 select * from accounts
 where Balance >=30000 and AccountType = 'Saving' ; 
 
 select * from accounts
 where Balance >=30000 && AccountType = 'Saving' ; 
 
 -- find all customer registered after 1 july 2026
 select * from customers
 where AccountCreationDate > ' 2026-07-01';
 
 select FirstName ,LastName,AccountCreationDate
 from customers
 where AccountCreationDate > '2026-07-01';
 
 select * from customers
 where Phone in ('8055694102','8908098894');

 

select FirstName,LastName,phone 
from customers
where Phone ='8055694102' or Phone = '8908098894';

-- between  operator
-- find customer  balance 10k to 25k 
select * from accounts;
select customerid , accounttype,balance
from accounts
where Balance between 10000 and 30000;

select customerid , accounttype,balance
from accounts
where Balance >=10000 and Balance <=30000;

-- like operator  
-- find all customer whose values name start with r 
-- matches any number of character , evene  zero character
select * from customers
where FirstName like 'r%';

-- all the customer whose lastname end with later a 
select * from customers
where LastName like '%a';

select * from customers
where LastName like '%a%';

-- "_" matches exactly one character
-- find all customers whose last name has exactly 3 character 
select * from customers
where LastName like '___';

-- ODERED BY 
-- sort the accounts table according to the customers balance

select AccountID,Balance 
from accounts 
order by balance;

-- sort the branches table according to the branch name
select BranchID , BranchName
from branches
order by BranchName;

-- sort the accounts table according to the customers balance
-- from highest to lowest

select customerID,Balance 
from accounts 
order by balance desc;

-- sort according to multiple coloumn
-- sort acctype and balance in descending oder
select AccountType,Balance
from accounts
order by AccountType desc, Balance desc;

-- DISTINCT CLAUSE
-- FIND distinct (unique) accoubt type from account table 

select distinct AccountType
from accounts;
-- FIND distinct (unique) transactionType AccountID
select distinct TransactionType, AccountID from transactions;

-- limit and offset

select * from customers
limit 2 offset 2;

-- top 2 customer with highest balance 
select * from accounts
order by Balance desc
limit 2 ;

select * from accounts
order by Balance desc
limit 1 offset 2;

select * from accounts
order by Balance desc
limit 2,1;  -- here 2 specifies the rows to skip and 1 specifies the number of rows to return

-- 	NULL / NOT NULL

insert into customers
(CustomerID,FirstName,LastName, Email,Phone,DateOfBirth,AccountCreationDate)
values
(105,'Suhas','Borkar','suhas@gmail.com',null,'2003-02-22','2026-05-05'),
(106,'Pranit','Kamble','pranit@gmail.com',null,'2000-02-12','2026-01-05'),
(107,'Sahil','Kadu','sahil@gmail.com',null,'2004-02-22','2026-03-05'),
(108,'Ayush','Sharma','ayush@gmail.com','9645254102','2003-12-22','2026-05-12'),
(109,'Aniket','Borkar','aniket@gmail.com',null,'2006-02-22','2026-01-30');

select * from customers
where phone is null;

select * from customers
where phone is not null;

insert into accounts
(AccountID,AccountType,Balance,CustomerID,BranchID)
values
(206,'saving',45000,105,1),
(207,'current',75000,106,2),
(208,'saving',45000,107,1),
(209,'current',34000,108,3),
(210,'current',120000,109,3);

insert into transactions
(transactionID,transactionDate,Amount,transactionType,AccountID)
values
(5,'2026-06-25',6000,'Credit',205),
(6,'2026-06-26',7000,'Debit',206),
(7,'2026-06-25',40000,'Credit',207),
(8,'2026-05-25',3000,'Debit',208),
(9,'2026-06-25',6000,'Credit',209);

insert into loans
(LoanId,LoanAmount,InterestRate,StartDate,EndDate,CustomerID)
values
(5,45000,9.15,'2026-01-01','2027-01-01',105),
(6,30000,8.15,'2025-02-01','2027-02-01',106),
(7,70000,7.15,'2026-03-01','2027-03-01',107),
(8,80000,8.15,'2026-04-22','2027-04-22',108);


-- case 40> high value cust , < low value cust , cust categeory

SELECT 
    AccountID,
    AccountType,
    Balance,
    CASE
        WHEN Balance >= 50000 THEN 'High Value Customer'
        ELSE 'Low Value Customer'
    END AS CustomerCategory
FROM accounts;
	
	
-- Categorize the deposite in the transaction table as per condition given
-- if above 10000(included) High Amount
-- if 5000 (included ) to 10000 medium amount
-- if upto 5000 low amount 
-- for transaction type withdrawal "Not Applicable"
-- credited means Deposite, debit means withdrawal
select *,
    case
		when TransactionType ='credit' and Amount >= 10000 then 'High Amount'
        when TransactionType ='credit' and Amount >=5000 then 'Medium Amount'
        when TransactionType ='credit' and Amount < 5000 then "Low Amount"
        else "Not Applicable"
	end as TransactionCategeory
from transactions;

select CustomerID ,upper(FirstName), upper(LastName)
from customers;

select CustomerID ,lower(FirstName), lower(LastName)
from customers;

select lastname , length(lastname) from customers;

select length("Nagpur") as bytes;  -- gives o/p in number of bytes
select length("नागपूर");		 -- gives o/p in number of bytes
select char_length("नागपूर");		-- gives o/p in number of characters
select char_length("Nagpur");  -- gives o/p in number of characters


select CustomerID , concat(FirstName," ",LastName) as Full_Name , phone
from customers;

select substring("hello world",7,5);

-- r.sharma
select CustomerID , concat(substring(firstname,1,1),".",substring(lastname,1)) as Full_Name , phone from customers;

-- Trim() function , by using without trim and then by using  trim
select length("   hello World   ");
select length(trim("   Hello World  ")); 
select length(trim(substring("Hello World",6)));

-- Replace Function
select replace("Mat mat Mat","M","C");

-- math function

-- round function , avg function 
select round(avg(Balance),2) from accounts
where AccountType ='Saving';

-- ceil function  , round up
select ceiling((avg(Balance))) from accounts
where AccountType ='current';

-- floor function , round down
select floor((avg(Balance))) from accounts
where AccountType ='Current';

select avg(amount) as AvgDeposit from transactions
where transactionType = 'Debit';

-- absolute it remove the sign (-, +)
select abs(-344);

-- mod , it return the remainder after the division

select mod (7,3);  -- return the remainder
select (7/3);  -- return the quitient

-- power ()
select power(2,3);
select power(1.5,3);

-- SQT ()
select sqrt(232);

-- Date function 
-- Now Function -- return the current date and time
select now();    -- return date and time
select curdate();   -- return current date
select curtime();	-- return cur time

-- YEAR() MONTH() DAY()
select year(dateofbirth),month(dateofbirth),day(dateofbirth) from customers;

-- Datediff () function  -- it return thee number dayss between two dates

select concat(FirstName," ",LastName) as Full_name ,DateOfBirth,
floor(datediff(curdate(),DateofBirth )/365) as age
from customers;



select concat(FirstName," ",LastName) as Full_name ,DateOfBirth,
timestampdiff(year,DateofBirth,curdate() ) as age
from customers;

-- Date_add function ,
select concat(FirstName," ",LastName) as Full_name  , accountcreationdate,
date_add(accountcreationdate, interval 1 year) as KYCRenewal from customers;

-- date sub function
select date_sub(curdate(), interval 7 day);

-- count function
select * from customers; 
select count(*) as Total_Customers from customers;			-- it count the number of rows with including the null value
select count(phone) as Total_Customers from customers;  -- it count the only not null value

-- sum() function
select sum(Balance) as TotalBalance from accounts;
select sum(balance) as SavingsTotal from accounts
where AccountType = 'saving' ;

-- avg function
select avg(amount) from transactions;
select floor(avg(amount)) as TotalDepositeTransaction from transactions
where TransactionType = 'Credit';

select avg(amount) as AverageDebitTransaction from transactions
where TransactionType = 'debit';

-- max() and min() function 

select max(Balance) from accounts;
-- find maximum balance in saving account
select max(Balance) from accounts
where AccountType = 'saving';

-- find min balance in saving account
select min(Balance) from accounts;
select min(Balance) from accounts
where AccountType = 'saving';

-- GROUP BY
select transactiontype ,sum(amount) from transactions
group by (TransactionType);

select * from accounts;
-- account type , out 3 culmn , count account 
select AccountType , 
		count(*), 
        sum(Balance) , 
        avg(Balance) 
from accounts
group by (AccountType);

-- find total accounts for branch and account type
select BranchID,AccountType,
        count(*) as NoOfAccounts
	from accounts
    group by BranchID,AccountType
    order by BranchID;
    


-- having    ----> it  filter the groups  -- it  works after group by
select BranchID,AccountType,
        count(*) as NoOfAccounts
	from accounts
    group by BranchID,AccountType
    having noOfAccounts >= 2 and AccountType = 'saving';


-- how many accounts open in specific year
SELECT 
    YEAR(AccountCreationDate) AS Years,
    COUNT(*) AS Total_Account
FROM
    customers
GROUP BY Years
order by years;


-- inner join 
-- find all customers having loans with their names ,  first name last name , 
-- interest rate and loan amount

select c.CustomerID, c.firstname , c.lastname , l.interestrate, l.loanAmount 
from customers c 
inner join loans l 
on c.CustomerID = l.customerID;

-- find the branch names for all the accountid 
-- include accountid , accounttype and branchname , branchaddress.

select a.AccountID , a.AccountType , b.branchname , b. branchaddress 
from accounts a 
inner join branches b
on a.BranchID = b.BranchId
where AccountType ='saving';

-- find all the customers( name , phone , Accounttype , balance)  where account type is saving 
select c.firstname ,c.phone , a.AccountType , a.Balance
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
where AccountType = 'saving';


select concat(c.firstname ," ", c.lastname) as Full_Name,c.phone , a.AccountType , a.Balance
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
where AccountType = 'saving';

-- insert values into the customer
insert into customers 
(CustomerID,FirstName,LastName,Email,Phone,DateOfBirth,AccountCreationDate)
values 
(110,'Pranay','Wath','pranay@gmail.com','7789568997','1995-02-12','2015-06-23'),
(111,'Prakash','Bhat','prakash@gmail.com','9089568997','2000-02-12','2020-06-23'),
(112,'Rehman','Khan','rehman@gmail.com','8778568997','2002-09-14','2026-06-23');

-- left join
-- firstname , lastname,phone,accounttype and balance
select c.firstname , c.lastname,c.phone, a.AccountType, a.Balance
from customers c
left join accounts a
on c.CustomerID =a.CustomerID;

-- from accounts left join customers
select c.firstname , c.lastname,c.phone, a.AccountType, a.Balance
from  accounts a
left join customers c
on c.CustomerID =a.CustomerID;
	
-- right join 
insert into branches
(BranchID,BranchName,BranchAddress,BranchPhone)
values
(5,"Mumbai Branch" ,"Andheri Mumabai",'9089899898'),
(6,"Nashik Branch" ,"near the tahsil office",'9956899898');

insert into accounts
(AccountID,AccountType,Balance,CustomerID,BranchID)
values
(211,'saving',65789,110,3),
(212,'current',70789,111,5);

insert into transactions
(TransactionID,TransactionDate,Amount,TransactionType,AccountID)
values
(10,'2026-04-11',55000,'Credit',201),
(11,'2024-02-11',60000,'Debit',202),
(12,'2025-12-19',15000,'Credit',203),
(13,'2026-08-11',40000,'Debit',204),
(14,'2026-05-11',57000,'Credit',205),
(15,'2026-03-23',4000,'Debit',206),
(16,'2026-05-11',1000,'Credit',207),
(17,'2024-10-11',5000,'Credit',208),
(18,'2026-01-30',8000,'Debit',209),
(19,'2026-04-11',55000,'Debit',203),
(20,'2025-12-11',2000,'Credit',201);


insert into transactions
(TransactionID,TransactionDate,Amount,TransactionType,AccountID)
values
(21,'2026-10-11',15000,'Debit',208),
(22,'2026-10-11',5000,'Credit',209);


-- entry accounts 2 
insert into accounts
(AccountID,AccountType,Balance,CustomerID,BranchID)
values
(213,'current',40000,101,1),
(214,'saving',4000,102,2);

-- inner join 
select concat(c.firstname," " ,c.lastname) as Full_Name , a.accountID ,a.accounttype,a.balance
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID;

select c.CustomerID, concat_ws(" ",c.firstname,c.lastname) as Full_Name , a.accountID ,a.accounttype,a.balance
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
order by c.CustomerID;


-- full outer join 
-- joining customers and accounts 

select * from customers c
left join accounts a 
on c.CustomerID = a.CustomerID
union
select * from customers c
right join accounts a 
on c.CustomerID = a.CustomerID;

-- cross join 

--  self join

create table Employees (
	EmployeeID int primary key,
    EmployeeName varchar(50) not null,
    ManagerID int,
    Department varchar(50),
    Salary DECIMAL(10,2),
    joiningDate DATE,
    BranchID INT ,
    
    foreign key ( managerID)
    references Employees(EmployeeID),
    
    foreign key (branchID)
    references Branches(BranchID)
);

INSERT INTO Employees
    (EmployeeID, EmployeeName, ManagerID, Department, Salary, JoiningDate, BranchID)
VALUES
    (1, 'Rajesh Sharma', NULL, 'Management', 120000.00, '2018-04-15', 1),
    (2, 'Priya Patel', 1, 'Human Resources', 75000.00, '2019-06-10', 2),
    (3, 'Amit Kumar', 1, 'Finance', 82000.00, '2020-01-20', 3),
    (4, 'Sneha Verma', 1, 'IT', 95000.00, '2019-09-05', 4),
    (5, 'Rahul Singh', 1, 'Sales', 78000.00, '2021-03-12', 5),
    (6, 'Neha Joshi', 2, 'Human Resources', 55000.00, '2021-07-19', 1),
    (7, 'Vikas Gupta', 2, 'Human Resources', 52000.00, '2022-02-14', 2),
    (8, 'Pooja Mehta', 3, 'Finance', 60000.00, '2021-11-08', 3),
    (9, 'Suresh Yadav', 3, 'Finance', 58000.00, '2022-05-16', 4),
    (10, 'Anjali Deshmukh', 4, 'IT', 72000.00, '2020-08-24', 5),
    (11, 'Rohan Kulkarni', 4, 'IT', 68000.00, '2021-10-11', 1),
    (12, 'Kavita Rao', 4, 'IT', 65000.00, '2022-01-17', 2),
    (13, 'Arjun Malhotra', 5, 'Sales', 57000.00, '2022-06-20', 3),
    (14, 'Meena Shah', 5, 'Sales', 59000.00, '2021-12-06', 4),
    (15, 'Deepak Thakur', 5, 'Sales', 54000.00, '2023-01-09', 5),
    (16, 'Nitin Pawar', 6, 'Human Resources', 42000.00, '2023-04-18', 1),
    (17, 'Swati Mishra', 7, 'Human Resources', 40000.00, '2023-07-03', 2),
    (18, 'Manish Jain', 8, 'Finance', 45000.00, '2023-02-27', 3),
    (19, 'Komal Sinha', 9, 'Finance', 43000.00, '2023-08-14', 4),
    (20, 'Akash Bansal', 10, 'IT', 50000.00, '2023-05-22', 5);
    
    
select e.EmployeeID , e.EmployeeName as employeeName, m.EmployeeName as managerName 
from employees e 
left join employees m 
on e.ManagerID = m.EmployeeID;

select e.EmployeeID , e.EmployeeName as employeeName, m.EmployeeName as managerName  , b.branchname
from employees e 
left join employees m 
on e.ManagerID = m.EmployeeID
inner join branches b
on e.BranchID = b.BranchId;

-- self join 2
-- find all the employees  who reports to the sneha verma 
select e.EmployeeID , e.employeename,e.Department ,m.EmployeeName as managername
from employees e
left join employees m
on e.ManagerID = m.EmployeeID
where m.EmployeeName = "sneha verma";


-- subqueries
-- find all customers whose balance is greater than avg balance 
select avg(balance) as AVG_BALANCE from accounts
where AccountType = 'saving';

select c.CustomerID, c.firstname , avg(balance) as Avg_Bal from  customers c 
join accounts a
on c.CustomerID = a.CustomerID
where a.AccountType ='saving'
group by c.firstname,c.CustomerID
having Avg_Bal> 34898 ;

-- subqueries
-- scaler subquery
-- find all customers whose balance is greater than avg balance 
-- account type = 'saving'

select accountID , customerid 
from accounts
where balance > (
	select avg(balance) from accounts
    where AccountType = 'saving'
) && AccountType = 'saving';


select c.customerid, c.firstname  , a.accountID 
from accounts a 
inner join customers c 
on c.CustomerID = a.CustomerID
where a.balance > (
	select avg(balance)  from accounts
    where AccountType = 'saving'
) && AccountType = 'saving';


-- find the acounts having highest balance 
select AccountID , balance from accounts
where balance = (
		select max(Balance) from accounts
);

-- find a customers whose year of birth is earlier than the average year of birth of all customers 
select firstname ,dateofbirth, year(dateofbirth)as YearOFBirth  from customers
where year(DateOfBirth) < (
		select floor(avg(year(dateofbirth) )) from customers
);

-- multi row subquery
-- find all customers who have taken at least one loan

select CustomerID , FirstName ,phone from customers
where CustomerID in (
		select CustomerID 
        from loans
        );

-- find all customers who have at least one saving account
select customerid , firstname , phone from customers
where CustomerID in(
		select CustomerID  from accounts
        where AccountType = 'saving'
		);

-- find all customers who have an account in branchId = 1 
select customerid , FirstName from customers
where CustomerID in (
		select CustomerID from accounts
        where BranchID = 1
);

-- find all accounts whose balance is greater than 
-- any account in brnachID = 1

select accountid , balance from accounts
where balance > any(
		select AccountID from accounts
        where BranchID = 1
);
-- find all accounts whose balance is greater than 
-- all account in brnachID = 1
select accountid , balance from accounts
where balance > all(
		select AccountID from accounts
        where BranchID = 1
);

-- find the branch with the highest average account balance 
select branchid , balance from accounts
where Balance > any(
			select BranchID, avg(Balance)from accounts

);


-- find account whoes balance is greater than 
-- the average balance of their respective branch

select a.AccountID , a.balance ,BranchID  from accounts a
where a.Balance > ( 
					select avg(a1.Balance)  from accounts a1
                    where a.branchid = a1.branchid
				);

-- find employees whose salary is greaater than the average salary of their respective department
select e.employeeid , e.salary , e.department
from employees e 
where e.Salary > (
		select avg(e1.Salary) from employees e1
        where e.Department = e1.Department
);

-- find customers who have more than one account
select c.customerid , c.FirstName from customers c 
where (
		select count(*) from accounts a
        where c.CustomerID = a.CustomerID
) > 1;

-- table subquery / derived table 



















select * from transactions;
select * from accounts;
select * from customers;
select * from branches;


-- 1. Display customers who do not have a Current account.

select c.customerID , c.firstname , a.AccountType ,a.AccountID
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
where a.AccountType != 'current'
order by c.CustomerID;

-- 2. Display Customername,Accountcreation date,Accounttype,Balancefor customers whose account was created in 2025.
select c.firstname , c.accountcreationdate,a.AccountType,a.Balance
from customers c
inner join accounts a 
on c.CustomerID = a.CustomerID
where year(accountcreationdate) = '2025';

-- 3 3. Display:Customername,Accountcreation date,Accounttype and calculate the number of days since account creation.
select 
c.firstname , c.accountcreationdate , a.AccountType , datediff(curdate(),c.accountcreationdate) as NumberOfDays
from customers c
inner join accounts a 
on c.CustomerID = a.CustomerID;

-- 4. Find the number of accounts held by each customer.
select c.CustomerID , c.firstname ,
count(a.CustomerID) as NumberOFAccounts 
from customers c 
left join accounts a 
on c.CustomerID = a.CustomerID
group by c.CustomerID;

select c.CustomerID ,c.firstname,
		count(a.AccountID ) as NumberOFAccounts
    from customers c
    left join accounts a 
    on c.CustomerID = a.CustomerID
    group by c.CustomerID;


-- 5. Find the total balance held by each customer.
select c.CustomerID ,c.firstname,
		sum(a.balance) as TotalBalance
        from customers  c
        left join accounts a 
        on c.CustomerID = a.CustomerID
        group by c.CustomerID;
        
-- 6 6. Find the number of customers for each account type.
select a.AccountType ,
		count(a.CustomerID) as NoCustForEachAccountType 
        from customers c
        left join accounts a 
        on c.CustomerID = a.CustomerID
        group by a.AccountType;
        
-- 7. Find the total balance for each account type.
select AccountType,
		sum(Balance)  as TotalBalance
        from accounts
        group by AccountType;
        
-- 8 Find the highest balance held by each account type.
select AccountType, max(Balance) as HighestBalance
		from accounts
        group by AccountType;
        
-- 9 Find the number of customers for each branch.   CORECT ANS IS BELOW
	select b.branchname , count(c.customerid) as NoOfAccounts
		from customers c 
        join accounts a
        on a.CustomerID= c.CustomerID
        left join branches b
        on a.BranchID =b.BranchID
        group by b.BranchName;
        
	select b.branchid , b.branchname , count(a.customerid) as NoOfAccounts
		from  accounts a 
       inner join branches b
        on a.BranchID= b.BranchID
        group by b.BranchId;
        
	--  CORRECT ANS FOR 9
    select b.branchname ,count(a.customerid) as NoOfAccounts
			from accounts a
            right join branches b 
            on a.BranchID = b.BranchID
            group by b.BranchId;
            
	-- 10. Find customers whose total account balance is greater than ₹40,000.
select c.CustomerID , c.FirstName, sum(a.Balance) as TotalAccountBalance
		from customers c
        inner join accounts a 
        on c.CustomerID = a.CustomerID
        group by c.CustomerID
        having TotalAccountBalance > 40000;
    
   
-- 11. Find customers who have more than one account.
select c.CustomerID , concat_ws(" ",c.firstname,c.lastname) as Full_name ,count(a.AccountID) as total_account
		from customers c
        inner join accounts a
        on c.CustomerID =a.CustomerID
        group by c.CustomerID
        having total_account > 1;
        
-- 12  Find customers who do not have an account.
select c.FirstName , a.AccountID 
	from customers c
    left join accounts a 
    on c.CustomerID  = a.CustomerID
    where a.AccountID is null;
    
-- 13. Find customers who do not have any loan.
		select c.CustomerID, c.FirstName ,l.loanid
			from customers c 
            left join loans l 
            on c.CustomerID = l.LoanId
            where l.LoanId is null;

        
--  14. Find customers who have never performed a transaction.
   select  c.CustomerID ,
			concat(c.firstname ," ",c.lastname ) as full_name , count(t.AccountID) as NoOfTransaction
            from customers c
            join accounts a
            on c.CustomerID = a.CustomerID
            left join transactions t
            on a.AccountID = t.AccountID
            group by CustomerID
            having NoOFtransaction = 0;


-- 15. Display all branches and their account count, including branches that have zero accounts.
select b.BranchID ,b.BranchName , count(a.AccountID) as NoOFAccount
		from branches b
        left join accounts a 
        on b.BranchID = a.BranchID
        group by b.BranchId  
        having NoOfAccount > 2;
        

      
-- find account whoe balance is greater than 
-- the average balance of their respective branch
















select * from accounts;
select * from loans;
select * from transactions;
select * from branches;
select * from customers;



-- Display the CustomerID, FirstName and Email of customers whose AccountCreationDate is after 1- Jan-2025. 
select CustomerID , FirstName , Email 
from customers
where AccountCreationDate > '2026-01-01';

-- 2.Display all Savings accounts having balance greater than ₹20,000.
select * from accounts
where AccountType = 'Saving' and
		Balance > 20000;
        
-- 3.Display customers whose Phone number is NOT NULL.
select * from customers
where phone is not null;

-- 4.Display distinct Account Types available in the Accounts table.
select distinct AccountType
from accounts;

-- 5.Display customers whose FirstName starts with R
select * from customers
where FirstName like 'R%';

-- 6.Display accounts having Balance between ₹20,000 and ₹60,000.
select * from accounts 
where Balance between 20000 and 60000;

-- 7.Display all Deposit transactions whose amount is greater than ₹3000.
select * from transactions
where TransactionType = 'Credit' and amount > 3000;

-- 8.Display customers whose CustomerID is IN (101,103,106,109).
select * from customers
where CustomerID  in (101,103,106,109);

--  9. Display first 5 customers ordered by CustomerID.
select * from customers
order by CustomerID
limit 5;

-- 10.Display customers after skipping first 3 records.
select * from customers
order by CustomerID
limit 99999 offset 3;


-- 11.Display Savings accounts having balance between ₹20,000 and ₹80,000
select * from accounts
where AccountType = 'Saving' and
	Balance between 20000  and 80000;
    
-- 12.Display customer names whose phone number is NULL and account was created after 2025-01-01.
select * from customers 
where Phone is null and
	AccountCreationDate > '2025-01-01';
    
-- 13.Display all customers whose FirstName starts with 'A' OR LastName starts with 'S'.
select * from customers 
where FirstName like 'A%' or 
	LastName like 'S%';


-- 14 Display all accounts whose AccountType is Savings or Salary and balance is greater than ₹10,000.
select * from accounts
where AccountType in ('Saving','Salary') and
	Balance > 10000;

-- 15.Display customers whose CustomerID is IN (101,102,105,109) and phone number is not NULL.
select * from customers 
where CustomerID in (101,102,105,109) and
	Phone is not null;

-- 16.Display transactions whose Amount is between ₹2,000 and ₹8,000 and TransactionType is Deposit.
select * from transactions
where Amount between 2000 and 8000 
and TransactionType ='Credit';

-- 17.Display distinct BranchIDs from Accounts where balance is greater than ₹30,000.
select distinct BranchID , Balance
from accounts
where Balance > 30000;

-- 18.Display customers whose email contains gmail and first name ends with a. 
select * from customers 
where FirstName like  '%a' and
		Email is not null;
        
-- 19.Display customers whose DateOfBirth is between 1995 and 2000.
select * from customers 
where year(DateOfBirth) between '1995' and '2000';

-- 20. Display first 3 Savings accounts having balance greater than ₹25,000.
select * from accounts
where AccountType = 'Saving' and
	Balance > 25000 
    limit 3;


-- 21.Display customers whose FirstName starts with 'P' and Phone IS NULL.
select * from customers 
where FirstName like "P%" and Phone is null ;

-- 22.Display accounts whose balance is NOT BETWEEN ₹20,000 and ₹50,000.
select * from accounts
where Balance not between 20000 and 50000;

-- 23.Display customers whose CustomerID is NOT IN (101,102,103).
select * from customers
where CustomerID not in(101,102,103);

-- 24.Display transactions that are Withdrawal and amount is less than ₹5000.
select * from transactions
where TransactionType = 'debit' and Amount <5000;

-- 25.Display customers whose email ends with gmail.com and phone number is available.
select * from customers 
where Email like '%gmail.com' and Phone is not null;

-- 26.Display distinct transaction types whose amount is greater than ₹5000.
select distinct transactiontype , transactionID , Amount from transactions
where Amount > 5000;

-- 27. Display all Savings accounts belonging to Branch 1 or Branch 3.
select * from accounts
where AccountType = 'saving' and BranchID in (1,2);

-- 28.Display customers whose first name contains 'ha' and DateOfBirth is after 1997.
select * from customers
where FirstName	like '%ha%' and DateOfBirth > 1997-12-31;

-- 29.Display accounts whose balance is greater than ₹30,000 but less than ₹80,000.
select * from accounts 
where Balance > 30000 and Balance <80000;

-- 30 Display first 4 Deposit transactions after skipping first 2 deposits.
select * from transactions
where TransactionType = 'credit' limit 4 offset 2;

-- 31 Display customer names whose phone number is NULL OR email starts with s.
select * from customers
where phone is null or Email like 's%' ;

-- 32 Display Savings accounts having balance greater than ₹10,000 AND belonging to Branch 1.
select * from accounts 
where Balance > 10000 and BranchID = '1';

-- 33 Display Current accounts having balance between ₹40,000 and ₹1,00,000.
select * from accounts 
where AccountType = 'current' and Balance between 40000 and 100000;

-- 34 Display customers whose last name starts with S and were created after 2024.
select * from customers 
where LastName like 's%'  and year(AccountCreationDate)> 2024 ;

-- 35 Display transactions whose amount is IN (2000,3000,5000,7000).

select * from transactions
where Amount in ( 2000,3000,5000,7000);

-- 36 Display customers whose first name starts with R or P, phone number is available and CustomerID is greater than 103.
select * from customers
where (firstname like 'R%' or FirstName like 'P%') and phone is not null and customerID > 103;

-- 37 Display distinct balances greater than ₹15,000.
SELECT DISTINCT
    balance, AccountID
FROM
    accounts
WHERE
    balance > 15000;

-- 38 Display all accounts except Savings accounts having balance above ₹25,000.
select * from accounts 
where AccountType != 'Saving' and Balance > 25000;

-- 39 Display customers whose email contains gmail but phone number is missing.
select * from customers 
where email is not null and phone is null;

-- 40 Display accounts whose balance is between ₹15,000 and ₹90,000 and AccountType is not Salary.
select * from accounts 
where balance between 15000 and 90000 and AccountType != 'salary';

-- Level 5 (Challenge Questions)
-- 41 Display first 5 customers whose FirstName starts with A or R, ordered by CustomerID.
SELECT 
    *
FROM
    customers
WHERE
    (FirstName LIKE 'A%'
        OR FirstName LIKE '%r')
ORDER BY CustomerID DESC
LIMIT 5;

-- 42 Display Savings and Salary accounts whose balance is greater than ₹15,000 and less than ₹60,000.
select * from accounts
where AccountType in ('Saving' , 'Salary') and (Balance >15000 and Balance<=60000);

-- 43 Display customers whose CustomerID is IN (101,103,105,107,109) and DateOfBirth is between 1994 and 2000.
select * from customers 
where CustomerID in (101,103,105,107,109) and (year(DateOfBirth) between  1994 and 2000);

-- 44 Display transactions whose amount is greater than ₹2000 but less than ₹8000 and TransactionType is not Withdrawal.
select * from transactions
where amount > 2000 and amount <8000 and TransactionType != 'Debit';

-- 45 Display customers whose phone number is NULL or FirstName contains 'an'.
select * from customers
where phone is null or firstname like '%an%';

-- 46 Display distinct AccountTypes where balance is greater than ₹20,000.
select distinct AccountType from accounts
where balance > 20000;

-- 47 Display customers after skipping first 2 records and display only the next 4 records.
select * from customers 
limit 2,4;

-- 48 Display customers whose last name ends with 'kar' and email contains gmail.
select * from customers 
where lastname like '%kar' and email is not null;

-- 49 Display accounts whose BranchID is IN (1,2) and balance is between ₹20,000 and ₹70,000.
select * from accounts 
where BranchID IN (1,2) and Balance between 20000 and 70000;

-- 50 Display all customers whose first name starts with r, phone number is not NULL, and account was created between 1-Jan-2025 and 31-Dec-2025.
select * from customers 
where (FirstName like 'r%' and phone is not null ) and AccountCreationDate between '2025-01-01' and '2025-12-31';

-- Tricky Level 1
-- 1 Display all customers whose first name starts with 'R' or 'S' but whose phone number is NULL.
select * from customers 
where (FirstName like 'r%' or FirstName like 's%') and phone is null;

-- 2 Display all accounts that are not Savings accounts and have a balance greater than ₹30,000.
select * from accounts 
where AccountType != 'saving' and Balance >30000;

-- 3 Display customers whose CustomerID is not 101, 102, or 103.
select * from customers
where CustomerID  not in (101, 102, 103);

-- 4 Display customers whose email does not end with "gmail.com".
select * from customers 
where email not like '%gmail.com';

-- 5 Display accounts whose balance is not between ₹20,000 and ₹50,000.
select * from accounts
where balance not between 20000 and 50000;

-- 6 Display all transactions except Deposit transactions.
select * from transactions
where TransactionType != 'credit';

-- 7 Display customers whose first name contains the letter 'a' but does not start with 'A'.
select * from customers
where FirstName like '%a%' and FirstName not like 'a%';

-- 8 Display distinct account types except Current.
select distinct AccountType from accounts
where AccountType != 'current';

-- 9 Display customers who have phone numbers available but were created before 2025.
select * from customers 
where phone is not null and year(AccountCreationDate) < 2026;

-- 10 Display first 3 Savings accounts after skipping the first 2 Savings accounts.
select * from accounts
where AccountType = 'saving' limit 2,3;

-- 11 Display customers whose CustomerID is between 101 and 110 but not equal to 105 or 108.
select * from customers 
where customerid between 101 and 110 and CustomerID != 105 and CustomerID!=108;

-- 12 Display transactions whose amount is greater than ₹2000 but not equal to ₹5000.
select * from transactions 
where amount > 2000 and amount != 5000;

-- 13 Display customers whose last name starts with 'S' and email contains gmail but phone number is NULL.
select * from customers 
where lastname like 's%' and email is not null and phone is null;

-- 14 Display accounts having balance between ₹15,000 and ₹60,000 but not belonging to Branch 2.
select * from accounts
where Balance between 15000 and 60000 and branchid != 2;

-- 15 Display customers whose FirstName starts with 'P' or ends with 't'.
select * from customers 
where FirstName like 'p%' or FirstName like '%t';

-- 16 Display accounts whose AccountType is Savings or Salary but balance is not between ₹10,000 and ₹40,000.
select * from accounts 
where AccountType in ('saving' , 'salary') and Balance not between 10000 and 40000;

-- 17 Display customers whose DateOfBirth is after 1995 but before 2000.
select * from customers
where year(DateOfBirth)> 1995 and year(dateofbirth) <2000;

-- 18 Display customers whose email contains gmail but FirstName does not contain 'a'.
select * from customers 
where email like '%gmail%' and FirstName  not like '%a%';

-- 19 Display transactions whose amount is between ₹2000 and ₹8000 but TransactionType is not Withdrawal.
select * from transactions 
where amount between 2000 and 8000 and TransactionType !='Debit';

-- 20 Display only the next 5 customers after skipping the first 4 customers.
select * from customers
limit 4,5;

-- 21 Display all Savings accounts having balance greater than ₹20,000 OR belonging to Branch 1. (Students often mistakenly use AND.)
select * from accounts
where (AccountType = 'saving') and (Balance > 20000 or BranchID = 1);

-- 22 Display all customers whose phone is NULL OR email contains gmail.
select * from customers 
where phone is null or email like '%gmail%';

-- 23 Display customers whose FirstName starts with 'A' or 'R' and whose CustomerID is greater than 105. (Requires proper use of parentheses.)
select * from customers 
where (FirstName like 'A%' or firstname like 'R%') and CustomerID > 105;

-- 24 Display customers whose CustomerID is NOT IN (101,103,105) and phone number is NOT NULL.
select * from customers 
where CustomerID not in (101,103,105) and phone is not null;

-- 25 Display accounts whose balance is less than ₹10,000 OR greater than ₹80,000.
select * from accounts 
where balance <10000 or Balance > 80000;

-- 26 Display transactions whose amount is NOT BETWEEN ₹3000 and ₹7000.
select * from transactions 
where amount not between 3000 and 7000;

-- 27 Display customers whose last name ends with 'kar' OR starts with 'D'.
select * from customers
where lastname like '%kar' or lastname like 'd%';

-- 28 Display customers whose email starts with 'a' OR phone number is NULL, but whose CustomerID is greater than 105.

select * from customers 
where (email like 'a%' or phone is null ) and CustomerID > 105;

-- 29 Display all accounts except Savings having balance between ₹25,000 and ₹60,000.
select * from accounts 
where AccountType !='saving' and Balance between 25000 and 60000;

-- 30 Display customers whose FirstName starts with 'R', Phone IS NOT NULL, CustomerID is between 101 and 110, and AccountCreationDate is after 2024-12-31.
select * from customers 
where FirstName like 'r%' and phone is not null
		and CustomerID between 101 and 110
        and AccountCreationDate >'2024-12-31';
        
-- 31 Display customers whose FirstName starts with 'A' or 'S' and Phone IS NOT NULL.
select * from customers
where (FirstName like 'a%' or FirstName like 's%') and phone is not null;

-- 32 Display customers whose Phone IS NULL and CustomerID is not in (101,102).
select * from customers
where phone is null and CustomerID not in (101,102);

-- 33 Display accounts whose Balance > 30000 and AccountType is Savings or Salary.
select * from accounts 
where Balance > 30000 and AccountType in ('salary', 'saving');

-- 34 Display customers whose FirstName contains 'a' but LastName does not contain 'a'.
select * from customers
where firstname like '%a%' and LastName not like '%a%';

-- 35 Display only 4 customers after skipping the first 3 customers, ordered by FirstName.
select * from customers
order by FirstName
limit 4 offset 3;



-- sql queries basic
-- 1 Display the CustomerID, FirstName and Email of customers whose AccountCreationDate is after 1-Jan-2025customers
select CustomerID , Firstname , Email , AccountCreationDate from customers
where AccountCreationDate > 2025-02-01;

-- 2 Display all Savings accounts having balance greater than ₹20,000.
select * from accounts 
where AccountType = 'saving' and balance >20000;

-- 3 Display customers whose Phone number is NOT NULL.
select * from customers 
where phone is not null;

-- 4 Display distinct Account Types available in the Accounts table.
select distinct AccountType from accounts;

--  5 Display customers whose FirstName starts with 'R'.
select * from customers
where FirstName like 'r%' ;

-- 6 Display accounts having Balance between ₹20,000 and ₹60,000.
select * from accounts 
where balance between 20000 and 60000;

-- 7  Display all Deposit transactions whose amount is greater than ₹3000.
select * from transactions 
where amount > 3000;


-- Part 1 — INNER JOIN: Basic
-- Level 1 — Simple INNER JOIN

-- 1 . Display the CustomerID, FirstName, LastName, AccountType, and Balance of all customers who have an account.
select c.CustomerID , c.firstname , c.lastname , a.AccountType , a.balance
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID;

-- 2 Display the customer's full name along with their AccountID, AccountType, and Balance.
-- Use CONCAT() to combine first name and last name.

select concat_ws(' ',c.firstname ,c.lastname) as full_name , a.AccountID , a.AccountType , a.Balance
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID;


-- Display all customers who have a Savings account.
-- Output:
-- Customer Name, AccountID, Balance

select c.firstname , a.AccountID , a.AccountType, a.balance 
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
where AccountType = 'saving';

-- 4 Display customers whose account balance is greater than 30000.
-- Output:
-- Customer Name, AccountType, Balance

select c.firstname , a.AccountType , a.Balance
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID;

-- 5 Display customers having either a Savings or Current account. Use IN.
select c.CustomerID , c.firstname ,a.AccountType 
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
where AccountType in('saving','Current');

-- 6 Display customers whose account type is not Savings. Use NOT IN.
select c.CustomerID , c.firstname , a.AccountType 
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
where AccountType not in('saving');

-- BETWEEN
-- 7 Display customers whose account balance is between 20,000 and 50,000.
-- Output:
-- Customer Name, AccountType, Balance

select c.firstname , a.AccountType , a.Balance
from customers c
inner join accounts a 
on c.CustomerID = a.CustomerID
where Balance between 20000 and 50000;


-- Q8. LIKE
-- Display customers whose first name starts with 'S'.
-- Output:
-- Customer Name, AccountType, Balance

select c.firstname , a.AccountType , a.Balance 
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
where FirstName like 's%' ;

-- Q9. LIKE + CONCAT
-- Display the full name and account details of customers whose last name ends with 'a'.

select concat_ws(' ',c.firstname , c.lastname) as FullName , a.*
from customers c 
inner join accounts a 
on c.CustomerID = a.CustomerID
where lastname  like '%a';

-- Q10. Multiple WHERE conditions
-- Display customers who:
-- •	have a Savings account 
-- •	AND balance is greater than 20,000

select c.firstname  , a.AccountType , a.balance 
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
where a.AccountType = 'saving' and Balance > 20000;

-- Q11. OR condition
-- Display customers who:
-- •	have a Savings account 
-- •	OR have a balance greater than 70,000 

select c.firstname , a.AccountType , a.Balance
from customers c 
inner join accounts a
on c.CustomerID = a.CustomerID
where AccountType = 'saving' or balance >70000;

-- Q12. NOT
-- Display customers who do not have a Current account.

select c.CustomerID , a.AccountType 
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
where a.AccountType not in('current');


-- Part 3 — INNER JOIN + String Functions
-- Q13.
-- Display:
-- •	Customer ID 
-- •	Full name in uppercase 
-- •	Account type 
-- •	Balance 
-- Use:
-- UPPER()
-- CONCAT()

select c.CustomerID , upper(concat(c.firstname," " , c.lastname)) as Full_Name,  a.AccountType ,a.balance
from customers  c
inner join accounts a
on c.CustomerID = a.CustomerID;

-- Q14.
-- Display the customer's name in the following format:
-- R.Sharma
-- K.Tiwari
-- N.Singh
-- Use SUBSTRING() and CONCAT().

select concat(substring(firstname ,1,1),".", lastname ) as full_name from customers;

-- Q15.
-- Display customers whose first name contains the letter 'a'.
-- Use LIKE.

select firstname from customers 
where FirstName like "%a%";

-- Q16.
-- Display:
-- •	Customer ID 
-- •	Full name 
-- •	Number of characters in the customer's first name 
-- •	Account balance 
-- Use CHAR_LENGTH().


select c.CustomerID , concat_ws(" " , c.firstname ,c.lastname) as FullName , char_length(c.firstname) as Charlenght, a.Balance
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID;


-- Q17.
-- Display customers whose first name has exactly 5 characters.
-- Use:
-- CHAR_LENGTH()
select firstname , char_length(firstname) as ch_length from customers
where char_length(firstname) = 5;

-- Part 4 — INNER JOIN + Date Functions
-- Now combine Customers and Accounts.
-- Q18.
-- Display:
-- •	Customer name 
-- •	Account creation date 
-- •	Account type 
-- •	Balance 
-- for customers whose account was created in 2025.
-- Use:
-- YEAR()

select c.firstname , c.accountCreationDate , a.AccountType , a.Balance
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
where year(c.accountCreationDate) = 2025;

-- Q19.
-- Display customers whose account was created after 1 January 2025.
select c.customerid ,  c.firstname , c.accountcreationdate  from customers c
where c.accountcreationdate > 2025-01-01;

-- Q20.
-- Display customers whose account was created between:
-- 2025-01-01
-- and
-- 2025-12-31
-- Use BETWEEN.

select CustomerID , accountCreationdate from customers 
where AccountCreationDate between '2025-01-01' and '2025-12-31';

-- Q21.
-- Display:
-- •	Customer name 
-- •	Account creation date 
-- •	Account type 
-- and calculate the number of days since account creation.
-- Use:
-- DATEDIFF()

select c.firstname , c.accountcreationdate , a.AccountType , datediff(curdate(),c.accountcreationdate) as NoOfDays
from customers c
inner join accounts a
on c.CustomerID= a.CustomerID;

-- Q22.
-- Display:
-- •	Customer name 
-- •	Date of birth 
-- •	Age 
-- along with their account information.
-- Use:
-- DATEDIFF()
-- and calculate approximate age in years.

select c.firstname , c.DateOfBirth , timestampdiff(year,c.dateofbirth,curdate()) as age
from customers c 
inner join accounts a
on c.CustomerID = a.CustomerID;

-- Part 5 — INNER JOIN + Aggregate Functions
-- Now the questions become more interesting.
-- Q23.
-- Find the total balance held by all customers.
-- Output:
-- Total Balance
-- Use:
-- SUM()

select  sum(a.Balance)  as TotalBalance
from customers c
inner join accounts a 
on c.CustomerID =a.CustomerID;

select sum(Balance)  as TotalBalance from accounts ;

-- Q24.
-- Find the average account balance of customers.
select avg(a.Balance)  as TotalBalance
from customers c
inner join accounts a 
on c.CustomerID =a.CustomerID;

select avg(Balance) from accounts;

-- Q25.
-- Find the maximum account balance among customers.
select max(balance) from accounts;








 









select * from accounts;
select * from customers;
select * from transactions;
