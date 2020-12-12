<?php
 
 include 'connectionDb.php';
 
 // Getting User email from JSON $obj array and store into $email.
 $idComp = $obj['idComp'];

 $id = $obj['id'];

 $valide = $obj['valide'];

 $status = $obj['status'];

 $intVal;

 $valide? $intVal = 1: $intVal = 0;
 
 $QuerySelect = "select * from utilisateur_has_competences where id = '$id'";

 $QueryUpdateP = "UPDATE utilisateur_has_competences SET valideProf = $intVal where utilisateurId = '$id' 
 and competencesIdcompetences = '$idComp'";

$QueryUpdateE = "UPDATE utilisateur_has_competences SET valideEleve = $intVal where utilisateurId = '$id' 
and competencesIdcompetences = '$idComp'";
 

if ($status == '0')
{
    if (mysqli_query($con,$QueryUpdateE))
        echo json_encode('1');
    else
    echo json_encode('-1');
}
    
else 
{
    if (mysqli_query($con,$QueryUpdateP))
        echo json_encode('1');
        else echo json_encode('-1');
}
     
 
 mysqli_close($con);
?>