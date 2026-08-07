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















select * from accounts;
select * from loans;
select * from transactions;
select * from branches;
select * from customers;

