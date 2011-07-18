<?php
    include("config.php");
    session_start();

    /* Extract the session variables */
    $accessToken = $_SESSION["sms_access_token"];
    $receiveMsg = $_REQUEST[receiveSms];
?>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <title>Receiving SMS</title>
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

<form name="receiveSms" method="get">
    Access Token <input type="text" name="access_token" value="<?php echo $accessToken ?>" size=40/><br/>
    <input type="submit" name="receiveSms" value="Receive SMS"/></form><br>
</form>

<?php
        /*
	  If Receive SMS request is submitted, then invoke the URL to get the inbox messages
	  by using the registrationID i.e. short code, along with the access token.
	*/
	if ($receiveMsg != null) {

	// Form the URL for getting the inbox messages
	$receiveSMS_Url = "https://beta-api.att.com/1/messages/inbox/sms?access_token=".$accessToken."&registrationID=".$short_code;

	$receiveSMS_headers = array(
		'Content-Type: application/x-www-form-urlencoded'
	);

	//Invoke the URL
	$receiveSMS = curl_init();
	curl_setopt($receiveSMS, CURLOPT_URL, $receiveSMS_Url);
	curl_setopt($receiveSMS, CURLOPT_HTTPGET, 1);
	curl_setopt($receiveSMS, CURLOPT_HEADER, 0);
	curl_setopt($receiveSMS, CURLINFO_HEADER_OUT, 0);
	curl_setopt($receiveSMS, CURLOPT_HTTPHEADER, $receiveSMS_headers);
	curl_setopt($receiveSMS, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($receiveSMS, CURLOPT_SSL_VERIFYPEER, false);

	$receiveSMS_response = curl_exec($receiveSMS);
	$responseCode=curl_getinfo($receiveSMS,CURLINFO_HTTP_CODE);
	print "Receive SMS Response :".$receiveSMS_response;

       /*
	  If URL invocation is successful fetch all the received sms,else display the error.
	*/

        if($responseCode==200)
        {
            //$jsonObj = json_decode($receiveSMS_response);
        	print "Receive SMS Messages : <br/>";
		//decode the response and display the messages.
		$jsonObj = json_decode($receiveSMS_response,true);
		$smsMsgList = $jsonObj['inboundSMSMessageList'];
		$noOfReceivedSMSMsg = $smsMsgList['numberOfMessagesInThisBatch'];
		echo "Number of SMS Messages received is : $noOfReceivedSMSMsg <br/>";

		if ($noOfReceivedSMSMsg == "0") {
		echo "<b>Currently there are no SMS messages to be received.</b>";
		} else {
		    echo "resourceURL :".$smsMsgList["resourceURL"]."<br/>";
		    print "<table><tr><th>Message Id</th><th>Message</th><th>Sender Address</th></tr>";
		    foreach($smsMsgList["inboundSMSMessage"] as $smsTag=>$val) {
		    echo "<tr><td>".$val["messageId"]."</td>";
		    echo "<td>".$val["message"]."</td>";
		    echo "<td>".$val["senderAddress"]."</td></tr>";
		    }
	    	print "</table>";
		}

        } else{
            echo curl_error($receiveSMS);
        }
	curl_close ($receiveSMS);
    }
?>
</body>
</html>
