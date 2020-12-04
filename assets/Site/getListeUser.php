<?php
 
 include 'connectionDb.php';

 $id = $obj['id'];
 
 
 //Applying User Login query with email and password.
 //$loginQuery = "select professeur.*, eleve.* from professeur, eleve where email = '$email' and motDePasse = '$motDePasse' ";
 $loginQuery =" SELECT u.nomPrenom, u.id
                FROM utilisateur u, utilisateur_has_utilisateur uhu
                WHERE '$id' = uhu.utilisateur_id
                AND u.id = uhu.utilisateur_id1";
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