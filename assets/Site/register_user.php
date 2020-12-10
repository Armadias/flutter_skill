<?php

/*//Define your Server host name here.
$HostName = "localhost";
 
//Define your MySQL Database Name here.
$DatabaseName = "id14922274_name";
 
//Define your Database User Name here.
$HostUser = "id14922274_namez";
 
//Define your Database Password here.
$HostPass = "Azerty0123456789/"; 
 
// Creating MySQL Connection.
$con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
 
// Storing the received JSON into $json variable.
$json = file_get_contents('php://input');
 
// Decode the received JSON and Store into $obj variable.
$obj = json_decode($json,true);*/

include 'connectionDb.php';

//include 'connectionDb.php';
 
// Getting user name from $obj object.
$nomPrenom = $obj['nomPrenom'];

// Getting email from $obj object.
$email = $obj['email'];
 
// Getting Password from $obj object.
$motDePasse = $obj['motDePasse'];

//$status = 'eleve';

// Checking whether Email is Already Exist or Not in MySQL Table.
$CheckSQL = "SELECT * FROM utilisateur WHERE email='$email'";

// Executing Email Check MySQL Query.
$check = mysqli_fetch_array(mysqli_query($con,$CheckSQL));


if(isset($check)){

	 $emailExist = 'ERREUR DE CREATION DE COMPTE: \nvotre Email existe déjà dans la base de donnée';
	 
	 // Converting the message into JSON format.
	$existEmailJSON = json_encode($emailExist);
	 
	// Echo the message on Screen.
	 echo $existEmailJSON ; 

  }
 else{
 
	 // Creating SQL query and insert the record into MySQL database table.
	 $Sql_Query = "insert into utilisateur (nomPrenom,email,motDePasse, status) values ('$nomPrenom','$email','$motDePasse', 0)";
	 
	 
	 if(mysqli_query($con,$Sql_Query)){
	 
		 // If the record inserted successfully then show the message.
		$MSG = 'C\'est bon tu est inscrit frérot ! Génial non !?' ;
		 
		// Converting the message into JSON format.
		$json = json_encode($MSG);
		 
		// Echo the message.
		 echo $json ;
	 
	 }
	 else{
	 
		echo 'Try Again';
	 
	 }
 }
 mysqli_close($con);
 
?>