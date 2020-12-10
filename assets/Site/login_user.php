<?php
 
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
		
		 echo json_encode($check);
	 
	 }
	 
	 else{
	 
		echo json_encode(-1);
	 
     }
     
 
 mysqli_close($con);
?>