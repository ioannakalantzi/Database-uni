ALTER TABLE movie
    ADD CONSTRAINT movie_pk
    PRIMARY KEY (id);

ALTER TABLE genre
    ADD CONSTRAINT genre_pk
    PRIMARY KEY (id);

ALTER TABLE productioncompany
    ADD CONSTRAINT productioncompany_pk
    PRIMARY KEY (id);

ALTER TABLE collection
    ADD CONSTRAINT collection_pk
    PRIMARY KEY (id);

ALTER TABLE movie_cast
    ADD CONSTRAINT movie_cast_pk
    PRIMARY KEY (cid);

ALTER TABLE movie_crew
    ADD CONSTRAINT movie_crew_pk
    PRIMARY KEY (cid);

ALTER TABLE keyword
    ADD CONSTRAINT keyword_pk
    PRIMARY KEY (id);

ALTER TABLE belongstocollection
    ADD CONSTRAINT FK_movieid FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE belongstocollection
    ADD CONSTRAINT FK_collectionid FOREIGN
KEY (collection_id)
    REFERENCES collection(id);

ALTER TABLE hasGenre
    ADD CONSTRAINT FK_movieid_genre FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE hasGenre
    ADD CONSTRAINT FK_genreid FOREIGN
KEY (genre_id)
    REFERENCES genre(id);

ALTER TABLE hasProductionCompany
    ADD CONSTRAINT FK_movieid_pc FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE hasProductionCompany
    ADD CONSTRAINT FK_pcid FOREIGN
KEY (pc_id)
    REFERENCES productioncompany(id);

ALTER TABLE movie_cast
    ADD CONSTRAINT FK_movieid_moviecast FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE movie_crew
    ADD CONSTRAINT FK_movieid_moviecrew FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE haskeyword
    ADD CONSTRAINT FK_keyid FOREIGN
KEY (key_id)
    REFERENCES keyword(id);

ALTER TABLE haskeyword
    ADD CONSTRAINT FK_movieid_haskeyword FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE ratings
    ADD CONSTRAINT FK_movieid_ratings FOREIGN
KEY (movie_id)
    REFERENCES movie(id);