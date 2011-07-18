<?php
    include ("config.php");
    $time=time();
    
    $date = $_POST['dateCreated'];
    $from = $_POST['from'];
    $to = $_POST['to'];
    $subject = $_POST['subject'];

    foreach($_FILES as $key){
        copy($key[tmp_name], "$attachment_dir/$time/".$key[name]);
    }

    $fp = fopen("$attachment/$time/report.txt", 'w');

    //start output buffering
    ob_start();
    echo "Date : " . $date . "\n";
    echo "From : " . $from . "\n";
    echo "To : " . $to . "\n";
    echo "Subject : " . $subject . "\n\n";
    echo "Files : ";
    
    print_r($_FILES);
    
    $echo = ob_get_contents();//get the contents of the output buffer.
    fwrite($fp, $echo);
    fclose($fp);
?>