<?php
session_start();
if (!isset($_SESSION['login'])) {
        header('Location: login.php'); 
    }
header('Content-type: text/plain');
print_r($_SESSION);
?>