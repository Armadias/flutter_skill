<?php
 
 include 'connectionDb.php';

 $nomCours = $obj['nomCours'];
 $descrCompetence = $obj['descrCompetence'];
 $nomCompetence = $obj['nomCompetence'];

 $Query ="SELECT * FROM `cours` WHERE cours.nomCours = '$nomCours'";
  
 $QueryExists = "SELECT * FROM `competences` WHERE competences.nom = '$nomCompetence' AND competences.descriptionCompetence = '$descrCompetence' "; 
  
 $QueryInsert = "INSERT INTO competences (nom, descriptionCompetence, cours_idcours)
VALUES ('$nomCompetence', '$descrCompetence', (SELECT idcours FROM cours
WHERE nomcours = '$nomCours'))";

 $QueryTabEleve = "SELECT uhc.utilisateur_id FROM `utilisateur_has_cours` uhc, `cours` c WHERE uhc.cours_idcours = c.idcours AND c.nomCours = '$nomCours'";

 $check = mysqli_fetch_array(mysqli_query($con,$Query));
 $checkExists = mysqli_fetch_array(mysqli_query($con,$QueryExists));
 //'$check.idcours'


if(isset($check)){
    if(isset($checkExists)){
        echo json_encode('-1');
    }
    else{
        echo json_encode('1');
   
        if(mysqli_query($con,$QueryInsert)){
        

            $result = mysqli_query($con,$QueryTabEleve);
        
            //var_dump($result);
            // Executing SQL Query.
            $row = mysqli_fetch_array($result);

            $message = array();
        
        
            do{
                $message[] = $row;
            }while ($row = mysqli_fetch_array($result));

		     
			for($i = 0; $i < sizeof($message); $i++){
		    $test = $message[$i]['utilisateur_id'];
		    $queryInsertEleve =
		    "INSERT INTO utilisateur_has_competences(utilisateurId, competencesIdcompetences,         
				competences_cours_idcours, valideEleve, valideProf)
		        VALUES (
		            $test,
		            (SELECT DISTINCT co.idcompetences FROM `utilisateur_has_competences` uhc, `cours` c, `competences` co 
						WHERE co.cours_idcours = c.idcours 
						AND c.nomCours = '$nomCours' 
						AND co.descriptionCompetence = '$descrCompetence'
						AND co.nom = '$nomCompetence'),
		            (SELECT c.idcours FROM `cours` c 
					WHERE c.nomCours = '$nomCours'),
					0,
					0
			)";
                
            mysqli_query($con,$queryInsertEleve);
		    }
        }
    }
}

 mysqli_close($con);
 
?>