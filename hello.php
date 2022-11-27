<?php
if(gethostname()=='users.iee.ihu.gr') {
	$mysqli=new mysqli('users','root',null,'bluff',null,'/home/student/it/2017/it174988/mysql/run/mysql.sock');
	echo "server side";	
}
else {
	$mysqli=new mysqli('localhost','root',null,'bluff');
	echo "localhost side";
}
$sql='select * from CARDS';
$st=$mysqli->prepare($sql);
$st->execute();
?>