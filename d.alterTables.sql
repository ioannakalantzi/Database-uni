ALTER TABLE belongsTocollection
    ADD CONSTRAINT belongs_pk
    PRIMARY KEY (collection_id, movie_id);

ALTER TABLE hasGenre
    ADD CONSTRAINT hasGenre_pk
    PRIMARY KEY (genre_id, movie_id);

ALTER TABLE haskeyword
    ADD CONSTRAINT haskeyword_pk
    PRIMARY KEY (key_id, movie_id);

ALTER TABLE hasProductioncompany
    ADD CONSTRAINT haspc_pk
    PRIMARY KEY (pc_id, movie_id);

ALTER TABLE ratings
    ADD CONSTRAINT ratings_pk
    PRIMARY KEY (user_id,movie_id);