<?php

require_once('Database.php');

class Customer{
    private $cust_id;
    private $cust_email;
    private $cust_firstname;
    private $cust_lastname;
    private $cust_rut;
    private $cust_address;
    private $cust_district;
    private $cust_region;
    private $cust_phone;
    private $cust_created_at;

    public function _construct($email, $firstname, $lastname, $rut, $address, $district, $region, $phone) {
        $this->cust_email = $email;
        $this->cust_firstname = $firstname;
        $this->cust_lastname = $lastname;
        $this->cust_rut = $rut;
        $this->cust_address = $address;
        $this->cust_district = $district;
        $this->cust_region = $region;
        $this->cust_phone = $phone;
    }

    public function set_cust_id($id) {
        $this->cust_id = $id;
    }

    public function get_cust_id() {
        return $this->cust_id;
    }

    public function set_cust_email($email) {
        $this->cust_email = $email;
    }

    public function get_cust_email() {
        return $this->cust_email;
    }

    public function set_cust_firstname($firstname) {
        $this->cust_firstname = $firstname;
    }

    public function get_cust_firstname() {
        return $this->cust_firstname;
    }

    public function set_cust_lastname($lastname) {
        $this->cust_lastname = $lastname;
    }

    public function get_cust_lastname() {
        return $this->cust_lastname;
    }

    public function set_cust_rut($rut) {
        $this->cust_rut = $rut;
    }

    public function get_cust_rut() {
        return $this->cust_rut;
    }

    public function set_cust_address($address) {
        $this->cust_address = $address;
    }

    public function get_cust_address() {
        return $this->cust_address;
    }

    public function set_cust_district($district) {
        $this->cust_district = $district;
    }

    public function get_cust_district() {
        return $this->cust_district;
    }

    public function set_cust_region($region) {
        $this->cust_region = $region;
    }

    public function get_cust_region() {
        return $this->cust_region;
    }

    public function set_cust_phone($phone) {
        $this->cust_phone = $phone;
    }

    public function get_cust_phone() {
        return $this->cust_phone;
    }

    public function set_cust_created_at($created_at) {
        $this->cust_created_at = $created_at;
    }

    public function get_cust_created_at() {
        return $this->cust_created_at;
    }

    static function create($cust_email, $cust_firstname, $cust_lastname, $cust_rut, $cust_address, $cust_district, $cust_region, $cust_phone) {
        try {
            $db = new Database();
            $dbconnection = $db->connect();
            $stmt = $dbconnection->prepare(
                "INSERT INTO customers(cust_email, cust_firstname, cust_lastname, cust_rut, cust_address, cust_district, cust_region, cust_phone) VALUES
                (:cust_email, :cust_firstname, :cust_lastname, :cust_rut, :cust_address, :cust_district, :cust_region, :cust_phone)"
            );
            $stmt->execute(
                [
                    ':cust_email'=>$cust_email, 
                    ':cust_firstname'=>$cust_firstname,
                    ':cust_lastname'=>$cust_lastname,
                    ':cust_rut'=>$cust_rut,
                    ':cust_address'=>$cust_address,
                    ':cust_district'=>$cust_district,
                    ':cust_region'=>$cust_region,
                    ':cust_phone'=>$cust_phone
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
            $stmt = $dbconnection->prepare("SELECT cust_id, cust_email, cust_firstname, cust_lastname, cust_rut, cust_address, cust_district, cust_region, cust_phone, cust_created_at FROM customers");
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

    static function get_by_id($cust_id) {
        try {
            $db = new Database();
            $dbconnection = $db->connect();
            $stmt = $dbconnection->prepare("SELECT cust_id, cust_email, cust_firstname, cust_lastname, cust_rut, cust_address, cust_district, cust_region, cust_phone, cust_created_at FROM customers WHERE cust_id = :cust_id");
            $stmt->execute(
                [':cust_id'=>$cust_id]
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

    static function update_by_id($cust_id, $cust_email, $cust_firstname, $cust_lastname, $cust_rut, $cust_address, $cust_district, $cust_region, $cust_phone) {
        try {
            $db = new Database();
            $dbconnection = $db->connect();
            $stmt = $dbconnection->prepare(
                "UPDATE dogs SET 
                cust_email = :cust_email,
                cust_firstname = :cust_firstname,
                cust_lastname = :cust_lastname,
                cust_rut = :cust_rut,
                cust_address = :cust_address,
                cust_district = :cust_district,
                cust_region = :cust_region,
                cust_phone = :cust_phone
                WHERE cust_id = :cust_id"
            );
            $stmt->execute(
                [
                    ':cust_email'=>$cust_email, 
                    ':cust_firstname'=>$cust_firstname,
                    ':cust_lastname'=>$cust_lastname,
                    ':cust_rut'=>$cust_rut,
                    ':cust_address'=>$cust_address,
                    ':cust_district'=>$cust_district,
                    ':cust_region'=>$cust_region,
                    ':cust_phone'=>$cust_phone,
                    ':cust_id'=>$cust_id
                ]
            );
            $stmt->execute();
            return $cust_id;
        } catch(PDOException $e) {
            echo "Error al actualizar<br>";
            echo $e->getMessage();
            exit;
        }
    }

    static function delete_by_id($cust_id) {
        try {
            $db = new Database();
            $dbconnection = $db->connect();
            $stmt = $dbconnection->prepare(
                "DELETE FROM customers WHERE cust_id = :cust_id"
            );
            $stmt->execute(
                [':cust_id'=>$cust_id]
            );
            $stmt->execute();
            return $cust_id;
        } catch(PDOException $e) {
            echo "Error al actualizar<br>";
            echo $e->getMessage();
            exit;
        }
    }

} 

?>