Περιγραφή του API
PHP functions

Δέχεται μία παράμετρο: Το player number του παίκτη
Ελέγχει αν νίκησε ο παίκτης με το δωθέν player number και το εισάγει στο game_status
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


ελέγχει από το game_status η σειρά ποιου παίκτη είναι
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
}


επιστρέφει τις τις γραμμές του πίνακα calls δηλαδή το πλήθος των καρτών και την κάρτα
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


Δέχεται τρεις παραμέτρους: το πλήθος των καρτών και τι κάρτα δήλωσε ο παίκτης ότι έπαιξε και ποιανού παίκτη σειρά είναι.
διαγράφει τα στοιχεία του πίνακα calls και εισάγει τις νέες κάρτες όταν γίνεται ένα call
Επιπλέον αλλάζει τη σειρά του παίκτη έτσι ώστε να παίξει ο άλλος.
function call_cards($method,$input){
	if($method=='PUT'){
		$total1=$input['total'];
		$text1=$input['text'];
		$change_turn=$input['change_turn'];

		global $mysqli;
		$sql = 'CALL call_cards(?,?,?)';
		$st=$mysqli->prepare($sql);
		$st->bind_param('sss',$total1,$text1,$change_turn);
		$st->execute();
		$res=$st->get_result();
		header('Content-type: application/json');
		print json_encode($res->fetch_all(MYSQLI_ASSOC),JSON_PRETTY_PRINT);	
	}
}


επιστρέφει όλες τις κάρτες (τον αριθμό ή τη φιγούρα, και το σύμβολο) 
που έχει ο player με player number A έτσι ώστε να τις εμφανίσει στο option menu.
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


επιστρέφει όλες τις κάρτες (τον αριθμό ή τη φιγούρα, και το σύμβολο) 
που έχει ο player με player number B έτσι ώστε να τις εμφανίσει στο option menu.
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


εισάγει έναν νέο όνομα παίκτη μαζί με το μοναδικό token του στη βάση 
ο οποίος έχει player_number Α ή Β
function handle_player($method, $p,$input) {
    switch ($b=array_shift($p)) {
			case 'B': 
			case 'A': handle_user($method, $b,$input);
						break;
			default: header("HTTP/1.1 404 Not Found");
					 print json_encode(['errormesg'=>"User $b not found."]);
					 break;
		}
}


Δέχεται δύο παραμέτρους: τον αριθμό ή τη φιγούρα της κάρτας και το σύμβολο της κάρτας που 
έχει παίξει ο παίκτης με player number Α.
Διαγράφει αυτές τις κάρτες που έχει παίξει ο παίκτης με player number Α από το χέρι του 
και τις εισάγει σε έναν άλλο πίνακα board
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


Δέχεται δύο παραμέτρους: τον αριθμό ή τη φιγούρα της κάρτας και το σύμβολο της κάρτας που 
έχει παίξει ο παίκτης με player number B.
Διαγράφει αυτές τις κάρτες που έχει παίξει ο παίκτης με player number B από το χέρι του 
και τις εισάγει σε έναν άλλο πίνακα board
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