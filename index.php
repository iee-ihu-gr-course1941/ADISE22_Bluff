<?php
$mysqli=new mysqli('localhost','root',null,'Bluff');
if($mysqli->connect_errno) echo"failed to connect";
$sql='select * from CARDS';
$st=$mysqli->prepare($sql);
$st->execute();
$res= $st->get_result();
$r= $res->fetch_assoc();
print "CARDS_ID: $r[CARDS_ID], card_text: $r[card_text], card_symbol: $r[card_symbol]";
?>
