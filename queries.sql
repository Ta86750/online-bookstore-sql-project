-- ============================================
-- 📚 ONLINE BOOKSTORE SQL PROJECT
-- ============================================


-- ============================================
-- 🔍 BASIC LEVEL QUERIES
-- ============================================

-- 1) Retrieve all books in the "Fiction" genre
SELECT * FROM books
WHERE genre = 'Fiction';

-- 2) Find books published after the year 1950
SELECT * FROM books
WHERE published_year > 1950;

-- 3) List all customers from Canada
SELECT * FROM customers
WHERE country = 'Canada';

-- 4) Show orders placed in November 2023
SELECT * FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available
SELECT SUM(stock) AS total_stock
FROM books;

-- 6) Find the details of the most expensive book
SELECT * FROM books
ORDER BY price DESC
LIMIT 1;

-- 7) Show all orders where quantity > 1
SELECT * FROM orders
WHERE quantity > 1;

-- 8) Retrieve all orders where total amount > 20
SELECT * FROM orders
WHERE total_amount > 20;

-- 9) List all genres available
SELECT DISTINCT genre
FROM books;

-- 10) Find the book with the lowest stock
SELECT * FROM books
ORDER BY stock ASC
LIMIT 1;

-- 11) Calculate total revenue
SELECT SUM(total_amount) AS revenue
FROM orders;


-- ============================================
-- 📊 INTERMEDIATE LEVEL QUERIES
-- ============================================

-- 1) Average price of Fantasy books
SELECT AVG(price) AS average_price
FROM books
WHERE genre = 'Fantasy';

-- 2) Top 3 most expensive Fantasy books
SELECT * FROM books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;

-- 3) Total books sold per genre
SELECT b.genre, SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.genre;

-- 4) Total books sold by each author
SELECT b.author, SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.author;


-- ============================================
-- 🚀 ADVANCED LEVEL QUERIES
-- ============================================

-- 1) Customers with at least 2 orders
SELECT o.customer_id, c.name, COUNT(o.order_id) AS order_count
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(o.order_id) >= 2;

-- 2) Most frequently ordered book
SELECT o.book_id, b.title, COUNT(o.order_id) AS order_count
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY o.book_id, b.title
ORDER BY order_count DESC
LIMIT 1;

-- 3) Cities where customers spent more than 30
SELECT DISTINCT c.city
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.total_amount > 30;

-- 4) Customer who spent the most
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 1;

-- 5) Remaining stock after orders
SELECT b.book_id, b.title, b.stock,
       COALESCE(SUM(o.quantity), 0) AS ordered_quantity,
       b.stock - COALESCE(SUM(o.quantity), 0) AS remaining_quantity
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock
ORDER BY b.book_id;
