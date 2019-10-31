<?php

require_once('Database.php');

class Admin {
    private $admin_id;
    private $admin_email;
    private $admin_password;
    private $admin_firstname;
    private $admin_lastname;
    private $admin_created_at;
    private $admin_level;

    public function _construct($email, $password, $firstname, $lastname, $level) {
        $this->admin_email = $email;
        $this->admin_password = $password;
        $this->admin_firstname = $firstname;
        $this->admin_lastname = $lastname;
        $this->admin_level = $level;
    }

    public function set_admin_id($id) {
        $this->admin_id = $id;
    }

    public function get_admin_id() {
        return $this->admin_id;
    }

    public function set_admin_email($email) {
        $this->admin_email = $email;
    }

    public function get_admin_email() {
        return $this->admin_email;
    }

    public function set_admin_password($password) {
        $this->admin_password = $password;
    }

    public function get_admin_password() {
        return $this->admin_password;
    }

    public function set_admin_firstname($firstname) {
        $this->admin_firstname = $firstname;
    }

    public function get_admin_firstname() {
        return $this->admin_firstname;
    }

    public function set_admin_lastname($lastname) {
        $this->admin_lastname = $lastname;
    }

    public function get_admin_lastname() {
        return $this->cust_lastname;
    }

    public function set_admin_created_at($created_at) {
        $this->admin_created_at = $created_at;
    }

    public function get_admin_created_at() {
        return $this->admin_created_at;
    }

    public function set_admin_level($level) {
        $this->admin_level = $level;
    }

    public function get_admin_level() {
        return $this->admin_level;
    }

    static function create($admin_email, $admin_password, $admin_firstname, $admin_lastname, $admin_level) {
        try {
            $db = new Database();
            $dbconnection = $db->connect();
            $stmt = $dbconnection->prepare(
                "INSERT INTO admins(admin_email, admin_password, admin_firstname, admin_lastname, admin_level) VALUES
                (:admin_email, :admin_password, :admin_firstname, :admin_lastname, :admin_level)"
            );
            $stmt->execute(
                [
                    ':admin_email'=>$admin_email, 
                    ':admin_password'=>$admin_password,
                    ':admin_firstname'=>$admin_firstname,
                    ':admin_lastname'=>$admin_lastname,
                    ':admin_level'=>$admin_level
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
            $stmt = $dbconnection->prepare("SELECT admin_id, admin_email, admin_password, admin_firstname, admin_lastname, admin_created_at, admin_level FROM admins");
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

    static function get_by_id($admin_id) {
        try {
            $db = new Database();
            $dbconnection = $db->connect();
            $stmt = $dbconnection->prepare("SELECT admin_id, admin_email, admin_password, admin_firstname, admin_lastname, admin_created_at, admin_level FROM admins WHERE admin_id = :admin_id");
            $stmt->execute(
                [':admin_id'=>$admin_id]
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

    static function update_by_id($admin_id, $admin_email, $admin_password, $admin_firstname, $admin_lastname, $admin_level) {
        try {
            $db = new Database();
            $dbconnection = $db->connect();
            $stmt = $dbconnection->prepare(
                "UPDATE dogs SET 
                admin_email = :admin_email,
                admin_password = :admin_password,
                admin_firstname = :admin_firstname,
                admin_lastname = :admin_lastname,
                admin_level = :admin_level
                WHERE admin_id = :admin_id"
            );
            $stmt->execute(
                [
                    ':admin_email'=>$admin_email, 
                    ':admin_password'=>$admin_password,
                    ':admin_firstname'=>$admin_firstname,
                    ':admin_lastname'=>$admin_lastname,
                    ':admin_level'=>$admin_level,
                    ':admin_id'=>$admin_id
                ]
            );
            $stmt->execute();
            return $admin_id;
        } catch(PDOException $e) {
            echo "Error al actualizar<br>";
            echo $e->getMessage();
            exit;
        }
    }

    static function delete_by_id($admin_id) {
        try {
            $db = new Database();
            $dbconnection = $db->connect();
            $stmt = $dbconnection->prepare(
                "DELETE FROM admins WHERE admin_id = :admin_id"
            );
            $stmt->execute(
                [':admin_id'=>$admin_id]
            );
            $stmt->execute();
            return $admin_id;
        } catch(PDOException $e) {
            echo "Error al actualizar<br>";
            echo $e->getMessage();
            exit;
        }
    }

} 
?>