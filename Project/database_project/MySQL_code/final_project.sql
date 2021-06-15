create database if not exists ecomDB;
use ecomDB;

# Create Store entity
create table if not exists Store (
store_id int not null AUTO_INCREMENT primary key,
store_name varchar(50) not null,
phone varchar(20),
country varchar(20),
city varchar(20),
address varchar(100),
zipcode int
);

# Create Employee entity
create table if not exists Employee (
employee_id int not null AUTO_INCREMENT primary key,
first_name varchar(20) not null,
last_name varchar(20) not null,
manager_id int,
store_id int,
sales int,
phone varchar(20),
email varchar(100) not null unique,
foreign key (manager_id) references Employee (store_id), 
foreign key (store_id) references Store (store_id)
);
);