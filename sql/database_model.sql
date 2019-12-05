DROP DATABASE IF EXISTS manada_adopciones;

CREATE DATABASE IF NOT EXISTS manada_adopciones CHARACTER SET UTF8MB4;

USE manada_adopciones;

CREATE TABLE IF NOT EXISTS dog_genders (
	gender_id TINYINT PRIMARY KEY AUTO_INCREMENT,
	gender_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS ages (
	age_id TINYINT PRIMARY KEY AUTO_INCREMENT,
	age_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS sizes (
	size_id TINYINT PRIMARY KEY AUTO_INCREMENT,
	size_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS breeds (
	breed_id INT PRIMARY KEY AUTO_INCREMENT,
	breed_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS status (
	status_id TINYINT PRIMARY KEY AUTO_INCREMENT,
	status_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS dogs (
	dog_id INT PRIMARY KEY AUTO_INCREMENT,
	dog_name VARCHAR(50) NOT NULL,
	dog_gender TINYINT NOT NULL,
	dog_age TINYINT NOT NULL,
	dog_size TINYINT NOT NULL,
	dog_half_breed TINYINT NOT NULL DEFAULT 0,
	dog_breed INT NOT NULL,
	dog_recomendations TEXT,
	dog_status TINYINT DEFAULT 1,
	dog_photo VARCHAR(100),
	dog_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CHECK(dog_half_breed = 0 OR dog_half_breed = 1),
	CHECK(dog_status BETWEEN 0 AND 4),
	CONSTRAINT fk_dog_gender FOREIGN KEY (dog_gender) REFERENCES dog_genders(gender_id),
	CONSTRAINT fk_dog_age FOREIGN KEY (dog_age) REFERENCES ages(age_id),
	CONSTRAINT fk_dog_size FOREIGN KEY (dog_size) REFERENCES sizes(size_id),
	CONSTRAINT fk_dog_breed FOREIGN KEY (dog_breed) REFERENCES breeds(breed_id),
	CONSTRAINT fk_dog_status FOREIGN KEY (dog_status) REFERENCES status(status_id)
);

CREATE TABLE IF NOT EXISTS regions (
	region_id INT PRIMARY KEY AUTO_INCREMENT,
	region_name VARCHAR(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS provinces (
	prov_id INT PRIMARY KEY AUTO_INCREMENT,
	prov_name VARCHAR(64) NOT NULL,
	prov_region INT NOT NULL,
	CONSTRAINT fk_region FOREIGN KEY (prov_region) REFERENCES regions(region_id)
);

CREATE TABLE IF NOT EXISTS districts (
	dist_id INT PRIMARY KEY AUTO_INCREMENT,
	dist_name VARCHAR(64) NOT NULL,
	dist_province INT NOT NULL,
	CONSTRAINT fk_province FOREIGN KEY (dist_province) REFERENCES provinces(prov_id)
);

CREATE TABLE IF NOT EXISTS user_genders (
	gender_id INT PRIMARY KEY AUTO_INCREMENT,
	gender_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
	user_id INT PRIMARY KEY AUTO_INCREMENT,
	user_email VARCHAR(50) UNIQUE NOT NULL,
	user_firstname VARCHAR(50) NOT NULL,
	user_lastname VARCHAR(50) NOT NULL,
	user_rut VARCHAR(12) NOT NULL,
	user_gender INT NOT NULL,
	user_address VARCHAR(50) NOT NULL,
	user_district INT NOT NULL,
	user_phone VARCHAR(50) NOT NULL,
	user_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_user_gender FOREIGN KEY (user_gender) REFERENCES user_genders(gender_id),
	CONSTRAINT fk_district FOREIGN KEY (user_district) REFERENCES districts(dist_id)
);

CREATE TABLE IF NOT EXISTS adoptions (
	id_user INT,
	id_dog INT NOT NULL,
	notes VARCHAR(200),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	adopted_at DATETIME,
	PRIMARY KEY (id_user, id_dog),
	CONSTRAINT fk_id_user FOREIGN KEY (id_user) REFERENCES users(user_id)
	ON DELETE CASCADE,
	CONSTRAINT fk_id_dog FOREIGN KEY (id_dog) REFERENCES dogs(dog_id) 
	ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS levels (
	level_id INT PRIMARY KEY AUTO_INCREMENT,
	level_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS admins(
	admin_id INT PRIMARY KEY AUTO_INCREMENT,
	admin_email VARCHAR(50) UNIQUE NOT NULL,
	admin_password VARCHAR(200) NOT NULL,
	admin_firstname VARCHAR(50) NOT NULL,
	admin_lastname VARCHAR(50) NOT NULL,
	admin_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	admin_level INT NOT NULL,
	CONSTRAINT fk_admin_level FOREIGN KEY (admin_level) REFERENCES levels(level_id)
);

DELIMITER //

CREATE TRIGGER adopted
AFTER UPDATE ON adoptions
FOR EACH ROW
BEGIN
	IF (NEW.adopted_at IS NOT NULL)
	THEN 
		UPDATE dogs 
		SET dog_status = 3 
		WHERE dog_id = OLD.id_dog;
	ELSE
		UPDATE dogs 
		SET dog_status = 2
		WHERE dog_id = OLD.id_dog;
	END IF;
END//

CREATE PROCEDURE save
(
  IN _email VARCHAR(50),
  IN _firstname VARCHAR(50),
  IN _lastname VARCHAR(60),
  IN _rut VARCHAR(12),
  IN _gender INT,
  IN _address VARCHAR(50),
  IN _district INT,
  IN _phone VARCHAR(50)
)
BEGIN
IF EXISTS (SELECT user_id FROM users WHERE user_email = _email)
THEN
  UPDATE users 
  SET user_firstname = _firstname, 
  user_lastname = _lastname, 
  user_rut = _rut, 
  user_gender = _gender, 
  user_address = _address, 
  user_district = _district, 
  user_phone = _phone 
  WHERE user_email = _email;
ELSE
  INSERT INTO users (user_email, user_firstname, user_lastname, user_rut, user_gender, user_address, user_district, user_phone) 
  VALUES (_email, _firstname, _lastname, _rut, _gender, _address, _district, _phone);
END IF;
END//

DELIMITER ;