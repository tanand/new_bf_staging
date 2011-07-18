<?php
    session_start();

    /* Extract the session variables. */
    $accessToken = $_SESSION["mms_access_token"];
    $sendMMSAction = $_REQUEST[sendMMS];
    $getMmsDelStatusAction = $_REQUEST[getMmsDeliveryStatus];
?>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <title>Sending MMS</title>
</head>

<body>
<img src="http://developer.att.com/developer/images/att.gif" />

<?php
    /*
      Check if access token is available in the session,
      else prompt user to fetch access token.
    */
    if($accessToken == null || $accessToken == '') {
        print '<br/><a href="oauth.php">Fetch Access Token</a><br/>';
    }
?>
<form name="sendMMS" method="post" enctype="multipart/form-data">
    Access Token <input type="text" name="access_token" value="<?php echo $accessToken ?>" size=40/><br/>
    MSISDN <input type="text" name="address" value="tel:" /><br/>
    Priority <select name="priority"><option value="Default" selected="selected">Default</option><option value="Low">Low</option><option value="Normal">Normal</option><option value="High">High</option></select>
    Subject <input type="text" name="subject" value="Test." size=40/><br/>
    Attachment <input type="file" name="file" id="file" />
    <input type="submit" name="sendMMS" value="Send MMS"/></form><br>
</form>

<?php
	/* Extract POST parmeters from send MMS form
	   and invoke the URL to send MMS along with access token
	*/
	if ($sendMMSAction != null) {
        $address = $_POST['address'];
	$priority = $_POST['priority'];
	$subject = $_POST['subject'];
        
	//Form byte array to be sent in MIME attachment
	$fileContents = join("", file($_FILES['file']['tmp_name']));

	$host="ssl://beta-api.att.com";
	$port="443";
	$fp = fsockopen($host, $port, $errno, $errstr);

	if (!$fp) {
	    echo "errno: $errno \n";
	    echo "errstr: $errstr\n";
	    return $result;
	}
	//Boundary for MIME part
	$boundary = "----------------------------".substr(md5(date("c")),0,10);

        //Form the first part of MIME body containing address, subject in urlencided format
	$sendMMSData = 'address='.urlencode($address).'&subject='.urlencode($subject).'&priority='.urlencode($priority);

	//Form the MIME part with MIME message headers and MIME attachment
	$data = "";
	$data .= "--$boundary\r\n";
	$data .= "Content-Type: application/x-www-form-urlencoded; charset=UTF-8\r\nContent-Transfer-Encoding: 8bit\r\nContent-Disposition: form-data; name=\"root-fields\"\r\nContent-ID: <startpart>\r\n\r\n".$sendMMSData."\r\n";
	$data .= "--$boundary\r\n";
	$data .= "Content-Disposition: attachment; name=\"".$_FILES['file']['name']."\"\r\n";
	$data .= "Content-Type: \"".str_replace("pjpeg", "jpeg", $_FILES['file']['type'])."\"\r\n";
	$data .= "Content-ID: <".$_FILES['file']['name'].">\r\n";
	$data .= "Content-Transfer-Encoding: binary\r\n\r\n";
	$data .= $fileContents."\r\n";
	$data .= "--$boundary--\r\n";
	
	// Form the HTTP headers
	$header = "POST https://beta-api.att.com/1/messages/outbox/mms?access_token=".$accessToken." HTTP/1.0\r\n";
	$header .= "Content-type: multipart/form-data; type=\"application/x-www-form-urlencoded\"; start=\"<startpart>\"; boundary=\"$boundary\"\r\n";
	$header .= "MIME-Version: 1.0\r\n";
	$header .= "Host: beta-api.att.com\r\n";
	$dc = strlen($data); //content length
	$header .= "Content-length: $dc\r\n\r\n";

	$httpRequest = $header.$data;
	fputs($fp, $httpRequest);
	

	$sendMMS_response="";
	while(!feof($fp)) {
	    $sendMMS_response .= fread($fp,1024);
	}
	fclose($fp);
	print "<p>SendMms Response : $sendMMS_response</p>";
	$responseCode=trim(substr($sendMMS_response,9,4));//get the response code.

	/*
	  If URL invocation is successful print the mms ID,
	  else print the error msg
	*/
	if($responseCode=='201')
	{
	    $splitString=explode("{",$sendMMS_response);
	    $joinString="{".implode("{",array($splitString[1],$splitString[2]));
	    $jsonObj = json_decode($joinString,true);
	    print "Id : ".$jsonObj['id'];
	} else {
	    print "The Request was Not Successful";
	}
}
?>
<hr>
<form name="getMmsDeliveryStatus" method="get">
    MMS ID <input type="text" name="id" value="" size=40/><br />
    Access Token <input type="text" name="access_token" value="<?php echo $accessToken ?>" size=40/><br>
    <input type="submit" name="getMmsDeliveryStatus" value="Get MMS Delivery Status" />
</form>

<?php

	/* Extract mms ID  from getMmsDeliveryStatus form
           and invoke the URL to get Mms Delivery Status along with access token
        */
	if ($getMmsDelStatusAction != null) {
    	$mmsID=$_GET["id"];

	//Form URL to get the delivery status
	$getMMSDelStatus_Url = "https://beta-api.att.com/1/messages/outbox/mms/";
	$getMMSDelStatus_Url .= $mmsID;
	$getMMSDelStatus_Url .= "?access_token=".$accessToken;

	//http header
	$getMMSDelStatus_headers = array(
		'Content-Type: application/x-www-form-urlencoded'
	);

	$getMMSDelStatus = curl_init();
	curl_setopt($getMMSDelStatus, CURLOPT_URL, $getMMSDelStatus_Url);
	curl_setopt($getMMSDelStatus, CURLOPT_HTTPGET, 1);
	curl_setopt($getMMSDelStatus, CURLOPT_HEADER, 0);
	curl_setopt($getMMSDelStatus, CURLINFO_HEADER_OUT, 0);
	curl_setopt($getMMSDelStatus, CURLOPT_HTTPHEADER, $getMMSDelStatus_headers);
	curl_setopt($getMMSDelStatus, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($getMMSDelStatus, CURLOPT_SSL_VERIFYPEER, false);

	$getMMSDelStatus_response = curl_exec($getMMSDelStatus);
	curl_close ($getMMSDelStatus);

	//decode the response and display the delivery status.
	$jsonObj = json_decode($getMMSDelStatus_response);
	$deliveryStatus = $jsonObj->{'deliveryInfoList'}->{'deliveryInfo'}->{'deliveryStatus'};
	echo "Delivery Status for MMS ID - ".$mmsID." : ".$deliveryStatus;
	}
?>
</body>
</html>