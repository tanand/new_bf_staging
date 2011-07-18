<?php
    session_start();
    
    /* Extract the session variables */  
    $accessToken = $_SESSION["sms_access_token"];
    $sendSMSAction = $_REQUEST[sendSms];
    $getSMSDelStatusAction = $_REQUEST[getSmsDeliveryStatus];
?>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <title>Sending SMS</title>
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

<?php //form for send SMS 
?>
<form name="sendSms" method="post">
    Access Token <input type="text" name="access_token" value="<?php echo $accessToken ?>" size=40/><br/>
    MSISDN <input type="text" name="address" value="tel:" /><br/>
    Message <input type="text" name="message" value="Test." size=40/><br/>
    <input type="submit" name="sendSms" value="Send SMS"/></form><br>
</form>

<?php
	/* Extract POST parmeters from send SMS form
	   and invoke he URL to send SMS along with access token
	*/
	if ($sendSMSAction != null) {
        $smsMsg = $_POST['message'];
        $address = $_POST['address'];
	
	// Form the URL to send SMS 
	$sendSMS_RequestBody = '{"address":"'.$address.'","message":"'.$smsMsg.'"}';//post data
	$sendSMS_Url = "https://beta-api.att.com/1/messages/outbox/sms?access_token=".$accessToken;
	$sendSMS_headers = array(
	'Content-Type: application/json'
	);
	
	//Invoke the URL
	$sendSMS = curl_init();
	curl_setopt($sendSMS, CURLOPT_URL, $sendSMS_Url);
	curl_setopt($sendSMS, CURLOPT_POST, 1);
	curl_setopt($sendSMS, CURLOPT_HEADER, 0);
	curl_setopt($sendSMS, CURLINFO_HEADER_OUT, 0);
	curl_setopt($sendSMS, CURLOPT_HTTPHEADER, $sendSMS_headers);
	curl_setopt($sendSMS, CURLOPT_POSTFIELDS, $sendSMS_RequestBody);
	curl_setopt($sendSMS, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($sendSMS, CURLOPT_SSL_VERIFYPEER, false);
	
	print "<p>Request sent in sendSMS  :</br>$sendSMS_RequestBody</p>";
	$sendSMS_response = curl_exec($sendSMS);
	
	print "<p>Response of sendSMS  :</br>$sendSMS_response</p>";

	$responseCode=curl_getinfo($sendSMS,CURLINFO_HTTP_CODE);

        /*
	  If URL invocation is successful print success msg along with sms ID,
	  else print the error msg
	*/
	  
	if($responseCode==200)
	{
		$jsonObj = json_decode($sendSMS_response);
		$smsID = $jsonObj->{'id'};//if the SMS send successfully ,then will get a SMS id.
        	echo "Successfully Submitted <br> SMS ID value is : ".$smsID;
	}
	else{
		echo curl_error($sendSMS);
	}
	curl_close ($sendSMS);
	
}
?>
<hr>
    <?php//form for getting delivery status ?>
<form name="getSmsDeliveryStatus" method="get">
    SMS ID <input type="text" name="id" value="" size=40/><br />
    Access Token <input type="text" name="access_token" value="<?php echo $accessToken ?>" size=40/><br>
    <input type="submit" name="getSmsDeliveryStatus" value="Get SMS Delivery Status" />
</form>

<?php
        /* Extract sms ID  from getSmsDeliveryStatus form
           and invoke the URL to get Sms Delivery Status along with access token
        */
	
	if ($getSMSDelStatusAction != null) {
        $smsID = $_GET['id'];
	
	// Form the URL to get Sms Delivery Status
	$getSMSDelStatus_Url = "https://beta-api.att.com/1/messages/outbox/sms/";
	$getSMSDelStatus_Url .= $smsID;
	$getSMSDelStatus_Url .= "?access_token=".$accessToken;
	$getSMSDelStatus_headers = array(
		'Content-Type: application/x-www-form-urlencoded'
	);
	
	//Invoke the URL
	$getSMSDelStatus = curl_init();	
	curl_setopt($getSMSDelStatus, CURLOPT_URL, $getSMSDelStatus_Url);
	curl_setopt($getSMSDelStatus, CURLOPT_HTTPGET, 1);
	curl_setopt($getSMSDelStatus, CURLOPT_HEADER, 0);
	curl_setopt($getSMSDelStatus, CURLINFO_HEADER_OUT, 0);
	curl_setopt($getSMSDelStatus, CURLOPT_HTTPHEADER, $getSMSDelStatus_headers);
	curl_setopt($getSMSDelStatus, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($getSMSDelStatus, CURLOPT_SSL_VERIFYPEER, false);

	$getSMSDelStatus_response = curl_exec($getSMSDelStatus);
	$responseCode=curl_getinfo($getSMSDelStatus,CURLINFO_HTTP_CODE);

        /*
	  If URL invocation is successful print success msg along with sms delivery status,
	  else print the error msg
	*/

	if($responseCode==200)
	{
		//decode the response and display it.
		$jsonObj = json_decode($getSMSDelStatus_response);
		$deliveryStatus = $jsonObj->{'deliveryInfoList'}->{'deliveryInfo'}->{'deliveryStatus'};
        	echo "Delivery Status for SMS ID - ".$smsID." : ".$deliveryStatus;
	}
	else{
		echo curl_error($getSMSDelStatus);
	}
	
	curl_close ($getSMSDelStatus);
	
}
?>
</body>
</html>
