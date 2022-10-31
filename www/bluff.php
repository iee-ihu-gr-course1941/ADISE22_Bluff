<?php
//CONNECTION TO DATABASE//


	 $mysqli=new mysqli('localhost','root',null,'Bluff');


$method = $_SERVER['REQUEST_METHOD'];
$request = explode('/',trim($_SERVER['PATH_INFO'],'/'));
$input = json_decode(file_get_contents('php://input'),true);

header("Content-Type: text/plain");
print "method=$method\n";
print "Path_info=".$_SERVER['PATH_INFO']."\n";
print_r($request);

switch ($r=array_shift($request)) {
    case 'deal_cards': deal_cards($method);           
    case 'player1_cards': show_p1($method);                        
    case 'player2_cards': show_p2($method);
    case 'new_game': new_game($method);        
    default: header("HTTP/1.1 404 Not Found");
    exit;
}
function show_p1($method)
{
    if($method=='GET')
    {
        global $mysqli;
        $sql='select * from player1_cards';
        $st = $mysqli->prepare($sql);
        $st->execute();
        $res=$st->get_result();
        header('Content-type: application/json');
        print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);  
    }
}
function show_p2($method)
{
    if($method=='GET')
    {
        global $mysqli;
        $sql='select * from player2_cards';
        $st = $mysqli->prepare($sql);
        $st->execute();
        $res=$st->get_result();
        header('Content-type: application/json');
        print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);  
    }
}

function new_game($method) 
{
    if($method=='GET')
    {
        global $mysqli;
        $sql='call newgame()';
        $mysqli->query($sql);   
    }
}
function deal_cards($method) 
{
    if($method=='GET')
    {
        global $mysqli;
        $sql='call dealcards()';
        $mysqli->query($sql);
    }
}

?>
