-- Create Item Table--
CREATE TABLE Item (
  id INT PRIMARY KEY,
  genre INT,
  author INT,
  label INT,
  publish_date DATE,
  archived BOOLEAN DEFAULT false,
  can_be_archived BOOLEAN,
  move_to_archive BOOLEAN,
  FOREIGN KEY (genre) REFERENCES genre(id),
  FOREIGN KEY (author) REFERENCES author(id),
  FOREIGN KEY (label) REFERENCES label(id)
);

--Create games table--
CREATE TABLE game(
  id INT GENERATED ALWAYS AS
  IDENTITY PRIMARY KEY,
  publish_date DATE,
  multiplayer VARCHAR(200),
  last_played_at DATE,
  author_id INT REFERENCES author(id)
);

--Create authors table--
CREATE TABLE author(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  first_name VARCHAR(200),
  last_name VARCHAR(200)
);

--create genre table--
CREATE TABLE genre(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(200)
);

--music_album table--

CREATE TABLE musicalbum (
    id INT GENERATED ALWAYS AS IDENTITY,
    publish_date DATE,
    on_spotify BOOLEAN,
    archived BOOLEAN,
    genre_id INT,
    PRIMARY KEY(id),
    CONSTRAINT fk_genre FOREIGN KEY(genre_id) REFERENCES genre(id)
);

--book table--

CREATE TABLE  book (
  id INT PRIMARY KEY REFERENCES item(id),
  publisher VARCHAR(40),
  cover_state VARCHAR(30)
);

--label table--

CREATE TABLE label (
  id INT PRIMARY KEY,
  title VARCHAR(30),
  color VARCHAR(20)
);

CREATE INDEX idx_item_genre_id ON games (genre);
CREATE INDEX idx_item_author_id ON games (author);
CREATE INDEX idx_item_label_id ON games (label);
CREATE INDEX idx_games_author_id ON games (author_id);
CREATE INDEX idx_musicalbum_genre_id ON musicalbum (genre_id);
CREATE INDEX idx_book_label_id ON book (label_id);