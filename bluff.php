<?php

require_once "users.php";

$user='localhost';
$pass='';
$db='bluff';
$host='localhost';
if(gethostname()=='users.iee.ihu.gr'){
$mysqli = new mysqli('localhost',$user,$pass,$db,null,'/home/student/it/2018/it185276/mysql/run/mysql.sock');
}else{
$mysqli = new mysqli('localhost:3309',$user,$pass,$db) or die("UNABLE TO CONNECT");
}
$method= $_SERVER['REQUEST_METHOD'];
$request= explode('/',trim($_SERVER['PATH_INFO'],'/'));
$input=json_decode(file_get_contents('php://input'),true);

switch($r=array_shift($request)) {
	case 'changeturn': change_turn($method);
	break;
	case 'checkturn': check_turn($method);
	break;
	case 'checkwin': check_win($method,$input);
	break;
	case 'show_calls': show_call($method);
	break;	
	case 'calls': call_cards($method,$input);
	break;
	case 'play_cards2': player2_plays($method,$input);
	break;
	case 'users': handle_player($method, $request,$input);
		break;
	case 'show_cards' :
	switch($b=array_shift($request)){
		case 'player1':player1_cards($method);
		break;
		case 'player2':player2_cards($method);
		break;
	}	
	break;
	case 'play_cards1': player1_plays($method,$input);
		break;

	default:
	header("HTTP/1.1 404 Not Found");
	exit;	
}

// function change_turn($method,$input){
// 	if($method=='PUT'){
// 		$turn=$input['change_turn'];

// 		global $mysqli;
// 		$sql = 'CALL change_the_turn(?)';
// 		$st=$mysqli->prepare($sql);
// 		$st->bind_param('s',$turn);
// 		$st->execute();
// 	}
// }

function check_win($method,$input){
	if($method=='PUT'){
		$number=$input['number'];

		global $mysqli;
		$sql = 'CALL win_check(?)';
		$st=$mysqli->prepare($sql);
		$st->bind_param('s',$number);
		$st->execute();
		$res=$st->get_result();
		header('Content-type: application/json');
		print json_encode($res->fetch_all(MYSQLI_ASSOC),JSON_PRETTY_PRINT);	
	}
}

function check_turn($method){
	if($method=='GET'){
		global $mysqli;
		$sql='select player_turn from game_status';
		$st=$mysqli->prepare($sql);
		$st->execute();
		$res=$st->get_result();
		header('Content-type: application/json');
		print json_encode($res->fetch_all(MYSQLI_ASSOC),JSON_PRETTY_PRINT);	
	}




		// global $mysqli;
		// $sql='select player_turn from game_status';
		// $st=$mysqli->prepare($sql);
		// $st->execute();
		// $res=$st->get_result();

		// $result = mysqli_query($conn, "select player_turn from game_status"); //

		// $row = mysqli_fetch_assoc($result);
		// $json = json_encode($row);
		// echo $json;
		// mysqli_close($conn);

		// header('Content-type: application/json');
		// print json_encode($res->fetch_all(MYSQLI_ASSOC),JSON_PRETTY_PRINT);	






		// // Execute a SELECT statement to retrieve the value from the database
		// $result = mysqli_query($conn, "SELECT value FROM table WHERE id = 1");

		// // Fetch the row of data as an associative array
		// $row = mysqli_fetch_assoc($result);

		// // Encode the array as a JSON object
		// $json = json_encode($row);

		// // Output the JSON object
		// echo $json;

		// // Close the connection
		// mysqli_close($conn);
	
}

function show_call($method){
	if($method=='GET'){
		global $mysqli;
		$sql = 'SELECT * FROM calls';
		$st=$mysqli->prepare($sql);
		$st->execute();
		$res=$st->get_result();
		header('Content-type: application/json');
		print json_encode($res->fetch_all(MYSQLI_ASSOC),JSON_PRETTY_PRINT);	
	}
}
function call_cards($method,$input){

	if($method=='PUT'){
		$total1=$input['total'];
		$text1=$input['text'];
		$change_turn=$input['change_turn'];

		global $mysqli;
		$sql = 'CALL call_cards(?,?,?)';	// eixe 2 erotimatika, epeidi prostethike to turn
		$st=$mysqli->prepare($sql);
		$st->bind_param('sss',$total1,$text1,$change_turn);
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

function handle_player($method, $p,$input) {
    switch ($b=array_shift($p)) {
		//	case '':
		//	case null: if($method=='GET') {show_users($method);}
		//			   else {header("HTTP/1.1 400 Bad Request"); 
		//					 print json_encode(['errormesg'=>"Method $method not allowed here."]);}
		//                break;
			case 'B': 
			case 'A': handle_user($method, $b,$input);
						break;
			default: header("HTTP/1.1 404 Not Found");
					 print json_encode(['errormesg'=>"User $b not found."]);
					 break;
		}
}

function player1_plays($method,$input) {
	if($method=='PUT'){
		$text=$input['text'];
		$symbol=$input['symbol'];

		global $mysqli;
		$sql = 'CALL player1_plays(?,?)';
		// $sql = 'delete from player1_cards where card_text=? and card_symbol=?';
		$st=$mysqli->prepare($sql);
		$st->bind_param('ss',$text,$symbol);
		$st->execute();
	}
}

function player2_plays($method,$input) {
	if($method=='PUT'){
		$text=$input['text'];
		$symbol=$input['symbol'];

		global $mysqli;
		$sql = 'CALL player2_plays(?,?)';
		// $sql = 'delete from player1_cards where card_text=? and card_symbol=?';
		$st=$mysqli->prepare($sql);
		$st->bind_param('ss',$text,$symbol);
		$st->execute();
	}
}

?>