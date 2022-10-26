<?php

if(gethostname()=='users.iee.ihu.gr') {
	$mysqli=new mysqli('localhost','root','Fuegozz1!','Bluff',null,'/home/student/it/2017/it174988/mysql/run/mysql.sock');
	echo "server side";	
}
else {
	$mysqli=new mysqli('localhost','root',null,'Bluff');
	echo "localhost side";
}
if($mysqli->connect_errno) echo"failed to connect";
$sql='select * from CARDS';
$st=$mysqli->prepare($sql);
$st->execute();
$res= $st->get_result();
$r= $res->fetch_assoc();
print "ID: $r[ID], card_text: $r[card_text], card_symbol: $r[card_symbol]";
?>
