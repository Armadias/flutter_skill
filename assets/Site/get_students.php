<?php
 
	//Define your host here.
	$HostName = "localhost";
	 
	//Define your MySQL Database Name here.
	$DatabaseName = "id11189654_flutter_db";
	 
	//Define your Database UserName here.
	$HostUser = "id11189654_root";
	 
	//Define your Database Password here.
	$HostPass = "1234567890";
	 
	// Creating connection
	$conn = new mysqli($HostName, $HostUser, $HostPass, $DatabaseName);
 
if ($conn->connect_error) {
 
	die("Connection failed: " . $conn->connect_error);
} 
 
    $utilisateurid = $obj['utilisateurid'];
    
	// Creating SQL command to fetch all records from Student_Data Table.
	//$sql = "SELECT * FROM utilisateur_has_utilisateur WHERE utilisateur.id = '$id'";
	$sql = "SELECT * FROM utilisateur, utilisateur_has_utilisateur WHERE utilisateur_has_utilisateur.utilisateur_id = $utilisateurid";
	
	$result = $conn->query($sql);
 
if ($result->num_rows >0) {
 
	 while($row[] = $result->fetch_assoc()) {
	 
	 $item = $row;
	 
	 $json = json_encode($item, JSON_NUMERIC_CHECK);
	 
 }
 
} else {
	echo "No Data Found.";
}
echo $json;
$conn->close();
 
?>