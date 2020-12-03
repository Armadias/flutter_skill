<?php
 
/* //Define your Server host name here.
 $HostName = "localhost";
 
 //Define your MySQL Database Name here.
 $DatabaseName = "id14922274_name";
 
 //Define your Database User Name here.
 $HostUser = "id14922274_namez";
 
 //Define your Database Password here.
 $HostPass = "Azerty0123456789/"; 
 
 // Creating MySQL Connection.
 $con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
 
 // Getting the received JSON into $json variable.
 $json = file_get_contents('php://input');
 
 // Decoding the received JSON and store into $obj variable.
 $obj = json_decode($json,true);*/
 
 include 'connectionDb.php';
 
 // Getting User email from JSON $obj array and store into $email.
 $email = $obj['email'];
 
 // Getting Password from JSON $obj array and store into $password.
 $motDePasse = $obj['motDePasse'];
 
 $nomPrenom = $obj['nomPrenom'];
 
 //Applying User Login query with email and password.
 //$loginQuery = "select professeur.*, eleve.* from professeur, eleve where email = '$email' and motDePasse = '$motDePasse' ";
 $loginQuery = "select * from utilisateur where email = '$email' and motDePasse = '$motDePasse'";
 //$loginQuery2 = "select * from professeur where email = '$email' and motDePasse = '$motDePasse' ";
 
 // Executing SQL Query.
 $check = mysqli_fetch_array(mysqli_query($con,$loginQuery));
 //$check2 = mysqli_fetch_array(mysqli_query($con,$loginQuery2));
 
	if(isset($check)){
		
		 // Successfully Login Message.
		 $onLoginSuccess = 'Login Matched';
		 
		 
		 // Converting the message into JSON format.
		 $SuccessMSG = json_encode($onLoginSuccess);
		 //$SuccessMSG = json_encode($check);
		 
		 // Echo the message.
		 echo $SuccessMSG ;
		 //echo json_encode($check);
	 
	 }
	 
	 else{
	 
		 // If Email and Password did not Matched.
		$InvalidMSG = 'ERREUR DE CONNECTION \n voulez vous créér un compte?';
		 
		// Converting the message into JSON format.
		$InvalidMSGJSon = json_encode($InvalidMSG);
		 
		// Echo the message.
		 echo $InvalidMSGJSon ;
	 
	 }
 
 mysqli_close($con);
?>