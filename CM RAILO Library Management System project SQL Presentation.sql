-- MANDY'S PRESENTATION
-- Library Management System SQL project

 CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Create Books table 
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(50) NOT NULL,
    Author VARCHAR(50) NOT NULL,
    PublicationDate DATE NOT NULL,
    Genre VARCHAR(20)
);

-- Create Borrowers table
CREATE TABLE Borrowers (
    BorrowerID INT PRIMARY KEY,
    Names VARCHAR(50) NOT NULL,
    Email VARCHAR(30) UNIQUE,
    Phone VARCHAR(20) NOT NULL
);

-- Create Loans table 
CREATE TABLE Loans (
LoanID INT PRIMARY KEY,
BookID INT,
BorrowerID INT,
LoanDate DATE,
ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
);

-- Create Fines table
CREATE TABLE Fines (
    FineID INT PRIMARY KEY,
    LoanID INT,
    FineAmount DECIMAL(10,2),
    FineDate DATE,
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);

-- Create Payments table 
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    FineID INT,
    PaymentAmount DECIMAL(10,2),
    PaymentDate DATE,
    FOREIGN KEY (FineID) REFERENCES Fines(FineID)
);

-- Insert in Books
INSERT INTO Books (BookID, Title, Author, PublicationDate, Genre) VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', '2010-07-11', 'Fiction'),
(2, '1984', 'George Orwell', '2009-06-08', 'Dystopian'),
(3, 'Medicine in Depth', 'John Smith', '2015-10-18', 'Health and Medicine'),
(4, 'The Great Gatsby', 'F. Scott Fitzgerald', '2018-04-10', 'Classic'),
(5, 'War and Peace', 'Leo Tolstoy', '2023-01-01', 'Historical'),
(6, 'Crime and Punishment', 'Fyodor Dostoevsky', '2025-01-01', 'Psychological'),
(7, 'Pride and Prejudice', 'Jane Austen', '2016-01-28', 'Romance'),
(8, 'Tissues and Organs', 'Dr. Aldous Huxley', '2007-08-30', 'Health and Medicine'),
(9, 'The Hobbit', 'J.R.R. Tolkien', '2012-09-21', 'Fantasy'),
(10, 'The Catcher in the Rye', 'J.D. Salinger', '2012-07-16', 'Fiction');

SELECT DISTINCT Genre
FROM Books;

UPDATE Books
SET Author = 'Dr. John Smith'
WHERE BOOKID =3;

SELECT * FROM books;

-- Insert in Borrowers
INSERT INTO Borrowers (BorrowerID, Names, Email, Phone) VALUES
(1, 'Alice Johnson', 'alicej@gmail.com', '+2771-456-7890'),
(2, 'Bob Smith', 'bobs@gmail.com', '+2782-567-8901'),
(3, 'Charlie Brown', 'charlieb@gmail.com', '+2778-678-9012'),
(4, 'David White', 'davidw@gmail.com', '+2779-789-0123'),
(5, 'Emma Wilson', 'emmaw@gmail.com', '+2786-890-1234'),
(6, 'Frank Thomas', 'frankt@gmail.com', '+2786-901-2345'),
(7, 'Grace Hall', 'graceh@gmail.com', '+2771-012-3456'),
(8, 'Henry King', 'henryk@gmail.com', '+2782-123-4567'),
(9, 'Ivy Adams', 'ivya@gmail.com', '+2778-234-5678'),
(10, 'Jack Carter', 'jackc@gmail.com', '+2773-345-6789');
SELECT *FROM borrowers;

-- Books borrowed by a particular person
SELECT B.Names, L.LoanID, BK.Title, L.LoanDate, L.ReturnDate
FROM Borrowers B
INNER JOIN Loans L ON B.BorrowerID = L.BorrowerID
INNER JOIN Books BK ON L.BookID = BK.BookID
WHERE B.Names = 'Alice Johnson';

-- Finding books that are either Fiction OR Fantasy
SELECT * FROM Books
WHERE Genre = 'Fiction' 
OR Genre = 'Fantasy';

-- Insert in Loans
INSERT INTO Loans (LoanID, BookID, BorrowerID, LoanDate, ReturnDate) VALUES
(1, 3, 1, '2025-01-01', '2025-01-10'),
(2, 2, 2, '2025-01-02', '2025-01-16'),
(3, 8, 1, '2025-01-10', '2025-01-17'),
(4, 4, 5, '2025-01-10', '2025-01-18'),
(5, 5, 3, '2025-01-12', '2025-01-19'),
(6, 6, 6, '2025-01-14', '2025-01-20'),
(7, 3, 7, '2025-01-15', '2025-01-21'),
(8, 7, 5, '2025-01-20', '2025-01-22'),
(9, 1, 9, '2025-01-27', '2025-01-30'),
(10, 10, 10, '2025-01-27', '2025-02-05'),
(11, 9, 4, '2025-01-28', '2025-02-05'),
(12, 6, 8, '2025-01-31', '2025-02-08');
SELECT * FROM loans;

-- Insert Fines
INSERT INTO Fines (FineID, LoanID, FineAmount, FineDate) VALUES
(1, 2, 3.00, '2025-01-17'),
(2, 3, 4.50, '2025-01-18'),
(3, 5, 6.00, '2025-01-20'),
(4, 6, 3.50, '2025-01-21'),
(5, 7, 7.00, '2025-01-22'),
(6, 9, 4.00, '2025-01-24');
SELECT * FROM fines;

SELECT * FROM Fines
WHERE FineAmount > 5.00 
AND FineDate BETWEEN '2025-01-01' AND '2025-01-31';

-- Insert Payments 
INSERT INTO Payments (PaymentID, FineID, PaymentAmount, PaymentDate) VALUES
(1, 1, 3.00, '2025-01-18'),
(2, 2, 4.50, '2025-01-19'),
(3, 3, 18.00, '2025-01-22'),
(4, 4, 7.00, '2025-01-23'),
(5, 5, 7.00, '2025-01-23'),
(6, 6, 4.00, '2025-01-25');
SELECT * FROM payments;
-- Get a list of unique book genres
SELECT DISTINCT Genre
FROM Books;

-- How much has been paid for fines in total,so we sum up all of the payments
SELECT SUM(P.PaymentAmount) AS TotalPayments 
FROM Payments P;

--  Finding fines greater than 5.00 AND issued in January 2025
SELECT * FROM Fines
WHERE FineAmount > 5.00 
AND FineDate BETWEEN '2025-01-01' AND '2025-01-31';

SELECT * FROM Books
WHERE Genre = 'Fiction' 
OR Genre = 'Health and Medicine';


-- Creating View
CREATE VIEW BorrowerLoanDetails AS
SELECT 
B.BorrowerID, B.Names, B.Email, 
L.LoanID, L.LoanDate, L.ReturnDate, 
BK.Title AS BookTitle, F.FineAmount, P.PaymentAmount
FROM Borrowers B
INNER JOIN Loans L ON B.BorrowerID = L.BorrowerID
INNER JOIN Books BK ON L.BookID = BK.BookID
LEFT JOIN Fines F ON L.LoanID = F.LoanID
LEFT JOIN Payments P ON F.FineID = P.FineID;
SELECT * FROM BorrowerLoanDetails;

-- creating Stored Function
-- This stored function GetTotalFineAmount will be called with the provided BorrowerID value and give us the amount a person owes
DELIMITER $$
CREATE FUNCTION GetTotalFineAmount(BorrowerID INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
DECLARE TotalFine DECIMAL(10,2);
SELECT SUM(F.FineAmount) INTO TotalFine 
FROM Fines F
INNER JOIN Loans L ON F.LoanID = L.LoanID
WHERE L.BorrowerID = BorrowerID;
RETURN TotalFine;
END$$
DELIMITER ;
-- stored function GetTotalFineAmount will be called with the provided BorrowerID value and give us the amount a person owes
SELECT GetTotalFineAmount(9) AS TotalFine;

-- Query to Check Fines per Borrower
SELECT B.BorrowerID, B.Names, GetTotalFineAmount(B.BorrowerID) AS TotalFine FROM Borrowers B;

-- For a detailed view of borrowers and their loan information, including fines and payments, 
SELECT * FROM BorrowerLoanDetails;

-- A subquery that helps analyze the total fines paid by each borrower and only shows borrowers who have paid more than $5.00 in fines.
SELECT BorrowerID, Names, TotalPaid
FROM (
SELECT B.BorrowerID, B.Names, SUM(P.PaymentAmount) AS TotalPaid
FROM Borrowers B
INNER JOIN Loans L ON B.BorrowerID = L.BorrowerID
INNER JOIN Fines F ON L.LoanID = F.LoanID
INNER JOIN Payments P ON F.FineID = P.FineID
GROUP BY B.BorrowerID, B.Names
) AS BorrowerPayments
WHERE TotalPaid > 5.00;

-- Creating a stored procedure and demonstrating how it runs
DELIMITER $$

CREATE PROCEDURE GetBorrowerLoanHistory(IN borrower_id INT)
BEGIN
    SELECT 
L.LoanID, B.Names, BK.Title AS BookTitle, 
L.LoanDate, L.ReturnDate, F.FineAmount, P.PaymentAmount
FROM Loans L
INNER JOIN Borrowers B ON L.BorrowerID = B.BorrowerID
INNER JOIN Books BK ON L.BookID = BK.BookID
LEFT JOIN Fines F ON L.LoanID = F.LoanID
LEFT JOIN Payments P ON F.FineID = P.FineID
WHERE L.BorrowerID = borrower_id;
END $$

DELIMITER ;
-- Running the Stored Procedure to get loan details for a specific borrower
CALL GetBorrowerLoanHistory(1);

-- query with group by and having to demonstrate how to extract data from your DB for analysis 
-- I want to count how many books each borrower has borrowed and only show those who borrowed more than 1 book.
SELECT Borrowers.Names, COUNT(Loans.LoanID) AS TotalBooksBorrowed
FROM Borrowers
JOIN Loans ON Borrowers.BorrowerID = Loans.BorrowerID
GROUP BY Borrowers.Names
HAVING COUNT(Loans.LoanID) > 1;

-- THE END OF PROJECT.