-- Total stock
SELECT SUM(stock) AS Total_Stock FROM books;

-- Most expensive book
SELECT * FROM books ORDER BY price DESC LIMIT 1;

-- Orders with quantity > 1
SELECT * FROM orders WHERE quantity > 1;

-- Total revenue
SELECT SUM(total_amount) AS Revenue FROM orders;

-- Genre-wise sales
SELECT b.genre, SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.genre;

-- Top customer
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 1;
