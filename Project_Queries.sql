SELECT subquery.year, SUM(subquery.movies_per_year) AS movies_per_year
FROM (
  SELECT YEAR(m.release_date) AS year, COUNT(*) AS movies_per_year
  FROM movie m
  WHERE budget > 1000000
  GROUP BY release_date
) AS subquery
GROUP BY subquery.year
ORDER BY subquery.year;

SELECT g.name AS genre, COUNT(*) AS movies_per_genre
FROM movie m
JOIN hasGenre hg 
ON hg.movie_id = m.id
JOIN genre g
ON g.id = hg.genre_id
WHERE m.budget > 1000000 OR m.runtime > 120
GROUP BY hg.genre_id, g.name

SELECT g.name AS genre,YEAR(m.release_date) AS year, COUNT(*) AS movies_per_gy
FROM movie m
JOIN hasGenre hg 
ON hg.movie_id = m.id
JOIN genre g
ON g.id = hg.genre_id
WHERE YEAR(m.release_date) IS NOT NULL
GROUP BY g.name, YEAR(m.release_date)
ORDER BY YEAR(m.release_date)

SELECT YEAR(m.release_date) AS year, SUM(m.revenue) AS revenues_by_year
FROM movie m
JOIN movie_cast mc ON m.id = mc.movie_id
WHERE mc.name = 'Leonardo DiCaprio'
GROUP BY YEAR(m.release_date)
ORDER BY year;

SELECT YEAR(m.release_date) AS year, MAX(m.budget) AS max_budget
FROM movie m
WHERE m.budget > 0
GROUP BY YEAR(m.release_date)
ORDER BY year;

SELECT c.name AS trilogy_name
FROM collection c
JOIN belongstoCollection bc ON c.id = bc.collection_id
GROUP BY c.id, c.name
HAVING COUNT(bc.movie_id) = 3;

SELECT AVG(r.rating) AS avg_rating, COUNT(r.rating) AS rating_count
FROM ratings r
GROUP BY r.user_id;

SELECT TOP 10 title AS movie_title, budget
FROM movie
WHERE budget > 0
ORDER BY budget DESC

SELECT YEAR(m.release_date) AS year, m.budget AS movies_with_max_budget
FROM movie m
WHERE m.budget = (
    SELECT MAX(budget)
    FROM movie
    WHERE YEAR(release_date) = YEAR(m.release_date) AND budget > 0
)
ORDER BY year, m.title;

CREATE VIEW Popular_Movie_Pairs AS
SELECT m1.id AS movie1_id, m2.id AS movie2_id, COUNT(*) AS popularity
FROM ratings r1
JOIN ratings r2 ON r1.user_id = r2.user_id AND r1.movie_id < r2.movie_id
JOIN movie m1 ON r1.movie_id = m1.id
JOIN movie m2 ON r2.movie_id = m2.id
WHERE r1.rating > 4 AND r2.rating > 4
GROUP BY m1.id, m2.id
HAVING COUNT(*) > 10;