<?php
$host='localhost';
$db='Bluff';
require_once "db_upass.php";

$user=$DB_USER;
$pass=$DB_PASS;

$$mysqli=new mysqli($host,$user,$pass,$db,null,'/home/student/it/2017/it174988/mysql/run/mysql.sock');
if($mysqli->connect_errno) echo"failed to connect";