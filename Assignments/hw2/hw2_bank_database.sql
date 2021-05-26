# create the Bank database
create database if not exists Bank;
use Bank;

CREATE TABLE IF NOT EXISTS account (
    account_number CHAR(5) NOT NULL PRIMARY KEY,
    branch_name VARCHAR(10),
    balance DOUBLE
);
CREATE TABLE IF NOT EXISTS branch (
    branch_name VARCHAR(10) NOT NULL PRIMARY KEY,
    branch_city VARCHAR(10),
    assets DOUBLE
);
CREATE TABLE IF NOT EXISTS customer (
    customer_name VARCHAR(20) NOT NULL PRIMARY KEY,
    customer_street VARCHAR(20),
    customer_city VARCHAR(10)
);
CREATE TABLE IF NOT EXISTS loan (
    loan_number VARCHAR(5) NOT NULL PRIMARY KEY,
    branch_name VARCHAR(10),
    amount DOUBLE
);
CREATE TABLE IF NOT EXISTS borrower (
    customer_name VARCHAR(20) NOT NULL,
    loan_number VARCHAR(5) NOT NULL,
    PRIMARY KEY (customer_name , loan_number)
);
CREATE TABLE IF NOT EXISTS depositor (
    customer_name VARCHAR(20) NOT NULL,
    account_number CHAR(5) NOT NULL,
    PRIMARY KEY (customer_name , account_number)
);
CREATE TABLE IF NOT EXISTS employee (
    employee_name VARCHAR(20) NOT NULL,
    branch_name VARCHAR(10) NOT NULL,
    salary DOUBLE,
    PRIMARY KEY (employee_name , branch_name)
); 

# populate the tables
## account 
insert into account values('A-101', 'Downtown', 500);
insert into account values('A-102', 'Perryridge', 400);
insert into account values('A-201', 'Brighton', 900);
insert into account values('A-215', 'Mianus', 700);
insert into account values('A-217', 'Brighton', 750);
insert into account values('A-222', 'Redwood', 700);
insert into account values('A-305', 'Round Hill', 350);

## branch
insert into branch values('Brighton', 'Brooklyn', 7100000);
insert into branch values('Downtown', 'Brooklyn', 9000000);
insert into branch values('Mianus', 'Horseneck', 400000);
insert into branch values('North Town', 'Rye', 3700000);
insert into branch values('Perryridge', 'Horseneck', 1700000);
insert into branch values('Pownal', 'Bennington', 300000);
insert into branch values('Redwood', 'Palo Alto', 2100000);
insert into branch values('Round Hill', 'Horseneck', 8000000);

## customer
insert into customer values('Adams', 'Spring', 'Pittsfield');
insert into customer values('Brooks', 'Senator', 'Brooklyn');
insert into customer values('Curry', 'North', 'Rye');
insert into customer values('Glenn', 'Sand Hill', 'Woodside');
insert into customer values('Green', 'Walnut', 'Stamford');
insert into customer values('Hayes', 'Main', 'Harrison');
insert into customer values('Johnson', 'Alma', 'Palo Alto');
insert into customer values('Jones', 'Main', 'Harrison');
insert into customer values('Lindsay', 'Park', 'Pittsfield');
insert into customer values('Smith', 'North', 'Rye');
insert into customer values('Turner', 'Putnam', 'Stamford');
insert into customer values('Williams', 'Nassau', 'Princeton');

## loan
insert into loan values('L-11', 'Round Hill', 900);
insert into loan values('L-14', 'Downtown', 1500);
insert into loan values('L-15', 'Perryridge', 1500);
insert into loan values('L-16', 'Perryridge', 1300);
insert into loan values('L-17', 'Downtown', 1000);
insert into loan values('L-23', 'Redwood', 2000);
insert into loan values('l-93', 'Mianus', 500);

## borrower
insert into borrower values('Adams', 'L-16');
insert into borrower values('Curry', 'L-93');
insert into borrower values('Hayes', 'L-15');
insert into borrower values('Jackson', 'L-14');
insert into borrower values('Jones', 'L-17');
insert into borrower values('Smith', 'L-11');
insert into borrower values('Smith', 'L-23');
insert into borrower values('Williams', 'L-17');

## depositor
insert into depositor values('Hayes', 'A-102');
insert into depositor values('Johnson', 'A-102');
insert into depositor values('Johnson', 'A-201');
insert into depositor values('Jones', 'A-217');
insert into depositor values('Lindsay', 'A-222');
insert into depositor values('Smith', 'A-215');
insert into depositor values('Turner', 'A-305');

## employee
insert into employee values('Adams', 'Perryridge', 1500);
insert into employee values('Brown', 'Perryridge', 1300);
insert into employee values('Gopal', 'Perryridge', 5300);
insert into employee values('Johnson', 'Downtown', 1500);
insert into employee values('Loreena', 'Downtown', 1300);
insert into employee values('Peterson', 'Downtown', 2500);
insert into employee values('Rao', 'Austin', 1500);
insert into employee values('Sato', 'Austin', 1600);

# Retrieval Queries
## 1. Find all loan number for loans made at the Perryridge branch with loan amounts greater than $1100.
## 2. Find the loan number of those loans with loan amounts between $1,000 and $1,500 (that is, >=$1,000 and <=$1,500)
## 3. Find the names of all branches that have greater assets than some branch located in Brooklyn.
## 4. Find the customer names and their loan numbers for all customers having a loan at some branch.
## 5. Find all customers who have a loan, an account, or both:
## 6. Find all customers who have an account but no loan. (no minus operator provided in mysql)
## 7. Find the number of depositors for each branch.
## 8. Find the names of all branches where the average account balance is more than $500.
## 9. Find all customers who have both an account and a loan at the bank.
## 10. Find all customers who have a loan at the bank but do not have an account at the bank
## 11. Find the names of all branches that have greater assets than all branches located in Horseneck. (using both non-nested and nested select statement)
## 12. 1 query of your choice involving aggregate functions
## 13. 1 query of your choice involving group by feature.
