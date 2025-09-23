-- day 17/100 days challenge


DROP TABLE IF EXISTS user_activities;

CREATE TABLE user_activities (
    user_id INT,
    activity VARCHAR(10), -- Either 'Login' or 'Logout'
    activity_time TIMESTAMP
);



INSERT INTO user_activities (user_id, activity, activity_time) VALUES
(1, 'Login', '2024-01-01 08:00:00'),
(1, 'Logout', '2024-01-01 12:00:00'),
(1, 'Login', '2024-01-01 13:00:00'),
(1, 'Logout', '2024-01-01 17:00:00'),
(2, 'Login', '2024-01-01 09:00:00'),
(2, 'Logout', '2024-01-01 11:00:00'),
(2, 'Login', '2024-01-01 14:00:00'),
(2, 'Logout', '2024-01-01 18:00:00'),
(3, 'Login', '2024-01-01 08:30:00'),
(3, 'Logout', '2024-01-01 12:30:00');

SELECT * FROM user_activities


-- Find out each users and productivity time in hour!
-- productivity time = login - logout time

WITH session1
AS
(SELECT
	*,
	LAG(activity_time) OVER(PARTITION BY user_id ORDER BY activity_time) as pre_activity_time,
	LAG(activity) OVER(PARTITION BY user_id ORDER BY activity_time) as pre_activity
FROM 
	user_activities
ORDER BY 1
),
session2
AS
(
SELECT
	user_id,
	pre_activity as login,
	pre_activity_time as login_time,
	activity as logout,
	activity_time as logout_time,
	EXTRACT(EPOCH FROM (activity_time - pre_activity_time))/3600 as diff_hour
FROM session1
WHERE pre_activity ILIKE 'login'
	AND
	activity ILIKE 'logout'
)
SELECT 
	user_id,
	ROUND(SUM(diff_hour),0) as hours
FROM session2
GROUP BY 1

