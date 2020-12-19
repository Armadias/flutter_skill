<?php
 
 include 'connectionDb.php';
 
 // Getting User email from JSON $obj array and store into $email.
 $email = $obj['email'];
 
 // Getting Password from JSON $obj array and store into $password.
 $motDePasse = $obj['motDePasse'];
 
 //Applying User Login query with email and password.
 $loginQuery = "select * from utilisateur where email = '$email' and motDePasse = '$motDePasse'";
 
 // Executing SQL Query.
 $check = mysqli_fetch_array(mysqli_query($con,$loginQuery));
 
	if(isset($check)){
		
		 echo json_encode($check);
	 
	 }
	 
	 else{
	 
		echo json_encode('-1');
	 
     }
     
 
 mysqli_close($con);
?>