<?php
 
 include 'connectionDb.php';

 $id = $obj['id'];
 
 
 //Applying User Login query with email and password.
 //$loginQuery = "select professeur.*, eleve.* from professeur, eleve where email = '$email' and motDePasse = '$motDePasse' ";
 $Query =" SELECT DISTINCT nomCours 
            FROM cours
 ";

$result = mysqli_query($con,$Query);
 
 // Executing SQL Query.
 $row = mysqli_fetch_array($result);
 
	if(isset($row)){

        $message = array();
        
        
        do{
            $message[] = $row;
        }while ($row = mysqli_fetch_array($result));

		 echo json_encode($message);
	 
	 }
	 
	 else{
	 
		echo json_encode(-1);
	 
     }
     
 
 mysqli_close($con);
?>