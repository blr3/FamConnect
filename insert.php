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

$first_name = $conn->real_escape_string($_POST['first_name']);
$last_name = $conn->real_escape_string($_POST['last_name']);
$birth_year = $conn->real_escape_string($_POST['birth_year']);
$birth_place = $conn->real_escape_string($_POST['birth_place']);

$full_name = "$first_name $last_name";

$stmt = $conn->prepare("INSERT INTO ancestors (fullName, birthLikeDate, birthLikePlaceText) VALUES (?,?,?)");
$stmt->bind_param("sss", $full_name, $birth_year, $birth_place);

$success = $stmt->execute();
if (!success) {
    echo "execute failed: " . htmlspecialchars($stmt->error);
}

$stmt->close();
$conn->close();
?>