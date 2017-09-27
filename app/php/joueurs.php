<?php 
	if (is_ajax()) {
		if(isset($_POST['action']) && !empty($_POST['action'])){
            include('config.php');
            $pdo = new PDO($dsn, $user, $password);
            
            switch($_POST['action']){
                
                case 'getJoueurs':
                    $sql  = "SELECT id, pseudo, statut, mac, paiement, etat FROM users ORDER BY pseudo"; 
                    $statement=$pdo->prepare($sql);
                    $statement->execute();
                    $results=$statement->fetchAll(PDO::FETCH_ASSOC);
                    echo json_encode($results);
                break;
                
                case 'updateMac':
		    $sql = "UPDATE users SET mac=" . $_POST['data'] . " WHERE id=" . $_POST['id'];
                    $statement=$pdo->prepare($sql);
                    $statement->execute();
                    if (!$statement->execute()) {
                        echo "erreur";
                    }
                break;
                
                case 'addJoueur':
                    $json = $_POST['data'];
                    $obj = json_decode($json);
                    $sql  = "INSERT INTO users (pseudo, statut, mac, paiement, etat) VALUES ('";
                    $sql .= $obj->{'pseudo'} . "','";
                    $sql .= $obj->{'statut'} . "','";
                    $sql .= $obj->{'mac'} . "','";
                    $sql .= $obj->{'paiement'} . "','"; 
                    $sql .= $obj->{'etat'} . "')";
                    $statement=$pdo->prepare($sql);
                    $statement->execute();
                break;
                    $json = $_POST['data'];
                
                    
                case 'updateJoueur':
                    $json = $_POST['data'];
                    $obj = json_decode($json);
                    $sql = "UPDATE users SET " . $obj->{'field'};
                    ($obj->{'field'} == 'mac')? $sql .= "='" . $obj->{'value'} : $sql .= "='" . addslashes($obj->{'value'});
                    $sql .= "' WHERE id='" . $obj->{'id'} . "'";
                    //echo ($sql);
                    $statement=$pdo->prepare($sql);
                    $statement->execute();
                break;
                
                case 'deleteJoueur':
					$sql = "DELETE FROM users WHERE id='" . json_decode($_POST['id']) . "'";
                    $statement=$pdo->prepare($sql);
                    $statement->execute();
                    if (!$statement->execute()) {
                        echo "erreur";
                    }
                break;
                
                case 'getStats':
					$sql = "SELECT statut, COUNT(*) as value FROM users GROUP BY statut";
                    $statement=$pdo->prepare($sql);
                    $statement->execute();
                    $result = $statement->fetchAll(PDO::FETCH_ASSOC);
                    echo json_encode($result);
                break;
                
                case 'deleteAllJoueur':
					$sql = "TRUNCATE TABLE users";
                    $statement=$pdo->prepare($sql);
                    $statement->execute();
                    if (!$statement->execute()) {
                        echo "erreur";
                    }
                break;
                
                case 'getJoueurFromMac':
                    $sql = "SELECT id, pseudo, statut, mac, paiement, etat FROM users WHERE mac=" . $_POST['mac'];
                    $statement=$pdo->prepare($sql);
                    $statement->execute();
                    $result = $statement->fetchAll(PDO::FETCH_ASSOC);
                    echo json_encode($result);
                break;
            }
               
        } else {
            echo "parametre action manquant";
        }
    }
	function is_ajax() {
		return isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';
	}
?>