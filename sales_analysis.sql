-- Create Customers Table
CREATE TABLE customers (
    customer_id INT,
    name VARCHAR(50),
    city VARCHAR(50)
);

-- Create Orders Table
CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2)
);

-- Insert Sample Customers
INSERT INTO customers VALUES
(1, 'Asha', 'Chennai'),
(2, 'Ravi', 'Dubai'),
(3, 'Meera', 'Mumbai'),
(4, 'John', 'Abu Dhabi'),
(5, 'Sara', 'Delhi');

-- Insert Sample Orders
INSERT INTO orders VALUES
(101, 1, '2024-01-01', 500),
(102, 1, '2024-01-10', 700),
(103, 2, '2024-01-05', 1000),
(104, 2, '2024-02-01', 1500),
(105, 3, '2024-02-10', 300),
(106, 3, '2024-03-01', 400),
(107, 4, '2024-03-05', 2000),
(108, 5, '2024-03-15', 800),
(109, 5, '2024-04-01', 1200);

-- Total Revenue
SELECT SUM(amount) AS total_revenue
FROM orders;

-- Top 3 Customers
SELECT c.name, SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 3;

-- Second Highest Order per Customer
SELECT customer_id, order_id, amount
FROM (
    SELECT 
        customer_id,
        order_id,
        amount,
        DENSE_RANK() OVER (
            PARTITION BY customer_id
            ORDER BY amount DESC
        ) AS rnk
    FROM orders
) t
WHERE rnk = 2;

-- Running Total Revenue
SELECT 
    order_date,
    SUM(amount) OVER (ORDER BY order_date) AS running_total
FROM orders;
