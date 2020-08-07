<?php
// Create connection to database
$con=mysqli_connect("localhost","famconnect_test","t1e2s3t4*","famconnect_db");

// Check connection
if (mysqli_connect_errno())
{
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$first_name = $con->real_escape_string($_POST['first_name']);
//$last_name = $con->real_escape_string($_POST['last_name']);
$birth_year = $con->real_escape_string($_POST['birth_year']);
$birth_place = $con->real_escape_string($_POST['birth_place']);
// $checkbox = $con->real_escape_string($_POST['checkbox']);

$first_name = '%' . $first_name . '%';
$birth_year = '%' . $birth_year . '%';
$birth_place  = '%' . $birth_place  . '%';

$stmt = $con->prepare("SELECT pid, fullName, sex, birthLikeDate, birthLikePlaceText FROM ancestors
  WHERE fullName LIKE ? AND birthLikeDate LIKE ? AND birthLikePlaceText LIKE ?");
$stmt->bind_param('sss', $first_name, $birth_year, $birth_place);
$stmt->execute();
$result = $stmt->get_result();
// $result = $stmt->fetchAll();
$json_array = array();

// Prepares all the results to be encoded in a JSON
while ($row = $result->fetch_assoc())
{
    $ancestors_id = $row['pid'];
    $ancestors_fullName = $row['fullName'];
    $ancestors_sex = $row['sex'];
    $ancestors_birthLikeDate =$row['birthLikeDate'];
    $ancestors_birthLikePlaceText = $row['birthLikePlaceText'];
    $ancestors = array('pid' => $ancestors_id, 'fullName' => $ancestors_fullName, 'sex' => $ancestors_sex,
    'birthLikeDate' => $ancestors_birthLikeDate, 'birthLikePlaceText' => $ancestors_birthLikePlaceText);
    array_push($json_array, $ancestors);
}

// encodes array with results from database
echo json_encode($json_array);
mysqli_close($con);
?>
