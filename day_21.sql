-- 22/100 Days SQL Challenge

-- Given a user_activity table, write a SQL query to find all users who have logged in on at least 3 consecutive days.

DROP TABLE IF EXISTS user_activity;
CREATE TABLE user_activity (
    user_id INT,
    login_date DATE
);



INSERT INTO user_activity (user_id, login_date) VALUES
(1, '2024-08-01'),
(1, '2024-08-02'),
(1, '2024-08-05'),
(1, '2024-08-07'),
(2, '2024-08-01'),
(2, '2024-08-02'),
(2, '2024-08-03'),
(2, '2024-08-04'),
(2, '2024-08-06'),
(3, '2024-08-01'),
(3, '2024-08-02'),
(3, '2024-08-03'),
(3, '2024-08-07'),
(4, '2024-08-02'),
(4, '2024-08-05'),
(4, '2024-08-07');

-- Given a user_activity table, write a SQL query to find all users who have logged in on at least 3 consecutive days.


WITH steak
AS
(SELECT
	*,
	CASE
		WHEN login_date = LAG(login_date) OVER(PARTITION BY user_id ORDER BY login_date) + INTERVAL '1 day' THEN 1
		ELSE 0
	END AS pre_day_login
FROM user_activity),
steaks
AS 
(SELECT
	*,
	SUM(pre_day_login) OVER(PARTITION BY user_id ORDER BY login_date) as sum_of_day
FROM steak) 
SELECT
	DISTINCT user_id
FROM steaks
WHERE sum_of_day >= 2

