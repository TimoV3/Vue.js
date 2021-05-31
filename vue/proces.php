<?php
    $conn = new mysqli("localhost","root","","crud_vue");
    if ($conn->connect_error) {
        die("Connection failed".$conn->connect_error);
    }

    $result = array('error' =>false);
    $action = ' ';

    if(isset($_GET['action'])){
        $action = $_GET['action'];
    }

    if($action == 'read'){
        $sql = $conn->query("SELECT * FROM shop");
        $shop = array();
        while($row = $sql->fetch_assoc()){
            array_push($shop, $row);
        }
        $result['shop'] = $shop;
    }
    
    if($action == 'create'){
        $merk = $_POST['merk'];
        $beschrijving = $_POST['beschrijving'];
        $product = $_POST['product'];

        $sql = $conn->query("INSERT INTO shop (merk,beschrijving,product) VALUES('$merk','$beschrijving','$product')");

        if($sql) {
            $result['message'] = "product is toegevoegd";
        }
        else {
            $result['error'] = true;
            $result['message'] = "hij doet nie";
        }
    }    if($action == 'read'){
        $sql = $conn->query("SELECT * FROM shop");
        $shop = array();
        while($row = $sql->fetch_assoc()){
            array_push($shop, $row);
        }
        $result['shop'] = $shop;
    }
    
    if($action == 'update'){
        $id = $_POST['id'];
        $merk = $_POST['merk'];
        $beschrijving = $_POST['beschrijving'];
        $product = $_POST['product'];

        $sql = $conn->query("UPDATE shop SET merk='$merk', beschrijving ='$beschrijving', product= '$product' WHERE id='$id'");

        if($sql) {
            $result['message'] = "product is geupdate";
        }
        else {
            $result['error'] = true;
            $result['message'] = "hij doet nie met update";
        }
    }

    if($action == 'delete'){
        $id = $_POST['id'];

        $sql = $conn->query("DELETE FROM shop WHERE id='$id'");

        if($sql) {
            $result['message'] = "product is gedelete";
        }
        else {
            $result['error'] = true;
            $result['message'] = "hij doet nie met delete";
        }
    }
    
    $conn->close();
    echo json_encode($result);
?>