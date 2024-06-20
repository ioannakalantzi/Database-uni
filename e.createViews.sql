CREATE VIEW Actor AS
SELECT DISTINCT person_id, gender, name
FROM Movie_Cast

CREATE VIEW CrewMember AS
SELECT DISTINCT person_id, gender, name
FROM Movie_Crew

CREATE VIEW Person AS
SELECT DISTINCT person_id, gender, name FROM Actor
UNION
SELECT DISTINCT person_id, gender, name FROM CrewMember