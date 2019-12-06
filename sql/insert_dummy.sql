-- Datos Admin
INSERT INTO levels (level_name) VALUES
	("Super Administrador"),
	("Administrador");

INSERT INTO admins (admin_email, admin_password, admin_firstname, admin_lastname, admin_level) VALUES
	("admin@gmail.com","admin","Juanito","Pérez",1);


-- Inserciones de prueba

INSERT INTO dogs (dog_name, dog_gender, dog_age, dog_size, dog_half_breed, dog_breed, dog_recomendations, dog_photo) VALUES
	(
		"Flaco", 
		2, 
		3, 
		3, 
		1,
		13, 
		"Recomendado para familias con niños, también para gente joven que guste de perros traedores de presa.", 
		"https://i.imgur.com/YO2K053.jpg"
	),
	(
		"Linda", 
		1, 
		4, 
		2, 
		1, 
		30,
		"Se recomienda para familias con niños y también para personas adultas mayores con bajos requerimientos de gasto de energía.", 
		"https://i.imgur.com/YO2K053.jpg"
	),
	(
		"Manuel", 
		2, 
		2, 
		4, 
		0,
		6, 
		"Se recomienda tenerlo con otros perros que no representenuna eventual rivalidad o con perras. Es de una energía equilibrada y seria de ayuda un programa de obediencia básica para templar su conducta.", 
		"https://i.imgur.com/YO2K053.jpg"
	),
	(
		"Martina", 
		1, 
		2, 
		2, 
		1, 
		22,
		"Recomendada para familias con niños, adultos mayores, gente joven y perro de compañía. Apta para vivir en departamento y con necesidades de gasto de energía medio.", 
		"https://i.imgur.com/YO2K053.jpg"
	),
	(
		"Chascón", 
		2, 
		2, 
		4, 
		1, 
		15,
		"Se recomienda para compañía de gente joven y con posibilidades de actividades que exijan gasto energético.", 
		"https://i.imgur.com/YO2K053.jpg"
	);

INSERT INTO users (user_email, user_firstname, user_lastname, user_rut, user_gender, user_address, user_district, user_phone) VALUES
	(
		"francisca.brinckfeldt@gmail.com",
		"Francisca",
		"Brinckfeldt",
		"19.120.891-9",
		1,
		"Dresden 153",
		65,
		"+56933639099"
	),
	(
		"borisbelmarm@gmail.com",
		"Boris",
		"Belmar",
		"18.594.160-4",
		2,
		"Av. Laguna Sur 8643",
		95,
		"+56940458105"
	);

INSERT INTO adoptions (adoption_user, adoption_dog) VALUES (1, 4);