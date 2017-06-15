<?php
	
	$servername	=	"localhost";//IP SERVER DATABASE
	$username		=	"root";
	$password		=	"";
	$database		=	"db_rsukramatjati_devlp";
	

$koneksi = mysql_connect($servername, $username, $password); 
	if (!$koneksi){
	echo "Couldn't connect to host $servername because <b> ".mysql_error()."</b>";
	}else{
	$select_db = mysql_select_db($database);
		if (!$select_db){
			echo "Couldn't select database $database because <b>".mysql_error()."</b>";
		}
	}
	# create sqlConnection
	/*$connectionInfo = array( "Database"=>"$database", "UID"=>"$username", "PWD"=>"$password");
	$conn = mysql_connect( $servername, $connectionInfo);
	
	# check sqlConnection
	/*
	if( $conn ) {
		echo "Connection established.<br />";
	}else{
		echo "Connection could not be established.<br />";
		die( print_r( sqlsrv_errors(), true));
	}
	*/
?>