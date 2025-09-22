-- Day 19/100 days challenge

-- Spotify Data Analyst Interview question

/*
Question:
Analyze Spotify's user listening data to find out 
which genre of music has the highest average listening time per user.
*/

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS plays;

-- Create users table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    country VARCHAR(100)
);

-- Insert sample data into users table
INSERT INTO users (user_id, user_name, country) VALUES
(1, 'Alice', 'USA'),
(2, 'Bob', 'Canada'),
(3, 'Charlie', 'UK'),
(4, 'David', 'Germany'),
(5, 'Eva', 'France'),
(6, 'Frank', 'Australia'),
(7, 'Grace', 'Italy');

-- Create plays table
CREATE TABLE plays (
    user_id INT,
    song_id INT,
    genre VARCHAR(100),
    listening_time INT
);

-- Insert sample data into plays table
INSERT INTO plays (user_id, song_id, genre, listening_time) VALUES
(1, 101, 'Rock', 120),
(1, 102, 'Pop', 80),
(2, 103, 'Rock', 90),
(2, 104, 'Jazz', 60),
(3, 105, 'Classical', 150),
(3, 106, 'Rock', 110),
(4, 107, 'Pop', 90),
(4, 108, 'Classical', 70),
(5, 109, 'Jazz', 80),
(5, 110, 'Pop', 65),
(1, 111, 'Jazz', 50),
(2, 112, 'Classical', 40),
(3, 113, 'Pop', 100),
(4, 114, 'Rock', 70),
(5, 115, 'Classical', 60),
(6, 116, 'Rock', 130),
(6, 117, 'Pop', 120),
(7, 118, 'Jazz', 75),
(7, 119, 'Classical', 50),
(7, 120, 'Rock', 65);

-- which genre of music has the highest average listening time per user.
SELECT * FROM users;
SELECT * FROM plays;

WITH user_listen_time
AS
(SELECT
	user_id,
	genre,
	SUM(listening_time) as total_tym
FROM plays
GROUP BY 1,2
ORDER BY 1,2)

SELECT
	genre,
	ROUND(AVG(total_tym),2) as avg_time
FROM user_listen_time
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
