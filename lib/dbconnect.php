<?php
$host='localhost';
$db='Bluff';
require_once "db_upass.php";

$user=$DB_USER;
$pass=$DB_PASS;
if(gethostname()=='users.iee.ihu.gr')
{
$mysqli=new mysqli($host, $user, $pass, $db,$pass,'/home/student/it/2017/it174988/mysql/run/mysql.sock');
} else {
$mysqli = new mysqli($host, $user, $pass, $db);
}

$mysqli = new mysqli($host, 'root', 'Fuegozz1!', $db);

if ($mysqli->connect_errno) {
	echo"Failed to connect to MySQL:(".
	$mysqli->connect_errno . ") " . $mysqli->connect_error;
}?>