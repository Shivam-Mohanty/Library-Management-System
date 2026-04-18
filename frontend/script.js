// Base URL for your Go API
const API_BASE_URL = 'http://localhost:8080/api';

// Fetch data as soon as the page loads
document.addEventListener('DOMContentLoaded', () => {
    fetchBooks();
    
    // Add event listeners for the search feature
    const searchBtn = document.getElementById('searchBtn');
    const searchInput = document.getElementById('searchInput');
    
    if (searchBtn && searchInput) {
        searchBtn.addEventListener('click', searchBooks);
        
        // Listen for live input changes to make it update with each letter
        searchInput.addEventListener('input', searchBooks);
        
        searchInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                searchBooks();
            }
        });
    }
});

// Function to fetch and display books
async function fetchBooks() {
    const tableBody = document.querySelector('#booksTable tbody');
    
    try {
        // Show loading state
        tableBody.innerHTML = '<tr><td colspan="5" class="loading">Fetching data from Go server...</td></tr>';

        // Make the HTTP GET request to your Go backend
        const response = await fetch(`${API_BASE_URL}/books`);
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const books = await response.json();
        
        // Clear the table
        tableBody.innerHTML = '';

        // Check if database is empty
        if (!books || books.length === 0) {
            tableBody.innerHTML = '<tr><td colspan="5" class="loading">No books found in the database.</td></tr>';
            return;
        }

        // Loop through the data and create table rows
        books.forEach(book => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${book.book_id}</td>
                <td><strong>${book.title}</strong></td>
                <td>${book.author}</td>
                <td>${book.publisher}</td>
                <td>
                    <span style="color: ${book.available_copies > 0 ? 'green' : 'red'}; font-weight: bold;">
                        ${book.available_copies}
                    </span>
                </td>
            `;
            tableBody.appendChild(row);
        });

    } catch (error) {
        console.error("Error fetching books:", error);
        tableBody.innerHTML = `<tr><td colspan="5" style="color: red; text-align: center;">Error connecting to the database API. Is your Go server running?</td></tr>`;
    }
}

// Function to handle fetching and displaying search results
async function searchBooks() {
    const searchInput = document.getElementById('searchInput');
    if (!searchInput) return;

    const keyword = searchInput.value.trim();
    if (!keyword) {
        // If input is empty, reload full catalog
        fetchBooks();
        return;
    }

    const tableBody = document.querySelector('#booksTable tbody');
    
    try {
        // Show loading state
        tableBody.innerHTML = '<tr><td colspan="5" class="loading">Searching...</td></tr>';

        // Make the HTTP GET request with query param
        const response = await fetch(`${API_BASE_URL}/search?q=${encodeURIComponent(keyword)}`);
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const books = await response.json();
        
        // Clear the table
        tableBody.innerHTML = '';

        // Check if no results found
        if (!books || books.length === 0) {
            tableBody.innerHTML = '<tr><td colspan="5" class="loading">No books found matching your search.</td></tr>';
            return;
        }

        // Display the filtered data
        books.forEach(book => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${book.book_id}</td>
                <td><strong>${book.title}</strong></td>
                <td>${book.author}</td>
                <td>${book.publisher}</td>
                <td>
                    <span style="color: ${book.available_copies > 0 ? 'green' : 'red'}; font-weight: bold;">
                        ${book.available_copies}
                    </span>
                </td>
            `;
            tableBody.appendChild(row);
        });

    } catch (error) {
        console.error("Error searching books:", error);
        tableBody.innerHTML = `<tr><td colspan="5" style="color: red; text-align: center;">Error connecting to the database API. Is your Go server running?</td></tr>`;
    }
}