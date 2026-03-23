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