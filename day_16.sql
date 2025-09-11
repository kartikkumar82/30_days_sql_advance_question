-- 25/100 sql challenge

DROP TABLE IF EXISTS Friends;
CREATE TABLE Friends (
    id INT,
    friend_id INT 
);


DROP TABLE IF EXISTS Ratings;
CREATE TABLE Ratings (
    id INT PRIMARY KEY,
    rating INT
);

INSERT INTO Friends (id, friend_id)
VALUES
(1, 2),
(1, 3),
(2, 3),
(3, 4),
(4, 1),
(4, 2),
(5,NULL),
(6,NULL);


INSERT INTO Ratings (id, rating)
VALUES
(1, 85),
(2, 90),
(3, 75),
(4, 88),
(5, 82),
(6, 91);





SELECT * FROM Friends;
SELECT * FROM Ratings;

-- MNC data analyst interview 

-- Retrieve all Ids of a person whose rating is greater than friend's id
-- If person does not have any friend, retrieve only their id only if rating greater than 85



SELECT 
	DISTINCT(id)
FROM
(   SELECT
	    f.id,
		r.rating,
	    f.friend_id,
	    r1.rating
	FROM friends f
	LEFT JOIN ratings r
	    USING (id)
	LEFT JOIN ratings r1
	    ON f.friend_id = r1.id
	WHERE 
	    (
	        f.friend_id IS NOT NULL 
	        AND r.rating > r1.rating
	    )
	    OR 
	    (
	        f.friend_id IS NULL 
	        AND r.rating > 85
	    )
)

