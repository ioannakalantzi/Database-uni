/*"Βρες μου τους τίτλους των ταινιών που ξεκινούν από "the..." και ο μέσος όρος βαθμολογίας τους, είναι ανάμεσα σε 2 και 4"
Output: 7 rows
*/

SELECT keyword.name, avg(ratings.rating) as average_rating
FROM haskeyword
INNER JOIN keyword
ON keyword.id = haskeyword.key_id
FULL OUTER JOIN ratings
ON ratings.movie_id = haskeyword.movie_id
GROUP BY keyword.name
HAVING keyword.name like 'the %' AND avg(ratings.rating) BETWEEN 2 AND 4

/*"Βρες μου τους ηθοποιούς που έχουν παίξει σε ταινίες με μέγιστη βαθμολογία μικρότερη του ενός,
μαζί με το όνομα της ταινίας"
Output: 153 rows
*/

SELECT m.name, mo.title 
FROM movie_cast m 
INNER JOIN ratings r 
ON m.movie_id=r.movie_id
INNER JOIN movie mo 
ON mo.id = m.movie_id 
GROUP BY m.movie_id, m.name, mo.title
HAVING max(r.rating)<1

/*"Βρες μου τις ιστοσελίδες των ταινιών με μέσο όρο βαθμολογίας 5, όταν αυτές υπάρχουν, 
μαζί με τον μέσο όρο βαθμολογίας τους"
Output: 4 rows
*/

SELECT m.homepage, avg(r.rating) as average_rating
FROM ratings r
FULL OUTER JOIN movie m 
ON id = movie_id
WHERE m.homepage IS NOT NULL
GROUP BY r.movie_id, m.homepage
HAVING avg(r.rating)=5

/*"Βρες μου τους τίτλους των 500 πρώτων ταινιών που κυκλοφόρησαν, μαζί με την ημερομηνία κυκλοφορίας τους"
Output: 500 rows
*/

SELECT TOP(500) m.original_title, m.release_date
FROM movie m
WHERE m.release_date IS NOT NULL
ORDER BY release_date

/*"Βρες μου τους ηθοποιούς και τον χαρακτήρα που έπαιξαν, σε αλφαβητική σειρά,
 σε ταινία που η μικρότερη βαθμολογία να είναι μεγαλύτερη του 4"
Output: 1290 rows
*/

SELECT DISTINCT m.name, m.character
FROM movie_cast m 
INNER JOIN ratings r 
ON m.movie_id = r.movie_id
WHERE m.character IS NOT NULL
GROUP BY m.name, m.character, m.movie_id
HAVING min(r.rating)>4
ORDER BY m.name

/*"Βρες μου το είδος και τον τίτλο των 20 πρώτων ταινιών σε δημοτικότητα, με φθίνουσα σειρά"
Output: 20 rows
*/

SELECT TOP(20) g.name, m.title,  m.popularity
FROM genre g 
INNER JOIN hasGenre hg 
ON g.id = hg.genre_id
INNER JOIN movie m 
ON hg.movie_id = m.id
GROUP BY hg.movie_id, g.name, m.popularity, m.title
ORDER BY m.popularity DESC

/*"Βρες μου όλους τους τίτλους των ταινιών οι οποίες ανήκουν στην κατηγορία Animation"
Output:256 rows
*/

SELECT m.title
FROM movie m
INNER JOIN hasGenre hg 
ON m.id = hg.movie_id
INNER JOIN genre g 
ON hg.genre_id = g.id
WHERE g.name = 'Animation' AND g.id = 16

/*"Βρες μου τους τιτλους των ταινιών οι οποίες έχουν κέρδη μεγαλύτερα απο 100 εκατ και
έχουν κριτικές πάνω από 4"
Output: 261 rows
*/

SELECT m.title
FROM movie m
INNER JOIN ratings r 
ON m.id = r.movie_id
GROUP BY m.revenue, r.rating, m.title
HAVING m.revenue > 100000000 AND r.rating > 4

/*"Βρες μου τους τίτλους των 10 ταινιών με τον μεγαλύτερο μέσο όρο βαθμολογίας, οι οποίες ανήκουν στην κατηγορία 
Adventure, μαζί με τον μέσο όρο σε φθίνουσα σειρά"
Output: 10 rows
*/

SELECT TOP(10) m.title, AVG(r.rating) AS avgRating
FROM movie m
INNER JOIN hasGenre hg ON m.id = hg.movie_id
INNER JOIN genre g 
ON hg.genre_id = g.id
INNER JOIN ratings r 
ON m.id = r.movie_id
WHERE g.name = 'Adventure' AND g.id = 12
GROUP BY m.id, m.title
ORDER BY avgRating DESC

/*"Βρες μου τους τίτλους των ταινιών οι οπόιες ξεκινάνε με "The.." 
και ανήκουν στην κατηγορία Drama"
Output: 1115 rows
*/

SELECT m.title
FROM movie m
INNER JOIN hasGenre hg 
ON m.id = hg.movie_id
INNER JOIN genre g 
ON hg.genre_id = g.id 
GROUP BY m.title, g.name
HAVING m.title LIKE 'The %' AND g.name = 'Drama'

/*"Βρες μου τους τιτλους των ταινιών οι οποίες ανήκουν στην κατηγορία Action
και έχουν μέσο όρο βαθμολογίας πάνω από 4, μαζί με τον μέσο όρο"
Output: 256 rows
*/

SELECT m.title, avg(ratings.rating) as avgRating
FROM movie m 
INNER JOIN hasGenre hg 
ON m.id = hg.movie_id
INNER JOIN genre g 
ON hg.genre_id = g.id AND g.name = 'Action' AND g.id = 28
FULL OUTER JOIN ratings
ON ratings.movie_id = m.id
GROUP BY m.title, ratings.rating
HAVING avg(ratings.rating)>4

/*"Βρές μου τους τίτλους ταινιών οι οπόιες έχουν βαθμολογία μεταξύ 3 και 5 και η γλώσσα τους είναι 
στα ιταλικά(it)"
Output: 18 rows
*/

SELECT DISTINCT m.title, avg(r.rating) as avgRatings 
FROM movie m
INNER JOIN ratings r 
ON m.id = r.movie_id
GROUP BY m.title , m.original_language
HAVING avg(r.rating) BETWEEN 3 AND 5 AND m.original_language = 'it'