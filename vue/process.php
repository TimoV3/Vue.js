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

    // reading the data into the site check if it works with postman
    if($action == 'read'){
        $sql = $conn->query("SELECT * FROM users");
        $users = array();
        while($row = $sql->fetch_assoc()){
            array_push($users, $row);
        }
        $result['users'] = $users; 
    }

    // adding new users 
    if($action == 'create'){
        $name = $_POST['name'];
        $email = $_POST['email'];
        $phone = $_POST['phone'];

        $sql = $conn->query("INSERT INTO users (name,email,phone) VALUES('$name','$email','$phone')");

        if($sql) {
            $result['message'] = "Gebruiker is toegevoegd";
        }
        else {
            $result['error'] = true;
            $result['message'] = "hij doet nie";
        }
    }    if($action == 'read'){
        $sql = $conn->query("SELECT * FROM users");
        $users = array();
        while($row = $sql->fetch_assoc()){
            array_push($users, $row);
        }
        $result['users'] = $users;
    }

    //updating existing users
    if($action == 'update'){
        $id = $_POST['id'];
        $name = $_POST['name'];
        $email = $_POST['email'];
        $phone = $_POST['phone'];

        $sql = $conn->query("UPDATE users SET name='$name', email ='$email', phone= '$phone' WHERE id='$id'");

        if($sql) {
            $result['message'] = "Gebruiker is geupdate";
        }
        else {
            $result['error'] = true;
            $result['message'] = "hij doet nie met update";
        }
    }

    // deleting users using their respective ID
    if($action == 'delete'){
        $id = $_POST['id'];

        $sql = $conn->query("DELETE FROM users WHERE id='$id'");

        if($sql) {
            $result['message'] = "Gebruiker is gedelete";
        }
        else {
            $result['error'] = true;
            $result['message'] = "hij doet nie met delete";
        }
    }

    $conn->close();
    echo json_encode($result);
?>