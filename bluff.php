<?php
$user='root';
$pass='';
$db='bluff';
$host='localhost';
if(gethostname()=='users.iee.ihu.gr'){
$mysqli = new mysqli('localhost',$user,$pass,$db,null,'/home/student/it/2017/it174988/mysql/run/mysql.sock');
}else{
$mysqli = new mysqli('localhost',$user,$pass,$db) or die("UNABLE TO CONNECT");
}
$method= $_SERVER['REQUEST_METHOD'];
$request= explode('/',trim($_SERVER['PATH_INFO'],'/'));
$input=json_decode(file_get_contents('php://input'),true);

switch($r=array_shift($request)) {
	case 'show_cards' :
	switch($b=array_shift($request)){
		case 'player1':player1_cards($method);
		break;
	}	
	break;
	case 'play_cards':
		switch($b=array_shift($request)){
			case 'player1':player1_plays($method);
			break;
		}	
	default:
	header("HTTP/1.1 404 Not Found");
	exit;	
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


?>