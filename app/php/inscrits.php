<?php
echo "sync";
include('../../lib/simplehtmldom/simple_html_dom.php');
include('config.php');
$pdo = new PDO($dsn, $user, $password);
/*--------------------*/
$html = new simple_html_dom();
$html->load_file('http://www.oufs-lan.org/inscrits.html');

$joueurs = '';

foreach($html->find('#table-joueur-inscrits') as $e)
    foreach($e->find('td') as $f){
        //echo $f->innertext . "=" . strlen($f->innertext)."<br>";
        if(strlen($f->innertext) > 27){ 
            $joueurs .= "('" . addslashes(str_replace(['<span class="team">','</span>'],'',$f->innertext)) . "'),";
        }
    }   
$sql_joueurs  = "INSERT INTO users(pseudo) VALUES " . rtrim($joueurs,',');
$statement_joueurs=$pdo->prepare($sql_joueurs);
$statement_joueurs->execute();

$staff = '';
foreach($html->find('#table-staff-inscrits') as $e)
    foreach($e->find('td') as $f)
        $staff .= "('staff','" . $f->innertext . "'),";

$sql_staff  = "INSERT INTO users(statut,pseudo) VALUES " . rtrim($staff,',');
$statement_staff=$pdo->prepare($sql_staff);
$statement_staff->execute();

$sql = "UPDATE users SET statut='' WHERE statut IS NULL";
$statement=$pdo->prepare($sql);
$statement->execute();
$sql = "UPDATE users SET mac='' WHERE mac IS NULL";
$statement=$pdo->prepare($sql);
$statement->execute();
$sql = "UPDATE users SET paiement='' WHERE paiement IS NULL";
$statement=$pdo->prepare($sql);
$statement->execute();

?>