CREATE DATABASE Sportswear;
USE Sportswear;

CREATE TABLE color (
    id INT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    extra_fee DECIMAL(6,2) CHECK (extra_fee >= 0)
);

INSERT INTO color VALUES
(1,'Red',50),
(2,'Green',30),
(3,'Blue',0),
(4,'Black',20),
(5,'White',0),
(6,'Yellow',0);

CREATE TABLE customer (
    id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    favorite_color_id INT,
    FOREIGN KEY (favorite_color_id) REFERENCES color(id)
);

INSERT INTO customer VALUES
(101,'Jay','Patel',1),
(102,'Dhruv','Shah',2),
(103,'Amit','Joshi',3),
(104,'Neha','Mehta',4),
(105,'Priya','Desai',5),
(106,'Rahul','Modi',6),
(107,'Riya','Kapoor',3);

CREATE TABLE category (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    parent_id INT NULL,
    FOREIGN KEY (parent_id) REFERENCES category(id)
);

INSERT INTO category VALUES
(1,'Top Wear',NULL),
(2,'Bottom Wear',NULL),
(3,'T-Shirt',1),
(4,'Jacket',1),
(5,'Joggers',2),
(6,'Shorts',2);

CREATE TABLE clothing (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    size VARCHAR(10) CHECK (size IN ('S','M','L','XL','2XL','3XL')),
    price DECIMAL(8,2) CHECK (price > 0),
    color_id INT NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (color_id) REFERENCES color(id),
    FOREIGN KEY (category_id) REFERENCES category(id)
);

INSERT INTO clothing VALUES
(201,'Sports T-Shirt','M',800,1,3),
(202,'Sports T-Shirt','L',850,2,3),
(203,'Sports T-Shirt','XL',900,3,3),
(204,'Winter Jacket','XL',2000,4,4),
(205,'Training Joggers','M',1200,5,5),
(206,'Training Joggers','L',1300,3,5),
(207,'Training Joggers','XL',1400,2,5),
(208,'Running Shorts','M',700,6,6),
(209,'Running Shorts','XL',750,1,6);

CREATE TABLE clothing_order (
    id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    clothing_id INT NOT NULL,
    items INT CHECK (items > 0),
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (clothing_id) REFERENCES clothing(id)
);

INSERT INTO clothing_order VALUES
(301,101,201,2,'2024-04-10'),
(302,101,203,1,'2024-05-12'),
(303,102,205,3,'2024-03-22'),
(304,103,204,1,'2024-06-18'),
(305,104,207,2,'2024-04-25'),
(306,105,208,4,'2024-07-02'),
(307,101,205,1,'2025-01-10');


--1. List the customers whose favorite color is Red or Green and name is Jay or Dhruv

    SELECT first_name
    FROM customer JOIN color
    ON color.id = customer.favorite_color_id
    WHERE first_name IN ('JAY','DHRUV') AND name IN ('RED','GREEN')

--2. List the different types of Joggers with their sizes.

    SELECT CLOTHING.name,size
    FROM clothing JOIN category
    ON clothing.category_id = category.id
    WHERE category.name = 'JOGGERS'

--3. List the orders of Jay of T-Shirt after 1st April 2024.

    SELECT *
    FROM clothing_order JOIN clothing
    ON clothing.id = clothing_order.clothing_id
    JOIN category
    ON category.id = clothing.category_id
    JOIN customer
    ON customer.id = clothing_order.customer_id
    WHERE customer.first_name = 'JAY' AND category.name = 'T-SHIRT' AND clothing_order.order_date > '2024-04-01'

--4. List the customer whose favorite color is charged extra.

    SELECT customer.first_name
    FROM color JOIN customer
    ON color.id = customer.favorite_color_id
    WHERE color.extra_fee IS NOT NULL

--5. List category wise clothing’s maximum price, minimum price, average price and number of clothing items.

    SELECT category.name,MAX(clothing.price),MIN(clothing.price),AVG(clothing.price),COUNT(clothing_order.items)
    FROM category JOIN clothing
    ON category.id = clothing.category_id
    JOIN clothing_order
    ON clothing_order.clothing_id = clothing.id
    GROUP BY category.name

--6. List the customers with no purchases at all.

    SELECT customer.first_name
    FROM customer 
    WHERE id NOT IN (
        SELECT customer_id
        FROM clothing_order
    )

--7. List the orders of favorite color with all the details.

    SELECT clothing_order.* 
    FROM color JOIN customer
    ON color.id = customer.favorite_color_id
    JOIN clothing_order
    ON clothing_order.customer_id = customer.id
    WHERE color.id = customer.favorite_color_id

--8. List the customers with total purchase value, number of orders and number of items purchased.

    SELECT customer.first_name,SUM(clothing.price*clothing_order.items),COUNT(clothing_order.id),COUNT(clothing_order.items)
    FROM customer JOIN clothing_order
    ON customer.id = clothing_order.customer_id
    JOIN clothing
    ON clothing.id = clothing_order.clothing_id
    GROUP BY customer.first_name

--9. List the Clothing item, Size, Order Value and Number of items sold during financial year 2024-25

    SELECT clothing_order.items,clothing.size,clothing.price,COUNT(clothing_order.items)
    FROM clothing_order JOIN clothing
    ON clothing.id = clothing_order.clothing_id
    WHERE YEAR(clothing_order.order_date) IN (2024,2025)

--10. List the customers who wears XL size.

    