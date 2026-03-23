package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"

	_ "github.com/lib/pq" // PostgreSQL driver
)

// Book struct maps to the Books table
type Book struct {
	BookID          int    `json:"book_id"`
	Title           string `json:"title"`
	Author          string `json:"author"`
	Publisher       string `json:"publisher"`
	YearPublished   int    `json:"year_of_publication"`
	AvailableCopies int    `json:"available_copies"`
}

var db *sql.DB

func main() {
	// Database connection string (Update with actual credentials)
	// Replace YOUR_PASSWORD and your PORT exactly
	connStr := "postgres://postgres:postgres@127.0.0.1:5432/library?sslmode=disable"
	var err error
	db, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		log.Fatal("Cannot connect to database:", err)
	}
	fmt.Println("Successfully connected to the database!")

	// Define API Endpoints
	http.HandleFunc("/api/books", getBooksHandler)
	http.HandleFunc("/api/overdue", getOverdueBooksHandler)

	// Start the server
	fmt.Println("Server running on port 8080...")
	log.Fatal(http.ListenAndServe(":8080", nil))
}

// Handler for Q2: Display all books
func getBooksHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Access-Control-Allow-Origin", "*")

	w.Header().Set("Content-Type", "application/json")

	rows, err := db.Query("SELECT * FROM Books")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var books []Book
	for rows.Next() {
		var b Book
		if err := rows.Scan(&b.BookID, &b.Title, &b.Author, &b.Publisher, &b.YearPublished, &b.AvailableCopies); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		books = append(books, b)
	}

	json.NewEncoder(w).Encode(books)
}

// Handler for Q6: Display details of overdue books
func getOverdueBooksHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	query := `
        SELECT book_id, member_id, due_date 
        FROM Issues 
        WHERE due_date < CURRENT_DATE AND return_date IS NULL
    `

	rows, err := db.Query(query)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	type OverdueIssue struct {
		BookID   int       `json:"book_id"`
		MemberID int       `json:"member_id"`
		DueDate  time.Time `json:"due_date"`
	}

	var overdue []OverdueIssue
	for rows.Next() {
		var issue OverdueIssue
		if err := rows.Scan(&issue.BookID, &issue.MemberID, &issue.DueDate); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		overdue = append(overdue, issue)
	}

	json.NewEncoder(w).Encode(overdue)
}
