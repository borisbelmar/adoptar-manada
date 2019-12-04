SELECT dog_name, dog_status FROM dogs WHERE dog_id = 4;

SELECT * FROM adoptions;

UPDATE adoptions
SET adopted_at = CURRENT_TIMESTAMP 
WHERE id_user = 1 AND id_dog = 4;

SELECT dog_name, dog_status FROM dogs WHERE dog_id = 4;
SELECT * FROM adoptions;
    
SELECT * FROM breeds;

SELECT dog_id, dog_name, dog_age, dog_half_breed, dog_breed, dog_photo 
FROM dogs
WHERE dog_status = dog_status;

SELECT dog_id, dog_name, dog_age, dog_half_breed, dog_breed, dog_photo 
FROM dogs;