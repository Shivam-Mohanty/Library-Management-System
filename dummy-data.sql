-- 1. Insert Data into Books Table
INSERT INTO Books (book_id, title, author, publisher, year_of_publication, available_copies) VALUES
(1, 'Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', 'Scholastic', 1997, 5),
(2, 'Introduction to Algorithms', 'Thomas H. Cormen', 'MIT Press', 2009, 3),
(3, 'Database System Concepts', 'Abraham Silberschatz', 'McGraw-Hill', 2019, 2),
(4, 'Harry Potter and the Chamber of Secrets', 'J.K. Rowling', 'Scholastic', 1998, 0),
(5, 'The God of Small Things', 'Arundhati Roy', 'IndiaInk', 1997, 4);

-- 2. Insert Data into Librarians Table
INSERT INTO Librarians (librarian_id, name, contact_details) VALUES
(1, 'Mr. Ramesh Nayak', 'ramesh.lib@library.com'),
(2, 'Ms. Sunita Mishra', 'sunita.lib@library.com');

-- 3. Insert Data into Members Table
INSERT INTO Members (member_id, name, email, phone_number, membership_date) VALUES
(101, 'Aarav Patel', 'aarav.p@example.com', '9876543210', '2024-05-15'), -- Joined after Jan 2024
(102, 'Priya Sharma', 'priya.s@example.com', '8765432109', '2023-11-20'),
(103, 'Rahul Dash', 'rahul.dash@example.com', '7654321098', '2025-02-10'), -- Joined after Jan 2024
(104, 'Sneha Mohanty', 'sneha.m@example.com', '6543210987', '2022-01-10'), 
(105, 'Amit Kumar', 'amit.k@example.com', '5432109876', '2021-06-15'); -- Old member, hasn't issued books recently

-- 4. Insert Data into Issues Table
-- Note: Assuming today's date is in March 2026 for the due dates
INSERT INTO Issues (issue_id, book_id, member_id, librarian_id, issue_date, due_date, return_date) VALUES
(1, 1, 101, 1, '2026-03-01', '2026-03-15', NULL), -- Currently overdue by member 101
(2, 2, 102, 2, '2026-03-10', '2026-03-24', NULL), -- Currently issued, not overdue yet
(3, 3, 101, 1, '2026-02-15', '2026-03-01', '2026-02-28'), -- Returned on time by member 101
(4, 5, 103, 2, '2026-03-05', '2026-03-19', NULL), -- Currently overdue
(5, 1, 104, 1, '2023-05-10', '2023-05-24', '2023-05-22'); -- Very old issue