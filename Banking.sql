-- show databases;
-- create database BankingDB;
USE bankingdb;
CREATE TABLE Customers(
	CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email varchar(100),
    Phone varchar(15),
    AccountCreationDate date
);

describe customers;
select * from Customers;



    

