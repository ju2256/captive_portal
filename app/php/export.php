<?php
include('config.php');
$pdo = new PDO($dsn, $user, $password);
/** Error reporting */
error_reporting(E_ALL);
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);
date_default_timezone_set('Europe/London');

define('EOL',(PHP_SAPI == 'cli') ? PHP_EOL : '<br />');

/** Include PHPExcel */
require_once dirname(__FILE__) . '../../../lib/phpexcel/PHPExcel.php';


// Create new PHPExcel object
//echo date('H:i:s') , " Create new PHPExcel object" , EOL;
$objPHPExcel = new PHPExcel();

// Set document properties
//echo date('H:i:s') , " Set document properties" , EOL;
$objPHPExcel->getProperties()->setCreator("Maarten Balliauw")
							 ->setLastModifiedBy("Maarten Balliauw")
							 ->setTitle("PHPExcel Test Document")
							 ->setSubject("PHPExcel Test Document")
							 ->setDescription("Test document for PHPExcel, generated using PHP classes.")
							 ->setKeywords("office PHPExcel php")
							 ->setCategory("Test result file");


// Entete
//echo date('H:i:s') , " Add some data" , EOL;
$objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('A1', 'Export excel Les OUFSLAN')
			->setCellValue('A2', 'Pseudo')
			->setCellValue('B2', 'statut')
			->setCellValue('C2', '@mac')
			->setCellValue('D2', 'paiement')
			->setCellValue('E2', 'accès réseau');

// export bdd

$sql = "SELECT pseudo, statut, mac, paiement, etat FROM users ORDER BY pseudo";
$statement=$pdo->prepare($sql);
$statement->execute();
$result = $statement->fetchAll();

$i = 3;
foreach($result as $row) {
    if($row[4] == '1'){ $row[4] = 'oui'; } else { $row[4] = 'non'; }
	$objPHPExcel->setActiveSheetIndex(0)
			->setCellValue('A'.$i, $row['0'])
			->setCellValue('B'.$i, $row['1'])
			->setCellValue('C'.$i, $row['2'])
			->setCellValue('D'.$i, $row['3'])
			->setCellValue('E'.$i, $row['4']);
	$i++;
}

// Rename worksheet
//echo date('H:i:s') , " Rename worksheet" , EOL;
$objPHPExcel->getActiveSheet()->setTitle('Simple');

// Set active sheet index to the first sheet, so Excel opens this as the first sheet
$objPHPExcel->setActiveSheetIndex(0);

$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
$objWriter->save(str_replace('.php', '.xls', __FILE__));

// partie download

$file = 'export.xls';

if (file_exists($file)) {
    header('Content-Description: File Transfer');
    header('Content-Type: application/octet-stream');
    header('Content-Disposition: attachment; filename="'.basename($file).'"');
    header('Expires: 0');
    header('Cache-Control: must-revalidate');
    header('Pragma: public');
    header('Content-Length: ' . filesize($file));
    readfile($file);
    exit;
}
