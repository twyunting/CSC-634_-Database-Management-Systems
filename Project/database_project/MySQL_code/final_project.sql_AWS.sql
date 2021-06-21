############################################# CREATE DB ############################################################
create database if not exists ecomDB;
use ecomDB;
############################################# CREATE TABLE #########################################################
# create a Store entity
create table if not exists Store (
store_id int not null primary key,
store_name varchar(50) not null,
phone varchar(20),
country varchar(20),
city varchar(20),
address varchar(100),
zipcode int
);

# create a Employee entity
create table if not exists Employee (
employee_id varchar(20) not null primary key,
first_name varchar(20) not null,
last_name varchar(20) not null,
manager_id varchar(20),
store_id int,
sales int,
phone varchar(20),
email varchar(100) not null unique,
foreign key (manager_id) references Employee (employee_id), 
foreign key (store_id) references Store (store_id)
);

# create a Amazon_Order entity
create table if not exists Amazon_Order (
ASIN varchar(50) not null primary key,
customer_id int,
employee_id varchar(20),
store_id int,
order_date date,
delivery_date date,
status varchar(50),
foreign key (employee_id) references Employee (employee_id), 
foreign key (store_id) references Store (store_id) 
);

# create a Order_Detail entity
create table if not exists Order_Detail (
ASIN varchar(50) not null,
order_id int not null,
product_id int,
qty_order double,
subtotal double, 
PRIMARY KEY (ASIN, order_id) 
);

############################################# POPULATING THE TABLES #########################################################
# Store
insert into Store values(1, 'Cable Master', '(617)-3332634', 'USA', 'Washingtion DC', '4400 Massachusetts Ave NW, Washington, DC 20016', 20006);
insert into Store values(2, 'CC Connector', '(520)-1234567', 'USA', 'New York City', '20 W 34th St, New York, NY 10001', 10001);
insert into Store values(3, 'Nerdy Computer', '(123)-6969453', 'USA', 'San Francisco', '5630 Bay St, Emeryville, CA 94608', 94608);
insert into Store values(4, 'HD DVD King', '(781)-4226358', 'USA', 'Las Vegas', '3400 S Las Vegas Blvd, Las Vegas, NV 89109', 89109);
insert into Store values(5, 'Music You And Me', '(513)-4234567', 'Canada', 'Laval', '3003 Boulevard le Carrefour, Laval, QC H7T 1C7', 12345);
insert into Store values(6, 'Super Drone', '(202)-4995340', 'USA', 'Boston', '150 Morrissey Blvd, Boston, MA 02125', 02125);
select * from Store;


# Employee
insert into Employee values('HQ001', 'Yunting', 'Chiu', NULL,  001, 3000, '(426)-888-9453', 'yc6705a@american.edu');
insert into Employee values('HQ002', 'Yi', 'Ma', 'HQ001', 002, 50000, '(123)-456-7890', 'yimama@georgetown.edu');
insert into Employee values('HQ003', 'Vitalik', 'Buterin', 'HQ001', 003, 70000, '(113)-456-7330', 'etherum@google.com');
insert into Employee values('HQ004', 'Tracey', 'Brown', 'HQ002', 003, 60000, '(223)-439-2267', 'ada@yahoo.com');
insert into Employee values('MARS001', 'Elon', 'Musk', 'HQ001', 001, 9000000, '(998)-426-6969', 'mars@tesla.com');
insert into Employee values('MARS002', 'Andrew', 'Wang', 'MARS001', 002, 48850, '(784)-345-3926', 'wonderful@spacex.com');
select * from Employee;

# Amazon_Order
insert into Amazon_Order values('B014I8T0YQ', 1, 'HQ001', 1, '2018-06-20', '2018-06-23', 'Shipped');
insert into Amazon_Order values('BB07TVK1V59', 1, 'HQ001', 1, '2018-06-20', '2018-06-22', 'Shipped');
insert into Amazon_Order values('B093PQMWHF', 2, 'MARS001', 3, '2019-03-05', '2019-03-30', 'Shipped');
insert into Amazon_Order values('B094QQMWHF', 3, 'MARS001', 3, '2021-06-16', '2021-07-25', 'Unshipped');
insert into Amazon_Order values('B07YFCD354', 4, 'HQ002', 2, '2020-05-18', '2020-05-22', 'Shipped');
insert into Amazon_Order values('B01IQN17A4', 5, 'HQ003', 2, '2021-06-15', '2025-05-12', 'Unshipped');
select * from Amazon_Order;


# Order_Detail
insert into Order_Detail values('B014I8T0YQ', 1, 1, 40, 3400);
insert into Order_Detail values('BB07TVK1V59', 2, 2, 30, 6000);
insert into Order_Detail values('B093PQMWHF', 3, 3, 100, 40000);
insert into Order_Detail values('B094QQMWHF', 4, 4, 50, 4000);
insert into Order_Detail values('B07YFCD354', 5, 5, 60, 20000);
insert into Order_Detail values('B01IQN17A4', 6, 6, 5, 39500);
select * from Order_Detail;

# Select Query
## select involving one/more conditions in Where Clause 
## Q: Which ASIN is from Cable Master?
select ASIN from Amazon_Order A inner join Store S
on A.store_id = S.store_id 
where store_name  = "Cable Master";

## select with aggregate functions (i.e., SUM,MIN,MAX,AVG,COUNT)
## Q: Look at the average sales for each store.
select store_name, round(avg(sales), 2) as avgSales from Employee E inner join Store S
on E.store_id = S.store_id
group by E.store_id;

## select with Having, Group By, Order By clause
## Q: I would like to confirm that the order status has shipped more than one order.
select status, count(*) as cnt from Amazon_Order
group by status
having count(*) > 1
order by count(*) desc;

## Nested Select
## Q: Find the ASINs which is from the Mars office.
select ASIN from Amazon_Order where employee_id in (
	select employee_id from Employee where employee_id like "MARS%");

# select involving the Union operation
## Q: find all store ID in the database.
(select store_id from Employee)
union
(select store_id from Store)
union
(select store_id from Amazon_Order);

# Insert Query
## insert one tuple into a table (for 2 tables, just add 3 records for each table)
## Q: insert three tuples into a Order_Detail table
insert into Order_Detail values('B014I8T0YQ', 6, 1, 20, 1700);
insert into Order_Detail values('B014I8T0YQ', 7, 1, 10, 850);
insert into Order_Detail values('B014I8T0YQ', 8, 1, 40, 3400);
select ASIN from Order_Detail;

## Q: insert three tuples into a Employee table
insert into Employee values('HQ005', 'Doge', 'Brown', 'HQ002',  003, 70000, '(858)-838-9123', 'dogetothemoon@american.edu');
insert into Employee values('HQ006', 'Barry', 'Smith', 'HQ001', 001, 45000, '(432)-456-7890', 'noschool@lol.edu');
insert into Employee values('Earth', 'Mother', 'Ground', 'HQ001', 002, 58990, '(222)-333-8888', 'googleearth@apple.com');
select first_name, last_name from Employee;

## Q: insert three tuples with a specific attribute
Insert into Amazon_Order (ASIN) values ('B0741WGQ36');
Insert into Amazon_Order (ASIN) values ('B0741WGQ23');
Insert into Amazon_Order (ASIN) values ('B00BAXRQ3K');
select * from Amazon_Order;

## insert a set of tuples (by using another select statement)
## Q: insert the ASIN to Order_Detail from Amazon_Order which ASIN start with "B".
insert into Order_Detail (ASIN)
select ASIN from Amazon_Order
where ASIN like "B%";
select * from Order_Detail;

## insert involving two tables
insert into Order_Detail (ASIN)
select ASIN from Amazon_Order
where ASIN in (select ASIN from Order_Detail where subtotal < 800);
select * from Order_Detail;

# Delete Query
## One table
delete from Store
where country != "USA";
select store_name, country from Store; 

## Multiple tables
delete from Amazon_Order
where ASIN in (select ASIN from Order_Detail where subtotal < 3000);
select ASIN from Amazon_Order;
# select * from Order_Detail;

# Update Query

## One table
update Store
set country = "United States"
where country = "USA";
select store_name, country from Store;

## Multiple Tables
### Increase the balance of each order by 20% if the shipping status is still unshipped.
update Order_Detail
set subtotal = round(subtotal * 1.2, 2) 
where ASIN in (select ASIN from Amazon_Order where status = "Unshipped");
select * from Order_Detail where qty_order is not null;

# View Query
## One Relation with Operators
create view AUspy as 
select * from Employee;
update AUspy
set first_name = "AU SPY"
where email like "%american%";
select first_name, email from AUspy;

## Multiple Relations with Operators
create view threeTables as
select E.first_name, E.last_name from Store S
inner join Employee E on S.store_id = E.store_id
inner join Amazon_Order A on A.employee_id = E.employee_id;
select * from threeTables;

############################################################################################################
# Database Trigger
## Creating Database Log
Create table logMessage (message varchar(100));
Delimiter $$
create trigger add_store after insert on Store
for each row
begin
insert into logMessage values(concat('The store has been added by ',current_user(), ' ',
new.store_name, ' on ',current_date()));
end;

insert into Store values(7, 'Cheating Cups', '(335)-5643389', 'USA', 'Bethesda', '4903 Edgemoor Ln., Bethesda, MD 20814', 20814);
select store_name from Store;
select * from logMessage;

## Gathering Statistics
### When a new employee is added to the database, the system should calculate a new store income table for each store.
create table store_income (store_id int, min_sales double, max_sales double, avg_sales double);
Delimiter $$

create trigger store_income_insert after insert on Employee
for each row
begin
delete from store_income;
insert store_income
select store_id, min(sales), max(sales), avg(sales) from Employee group by store_id;
end;
$$

insert into Employee values('HQ007', 'David', 'Good', "HQ003",  001, 60000, '(426)-888-9453', '123@american.edu');
insert into Employee values('HQ008', 'Catie', 'Lover', 'HQ001', 002, 20000, '(123)-456-7890', '34@georgetown.edu');
insert into Employee values('HQ009', 'Ice', 'Burg', "HQ004",  001, 300000, '(426)-888-9453', '334@american.edu');
insert into Employee values('HQ010', 'Yolo', 'Brown', "HQ005",  006, 40000, '(426)-888-9453', '556@american.edu');
insert into Employee values('MARS005', 'Queens', 'Washington', 'MARS001', 003, 50000, '(123)-456-7890', '678@georgetown.edu');
select first_name, last_name, store_id, sales from Employee;
select * from store_income;

## Enforcing Referential Integrity
## Cancel the store income table with the specific store once the Store id has been removed. Because this store has been closed.
Delimiter $$
create trigger bye_store_count after delete on Employee
for each row
begin
delete from store_income where store_id = old.store_id;
end;
$$

delete from Employee where store_id = 3;
select * from Employee;
select * from store_income;

## Enforcing Business Rule
### The order's subtotal cannot be a negative value.
Delimiter $$
create trigger subtotal_rule before insert on Order_Detail
for each row
begin
if new.subtotal < 0 then
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtotal cannot be a negative value';
end if;
end;
$$

insert into Order_Detail values('B01L1DJDPM', 10, 9, 45, 27000);
insert into Order_Detail values('B07VL69TGB', 12, 10, 5, -200);
select * from Order_Detail;
