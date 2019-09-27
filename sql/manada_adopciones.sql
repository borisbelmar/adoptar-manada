DROP DATABASE IF EXISTS manada_adopciones;

CREATE DATABASE IF NOT EXISTS manada_adopciones CHARACTER SET UTF8MB4;

USE manada_adopciones;

CREATE TABLE IF NOT EXISTS genders (
	gender_id INT PRIMARY KEY AUTO_INCREMENT,
    gender_name VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS sizes (
	size_id INT PRIMARY KEY AUTO_INCREMENT,
    size_name VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS breeds (
	breed_id INT PRIMARY KEY AUTO_INCREMENT,
    breed_name VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS dogs (
	dog_id INT PRIMARY KEY AUTO_INCREMENT,
    dog_name VARCHAR(50) NOT NULL,
    dog_gender INT NOT NULL,
    dog_age INT NOT NULL,
    dog_size INT NOT NULL,
    dog_half_breed INT NOT NULL DEFAULT 0,
    dog_breed INT NOT NULL,
    dog_recomendations TEXT,
    dog_status INT DEFAULT 1,
    dog_photo VARCHAR(100) NOT NULL,
    dog_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK(dog_half_breed = 0 OR dog_half_breed = 1),
    CHECK(dog_status BETWEEN 0 AND 2),
    CONSTRAINT fk_dog_gender FOREIGN KEY (dog_gender) REFERENCES genders(gender_id),
    CONSTRAINT fk_dog_size FOREIGN KEY (dog_size) REFERENCES sizes(size_id),
    CONSTRAINT fk_dog_breed FOREIGN KEY (dog_breed) REFERENCES breeds(breed_id)
);
CREATE TABLE IF NOT EXISTS customers (
	cust_id INT PRIMARY KEY AUTO_INCREMENT,
    cust_email VARCHAR(50) NOT NULL,
    cust_firstname VARCHAR(50) NOT NULL,
    cust_lastname VARCHAR(50) NOT NULL,
    cust_rut VARCHAR(12) NOT NULL,
    cust_address VARCHAR(50) NOT NULL,
    cust_district VARCHAR(50) NOT NULL,
    cust_region VARCHAR(50) NOT NULL,
    cust_phone VARCHAR(50) NOT NULL,
    cust_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS customers_dogs (
	id_cust INT,
    id_dog INT NOT NULL,
    adopted_at DATETIME,
    CONSTRAINT fk_id_cust FOREIGN KEY (id_cust) REFERENCES customers(cust_id)
    ON DELETE SET NULL,
    CONSTRAINT fk_id_dog FOREIGN KEY (id_dog) REFERENCES dogs(dog_id) 
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS levels (
	level_id INT PRIMARY KEY AUTO_INCREMENT,
    level_name VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS admins(
	admin_id INT AUTO_INCREMENT,
    admin_email VARCHAR(50) NOT NULL,
    admin_password VARCHAR(200) NOT NULL,
    admin_firstname VARCHAR(50) NOT NULL,
    admin_lastname VARCHAR(50) NOT NULL,
    admin_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    admin_level INT NOT NULL,
    CONSTRAINT pk_admin PRIMARY KEY(admin_id, admin_email),
    CONSTRAINT fk_admin_level FOREIGN KEY (admin_level) REFERENCES levels(level_id)
);

DELIMITER //

CREATE TRIGGER adopted
AFTER UPDATE ON customers_dogs
FOR EACH ROW
BEGIN
	UPDATE dogs 
	SET dog_status = 2 
	WHERE dog_id = OLD.id_dog;
END//

DELIMITER ;