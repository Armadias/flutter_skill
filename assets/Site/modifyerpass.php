<?php
 
 include 'connectionDb.php';
 
 // Getting User email from JSON $obj array and store into $email.
 $motDePasse = $obj['motDePasse'];

 $id = $obj['id'];
 
 $QuerySelect = "select * from utilisateur where id = '$id'";

 $QueryUpdate = "UPDATE utilisateur SET motDePasse = '$motDePasse' where id = '$id'";
 

if(mysqli_query($con,$QueryUpdate))
    echo json_encode(mysqli_fetch_array(mysqli_query($con,$QuerySelect)));

else echo json_encode('-1');
     
 
 mysqli_close($con);
?>