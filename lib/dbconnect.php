<?php

$mysqli=new mysqli('localhost',root,null,'Bluff');
if($mysqli->connect_errno) {
	echo"failed to connect";
?>