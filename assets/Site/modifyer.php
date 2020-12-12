<?php
 
 include 'connectionDb.php';
 
 // Getting User email from JSON $obj array and store into $email.
 $email = $obj['email'];
 
 // Getting Password from JSON $obj array and store into $password. 
 $nomPrenom = $obj['nomPrenom'];

 $id = $obj['id'];
 
 $QuerySelect = "select * from utilisateur where id = '$id'";

 $QueryUpdate = "UPDATE utilisateur SET nomPrenom = '$nomPrenom' , email = '$email' where id = '$id'";

 $QueryExist = "SELECT email FROM utilisateur WHERE email='$email'";
 
 $QueryUsActuel = "SELECT email FROM utilisateur WHERE id='$id'";
 
 $check1 = mysqli_fetch_array(mysqli_query($con,$QueryExist));
 $emailAct = mysqli_fetch_array(mysqli_query($con,$QueryUsActuel));


if(isset($check1)){
    if ($check1["email"] != $emailAct["email"])
        echo json_encode('1');
    else
    {
        mysqli_query($con,$QueryUpdate);

        $check = mysqli_fetch_array(mysqli_query($con,$QuerySelect));

        if (isset($check))
            echo json_encode($check);
        else
            echo json_encode('-1');
    }
}

else{
mysqli_query($con,$QueryUpdate);

$check = mysqli_fetch_array(mysqli_query($con,$QuerySelect));

    if (isset($check))
      echo json_encode($check);
    else
      echo json_encode('-1');
    
}
     
 
 mysqli_close($con);
?>