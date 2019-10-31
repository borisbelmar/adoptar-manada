<?php

require_once('Database.php');

class Dog {
    private $dog_id;
    private $dog_name;
    private $dog_gender;
    private $dog_age;
    private $dog_size;
    private $dog_half_breed;
    private $dog_breed;
    private $dog_recomendations;
    private $dog_status;
    private $dog_photo;
    private $dog_created_at;

    public function _construct($name, $gender, $age, $size, $half_breed, $breed, $recomendations, $photo) {
        $this->dog_name = $name;
        $this->dog_gender = $gender;
        $this->dog_age = $age;
        $this->dog_size = $size;
        $this->dog_half_breed = $half_breed;
        $this->dog_breed = $breed;
        $this->dog_recomendations = $recomendations;
        $this->dog_photo = $photo;
    }

    public function set_dog_id($id) {
        $this->dog_id = $id;
    }

    public function get_dog_id() {
        return $this->dog_id;
    }

    public function set_dog_name($name) {
        $this->dog_name = $name;
    }

    public function get_dog_name() {
        return $this->dog_name;
    }

    public function set_dog_gender($gender) {
        $this->dog_gender = $gender;
    }

    public function get_dog_gender() {
        return $this->dog_gender;
    }

    public function set_dog_age($age) {
        $this->dog_age = $age;
    }

    public function get_dog_age() {
        return $this->dog_age;
    }

    public function set_dog_size($size) {
        $this->dog_size = $size;
    }

    public function get_dog_size() {
        return $this->dog_size;
    }

    public function set_dog_half_breed($half_breed) {
        $this->dog_half_breed = $half_breed;
    }

    public function get_dog_half_breed() {
        return $this->dog_half_breed;
    }

    public function set_dog_breed($breed) {
        $this->dog_breed = $breed;
    }

    public function get_dog_breed() {
        return $this->dog_breed;
    }

    public function set_dog_recomendations($recomendations) {
        $this->dog_recomendations = $recomendations;
    }

    public function get_dog_recomendations() {
        return $this->dog_recomendations;
    }

    public function set_dog_status($status) {
        $this->dog_status = $status;
    }

    public function get_dog_status() {
        return $this->dog_status;
    }

    public function set_dog_photo($photo) {
        $this->dog_photo = $photo;
    }

    public function get_dog_photo() {
        return $this->dog_photo;
    }

    public function set_dog_created_at($created_at) {
        $this->dog_created_at = $created_at;
    }

    public function get_dog_created_at() {
        return $this->dog_created_at;
    }

    static function create($dog_name, $dog_gender, $dog_age, $dog_size, $dog_half_breed, $dog_breed, $dog_recomendations, $dog_photo) {
        try {
            $db = new Database();
            $dbconnection = $db->connect();
            $stmt = $dbconnection->prepare(
                "INSERT INTO dogs(dog_name, dog_gender, dog_age, dog_size, dog_half_breed, dog_breed, dog_recomendations, dog_photo) VALUES
                (:dog_name, :dog_gender, :dog_age, :dog_size, :dog_half_breed, :dog_breed, :dog_recomendations, :dog_photo)"
            );
            $stmt->execute(
                [
                    ':dog_name'=>$dog_name, 
                    ':dog_gender'=>$dog_gender,
                    ':dog_age'=>$dog_age,
                    ':dog_size'=>$dog_size,
                    ':dog_half_breed'=>$dog_half_breed,
                    ':dog_breed'=>$dog_breed,
                    ':dog_recomendations'=>$dog_recomendations,
                    ':dog_photo'=>$dog_photo
                ]
            );
            return $dbconnection->lastInsertId();
        } catch(PDOException $e) {
            echo "Error al insertar<br>";
            echo $e->getMessage();
            exit;
        }
    }

    static function get_all() {
        try {
            $db = new Database();
            $dbconnection = $db->connect();
            $stmt = $dbconnection->prepare("SELECT dog_id, dog_name, dog_gender, dog_age, dog_size, dog_half_breed, dog_breed, dog_recomendations, dog_status, dog_photo, dog_created_at FROM dogs");
            $stmt->execute();
            $rows = $stmt->fetchAll();
            $stmt = null;
            return $rows;
        } catch(PDOException $e) {
            echo "Error en la consulta<br>";
            echo $e->getMessage();
            exit;
        }
    }

    static function get_by_id($dog_id) {
        try {
            $db = new Database();
            $dbconnection = $db->connect();
            $stmt = $dbconnection->prepare("SELECT dog_id, dog_name, dog_gender, dog_age, dog_size, dog_half_breed, dog_breed, dog_recomendations, dog_status, dog_photo, dog_created_at FROM dogs WHERE dog_id = :dog_id");
            $stmt->execute(
                [':dog_id'=>$dog_id]
            );
            $rows = $stmt->fetchAll();
            $stmt = null;
            return $rows[0];
        } catch(PDOException $e) {
            echo "Error en la consulta<br>";
            echo $e->getMessage();
            exit;
        }
    }

    static function update_by_id($dog_id, $dog_name, $dog_gender, $dog_age, $dog_size, $dog_half_breed, $dog_breed, $dog_recomendations, $dog_status, $dog_photo) {
        try {
            $db = new Database();
            $dbconnection = $db->connect();
            $stmt = $dbconnection->prepare(
                "UPDATE dogs SET 
                dog_name = :dog_name,
                dog_gender = :dog_gender,
                dog_age = :dog_age,
                dog_size = :dog_size,
                dog_half_breed = :dog_half_breed,
                dog_breed = :dog_breed,
                dog_recomendations = :dog_recomendations,
                dog_status = :dog_status,
                dog_photo = :dog_photo
                WHERE dog_id = :dog_id"
            );
            $stmt->execute(
                [
                    ':dog_name'=>$dog_name,
                    ':dog_gender'=>$dog_gender,
                    ':dog_age'=>$dog_age,
                    ':dog_size'=>$dog_size,
                    ':dog_half_breed'=>$dog_half_breed,
                    ':dog_breed'=>$dog_breed,
                    ':dog_recomendations'=>$dog_recomendations,
                    ':dog_status'=>$dog_status,
                    ':dog_photo'=>$dog_photo,
                    ':dog_id'=>$dog_id
                ]
            );
            $stmt->execute();
            return $dog_id;
        } catch(PDOException $e) {
            echo "Error al actualizar<br>";
            echo $e->getMessage();
            exit;
        }
    }

    static function delete_by_id($dog_id) {
        try {
            $db = new Database();
            $dbconnection = $db->connect();
            $stmt = $dbconnection->prepare(
                "DELETE FROM dogs WHERE dog_id = :dog_id"
            );
            $stmt->execute(
                [':dog_id'=>$dog_id]
            );
            $stmt->execute();
            return $dog_id;
        } catch(PDOException $e) {
            echo "Error al actualizar<br>";
            echo $e->getMessage();
            exit;
        }
    }
} 
?>