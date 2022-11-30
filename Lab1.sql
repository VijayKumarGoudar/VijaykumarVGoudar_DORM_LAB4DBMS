create database Ecommerce;
use Ecommerce;

-- Q1.1)	You are required to create tables for supplier,customer,category,product,
-- supplier_pricing,order,rating to store the data for the E-commerce 
-- with the schema definition given below.

-- --------------Creating  tables --------------------------------
create table supplier(
SUP_ID int primary key,
SUP_NAME varchar(50) not null,
SUP_CITY varchar(50) not null,
SUP_PHONE varchar(50) not null
);

create table customer (
CUS_ID	INT  primary key,
CUS_NAME	VARCHAR(20) NOT NULL,
CUS_PHONE	VARCHAR(10) NOT NULL,
CUS_CITY	VARCHAR(30) NOT NULL,
CUS_GENDER	CHAR
);

create table category(
CAT_ID	INT primary key,
CAT_NAME	VARCHAR(20) NOT NULL
);

create table product(
PRO_ID	INT,
PRO_NAME	VARCHAR(20) NOT NULL DEFAULT 'Dummy',
PRO_DESC	VARCHAR(60),
CAT_ID	INT,
PRIMARY KEY (PRO_ID),
FOREIGN KEY (CAT_ID) REFERENCES category(CAT_ID)
);

create table supplier_pricing(
PRICING_ID	INT primary key,
PRO_ID	INT,
SUPP_ID	INT,
SUPP_PRICE	INT DEFAULT 0,
FOREIGN KEY (PRO_ID) REFERENCES product(PRO_ID),
FOREIGN KEY (SUPP_ID) REFERENCES supplier(SUP_ID)
);

create table order_tb(
ORD_ID	INT primary key,
ORD_AMOUNT	INT NOT NULL,
ORD_DATE	DATE NOT NULL,
CUS_ID INT ,
PRICING_ID INT,
FOREIGN KEY (CUS_ID) REFERENCES customer(CUS_ID),
FOREIGN KEY (PRICING_ID) REFERENCES supplier_pricing(PRICING_ID)
);

create table rating(
RAT_ID	INT primary key,
ORD_ID	INT,
RAT_RATSTARS INT NOT NULL,
FOREIGN KEY (ORD_ID) REFERENCES order_tb(ORD_ID)
);

-- Q2.2) Insert the following data in the table created above
-- ------------------Inserting data --------------------------

insert into supplier values 
(1,'Rajesh Retails','Delhi','1234567890'),
(2,'Appario Ltd.','Mumbai', '2589631470'),
(3,'Knome products','Banglore', '9785462315'),
(4,'Bansal Retails',	'Kochi'	, '8975463285'),
(5,'Mittal Ltd.','Lucknow','7898456532');

insert into customer values
(1,'AAKASH','9999999999','DELHI','M'),
(2,'AMAN','9785463215','NOIDA','M'),
(3,'NEHA','9999999999','MUMBAI','F'),
(4,'MEGHA','9994562399','KOLKATA','F'),
(5,'PULKIT','7895999999','LUCKNOW','M');


insert into category values
(1,'BOOKS'),
(2,'GAMES'),
(3,'GROCERIES'),
(4,'ELECTRONICS'),
(5,'CLOTHES');


insert into product values
(1,'GTAV','Windows7andabovewithi5processorand8GBRAM',2),
(2,'TSHIRT','SIZE-LwithBlack,BlueandWhitevariations',5),
(3,'ROGLAPTOP','Windows10with15inchscreen,i7processor,1TBSSD',4),
(4,'OATS','HighlyNutritiousfromNestle',3),
(5,'HARRYPOTTER','BestCollectionofalltimebyJ.KRowling',1),
(6,'MILK','1LTonedMIlk',3),
(7,'BoatEarphones','1.5MeterlongDolbyAtmos',4),
(8,'Jeans','StretchableDenimJeanswithvarioussizesandcolor',5),
(9,'ProjectIGI','compatiblewithwindows7andabove',2),
(10,'Hoodie','BlackGUCCIfor13yrsandabove',5),
(11,'RichDadPoorDad','WrittenbyRObertKiyosaki',1),
(12,'TrainYourBrain','ByShireenStephen',1);

insert into supplier_pricing values 
 (1,  1,  2,  1500)
,(2,  3,  5,  30000)
,(3,  5,  1,  3000)
,(4,  2,  3,  2500)
,(5,  4,  1,  1000)
,(6,  12,  2,  780)
,(7,  12,  4,  789)
,(8,  3,  1,  31000)
,(9,  1,  5,  1450)
,(10,  4,  2,  999)
,(11,  7,  3,  549)
,(12,  7,  4,  529)
,(13,  6,  2,  105)
,(14,  6,  1,  99)
,(15,  2,  5,  2999)
,(16,  5,  2,  2999);



insert into order_tb values
(101, 1500	,	'2021-10-06',	2,		1 ),
(102, 1000	,	'2021-10-12',	3,		5 ),
(103, 30000	,	'2021-09-16',	5,		2 ),
(104, 1500	,	'2021-10-05',	1,		1 ),
(105, 3000	,	'2021-08-16',	4,		3 ),
(106, 1450	,	'2021-08-18',	1,		9 ),
(107, 789	,	'2021-09-01',	3,		7 ),
(108, 780	,	'2021-09-07',	5,		6 ),
(109, 3000	,	'2021-00-10',	5,		3 ),
(110, 2500	,	'2021-09-10',	2,		4 ),
(111, 1000	,	'2021-09-15',	4,		5 ),
(112, 789	,	'2021-09-16',	4,		7 ),
(113, 31000	,	'2021-09-16',	1,		8 ),
(114, 1000	,	'2021-09-16',	3,		5 ),
(115, 3000	,	'2021-09-16',	5,		3 ),
(116, 99	,	'2021-09-17',	2,		14);


insert into rating values
(1	,	101	,	4),
(2	,	102	,	3),
(3	,	103	,	1),
(4	,	104	,	2),
(5	,	105	,	4),
(6	,	106	,	3),
(7	,	107	,	4),
(8	,	108	,	4),
(9	,	109	,	3),
(10	,	110	,	5),
(11	,	111	,	3),
(12	,	112	,	4),
(13	,	113	,	2),
(14	,	114	,	1),
(15	,	115	,	1),
(16	,	116	,	0);

-- --------------------Queries -----------------------
-- Q3.3)	Display the total number of customers based
--  on gender who have placed orders of worth at least Rs.3000.

select cus_gender, count(*) from customer where  cus_id in  (
	select cus_id from order_tb group by 1 having sum(ord_amount) >= 3000
) group by 1;

-- Q4.4)	Display all the orders along with product name ordered 
-- by a customer having Customer_Id=2

select ord.*, prd.pro_name from order_tb ord
inner join supplier_pricing sup_price
	on ord.pricing_id = sup_price.pricing_id
inner join product prd 
	on sup_price.pro_id = prd.pro_id
where ord.cus_id=2;

-- Q5.5)	Display the Supplier details who can supply more than one product.

select * from supplier where sup_id in (
	select supp_id from supplier_pricing group by 1 having count(pro_id)>1
) order by sup_id;


-- Q6.6)	Find the least expensive product from each category and 
-- print the table with category id, name, product name and price of the product

select cat.cat_id, cat.cat_name, prd.pro_id, prd.pro_name, min(supp_price) as product_price from category cat
inner join product prd 
	on cat.cat_id = prd.cat_id
inner join supplier_pricing sup_price
	on prd.pro_id = sup_price.pro_id
group by 1 order by cat.cat_id;


-- Q7.7)	Display the Id and Name of the Product ordered after “2021-10-05”.

select prd.pro_id,prd.pro_name from order_tb ord 
inner join supplier_pricing sup_price
	on ord.pricing_id = sup_price.pricing_id
inner join product prd
	on prd.pro_id = sup_price.pro_id
where ord.ord_date > '2021-10-05';

-- Q8.8)	Display customer name and gender whose names start or end with character 'A'.

select * from customer where ( cus_name like 'A%'  or cus_name like '%A');

-- Q9.9)Create a stored procedure to display supplier id, name, rating and Type_of_Service. 
-- For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print 
-- “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.

call display_service();






