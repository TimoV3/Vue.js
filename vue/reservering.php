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
        $sql = $conn->query("SELECT * FROM reserveringen");
        $reserveringen = array();
        while($row = $sql->fetch_assoc()){
            array_push($reserveringen, $row);
        }
        $result['reserveringen'] = $reserveringen; 
    }

    // adding new reserveringen 
    if($action == 'create'){
        $Tafel = $_POST['Tafel'];
        $Datum = $_POST['Datum'];
        $Tijd = $_POST['Tijd'];
        $Klant_ID = $_POST['Klant_ID'];
        $Aantal = $_POST['Aantal'];
        $Status = $_POST['Status'];
        $Datum_toegevoegd = $_POST['Datum_toegevoegd'];
        $Aantal_k = $_POST['Aantal_k'];
        $Allergieen = $_POST['Allergieen'];
        $Opmerkingen = $_POST['Opmerkingen'];

        $sql = $conn->query("INSERT INTO reserveringen (Tafel,Datum,Tijd,Klant_ID,Aantal,Status,Datum_toegevoegd,Aantal_k,Allergieen,Opmerkingen) VALUES('$Tafel','$Datum','$Tijd','$Klant_ID','$Aantal','$Status','$Datum_toegevoegd','$Aantal_k','$Allergieen','$Opmerkingen')");

        if($sql) {
            $result['message'] = "Reservering is toegevoegd";
        }
        else {
            $result['error'] = true;
            $result['message'] = "hij doet nie";
        }
    }    if($action == 'read'){
        $sql = $conn->query("SELECT * FROM reserveringen");
        $reserveringen = array();
        while($row = $sql->fetch_assoc()){
            array_push($reserveringen, $row);
        }
        $result['reserveringen'] = $reserveringen;
    }

    //updating existing reserveringen
    if($action == 'update'){
        $ID = $_POST['ID'];
        $Tafel = $_POST['Tafel'];
        $Datum = $_POST['Datum'];
        $Tijd = $_POST['Tijd'];
        $Klant_ID = $_POST['Klant_ID'];
        $Aantal = $_POST['Aantal'];
        $Status = $_POST['Status'];
        $Datum_toegevoegd = $_POST['Datum_toegevoegd'];
        $Aantal_k = $_POST['Aantal_k'];
        $Allergieen = $_POST['Allergieen'];
        $Opmerkingen = $_POST['Opmerkingen'];

        $sql = $conn->query("UPDATE reserveringen SET Tafel='$Tafel' ,Datum = '$Datum' ,Tijd = '$Tijd',Klant_ID = '$Klant_ID' ,Aantal= '$Aantal',`Status`= '$Status',Datum_toegevoegd ='$Datum_toegevoegd',Aantal_k='$Aantal_k',Allergieen='$Allergieen',Opmerkingen='$Opmerkingen' WHERE ID='$ID'");

        if($sql) {
            $result['message'] = "reservering is geupdate";
        }
        else {
            $result['error'] = true;
            $result['message'] = "hij doet nie met update";
        }
    }

    // deleting reserveringen using their respective ID
    if($action == 'delete'){
        $ID = $_POST['ID'];

        $sql = $conn->query("DELETE FROM reserveringen WHERE ID='$ID'");

        if($sql) {
            $result['message'] = "reservering is gedelete";
        }
        else {
            $result['error'] = true;
            $result['message'] = "hij doet nie met delete";
        }
    }

    $conn->close();
    echo json_encode($result);
