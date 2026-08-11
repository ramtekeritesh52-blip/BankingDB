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

