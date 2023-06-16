CREATE DATABASE catalog;
\c catalog

CREATE TABLE item (
 id SERIAL PRIMARY KEY,
 genere INT,
 author INT,
 source INT,
 label INT,
 publish_date DATE,
 archived BOOLEAN,
 CONSTRAINT f_genere FOREIGN KEY (genere_id) REFERENCES geners(genere_id),
 CONSTRAINT f_author FOREIGN KEY (author_id) REFERENCES author(author_id),
 CONSTRAINT f_source FOREIGN KEY (source_id) REFERENCES source(source_id),
 CONSTRAINT f_label FOREIGN KEY (label_id) REFERENCES label(label_id),
 PRIMARY KEY(id)
);

CREATE TABLE label (
id SERIAL PRIMARY KEY,
title VARCHAR(30),
color VARCHAR(30),
items TEXT[]
);

CREATE TABLE book (
id SERIAL PRIMARY KEY,
publisher VARCHAR(30),
Cover_state VARCHAR(30),
publish_date DATE,
FOREIGN KEY (publish_date) REFERENCES item(publish_date)
);