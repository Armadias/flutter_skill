<?php
 
 include 'connectionDb.php';

 $id = $obj['id'];
 
 
 $Query =" SELECT uhc.utilisateurId, uhc.competencesIdcompetences, c.nomCours, c.descriptionCours, comp.descriptionCompetence, uhc.valideEleve, uhc.valideProf 
FROM `cours` c, `utilisateur_has_competences` uhc, `competences` comp 
WHERE uhc.utilisateurId = '$id'
AND c.idCours = comp.cours_idcours 
AND uhc.competencesIdcompetences = comp.idcompetences";

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