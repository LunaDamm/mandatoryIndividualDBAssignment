SET default_storage_engine=InnoDB;
DROP DATABASE IF EXISTS resturantDB;
CREATE DATABASE resturantDB;
USE resturantDB;

CREATE TABLE `customers` (
   customerID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   firstName VARCHAR(100) NOT NULL,
   lastName VARCHAR(100) NOT NULL,
   email VARCHAR(100) NOT NULL UNIQUE,
   phone VARCHAR(20)
);

CREATE TABLE `tables` (
   tableID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   seatingCapacity INT NOT NULL
);

CREATE TABLE `bookings` (
   bookingID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   customerID INT NOT NULL,
   tableID INT NOT NULL,
   bookingDate DATE NOT NULL,
   bookingTime TIME NOT NULL,
   numOfPpl INT UNSIGNED NOT NULL,
   FOREIGN KEY (customerID) REFERENCES `customers`(customerID),
   FOREIGN KEY (tableID) REFERENCES `tables`(tableID)
);

INSERT INTO `customers` (customerID, firstName, lastName, email, phone) VALUES
   (NULL, 'Søren', 'Sæl', 'soeren@sael.com', '+45 20 11 22 33'),
   (NULL, 'Peter', 'Panda', 'peter@panda.com', '+45 21 34 56 78'),
    (NULL, 'Silje', 'Søløve', 'silje@søløve.com', '+45 22 33 44 55'),
    (NULL, 'Lars', 'Løve', 'lars@løve.com', '+45 23 45 67 89'),
    (NULL, 'Mette', 'Måge', 'mette@måge.com', '+45 24 56 78 90'),
    (NULL, 'Kim', 'Kænguru', 'kim@kænguru.com', '+45 25 67 89 01'),
    (NULL, 'Nina', 'Næsehorn', 'nina@Næsehorn.com', '+45 26 78 90 12');

INSERT INTO `tables` (tableID, seatingCapacity) VALUES
   (NULL, 4),
   (NULL, 4),
   (NULL, 8);

INSERT INTO `bookings` (bookingID, customerID, tableID, bookingDate, bookingTime, numOfPpl) VALUES
   (NULL, 1, 1, '2026-10-02', '18:00:00', 2),
   (NULL, 2, 2, '2026-10-03', '19:00:00', 2),
   (NULL, 3, 3, '2026-10-03', '20:00:00', 4),
   (NULL, 4, 2, '2026-10-03', '21:00:00', 4),
   (NULL, 5, 3, '2026-10-03', '18:30:00', 5),
   (NULL, 6, 1, '2026-10-03', '19:30:00', 2),
   (NULL, 7, 3, '2026-10-03', '20:30:00', 7),
   (NULL, 1, 3, '2026-10-03', '21:30:00', 8);

-- Get a list of all tables in the restaurant (overview for the front-end)
SELECT t.tableID, t.seatingCapacity
FROM `tables` AS t
ORDER BY t.tableID;

-- Get a list of all bookings for a given customer (when they arrive at the restaurant) ordered by date
SELECT b.bookingID, b.bookingDate, b.bookingTime, b.numOfPpl
FROM `bookings` AS b
WHERE b.customerID = 1
ORDER BY b.bookingDate, b.bookingTime;

-- Get a list of all bookings for a given tableID, including the customers for a specific date
SELECT b.bookingID, c.firstName, c.lastName, b.bookingTime, b.numOfPpl
FROM `bookings` AS b
JOIN `customers` AS c ON b.customerID = c.customerID
WHERE b.tableID = 3 AND b.bookingDate = '2026-10-03'
ORDER BY b.bookingTime;
