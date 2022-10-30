<?php
$host='localhost';
$db='Bluff';
require_once "db_upass.php";

$user=$DB_USER;
$pass=$DB_PASS;

if(gethostname()=='users.iee.ihu.gr'){
$$mysqli=new mysqli($host,$user,$pass,$db,null,'/home/student/it/2017/it174988/mysql/run/mysql.sock');
	echo "server side"; }

else{
	$mysqli = new mysqli($host,'root',null,'bluff');
	echo "local side" ;
}
if($mysqli->connect_errno){
	 echo"failed to connect";
	 $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
?>