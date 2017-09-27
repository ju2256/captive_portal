<?php
session_start();

$_SESSION['test'][] = time();

header('Content-type: text/plain');
print_r($_SESSION);
?>