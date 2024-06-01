DROP DATABASE IF EXISTS exam01;
CREATE DATABASE exam01;
USE exam01;

CREATE TABLE CUSTOMER(
	CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    Phone VARCHAR(10),
    Email VARCHAR(50),
    Address VARCHAR(50),
    Note VARCHAR(50)
);
CREATE TABLE CAR(
	CarID INT PRIMARY KEY AUTO_INCREMENT,
    Maker VARCHAR(50),
    Model VARCHAR(10),
    Year date,
    Color VARCHAR(10),
    Note VARCHAR(50)
);
CREATE TABLE `ORDER`(
	OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT, 
    CarID INT,
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
    FOREIGN KEY (CarID) REFERENCES CAR(CarID),
    Amount INT DEFAULT 1,
    SalePrice INT,
    OrderDate Date,
    DeliveryDate Date,
    DeliveryAddress VARCHAR(50),
    Status ENUM("đã đặt hàng", "đã giao", "đã hủy") DEFAULT("đã đặt hàng"),
    Note VARCHAR(50)
);
INSERT INTO CUSTOMER (Name, Phone, Email, Address, Note)
VALUES 
("John Doe", "1234567890", "john.doe@example.com", "123 Elm St", "Preferred customer"),
("Jane Smith", "0987654321", "jane.smith@example.com", "456 Oak St", "Frequent buyer"),
("Alice Johnson", "5551234567", "alice.johnson@example.com", "789 Pine St", "First-time customer"),
("Bob Brown", "5557654321", "bob.brown@example.com", "321 Maple St", "Loyal customer"),
("Charlie Green", "5559876543", "charlie.green@example.com", "654 Birch St", "VIP customer");

INSERT INTO CAR (Maker, Model, Year, Color, Note)
VALUES
("Toyota", "Corolla", "2020-01-01", "Red", "Popular model"),
("Honda", "Civic", "2021-01-01", "Blue", "New arrival"),
("Ford", "Focus", "2019-01-01", "Black", "On sale"),
("Chevrolet", "Malibu", "2022-01-01", "White", "Top-rated"),
("Nissan", "Altima", "2023-01-01", "Silver", "Latest model");

INSERT INTO `ORDER` (CustomerID, CarID, Amount, SalePrice, OrderDate, DeliveryDate, DeliveryAddress, Status, Note)
VALUES
(1, 1, 1, 20000, "2023-05-01", "2023-05-15", "123 Elm St", "đã giao", "Delivered on time"),
(2, 2, 1, 22000, "2023-05-02", "2023-05-16", "456 Oak St", "đã giao", "Delivered with delay"),
(3, 3, 1, 18000, "2023-05-03", "2023-05-17", "789 Pine St", "đã đặt hàng", "Awaiting delivery"),
(4, 4, 1, 25000, "2023-05-04", "2023-05-18", "321 Maple St", "đã đặt hàng", "Processing"),
(5, 5, 1, 30000, "2023-05-05", "2023-05-19", "654 Birch St", "đã hủy", "Order cancelled by customer"),
(1, 2, 1, 21000, "2023-05-06", "2023-05-20", "123 Elm St", "đã giao", "Smooth transaction"),
(2, 3, 1, 19000, "2023-05-07", "2023-05-21", "456 Oak St", "đã giao", "Customer satisfied"),
(3, 4, 2, 50000, "2023-05-08", "2023-05-22", "789 Pine St", "đã đặt hàng", "Waiting for stock"),
(4, 5, 1, 31000, "2023-05-09", "2023-05-23", "321 Maple St", "đã đặt hàng", "Pending confirmation"),
(5, 1, 1, 20500, "2023-05-10", "2023-05-24", "654 Birch St", "đã hủy", "Out of stock"),
(1, 3, 1, 19500, "2023-05-11", "2023-05-25", "123 Elm St", "đã giao", "On time"),
(2, 4, 1, 25500, "2023-05-12", "2023-05-26", "456 Oak St", "đã giao", "Customer happy"),
(3, 5, 1, 30500, "2023-05-13", "2023-05-27", "789 Pine St", "đã đặt hàng", "Awaiting delivery"),
(4, 1, 1, 21500, "2023-05-14", "2023-05-28", "321 Maple St", "đã đặt hàng", "Pending stock"),
(5, 2, 1, 22000, "2023-05-15", "2023-05-29", "654 Birch St", "đã hủy", "Cancelled by customer"),
(1, 4, 1, 26000, "2023-05-16", "2023-05-30", "123 Elm St", "đã giao", "Delivered as promised"),
(2, 5, 1, 31000, "2023-05-17", "2023-05-31", "456 Oak St", "đã giao", "Satisfied customer"),
(3, 1, 1, 20000, "2023-05-18", "2023-06-01", "789 Pine St", "đã đặt hàng", "Processing order"),
(4, 2, 1, 22500, "2023-05-19", "2023-06-02", "321 Maple St", "đã đặt hàng", "Pending shipment"),
(5, 3, 1, 20000, "2023-05-20", "2023-06-03", "654 Birch St", "đã hủy", "Customer request"),
(1, 5, 1, 32000, "2023-05-21", "2023-06-04", "123 Elm St", "đã giao", "Excellent service"),
(2, 1, 1, 21000, "2023-05-22", "2023-06-05", "456 Oak St", "đã giao", "Quick delivery"),
(3, 2, 2, 44000, "2023-05-23", "2023-06-06", "789 Pine St", "đã đặt hàng", "Bulk order"),
(4, 3, 1, 19500, "2023-05-24", "2023-06-07", "321 Maple St", "đã đặt hàng", "Awaiting stock"),
(5, 4, 1, 27000, "2023-05-25", "2023-06-08", "654 Birch St", "đã hủy", "Cancelled by system");


SELECT Customer.Name, Sum(Amount) AS total_buy FROM Customer
LEFT JOIN `ORDER` USING (CustomerID)
GROUP BY Name
ORDER BY total_buy ASC;

DROP FUNCTION IF EXISTS GetTopMaker;
DELIMITER $$
CREATE FUNCTION GetTopMaker() 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE top_maker VARCHAR(50);
    
    SELECT Maker INTO top_maker
    FROM CAR
    LEFT JOIN `Order` USING (CarID)
    WHERE YEAR(DeliveryDate) = YEAR(CURRENT_DATE())
    GROUP BY Maker
    ORDER BY COUNT(*) DESC
    LIMIT 1;
    
    RETURN top_maker;
END$$
DELIMITER ;
Select GetTopMaker();
DROP PROCEDURE IF EXISTS delete_canceled_order;

DELIMITER $$
CREATE PROCEDURE delete_canceled_order() 
BEGIN
	SELECT Count(*)
    FROM `Order`
    WHERE Status Like "đã hủy" AND YEAR(OrderDate) < YEAR(NOW());
    
    DELETE FROM `Order`
    WHERE Status Like "đã hủy" AND YEAR(OrderDate) < YEAR(CURRENT_DATE());
END$$
DELIMITER ;

Call delete_canceled_order();

