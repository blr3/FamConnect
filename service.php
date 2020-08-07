<?php

$servername = "localhost";
$username = "famconnect_robert";
$password = "1139mapleavenue";
$db_name = "famconnect_db";

// Create connection
$con=mysqli_connect($servername, $username, $password, $db_name);

// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$first_name = $_POST['first_name'];
$last_name = $_POST['last_name'];
$birth_year = $_POST['birth_year'];
$birth_place = $_POST['birth_place'];
$checkbox = $_POST['checkbox'];


// This SQL statement selects ALL from the table 'ancestors'
$sql = "SELECT fullName, sex, birthLikeDate, birthLikePlaceText FROM ancestors";

$attribute_ctr = 0;
// check which attributes to search for and append to SQL query

if (isset($first_name) && isset($last_name)) {
    if ($attribute_ctr == 0) {
        $sql .= " WHERE ";
    }
    if ($checkbox) {
        $sql .= "fullName LIKE \"%" . $first_name . "%". $last_name . "%\"";
    } else {
        $sql .= "fullName = \"" . $first_name . " " . $last_name . "\"";
    }
    $attribute_ctr++;
} elseif (!isset($first_name)) {
    if ($attribute_ctr == 0) {
        $sql .= " WHERE ";
    } else {
        $sql .= " AND ";
    }
    if ($checkbox) {
        $sql .= "fullName LIKE \"%" . $last_name . "%\"";
    } else {
        $sql .= "fullName = \"%". $last_name . "\"";
    }
    $attribute_ctr++;
} elseif (!isset($last_name)) {
    if ($attribute_ctr == 0) {
        $sql .= " WHERE ";
    } else {
        $sql .= " AND ";
    }
    if ($checkbox) {
        $sql .= "fullName LIKE \"%" . $first_name . "%\"";
    } else {
        $sql .= "fullName = \"" . $first_name . "%". "\"";
    }
    $attribute_ctr++;
}
if (isset($birth_year)) {
    if ($attribute_ctr == 0) {
        $sql .= " WHERE ";
    } else {
        $sql .= " AND ";
    }
    $sql .= "birthLikeDate = $birth_year";
    $attribute_ctr++;
}
if (isset($birth_place)) {
    if ($attribute_ctr == 0) {
        $sql .= " WHERE ";
    } else {
        $sql .= " AND ";
    }
    $sql .= "birthLikePlaceText = $birth_place";
    $attribute_ctr++;
}

// Check if there are results
if ($result = mysqli_query($con, $sql))
{
	// If so, then create a results array and a temporary one
	// to hold the data
	$resultArray = array();
	$tempArray = array();

	// Loop through each row in the result set
	while($row = $result->fetch_object())
	{
		// Add each row into our results array
		$tempArray = $row;
	  array_push($resultArray, $tempArray);
	}

	// Finally, encode the array to JSON and output the results
	echo json_encode($resultArray);
}

// Close connections
mysqli_close($con);
?>
