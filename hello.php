<?php
if(gethostname()=='users.iee.ihu.gr') {
	$mysqli=new mysqli('localhost','root',null,'bluff',null,'/home/student/it/2017/it174988/mysql/run/mysql.sock');
	echo "server side";	
}
else {
	$mysqli=new mysqli('localhost','root',null,'bluff');
	echo "localhost side";
}
if($mysqli->connect_errno) echo"failed to connect";

$sql='select * from cards';
echo $sql;
$st=$mysqli->prepare($sql);
echo $st;
$st->execute();
$res= $st->get_result();
$r= $res->fetch_assoc();
echo "ID: $r[ID], card_text: $r[card_text], card_symbol: $r[card_symbol]";
?>
?>