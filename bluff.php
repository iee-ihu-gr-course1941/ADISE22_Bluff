<?php
$method= $_SERVER['REQUEST_METHOD'];
$request= explode('/',trim($_SERVER['PATH_INFO'],'/'));
$input=json_decode(file_get_contents('php://input'),true);
print_r($request);
exit;
switch($r=array_shift($request)) {
	case 'board';
	switch($b=array_shift($request)){
		case '':
		case null:handle_board($method);break;
		default:header("HTTP/1.1 404 Not Found");
		break;
	}
	break;
	default:
	header("HTTP/1.1 404 Not Found");
	exit;
	
}
