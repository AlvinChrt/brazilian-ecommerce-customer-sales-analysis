# Total Revenue
SELECT
    ROUND(SUM(payment_value),2) AS total_revenue
FROM order_payments;

# Total Orders
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM orders;

# Total Customer
SELECT
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers;

# Order Status Distribution
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

# Revenue Trend per Month
SELECT
    DATE_FORMAT(
        o.order_purchase_timestamp,
        '%Y-%m'
    ) AS order_month,
    ROUND(
        SUM(op.payment_value),
        2
    ) AS revenue
FROM orders o
JOIN order_payments op
    ON o.order_id = op.order_id
WHERE o.order_status = 'delivered'
GROUP BY order_month
ORDER BY order_month;

# Revenue by Product Category
SELECT
    ct.product_category_name_english,
    ROUND(
        SUM(oi.price),
        2
    ) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN category_translation ct
    ON p.product_category_name =
       ct.product_category_name
GROUP BY
    ct.product_category_name_english
ORDER BY revenue DESC
LIMIT 10;

# Top States by Revenue
SELECT
    c.customer_state,
    ROUND(
        SUM(op.payment_value),
        2
    ) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments op
    ON o.order_id = op.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY revenue DESC;