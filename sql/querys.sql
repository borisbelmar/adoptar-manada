/*** Dogs ***/

-- findAll() return array | Retorna todos los perros

SELECT dog_id, dog_name, dog_gender, dog_age, dog_size, dog_breed, dog_status, dog_photo 
FROM dogs
ORDER BY dog_created_at ASC;

-- findById(1) return row | Retorna solo el perro id 1

SELECT dog_id, dog_name, dog_gender, dog_age, dog_size, dog_half_breed, dog_breed, dog_recomendations, dog_status, dog_photo, dog_created_at 
FROM dogs 
WHERE dog_id = 1;

-- findByStatus(3) return array | Retorna todos los perros con status 3, es decir, adoptados

SELECT dog_id, dog_name, dog_gender, dog_age, dog_size, dog_breed, dog_status, dog_photo 
FROM dogs
WHERE dog_status = 3
ORDER BY dog_created_at ASC;

-- create("Cholo", 2, 1, 2, 0, 5, "Es muy bonito", NULL) return boolean | Agregamos al perro Cholo

INSERT INTO dogs(dog_name, dog_gender, dog_age, dog_size, dog_half_breed, dog_breed, dog_recomendations, dog_photo) VALUES 
	("Cholo", 2, 1, 2, 0, 5, "Es muy bonito", NULL);
	
-- updateById(5, "Chasconsiru", 2, 1, 2, 0, 5, "Es muy bonito", NULL, 4) return boolean | Actualiza el perro id 5.

UPDATE dogs SET 
	dog_name = 'Chasconsiru', 
	dog_gender = 2, 
	dog_age = 2, 
	dog_size = 4, 
	dog_half_breed = 0, 
	dog_breed = 5, 
	dog_recomendations = 'Es muy bonito',
	dog_photo = NULL,
	dog_status = 4
WHERE dog_id = 5;

-- deleteById(6) return boolean | Elimina el perro 6

DELETE FROM dogs WHERE dog_id = 6;

/*** User ***/

-- findAll() return array | Retorna todos los usuarios como contactos

SELECT user_id, user_email, user_firstname, user_lastname, user_rut, user_gender
FROM users
ORDER BY user_lastname ASC;

-- findById(2) return row | Retorna al usuario 2 con todos sus datos

SELECT user_id, user_email, user_firstname, user_lastname, user_rut, user_gender, user_address, user_district, user_phone, user_created_at 
FROM users
WHERE user_id = 2;

-- create("prueba@prueba.cl", "Juan", "Pérez", "10.123.456-7", 1, "Los palos 123", 63, "+5695641254") return boolean | Guarda un nuevo usuario

INSERT INTO users(user_email, user_firstname, user_lastname, user_rut, user_gender, user_address, user_district, user_phone) VALUES
	('prueba@prueba.cl', 'Juan', 'Pérez', '10.123.456-7', 1, 'Los palos 123', 63, '+5695641254');
	
-- save("prueba@prueba.cl", "Juanito", "Pérez", "10.123.456-7", 1, "Los palos 123", 63, "+5695641254") return boolean | Guarda o mofifica un usuario según si el email existe

CALL save('prueba@prueba.cl', 'Juanito', 'Pérez', '10.123.456-7', 1, 'Los palos 123', 63, '+5695641254');
CALL save('pruebita@prueba.cl', 'José', 'Soto', '10.563.456-7', 1, 'Alguna cosa 84', 68, '+5695641254');

-- updateById(3, "prueba@prueba.cl", "Juanito", "Pérez", "10.123.456-7", 1, "Los palos 123", 63, "+5695641254") return boolean | Actualiza al usuario con id 2

UPDATE users SET
	user_email = 'prueba@prueba.cl', 
	user_firstname = 'Juanito', 
	user_lastname = 'Pérez', 
	user_rut = '10.123.456-7', 
	user_gender = 2, 
	user_address = 'Los palos 123', 
	user_district = 65, 
	user_phone = '+5695641254'
WHERE user_id = 3;

-- deleteById(4) return boolean | Elimina al usuario 4

DELETE FROM users WHERE user_id = 4;

/*** Adoptions ***/

