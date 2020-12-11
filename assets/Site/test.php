<?php
include 'connectionDb.php';

// Getting user name from $obj object.
$nomPrenom = $obj['nomPrenom'];

// Getting email from $obj object.
$email = $obj['email'];
 
// Getting Password from $obj object.
$motDePasse = $obj['motDePasse'];

//$status = 'eleve';

// Checking whether Email is Already Exist or Not in MySQL Table.
$CheckSQL = "SELECT * FROM utilisateur WHERE email='$email'";
$InsertQuery = "INSERT INTO utilisateur (nomPrenom,email,motDePasse, status) VALUES ('$nomPrenom','$email','$motDePasse', 0)";
$SelectQuery = "SELECT * FROM utilisateur WHERE email = '$email'";

// Executing Email Check MySQL Query.
$check = mysqli_fetch_array(mysqli_query($con,$CheckSQL));


if(isset($check)){
	 
	echo json_encode('-1');
	 
  }
 else{
 
	 
	 
	 if(mysqli_query($con,$InsertQuery)){
	 
		 // If the record inserted successfully then show the message.
		 
        // Converting the message into JSON format.
        
        $connect =  mysqli_fetch_array(mysqli_query($con,$SelectQuery));
		 
		// Echo the message.
		 echo json_encode($connect) ;
	 
	 }
	 else{
	 
		echo json_encode('-1');
	 
	 }
 }
 mysqli_close($con);
 
?>