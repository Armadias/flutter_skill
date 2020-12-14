<?php
 
 include 'connectionDb.php';

 $image = $_FILES['image']['name'];
 $id = (int)$_POST['id'];

 $imagePath = 'image/'.$image;

 $tmp_name = $_FILES['image']['tmp_name'];

 move_uploaded_file($tmp_name, $imagePath);

 $insertQuery = "UPDATE utilisateur SET image = '$image' WHERE id = '$id'";

if(mysqli_query($con,$insertQuery))
    echo json_encode('1');
else 
    echo json_encode('-1');

 ?>