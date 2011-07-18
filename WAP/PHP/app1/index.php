<?php

    session_start();
    //get the session variables.
    $accessToken = $_SESSION["wap_access_token"];
    $sendWAPAction = $_REQUEST[sendWAP];
    $getWapDelStatusAction = $_REQUEST[getWapDeliveryStatus];
?>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <title>Sending Wap</title>
</head>

<body>
<img src="http://developer.att.com/developer/images/att.gif" />

<?php
//check whether the access token is available,else fetch it from the given url.
    if($accessToken == null || $accessToken == '') {
        print '<br/><a href="oauth.php">Fetch Access Token</a><br/>';
    }
?>
<form name="sendWAP" method="post">
    Access Token <input type="text" name="access_token" value="<?php echo $accessToken ?>" size=40/><br/>
    MSISDN <input type="text" name="address" value="tel:" /><br/>
    Priority <select name="priority"><option value="Default" selected="selected">Default</option><option value="Low">Low</option><option value="Normal">Normal</option><option value="High">High</option></select>
    Subject <input type="text" name="subject" value="Test." size=40/><br/>
    Attachment <input type="file" name="file" id="file" />
    <input type="submit" name="sendWAP" value="Send WAP"/></form><br>
</form>

<?php
//if the user submitted the sendWAP form, then get the values and try to send the WAP PUSH message.  
	if ($sendWAPAction != null) {
        	$address = $_POST['address'];
		$priority = $_POST['priority'];
		$subject = $_POST['subject'];
        
		$fileContents = join("", file($_FILES['file']['tmp_name'])); 
		
		
		$host="ssl://beta-api.att.com";//target host name
    		$port="443";//port number
    		//try to connect the socket  
    		$fp = fsockopen($host, $port, $errno, $errstr, 1000); 
		//checking the connection ,if it fails display the error 
    		if (!$fp) { 
        		echo "errno: $errno \n"; 
        		echo "errstr: $errstr\n"; 
        		//return $result; 
    		}
		
    		$boundary = "--0246824681357ACXZabcxyz";
    		//$sendWAP_JSonData = "address=$address&priority=$priority&subject=$subject&";
	        //$sendWAP_JSonData = 'address='.urlencode("tel:4257865687").'&subject='.urlencode("TestMMSMessage").'&priority=High'.'&content-type='.urlencode("application/xml");
	        $sendWAP_JSonData = 'address='.urlencode($address).'&subject='.urlencode("TestMMSMessage").'&priority=High'.'&content-type='.urlencode("application/xml");
   
    		//WAPPUSH data
    		$data = "";
    		$data .= "--$boundary\r\n";
    		$data .= "Content-type: application/x-www-form-urlencoded; charset=UTF-8\r\n";
    		$data .= "Content-Transfer-Encoding: 8bit\r\n";
		$data .= "Content-ID: <startpart>\r\n";
		$data .= "Content-Disposition: form-data; name=\"root-fields\"\r\n\r\n".$sendWAP_JSonData."\r\n"; 
		//$data .= "Content-type: application/xml\r\n\r\n";    		
		$data .= "--$boundary\r\n";
    		$data .= "Content-Type: text/plain\r\n";
    		$data .= "Content-Transfer-Encoding: binary\r\n";
		$data .= "Content-ID: <".$_FILES['file']['name'].">\r\n";
		$data .= "Content-Disposition: attachment; name=\"".$_FILES['file']['name']."\"\r\n\r\n";
		$data .= $fileContents."\r\n"; 
    		$data .= "--$boundary--\r\n"; 

    		//http header values
    		$header = "POST https://beta-api.att.com/1/messages/outbox/wapPush?access_token=$accessToken HTTP/1.1\r\n";
    		$header .= "Host: beta-api.att.com\r\n";
		//$header .= "X-HostCommonName: beta-api.att.com\r\n";
		//$header .= "Cookie: api.att-stg.amdocshub.com=\"R533090545\"\r\n";    		
    		$header .= "MIME-Version: 1.0\r\n";
		$dc = strlen($data); //content length
		//$header .= "Cookie2: $Version= \"1\"\r\n";
		//$header .= "Host: beta-api.att.com\r\n";
    		
		//$header .= "X-Forwarded-For: 135.214.40.30\r\n";
 		//$header .= "X-Target-URI: https://beta-api.att.com\r\n";
		$header .= "Content-Type: multipart/form-data; type=\"application/x-www-form-urlencoded\"; start=\"\"; boundary=\"$boundary\"\r\n";
		$header .= "Content-length: $dc\r\n\r\n";
		//$header .= "Connection: Keep-Alive\r\n\r\n";

    		$httpRequest = $header.$data;
    		fputs($fp, $httpRequest);
    		print("HTTP : $httpRequest");
    		//read the response from file and store it.
    		$res="";
    		while(!feof($fp)) { 
        		$res .= fread($fp,1); 
    		} 
    		fclose($fp); //close the socket
    		print ("Response=$res");//display the response

		$responseCode=trim(substr($res,9,4));//get the response code.
		//if the request is successful, get the id.else display the error.
		if($responseCode=='201')
		{
	    		$splitString=explode("\r\n\r\n",$res);
	    		$jsonObj = json_decode($splitString[1],true);
	    		print "Id : ".$jsonObj['id'];
		} else {
	    		print "The Request was Not Successful";
		}
	}
?>
<hr>
<form name="getWapDeliveryStatus" method="get">
    WAP ID <input type="text" name="id" value="" size=40/><br />
    Access Token <input type="text" name="access_token" value="<?php echo $accessToken ?>" size=40/><br>
    <input type="submit" name="getWapDeliveryStatus" value="Get WAP Delivery Status" />
</form>

<?php
//if the user submitted the getWapDeliveryStatus form,
//then try to get the delivery status by using the WAP id.	
	if ($getWapDelStatusAction != null) {
    		$wapID=$_GET["id"];
		//url to get the delivery status
		$getWAPDelStatus_Url = "https://beta-api.att.com/1/messages/outbox/wapPush/";
		$getWAPDelStatus_Url .= $wapID;
		$getWAPDelStatus_Url .= "?access_token=".$accessToken;
		//http header
		$getWAPDelStatus_headers = array(
		'Content-Type: application/x-www-form-urlencoded'
		);
	
		$getWAPDelStatus = curl_init();
		curl_setopt($getWAPDelStatus, CURLOPT_URL, $getWAPDelStatus_Url);
		curl_setopt($getWAPDelStatus, CURLOPT_HTTPGET, 1);
		curl_setopt($getWAPDelStatus, CURLOPT_HEADER, 0);
		curl_setopt($getWAPDelStatus, CURLINFO_HEADER_OUT, 0);
		curl_setopt($getWAPDelStatus, CURLOPT_HTTPHEADER, $getWAPDelStatus_headers);
		curl_setopt($getWAPDelStatus, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($getWAPDelStatus, CURLOPT_SSL_VERIFYPEER, false);

		$getWAPDelStatus_response = curl_exec($getWAPDelStatus);

		$responseCode=curl_getinfo($getWAPDelStatus,CURLINFO_HTTP_CODE);
		/*
	  		If URL invocation is successful fetch the response,
	  		else display the error.
		*/
      		if($responseCode==200)
      		{
	    		//decode the response and display the delivery status.
			$jsonObj = json_decode($getWAPDelStatus_response);
			$deliveryStatus = $jsonObj->{'deliveryInfoList'}->{'deliveryInfo'}->{'deliveryStatus'};
			echo "Delivery Status for WAP ID - ".$wapID." : ".$deliveryStatus;
		}
		else{
		echo curl_error($getWAPDelStatus);
		}
		curl_close ($getWAPDelStatus);
		
	}
?>
</body>
</html>


