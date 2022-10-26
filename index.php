Welcome to our Bluff game! 

<?php

echo "this line is from php...";
$sql= "select * from CARDS";
$st= $mysqli->prepare($sql);
$st->execute();
$res = $st->get_result();
$r=$res->fetch_assoc();
print "ID: $r[ID], CARD_TEXT: $r[card_text], CARD_SYMBOL: $r[card_symbol]";
?>