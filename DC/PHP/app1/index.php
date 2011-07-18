<?php
    session_start();
    
    /* Extract the session variables */  
    $accessToken = $_SESSION["deviceInfo_access_token"];
    $deviceInfo = $_REQUEST[deviceInfo];//while submitting the deviceInfo is set
?>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <title>Device Information</title>
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
<form name="deviceInfo" method="get">
    Access Token <input type="text" name="access_token" value="<?php echo $accessToken ?>" size=40/><br/>
    Device Id <input type="text" name="deviceId" value="tel:" /><br/>
    <input type="submit" name="deviceInfo" value="Device Information"/></form><br>
</form>

<?php
	/* Extract parmeter device Id from deviceInfo form
	   and invoke the URL to get deviceInfo along with access token
	*/
	if ($deviceInfo != null) {
        $deviceId = $_GET['deviceId'];
	
	// Form the URL to get deviceInfo
      
	$device_info_Url = "https://beta-api.att.com/1/devices/".$deviceId."/info";
	$device_info_Url .= "?access_token=".$accessToken;
	print "<p>Request URL  for device information :</br>$device_info_Url </p>";
	
	$device_info_headers = array(
		'Content-Type: application/x-www-form-urlencoded'
	);
	//Invoke the URL
	$device_info = curl_init();
	curl_setopt($device_info, CURLOPT_URL, $device_info_Url);
	curl_setopt($device_info, CURLOPT_HTTPGET, 1);
	curl_setopt($device_info, CURLOPT_HEADER, 0);
	curl_setopt($device_info, CURLINFO_HEADER_OUT, 0);
	curl_setopt($device_info, CURLOPT_HTTPHEADER, $device_info_headers);
	curl_setopt($device_info, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($device_info, CURLOPT_SSL_VERIFYPEER, false);
	
	
	$device_info_response = curl_exec($device_info);
	
	
	$responseCode=curl_getinfo($device_info,CURLINFO_HTTP_CODE);
	
       /*
	  If URL invocation is successful fetch the device Information and display,
	  else display the error.
	*/
        if($responseCode==200)
        {
           $jsonObj = json_decode($device_info_response); //decode the response and display it.
	     print "<table><tr><th>Name</th><th>Value</th></tr>";
	     echo "<tr><td>acwdevcert</td><td>".$jsonObj->{'deviceId'}->{'acwdevcert'}."</td></tr>";
	     echo "<tr><td>acwrel</td><td>".$jsonObj->{'deviceId'}->{'acwrel'}."</td></tr>";
	     echo "<tr><td>acwmodel</td><td>".$jsonObj->{'deviceId'}->{'acwmodel'}."</td></tr>";
	     echo "<tr><td>acwvendor</td><td>".$jsonObj->{'deviceId'}->{'acwvendor'}."</td></tr>";
	     echo "<tr><td>acwav</td><td>".$jsonObj->{'capabilities'}->{'acwav'}."</td></tr>";
	     echo "<tr><td>acwaocr</td><td>".$jsonObj->{'capabilities'}->{'acwaocr'}."</td></tr>";
	     echo "<tr><td>acwcf</td><td>".$jsonObj->{'capabilities'}->{'acwcf'}."</td></tr>";
	     echo "<tr><td>acwtermtype</td><td>".$jsonObj->{'capabilities'}->{'acwtermtype'}."</td></tr>";
	     print "</table>";
        }
        else{
            echo curl_error($device_info);
        }
	curl_close ($device_info);
    
}
?>
</body>
</html>
