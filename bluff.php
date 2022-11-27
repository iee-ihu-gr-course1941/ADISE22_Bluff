<?php
$user='root';
$pass='';
$db='bluff';
$host='localhost';
if(gethostname=='users.iee.ihu.gr'){
$mysqli = new mysqli('localhost',$user,$pass,$db,null,'/home/student/it/2017/it174988/mysql/run/mysql.sock it174988@users.iee.ihu.gr');
}else{
$mysqli = new mysqli('localhost',$user,$pass,$db) or die("UNABLE TO CONNECT");
}
$method= $_SERVER['REQUEST_METHOD'];
$request= explode('/',trim($_SERVER['PATH_INFO'],'/'));
$input=json_decode(file_get_contents('php://input'),true);

switch($r=array_shift($request)) {
	case 'show_cards' :
	switch($b=array_shift($request)){
		case 'player2':player2_cards($method);
		break;
		case 'player1':player1_cards($method);
		break;
		case 'player1_plays':player1_plays($method,$text,$symbol);
		default:header("HTTP/1.1 404 Not Found");
		break;
	}
	
	break;
	default:
	header("HTTP/1.1 404 Not Found");
	exit;	
}

function player2_cards($method){
	if($method=='GET'){
		global $mysqli;
		$sql='select * from player2_cards';
		$st=$mysqli->prepare($sql);
		$st->execute();
		$res=$st->get_result();
		header('Content-type: application/json');
		print json_encode($res->fetch_all(MYSQLI_ASSOC),JSON_PRETTY_PRINT);	
	}
}
function player1_cards($method){
	if($method=='GET'){
		global $mysqli;
		$sql='select * from player1_cards';
		$st=$mysqli->prepare($sql);
		$st->execute();
		$res=$st->get_result();
		header('Content-type: application/json');
		print json_encode($res->fetch_all(MYSQLI_ASSOC),JSON_PRETTY_PRINT);	
	}
}
function player1_plays($method,$text,$symbol){
	if($method=='POST'){
		global $mysqli;
		$sql='call player1_plays($text,$symbol)';
		$mysqli->query($sql);		
	}
}

?>