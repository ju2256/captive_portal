<?php 
	if (is_ajax()) {
		if(isset($_POST['action']) && !empty($_POST['action'])){
            switch($_POST['action']){
                case 'getMacFromLan':
                    $client = $_SERVER['REMOTE_ADDR'];
                    ob_start();                                 // requete ARP windows: IP <=> MAC
                    system("arp -a ".$client); 
                    $arp=ob_get_contents(); 
                    ob_clean(); 
                    $tArp = explode (' ',$arp);
                    foreach($tArp as $key => $value){
                        preg_match('/(?:[A-Fa-f0-9]{2}[:-]){5}(?:[A-Fa-f0-9]{2})/', $value, $matches);
                        if(count($matches)>0){ $mac = $matches[0]; }  
                    }
                    if($mac !=""){ 
                        echo json_encode(str_replace(":","-",$mac));
                    } else {
                        echo "false";
                    }
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