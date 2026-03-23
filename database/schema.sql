-- Create Books Table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    publisher VARCHAR(255),
    year_of_publication INT,
    available_copies INT DEFAULT 0
);

-- Create Members Table
CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(15),
    membership_date DATE
);

-- Create Librarians Table
CREATE TABLE Librarians (
    librarian_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_details VARCHAR(255)
);

-- Create Issues Table
CREATE TABLE Issues (
    issue_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    librarian_id INT,
    issue_date DATE,
    due_date DATE,
    return_date DATE NULL,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (librarian_id) REFERENCES Librarians(librarian_id)
);

SELECT * FROM Books;

SELECT * FROM Members 
WHERE membership_date > '2024-01-01';

-- Replace 'J.K. Rowling' with the target author
SELECT * FROM Books 
WHERE author = 'J.K. Rowling';

SELECT * FROM Issues 
WHERE return_date IS NULL;

SELECT * FROM Issues 
WHERE due_date < CURRENT_DATE 
AND return_date IS NULL;

SELECT SUM(available_copies) AS total_available_books 
FROM Books;

-- Replace '101' with the target member_id
SELECT b.* FROM Books b
JOIN Issues i ON b.book_id = i.book_id
WHERE i.member_id = 101;

SELECT member_id, COUNT(issue_id) AS total_books_issued 
FROM Issues 
GROUP BY member_id;

SELECT book_id, COUNT(issue_id) AS issue_count 
FROM Issues 
GROUP BY book_id 
ORDER BY issue_count DESC 
LIMIT 1;

-- Syntax may vary slightly depending on the SQL dialect (this works in MySQL)
SELECT issue_id, 
       DATEDIFF(CURRENT_DATE, due_date) * 5 AS fine_amount
FROM Issues 
WHERE due_date < CURRENT_DATE 
AND return_date IS NULL;

SELECT b.title, m.name AS member_name, i.issue_date
FROM Issues i
JOIN Books b ON i.book_id = b.book_id
JOIN Members m ON i.member_id = m.member_id;

SELECT m.*
FROM Members m
LEFT JOIN Issues i ON m.member_id = i.member_id
WHERE i.issue_id IS NULL;

-- Assuming book_id 1 is being issued
UPDATE Books 
SET available_copies = available_copies - 1 
WHERE book_id = 1 AND available_copies > 0;

DELETE FROM Members 
WHERE member_id NOT IN (
    SELECT DISTINCT member_id 
    FROM Issues 
    WHERE issue_date >= DATE_SUB(CURRENT_DATE, INTERVAL 2 YEAR)
);