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

    $id = $conn->real_escape_string($_POST['id']);
    
?>