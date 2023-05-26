create database ecommerce
USE ecommerce;
CREATE TABLE supplier (
SUPP_ID int PRIMARY Key, 
SUPP_NAME varchar(50) NOT NULL,
SUPP_CITY varchar(50) NOT NULL,
SUPP_PHONE varchar(50) NOT NULL
);

CREATE TABLE customer (
CUS_ID int PRIMARY Key, 
CUS_NAME varchar(20) NOT NULL,
CUS_PHONE varchar(10) NOT NULL,
CUS_CITY varchar(30) NOT NULL,
CUS_GENDER char
);

CREATE TABLE category (
CAT_ID int PRIMARY Key, 
CAT_NAME varchar(20) NOT NULL
);

CREATE TABLE product (
PRO_ID int PRIMARY Key, 
PRO_NAME varchar(20) NOT NULL default 'Dummy',
PRO_DESC varchar(60),
CAT_ID int,

FOREIGN KEY (CAT_ID)
REFERENCES category (CAT_ID)
);

CREATE TABLE supplier_pricing (
PRICING_ID int PRIMARY Key, 
PRO_ID int,
SUPP_ID int,
SUPP_PRICE int DEFAULT 0,

FOREIGN KEY (SUPP_ID)
REFERENCES supplier (SUPP_ID),

FOREIGN KEY (PRO_ID)
REFERENCES product (PRO_ID)

);

CREATE TABLE orders (
ORD_ID int PRIMARY Key, 
ORD_AMOUNT int NOT NULL,
ORD_DATE DATE,
CUS_ID int,
PRICING_ID int,

FOREIGN KEY (CUS_ID)
REFERENCES customer (CUS_ID),

FOREIGN KEY (PRICING_ID)
REFERENCES supplier_pricing (PRICING_ID)

);

CREATE TABLE rating (
RAT_ID int PRIMARY Key, 
ORD_ID int,
RAT_RATSTARS int NOT NULL,

FOREIGN KEY (ORD_ID)
REFERENCES orders (ORD_ID)
);

INSERT INTO supplier
VALUES
  (1, 'Rajesh Retails', 'Delhi', '1234567890'),
  (2, 'Appario Ltd.', 'Mumbai', '2589631470'),
  (3, 'Knome products', 'Banglore', '9785462315'),
  (4, 'Bansal Retails', 'Kochi', '8975463285'),
  (5, 'Mittal Ltd.', 'Lucknow', '7898456532')
  ;
  
INSERT INTO customer
VALUES
  (1, 'AAKASH', '9999999999', 'DELHI', 'M'),
  (2,'AMAN', '9785463215', 'NOIDA', 'M'),
  (3,'NEHA', '9999999999', 'MUMBAI', 'F'),
  (4,'MEGHA', '9994562399', 'KOLKATA', 'F'),
  (5, 'PULKIT', '7895999999', 'LUCKNOW', 'M')
  ;
  
  INSERT INTO category
VALUES
  (1, 'BOOKS'),
  (2,'GAMES'),
  (3,'GROCERIES'),
  (4,'ELECTRONICS'),
  (5, 'CLOTHES')
  ;

INSERT INTO product
VALUES
  (1, 'GTA V', 'Windows 7 and above with i5 processor and 8GB RAM', 2),
  (2, 'TSHIRT', '2 SIZE-L with Black, Blue, and White variations' ,5 ),
  (3, 'ROG LAPTOP', 'Windows 10 with 15-inch screen, i7 processor, 1TB SSD', 4),
  (4, 'OATS', 'Highly Nutritious from Nestle', 3),
  (5, 'HARRY POTTER', 'Best Collection of all time by J.K Rowling', 1),
  (6, 'MILK', '1L Toned Milk', 3),
  (7, 'Boat Earphones', '1.5-Meter long Dolby Atmos', 4),
  (8, 'Jeans', 'Stretchable Denim Jeans with various sizes and color', 5),
  (9, 'Project IGI', 'Compatible with Windows 7 and above', 2),
  (10, 'Hoodie', 'Black GUCCI for 13 yrs and above', 5),
  (11, 'Rich Dad Poor Dad', 'Written by Robert Kiyosaki', 1),
  (12, 'Train Your Brain', 'By Shireen Stephen', 1);
  
INSERT INTO supplier_pricing 
VALUE 
(1, 1, 2, 1500),
(2, 3, 5, 30000),
(3, 5, 1, 3000),
(4, 2, 3, 2500),
(5, 4, 1, 1000),
(6, 12, 2, 780),
(7, 12, 4, 789),
(8, 3, 1, 31000),
(9, 1, 5, 1450),
(10, 4, 2, 999),
(11, 7, 3, 549),
(12, 7, 4, 529),
(13, 6, 2, 105),
(14, 6, 1, 99),
(15, 2, 5, 2999),
(16, 5, 2, 2999)
;


INSERT INTO orders
VALUES
  (101, 1500, '2021-10-06', 2, 1),
  (102, 1000, '2021-10-12', 3, 5),
  (103, 30000, '2021-09-16', 5, 2),
  (104, 1500, '2021-10-05', 1, 1),
  (105, 3000, '2021-08-16', 4, 3),
  (106, 1450, '2021-08-18', 1, 7),
  (107, 789, '2021-09-01', 3, 7),
  (108, 780, '2021-09-07', 5, 6),
  (109, 3000, '2021-10-10', 5, 3),
  (110, 2500, '2021-09-10', 2, 4),
  (111, 1000, '2021-09-15', 4, 5),
  (112, 789, '2021-09-16', 4, 7),
  (113, 31000, '2021-09-16', 1, 8),
  (114, 1000, '2021-09-16', 3, 5),
  (115, 3000, '2021-09-16', 5, 3),
  (116, 99, '2021-09-17', 2, 14);

INSERT INTO rating
VALUES
  (1,101, 4),
  (2,102, 3),
  (3,103, 1),
  (4,104, 2),
  (5,105, 4),
  (6,106, 3),
  (7,107, 4),
  (8,108, 4),
  (9,109, 3),
  (10,110, 5),
  (11,111, 3),
  (12,112, 4),
  (13,113, 2),
  (14,114, 1),
  (15,115, 1),
  (16,116, 0);
  
  
 SELECT CUS_GENDER, COUNT(*) AS total_customers
FROM customer
WHERE CUS_ID IN (
    SELECT CUS_ID
    FROM orders
    WHERE ORD_AMOUNT >= 3000
    GROUP BY CUS_ID
)
GROUP BY CUS_GENDER; 

SELECT orders.ORD_ID, product.PRO_NAME
FROM orders
JOIN supplier_pricing ON orders.PRICING_ID = supplier_pricing.PRICING_ID
JOIN product ON supplier_pricing.PRO_ID = product.PRO_ID
WHERE orders.CUS_ID = 2;

SELECT supplier.supp_id, supplier.supp_name, supplier.supp_city, supplier.supp_phone
FROM supplier
JOIN supplier_pricing ON supplier.supp_id = supplier_pricing.supp_id
GROUP BY supplier.supp_id, supplier.supp_name, supplier.supp_city, supplier.supp_phone
HAVING COUNT(DISTINCT supplier_pricing.pro_id) > 1;

 SELECT c.cat_id, c.cat_name, p.pro_name, sp.supp_price
FROM category c
JOIN product p ON c.cat_id = p.cat_id
JOIN supplier_pricing sp ON p.pro_id = sp.pro_id
WHERE (c.cat_id, sp.supp_price) IN (
    SELECT cat_id, MIN(supp_price)
    FROM product
    JOIN supplier_pricing ON product.pro_id = supplier_pricing.pro_id
    GROUP BY cat_id
);

SELECT p.pro_id, p.pro_name
FROM product p
JOIN supplier_pricing sp ON p.pro_id = sp.pro_id
JOIN orders o ON sp.pricing_id = o.pricing_id
WHERE o.ord_date > '2021-10-05';


SELECT CUS_NAME, CUS_GENDER
FROM customer
WHERE CUS_NAME LIKE 'A%' OR CUS_NAME LIKE '%A';

DELIMITER //

CREATE PROCEDURE GetSupplierRatings()
BEGIN
    SELECT s.SUPP_ID, s.SUPP_NAME, AVG(r.RAT_RATSTARS) AS Rating,
    CASE
        WHEN AVG(r.RAT_RATSTARS) = 5 THEN 'Excellent Service'
        WHEN AVG(r.RAT_RATSTARS) > 4 THEN 'Good Service'
        WHEN AVG(r.RAT_RATSTARS) > 2 THEN 'Average Service'
        ELSE 'Poor Service'
    END AS Type_of_Service
    FROM supplier s
    JOIN supplier_pricing sp ON s.SUPP_ID = sp.SUPP_ID
    JOIN orders o ON sp.PRICING_ID = o.PRICING_ID
    JOIN rating r ON o.ORD_ID = r.ORD_ID
    GROUP BY s.SUPP_ID, s.SUPP_NAME;
END //

DELIMITER ;

CALL GetSupplierRatings();
