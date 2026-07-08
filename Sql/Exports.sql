SELECT
DATE_FORMAT(
order_purchase_timestamp,
'%Y-%m'
) AS Month,
SUM(payment_value) Revenue
FROM orders o
JOIN order_payments p
ON o.order_id=p.order_id
WHERE order_status='delivered'
GROUP BY Month
ORDER BY Month;

SELECT
pct.product_category_name_english,
SUM(op.payment_value) Revenue,
COUNT(DISTINCT oi.order_id) Orders
FROM products pr
JOIN category_translation pct
ON pr.product_category_name=pct.product_category_name
JOIN order_items oi
ON pr.product_id=oi.product_id
JOIN order_payments op
ON oi.order_id=op.order_id
GROUP BY pct.product_category_name_english
ORDER BY Revenue DESC;

SELECT
customer_state,
SUM(payment_value) Revenue,
COUNT(DISTINCT o.order_id) Orders
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_payments p
ON o.order_id=p.order_id
WHERE order_status='delivered'
GROUP BY customer_state
ORDER BY Revenue DESC;