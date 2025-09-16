DROP TABLE IF EXISTS cinemas;
CREATE TABLE cinemas
    (id SERIAL, seat_id INT);

INSERT INTO cinemas(seat_id)
VALUES
    (1),
    (0),
    (0),
    (1),
    (1),
    (1),
    (0);

-- Write a SQL query to find the id where the seat is empty
-- and both the seat immediately before and immediately after it are also empty


-- 1 ---> empty
-- 0 ---> full


SELECT
	id
FROM
( 	SELECT 
		*,
		LAG(seat_id) OVER(ORDER BY id) as prev_seat_id,
		LEAD(seat_id) OVER(ORDER BY id)as nxt_seat_id
	FROM cinemas
) AS t1
WHERE 
	seat_id = 1
AND
	prev_seat_id = 1
AND
	nxt_seat_id = 1