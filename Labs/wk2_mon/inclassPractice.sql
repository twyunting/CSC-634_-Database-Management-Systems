create database summer2021DB;
use summer2021DB;
create table if not exists account (account_number char(5) not null primary key,
branch_name varchar(10), balance double ); 

describe account;