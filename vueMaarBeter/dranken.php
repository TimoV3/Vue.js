<?php
    $conn = new mysqli("localhost","root","","examen");
    if ($conn->connect_error) {
        die("Connection failed".$conn->connect_error);
    }

    $result = array('error' =>false);
    $action = ' ';

    if(isset($_GET['action'])){
        $action = $_GET['action']; 
    }

    // reading the data into the site check if it works with postman
    if($action == 'read'){
        $sql = $conn->query("SELECT * FROM menuitems ");
        $menuitems = array();
        while($row = $sql->fetch_assoc()){
            array_push($menuitems, $row);
        }
        // die(var_dump($menuitems));
        $result['menuitems'] = $menuitems; 
    }

    // adding new menuitems 
    if($action == 'create'){
        $Code = $_POST['Code'];
        $Naam = $_POST['Naam'];
        $Gerechtsoort_ID = $_POST['Gerechtsoort_ID'];

        $sql = $conn->query("INSERT INTO menuitems (Code,Naam,Gerechtsoort_ID) VALUES('$Code','$Naam','$Gerechtsoort_ID')");

        if($sql) {
            $result['message'] = "Menu item is toegevoegd";
        }
        else {
            $result['error'] = true;
            $result['message'] = "hij doet nie";
        }
    }    if($action == 'read'){
        $sql = $conn->query("SELECT * FROM menuitems");
        $menuitems = array();
        while($row = $sql->fetch_assoc()){
            array_push($menuitems, $row);
        }
        $result['menuitems'] = $menuitems;
    }

    //updating existing menuitems
    if($action == 'update'){
        $ID = $_POST['ID'];
        $Code = $_POST['Code'];
        $Naam = $_POST['Naam'];
        $Gerechtsoort_ID = $_POST['Gerechtsoort_ID'];

        $sql = $conn->query("UPDATE menuitems SET Code='$Code' ,Naam = '$Naam' ,Gerechtsoort_ID = '$Gerechtsoort_ID' WHERE ID='$ID'");

        if($sql) {
            $result['message'] = "menuitem is geupdate";
        }
        else {
            $result['error'] = true;
            $result['message'] = "hij doet nie met update";
        }
    }

    // deleting menuitems using their respective ID
    if($action == 'delete'){
        $ID = $_POST['ID'];

        $sql = $conn->query("DELETE FROM menuitems WHERE ID='$ID'");

        if($sql) {
            $result['message'] = "menuitem is gedelete";
        }
        else {
            $result['error'] = true;
            $result['message'] = "hij doet nie met delete";
        }
    }

    $conn->close();
    echo json_encode($result);
