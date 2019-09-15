SELECT dog_name, dog_status FROM dogs WHERE dog_id = 4;

SELECT * FROM customers_dogs;

UPDATE customers_dogs 
SET adopted_at = CURRENT_TIMESTAMP 
WHERE id_cust = 1 AND id_dog = 4;

SELECT dog_name, dog_status FROM dogs WHERE dog_id = 4;
SELECT * FROM customers_dogs;
    
SELECT * FROM breeds;

SELECT dog_id, dog_name, dog_age, dog_half_breed, dog_breed, dog_photo 
FROM dogs
WHERE dog_status = dog_status;

SELECT dog_id, dog_name, dog_age, dog_half_breed, dog_breed, dog_photo 
FROM dogs;