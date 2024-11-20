
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE IF NOT EXISTS bookingtable (
  bookingID int(11) NOT NULL,
  movieID int(11) DEFAULT NULL,
  bookingTheatre varchar(100) NOT NULL,
  bookingType varchar(100) DEFAULT NULL,
  bookingDate varchar(50) NOT NULL,
  bookingTime varchar(50) NOT NULL,
  bookingFName varchar(100) NOT NULL,
  bookingLName varchar(100) DEFAULT NULL,
  bookingPNumber varchar(12) NOT NULL,
  bookingEmail varchar(255) NOT NULL,
  amount varchar(255) NOT NULL,
  ORDERID varchar(255) NOT NULL,
  DATE_TIME datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS feedbacktable (
  msgID int(12) NOT NULL,
  senderfName varchar(50) NOT NULL,
  senderlName varchar(50) DEFAULT NULL,
  sendereMail varchar(100) NOT NULL,
  senderfeedback varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS movietable (
  movieID int(11) NOT NULL,
  movieImg varchar(150) NOT NULL,
  movieTitle varchar(100) NOT NULL,
  movieGenre varchar(50) NOT NULL,
  movieDuration int(11) NOT NULL,
  movieRelDate date NOT NULL,
  movieDirector varchar(50) NOT NULL,
  movieActors varchar(150) NOT NULL,
  mainhall int(11) NOT NULL,
  viphall int(11) NOT NULL,
  privatehall int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS users (
  id int(11) NOT NULL,
  username varchar(80) NOT NULL,
  name varchar(80) NOT NULL,
  password varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP PROCEDURE IF EXISTS insert_booking;

DELIMITER $$
CREATE PROCEDURE insert_booking(
  in_bookingID INT,
  in_movieID INT,
  in_bookingTheatre VARCHAR(100),
  in_bookingType VARCHAR(100),
  in_bookingDate VARCHAR(50),
  in_bookingTime VARCHAR(50),
  in_bookingFName VARCHAR(100),
  in_bookingLName VARCHAR(100),
  in_bookingPNumber VARCHAR(12),
  in_bookingEmail VARCHAR(255),
  in_amount VARCHAR(255),
  in_ORDERID VARCHAR(255)
)
BEGIN
  INSERT INTO bookingtable (
    bookingID,
    movieID,
    bookingTheatre,
    bookingType,
    bookingDate,
    bookingTime,
    bookingFName,
    bookingLName,
    bookingPNumber,
    bookingEmail,
    amount,
    ORDERID,
    DATE_TIME
  ) VALUES (
    in_bookingID,
    in_movieID,
    in_bookingTheatre,
    in_bookingType,
    in_bookingDate,
    in_bookingTime,
    in_bookingFName,
    in_bookingLName,
    in_bookingPNumber,
    in_bookingEmail,
    in_amount,
    in_ORDERID,
    CURRENT_TIMESTAMP
  );
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS insert_movie;
DELIMITER $$
CREATE PROCEDURE insert_movie(
  in_movieID INT,
  in_movieImg VARCHAR(150),
  in_movieTitle VARCHAR(100),
  in_movieGenre VARCHAR(50),
  in_movieDuration INT,
  in_movieRelDate DATE,
  in_movieDirector VARCHAR(50),
  in_movieActors VARCHAR(150),
  in_mainhall INT,
  in_viphall INT,
  in_privatehall INT
)
BEGIN
  INSERT INTO movietable (
    movieID,
    movieImg,
    movieTitle,
    movieGenre,
    movieDuration,
    movieRelDate,
    movieDirector,
    movieActors,
    mainhall,
    viphall,
    privatehall
  ) VALUES (
    in_movieID,
    in_movieImg,
    in_movieTitle,
    in_movieGenre,
    in_movieDuration,
    in_movieRelDate,
    in_movieDirector,
    in_movieActors,
    in_mainhall,
    in_viphall,
    in_privatehall
  );
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS insert_movie_2;
DELIMITER $$
CREATE PROCEDURE insert_movie_2(
  in_movieImg VARCHAR(150),
  in_movieTitle VARCHAR(100),
  in_movieGenre VARCHAR(50),
  in_movieDuration INT,
  in_movieRelDate DATE,
  in_movieDirector VARCHAR(50),
  in_movieActors VARCHAR(150),
  in_mainhall INT,
  in_viphall INT,
  in_privatehall INT
)
BEGIN
  INSERT INTO movietable (
    movieImg,
    movieTitle,
    movieGenre,
    movieDuration,
    movieRelDate,
    movieDirector,
    movieActors,
    mainhall,
    viphall,
    privatehall
  ) VALUES (
    in_movieImg,
    in_movieTitle,
    in_movieGenre,
    in_movieDuration,
    in_movieRelDate,
    in_movieDirector,
    in_movieActors,
    in_mainhall,
    in_viphall,
    in_privatehall
  );
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS delete_movie;
DELIMITER $$
CREATE PROCEDURE delete_movie(
  in_movieID INT
)
BEGIN
    DELETE FROM movietable WHERE movieID = in_movieID;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS insert_user;
DELIMITER $$
CREATE PROCEDURE insert_user(
  in_id INT,
  in_username VARCHAR(80),
  in_name VARCHAR(80),
  in_password VARCHAR(80)
)
BEGIN
  INSERT INTO users (id,username, name, password) VALUES (in_id,in_username, in_name, in_password);
END $$
DELIMITER ;

CREATE TABLE IF NOT EXISTS insert_log (
  id INT AUTO_INCREMENT PRIMARY KEY,
  message VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER insert_booking_trigger
AFTER INSERT ON bookingtable
FOR EACH ROW
BEGIN
  INSERT INTO insert_log (message) VALUES ('Booking inserted successfully.');
END$$

CREATE TRIGGER update_booking_trigger
AFTER UPDATE ON bookingtable
FOR EACH ROW
BEGIN
  INSERT INTO insert_log (message) VALUES ('Booking Updated successfully.');
END$$

CREATE TRIGGER delete_booking_trigger
AFTER DELETE ON bookingtable
FOR EACH ROW
BEGIN
  INSERT INTO insert_log (message) VALUES ('Booking Deleted successfully.');
END$$

CREATE TRIGGER insert_movie_trigger
AFTER INSERT ON movietable
FOR EACH ROW
BEGIN
  INSERT INTO insert_log (message) VALUES ('Movie inserted successfully.');
END$$

CREATE TRIGGER delete_movie_trigger
AFTER DELETE ON movietable
FOR EACH ROW
BEGIN
  INSERT INTO insert_log (message) VALUES ('Movie deleted successfully.');
END$$

CREATE TRIGGER insert_user_trigger
AFTER INSERT ON users
FOR EACH ROW
BEGIN
  INSERT INTO insert_log (message) VALUES ('User inserted successfully.');
END$$

DELIMITER ;


CALL insert_booking(71, 6, 'private-hall', 'imax', '14-3', '15-00', 'xyz', 'abc', '000000000', '000@gmail.com', '5000.00', 'cash');

CALL insert_movie(1, 'img/movie-poster-1.jpg', 'Captain Marvel', ' Action, Adventure, Sci-Fi ', 220, '2018-10-18', 'Anna Boden, Ryan Fleck', 'Brie Larson, Samuel L. Jackson, Ben Mendelsohn', 0, 0, 0);
CALL insert_movie(2, 'img/movie-poster-2.jpg', 'Qarmat Bitamrmat  ', 'Comedy', 110, '2018-10-18', 'Assad Fouladkar', 'Ahmed Adam, Bayyumy Fouad, Salah Abdullah , Entsar, Dina Fouad ', 0, 0, 0);
CALL insert_movie(3, 'img/movie-poster-3.jpg', 'The Lego Movie', 'Animation, Action, Adventure', 110, '2014-02-07', 'Phil Lord, Christopher Miller', 'Chris Pratt, Will Ferrell, Elizabeth Banks', 0, 0, 0);
CALL insert_movie(4, 'img/movie-poster-4.jpg', 'Nadi Elregal Elserri ', 'Comedy', 105, '2019-01-23', ' Ayman Uttar', 'Karim Abdul Aziz, Ghada Adel, Maged El Kedwany, Nesreen Tafesh, Bayyumy Fouad, Moataz El Tony ', 0, 0, 0);
CALL insert_movie(5, 'img/movie-poster-5.jpg', 'VICE', 'Biography, Comedy, Drama', 132, '2018-12-25', 'Adam McKay', 'Christian Bale, Amy Adams, Steve Carell', 0, 0, 0);
CALL insert_movie(6, 'img/movie-poster-6.jpg', 'The Vanishing', 'Crime, Mystery, Thriller', 107, '2019-01-04', 'Kristoffer Nyholm', 'Gerard Butler, Peter Mullan, Connor Swindells', 0, 0, 0);

CALL insert_user(1, '123', 'john', '123');

ALTER TABLE bookingtable
  ADD PRIMARY KEY (bookingID),
  ADD UNIQUE KEY bookingID (bookingID),
  ADD KEY foreign_key_movieID (movieID),
  ADD KEY foreign_key_ORDERID (ORDERID);

ALTER TABLE feedbacktable
  ADD PRIMARY KEY (msgID),
  ADD UNIQUE KEY msgID (msgID);

ALTER TABLE movietable
  ADD PRIMARY KEY (movieID),
  ADD UNIQUE KEY movieID (movieID);

ALTER TABLE users
  ADD PRIMARY KEY (id);

ALTER TABLE bookingtable
  MODIFY bookingID int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

ALTER TABLE feedbacktable
  MODIFY msgID int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE movietable
  MODIFY movieID int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

ALTER TABLE users
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE bookingtable
  ADD CONSTRAINT foreign_key_movieID FOREIGN KEY (movieID) REFERENCES movietable (movieID);
COMMIT;
