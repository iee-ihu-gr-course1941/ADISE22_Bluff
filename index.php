<?php

$sql='select * from CARDS';
$st=$mysqli->prepare($sql);
$st->execute();
$res= $st->get_result();
$r= $res->fetch_assoc();
print "ID: $r[ID], card_text: $r[card_text], card_symbol: $r[card_symbol]";
?>
