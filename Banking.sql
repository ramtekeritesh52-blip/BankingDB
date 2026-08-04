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
and	table_name = 'customers';

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

update customers
set AccountCreationDate = '2025-04-23'
where customerID =101;


    -- 3 branch 5 entry

