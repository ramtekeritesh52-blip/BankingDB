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
add constraint fk_transaction_accounts
foreign key (accountID)
references accounts(accountID);

alter table loans
add customerID int primary key;
desc loans;


alter table loans
add constraint FK_Loans_Customers
foreign key (customerID)
references customers (customerID);










    

