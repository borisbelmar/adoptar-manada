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

-- findAll() return array | Trae todos los procesos de adopción

SELECT adoption_id, adoption_dog, adoption_user, adoption_notes, adoption_created_at, adoption_adopted_at
FROM adoptions
ORDER BY adoption_created_at ASC;

-- findById(1) return row | Trae el proceso de adopción con id 1

SELECT adoption_id, adoption_dog, adoption_user, adoption_notes, adoption_created_at, adoption_adopted_at
FROM adoptions
WHERE adoption_id = 1;

-- findByDog(2) return array | Trae todos los proceso ligados al perro 2

SELECT adoption_id, adoption_dog, adoption_user, adoption_notes, adoption_created_at, adoption_adopted_at
FROM adoptions
WHERE adoption_dog = 2;

-- findByStatus(2) | Trae solo los procesos en curso, es decir, no adoptados o deshabilitados

SELECT a.adoption_id, a.adoption_dog, a.adoption_user, a.adoption_notes, a.adoption_created_at, a.adoption_adopted_at, d.dog_status
FROM adoptions a
LEFT JOIN dogs d ON a.adoption_dog = d.dog_id
WHERE d.dog_status = 3;

-- findByUser(1) return array | Trae todos los proceso ligados al usuario 1

SELECT adoption_id, adoption_dog, adoption_user, adoption_notes, adoption_created_at, adoption_adopted_at
FROM adoptions
WHERE adoption_user = 1;

-- create(3,2,"Me encanta este perro") return boolean | Crea un proceso de adopción entre el usuario id 2 y el perro id 3

INSERT INTO adoptions (adoption_dog, adoption_user, adoption_notes) VALUES (3, 2, 'Me encanta este perro');

-- completeAdoption(1) return boolean | Completa el proceso de adopción id 2

UPDATE adoptions SET
	adoption_adopted_at = CURRENT_TIMESTAMP
WHERE adoption_id = 2;

-- deleteById(1) return boolean | Elimina la adopción 1

DELETE FROM adoptions WHERE adoption_id = 1;

/* Data Análisis */

-- Cantidad de procesos activos

SELECT COUNT(a.adoption_id) FROM adoptions a 
LEFT JOIN dogs d ON a.adoption_dog = d.dog_id 
WHERE d.dog_status BETWEEN 1 AND 2;

-- Cantidad de perros adoptados

SELECT COUNT(dog_id) AS 'count' FROM dogs 
WHERE dog_status = 3;

-- Cantidad de perros activos para ser adoptados

SELECT COUNT(dog_id) AS 'count' FROM dogs 
WHERE dog_status BETWEEN 1 AND 2;

-- Cantidad de perros adoptados entre una fecha y otra
-- En este caso 2019/12/01 y 2019/12/30

SELECT COUNT(d.dog_id) AS 'count' FROM dogs d
LEFT JOIN adoptions a ON d.dog_id = a.adoption_dog 
WHERE a.adoption_adopted_at BETWEEN '2019-12-01' AND '2019-12-30';

-- Cantidad de perros adoptados los últimos 30 días

SELECT COUNT(d.dog_id) AS 'count' FROM dogs d
LEFT JOIN adoptions a ON d.dog_id = a.adoption_dog 
WHERE a.adoption_adopted_at BETWEEN NOW() - INTERVAL 30 DAY AND NOW();

-- Último perro adoptado

SELECT d.dog_id, d.dog_name, a.adoption_id, a.adoption_adopted_at FROM dogs d
LEFT JOIN adoptions a ON d.dog_id = a.adoption_dog
WHERE a.adoption_adopted_at IS NOT NULL
ORDER BY a.adoption_adopted_at DESC
LIMIT 1;