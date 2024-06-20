SELECT Person_id 
FROM Person
GROUP BY person_id
HAVING COUNT(*) > 1 ;

SELECT *
FROM Person
WHERE person_id = 47395 OR person_id = 63574 OR person_id = 1785844;

UPDATE Movie_Cast
Set name='Miles Malleson', gender= '2'
WHERE person_id = '47395';

UPDATE Movie_Crew
Set name='Miles Malleson', gender= '2'
WHERE person_id = '47395';

UPDATE Movie_Cast
Set name='Cheung Ka-Fai', gender= '2'
WHERE person_id = '63574';

UPDATE Movie_Crew
Set name='Cheung Ka-Fai', gender= '2'
WHERE person_id = '63574';

UPDATE Movie_Cast
Set name='Peter Malota', gender= '2'
WHERE person_id = '1785844';

UPDATE Movie_Crew
Set name='Peter Malota', gender= '2'
WHERE person_id = '1785844';