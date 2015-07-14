DROP TABLE users;
DROP TABLE questions;
DROP TABLE question_follows;
DROP TABLE replies;
DROP TABLE question_likes;



-- Foreign key example
-- Documentation says foreign key track has to be enabled
-- Should probably ask a TA wether it's worth the trouble

--
-- CREATE TABLE track(
--   trackid     INTEGER,
--   trackname   TEXT,
--   trackartist INTEGER,
--   FOREIGN KEY(trackartist) REFERENCES artist(artistid)
-- );





CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(100) NOT NULL,
  lname VARCHAR(100) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL
);


INSERT INTO
  users (fname, lname)
VALUES
  ('Charlie', 'Wang'),
  ('Oscar', 'Garcia'),
  ('Albert', 'Einstein'),
  ('Barrack', 'Obama'),
  ('Vladimir', 'Putin'),
  ('Tupac', 'Shakur');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ("Charlie's question", "What noise does a cow make?", 1),
  ('Oscars quieston', 'What noise does a giraffe make?', 2),
  ('Alberts question', 'What is the secant of the square root of the cosmological constant?', 3),
  ('Barracks Question', 'Why is vlad such a loser??', 4),
  ('Vlads Question', 'What is the best country and why is it Russia?', 5),
  ('Pacs Question', '....', 6),
  ("Charlie's second question", "What noise does a cat make?", 1);

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (1, 4),
  (1, 5),
  (5, 4),
  (4, 1),
  (5, 1),
  (2, 5),
  (2, 5),
  (2, 4);

INSERT INTO
  replies (question_id, parent_id, user_id, body)
VALUES
  (1, NULL, 3, 'Mooooo'),
  (1, 1, 1, 'THANKS!'),
  (3, NULL, 1, "1 ± 3i");

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (1, 2),
  (2, 1),
  (3, 3),
  (2, 2),
  (1, 3),
  (1, 4),
  (1, 5)
