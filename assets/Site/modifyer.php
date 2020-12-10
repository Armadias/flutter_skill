<?php
 
 include 'connectionDb.php';
 
 $email = $obj['email'];

 $nomPrenom = $obj['nomPrenom'];

 $id = $obj['id'];

 $CheckSQL = "SELECT * FROM utilisateur WHERE email='$email'";

 $loginQuery = "UPDATE utilisateur SET nomPrenom = '$nomPrenom' , email = '$email' where id = '$id'";

 $check = mysqli_fetch_array(mysqli_query($con,$CheckSQL));
 
 if(isset($check)){

    $check = mysqli_fetch_array(mysqli_query($con,$loginQuery));

    if(isset($check)){
        
        $newQuery = "select * from utilisateur where id = '$id'";

        $check = mysqli_fetch_array(mysqli_query($con,$newQuery));

        if(isset($check))
          echo json_encode($check);
        
         else
          echo json_encode(-1);
	 
	 }
	 
	 else
		echo json_encode(-1);
    }
    else 
        echo json_encode("existe");
     
 
 mysqli_close($con);
?>