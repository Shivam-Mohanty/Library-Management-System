
# Library Management System

A full-stack database management project developed for a DBMS Lab. This system provides a backend API and a web interface to manage library books, members, librarians, and borrowing transactions.

**Author:** Shivam Kumar Mohanty

## Project Structure

* **backend/**: Contains the Go HTTP server (`main.go`) and module files.
* **database/**: Contains the SQL scripts for table creation (`schema.sql`) and test data (`seed_data.sql`).
* **frontend/**: Contains the HTML, CSS, and JavaScript files for the user interface.

## Prerequisites

* PostgreSQL
* Go (Golang)
* VS Code (with the Live Server extension)

*Note: If you are on Windows, run the Go backend in a standard PowerShell or Command Prompt terminal, not inside WSL, to ensure it connects properly to your local database.*

## Setup Instructions

### 1. Database
1. Open pgAdmin or your preferred SQL tool and connect to your local PostgreSQL server.
2. Create a new database: `CREATE DATABASE library;`
3. Connect to the `library` database.
4. Run the SQL code in `database/schema.sql` to create the tables.
5. Run the SQL code in `database/seed_data.sql` to insert the sample data.

### 2. Backend
1. Open a terminal and navigate to the `backend` folder.
2. Initialize the Go module and install the database driver:
   ```bash
   go mod init library-api
   go get [github.com/lib/pq](https://github.com/lib/pq)
   ```
3. Open `main.go` and update the connection string with your PostgreSQL password and port.
4. Start the server:
   ```bash
   go run main.go
   ```

### 3. Frontend
1. Open the `frontend` folder in VS Code.
2. Right-click `index.html` and select "Open with Live Server".
3. The dashboard will open in your browser and automatically fetch data from the database.

## Features Implemented

The included SQL scripts demonstrate various DBMS lab requirements, including:
* Data insertion and retrieval.
* Complex queries using JOIN clauses.
* Aggregation functions (SUM, COUNT).
* Date operations for calculating overdue fines.

***

Let me know if you need to adjust any of the steps or add specific details required by your instructor.
