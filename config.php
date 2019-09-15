<?php
    // Variables globales
    $_PROTOCOL = (!empty($_SERVER['HTTPS'])) ? 'https' : 'http';
    $_ROOT_DIR = '/';
    $_BASE_URL = $_PROTOCOL.'://'.$_SERVER['SERVER_NAME'].$_ROOT_DIR.'/';
    
    // Sesión
    session_start();
?>