<?php
// Create connection to database
$servername = "localhost";
$username = "famconnect_robert";
$password = "1139mapleavenue";
$db_name = "famconnect_db";

$conn = mysqli_connect($servername, $username, $password, $db_name);

// check connection
if (mysqli_connect_errno()) {
    echo "failed to connect to MySQL: " . mysqli_connect_error();
}

//$first_name = $conn->real_escape_string($_POST['first_name']);
//$last_name = $conn->real_escape_string($_POST['last_name']);
//$birth_year = $conn->real_escape_string($_POST['birth_year']);
//$birth_place = $conn->real_escape_string($_POST['birth_place']);
$id = $conn->real_escape_string($_POST['id']);

$full_name = "$first_name $last_name";
// add id column?
$stmt = $conn->prepare("DELETE FROM ancestors WHERE pid = ?");
$stmt->bind_param("i", $id);

if ($stmt->execute() === false) {
    echo "delete failed: " . htmlspecialchars($stmt->error);
}

$stmt->close();
$conn->close();
?>