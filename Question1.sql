-- SQL Question 
/*For each user, find:

- The **longest consecutive login streak**
- The **start date** of that streak
- The **end date** of that streak
*/


-- SQL Question Solution

CREATE TABLE logins (
    user_id INT,
    login_date DATE
);

INSERT INTO logins (user_id, login_date) VALUES
-- User 1 (streaks: 3 days, then 2 days)
(1, '2024-01-01'),
(1, '2024-01-02'),
(1, '2024-01-03'),
(1, '2024-01-05'),
(1, '2024-01-06'),

-- User 2 (streak: 4 days)
(2, '2024-02-10'),
(2, '2024-02-11'),
(2, '2024-02-12'),
(2, '2024-02-13'),

-- User 3 (no consecutive streak)
(3, '2024-03-01'),
(3, '2024-03-03'),
(3, '2024-03-05'),

-- User 4 (multiple streaks: 2 days, then 3 days)
(4, '2024-04-01'),
(4, '2024-04-02'),
(4, '2024-04-05'),
(4, '2024-04-06'),
(4, '2024-04-07'),

-- User 5 (edge case: same day duplicate + long streak)
(5, '2024-05-01'),
(5, '2024-05-01'),
(5, '2024-05-02'),
(5, '2024-05-03'),
(5, '2024-05-04');

SELECT * FROM logins;


-- Solution Approach 1

WITH table1
AS
(SELECT 
	DISTINCT user_id,
	login_date
FROM logins
ORDER BY user_id
),
table2
AS
(SELECT 
	user_id,
	login_date,
	ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY login_date) as rn
FROM table1),
table3
AS
(SELECT 
	user_id,
	login_date,
	rn,
	login_date - (rn || 'days')::interval as streak_date
FROM table2),
table4
AS
(SELECT 
	user_id,
	streak_date,
	MIN(login_date) as streak_startDate,
	MAX(login_date) as streak_endDate,
	COUNT(*) as total_days,
	RANK() OVER(PARTITION BY user_id ORDER BY COUNT(*) DESC) as rnk
FROM table3
GROUP BY user_id, streak_date
ORDER BY user_id
)
SELECT
	user_id,
	streak_startDate,
	streak_endDate
FROM table4
WHERE rnk = 1;
	