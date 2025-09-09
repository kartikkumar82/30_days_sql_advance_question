-- 14/30 days challenge
/*
Zomato's delivery system encountered an issue where each item's order was swapped with the next item's order. 
Your task is to correct this swapping error and return the proper pairing of order IDs and items. 
If the last item has an odd order ID, it should remain as the last item in the corrected data.
Write an SQL query to correct the swapping error and produce the corrected order pairs.
*/


DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    item VARCHAR(255) NOT NULL
);

INSERT INTO orders (order_id, item) VALUES
(1, 'Chow Mein'),
(2, 'Pizza'),
(3, 'Veg Nuggets'),
(4, 'Paneer Butter Masala'),
(5, 'Spring Rolls'),
(6, 'Veg Burger'),
(7, 'Paneer Tikka');

SELECT * FROM orders

WITH new_order
AS
(	SELECT
		COUNT(*) AS total_order
	FROM orders
)
SELECT 
	order_id as incorrect_order,
	CASE
	WHEN order_id % 2 <> 0 AND total_order <> order_id THEN order_id +1
	WHEN order_id % 2 <> 0 AND total_order = order_id THEN order_id
	ELSE order_id - 1 END as correct_order,
	item
FROM new_order
CROSS JOIN 
	orders
ORDER BY 2

