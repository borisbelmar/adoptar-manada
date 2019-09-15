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
    dog_breed INT NOT NULL,
    dog_recomendations TEXT,
    dog_status INT DEFAULT 1,
    dog_photo VARCHAR(100) NOT NULL,
    dog_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
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
INSERT INTO genders (gender_name) VALUES
	("Hembra"),
    ("Macho")
;    
INSERT INTO sizes (size_name) VALUES
	("Miniatura"),
    ("Pequeño"),
    ("Mediano"),
    ("Grande")
;    
INSERT INTO breeds (breed_name) VALUES
	("Mestizo"),
    ("Affenpinscher"),
	("Airedale terrier"),
	("Aïdi"),
	("Akita Inu"),
	("Akita Americano"),
	("Alano español"),
	("Alaskan malamute"),
	("Alaskan Klee Kai"),
	("American Hairless terrier"),
	("American Staffordshire Terrier"),
	("Antiguo Perro Pastor Inglés"),
	("Appenzeller"),
	("Australian Cattle Dog"),
	("Australian terrier"),
	("Australian Silky Terrier"),
	("Azawakh"),
	("Bardino (Perro majorero)"),
	("Bandog"),
	("Basenji"),
	("Basset azul de Gascuña"),
	("Basset hound"),
	("Beagle"),
	("Beauceron"),
	("Bedlington terrier"),
	("Bergamasco"),
	("Bichon frisé"),
	("Bichón maltés"),
	("Bichón habanero"),
	("Bobtail"),
	("Bloodhound"),
	("Border collie"),
	("Borzoi"),
	("Boston terrier"),
	("Bóxer"),
	("Boyero de Berna"),
	("Boyero de Flandes"),
	("Braco alemán de pelo corto"),
	("Braco alemán de pelo duro"),
	("Braco de Auvernia"),
	("Braco francés"),
	("Braco húngaro"),
	("Braco italiano"),
	("Braco tirolés"),
	("Braco de Saint Germain"),
	("Braco de Weimar"),
	("Bull Terrier"),
	("Bulldog americano"),
	("Bulldog francés"),
	("Bulldog inglés"),
	("Bullmastiff"),
	("Buhund noruego"),
	("Can de palleiro"),
	("Caniche"),
	("Cão da Serra da Estrela"),
	("Cão da Serra de Aires"),
	("Cão de Agua Português"),
	("Cão de Castro Laboreiro"),
	("Cão de Fila de São Miguel"),
	("Cavalier King Charles Spaniel"),
	("Cazador de alces noruego"),
	("Chesapeake Bay Retriever")
;    
INSERT INTO dogs (dog_name, dog_gender, dog_age, dog_size, dog_breed, dog_recomendations, dog_photo) VALUES
	(
		"Flaco", 
        2, 
        3, 
        3, 
        1, 
        "Recomendado para familias con niños, también para gente joven que guste de perros traedores de presa.", 
        "https://i.imgur.com/YO2K053.jpg"
	),
    (
		"Linda", 
        1, 
        4, 
        2, 
        1, 
        "Se recomienda para familias con niños y también para personas adultas mayores con bajos requerimientos de gasto de energía.", 
        "https://i.imgur.com/YO2K053.jpg"
	),
	(
		"Manuel", 
        2, 
        2, 
        4, 
        1, 
        "Se recomienda tenerlo con otros perros que no representenuna eventual rivalidad o con perras. Es de una energía equilibrada y seria de ayuda un programa de obediencia básica para templar su conducta.", 
        "https://i.imgur.com/YO2K053.jpg"
	),
    (
		"Martina", 
        1, 
        2, 
        2, 
        1, 
        "Recomendada para familias con niños, adultos mayores, gente joven y perro de compañía. Apta para vivir en departamento y con necesidades de gasto de energía medio.", 
        "https://i.imgur.com/YO2K053.jpg"
	),
    (
		"Chascón", 
        2, 
        2, 
        4, 
        1, 
        "Se recomienda para compañía de gente joven y con posibilidades de actividades que exijan gasto energético.", 
        "https://i.imgur.com/YO2K053.jpg"
	)
;

INSERT INTO customers (cust_email, cust_firstname, cust_lastname, cust_rut, cust_address, cust_district, cust_region, cust_phone) VALUES
	(
		"francisca.brinckfeldt@gmail.com",
        "Francisca",
        "Brinckfeldt",
        "19.120.891-9",
        "Dresden 153",
        "Valparaíso",
        "Valparaíso",
        "+56933639099"
	),
    (
		"borisbelmarm@gmail.com",
        "Boris",
        "Belmar",
        "18.594.160-4",
        "Av. Lagura Sur 8643",
        "Pudahuel",
        "Metropolitana",
        "+56940458105"
    )
;

INSERT INTO customers_dogs (id_cust, id_dog) VALUES
	(1, 4)
;

INSERT INTO levels (level_name) VALUES
	("Super Administrador"),
    ("Administrador")
;

INSERT INTO admins (admin_email, admin_password, admin_firstname, admin_lastname, admin_level) VALUES
	(
		"admin@gmail.com",
        "admin",
        "Juanito",
        "Pérez",
        1
	)
;

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

SELECT dog_name, dog_status FROM dogs WHERE dog_id = 4;
SELECT * FROM customers_dogs;

UPDATE customers_dogs 
SET adopted_at = CURRENT_TIMESTAMP 
WHERE id_cust = 1 AND id_dog = 4;

SELECT dog_name, dog_status FROM dogs WHERE dog_id = 4;
SELECT * FROM customers_dogs;
    
SELECT * FROM breeds;

SELECT dog_id, dog_name, dog_age, dog_breed, dog_photo 
FROM dogs
WHERE dog_status = dog_status;

SELECT dog_id, dog_name, dog_age, dog_breed, dog_photo 
FROM dogs;