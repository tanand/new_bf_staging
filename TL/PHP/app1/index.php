<?php
    session_start();

   /* Extract the session variables */
    $accessToken = $_SESSION["deviceLocation_access_token"];
    $getDeviceLoc = $_REQUEST[deviceLocation];//while submitting the deviceInfo is set
?>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <title>Device Location</title>
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
<form name="deviceLocation" method="get">
    Access Token <input type="text" name="access_token" value="<?php echo $accessToken ?>" size=40/><br/>
    Device Id <input type="text" name="deviceId" value="tel:" /><br/>
    <input type="submit" name="deviceLocation" value="Device Location"/></form><br>
</form>

<?php
	/*
	   Extract parameter device Id from deviceLocation form
	   and invoke the URL to get device location along with access token
	*/
	if ($getDeviceLoc != null) {
        $deviceId = $_GET['deviceId'];

 	// Form the URL to get device location
	//$device_location_Url = "https://beta-api.att.com/1/devices/tel:4257865687/location";
	$device_location_Url = "https://beta-api.att.com/1/devices/".$deviceId."/location";
	$device_location_Url .= "?access_token=".$accessToken;
	
	print "<p>device_location_Url  :</br>$device_location_Url</p>";
	
	$device_location_headers = array(
		'Content-Type: application/x-www-form-urlencoded'
	);
	//Invoke the URL
	$device_location = curl_init();
	curl_setopt($device_location, CURLOPT_URL, $device_location_Url);
	curl_setopt($device_location, CURLOPT_HTTPGET, 1);
	curl_setopt($device_location, CURLOPT_HEADER, 0);
	curl_setopt($device_location, CURLINFO_HEADER_OUT, 0);
	curl_setopt($device_location, CURLOPT_HTTPHEADER, $device_location_headers);
	curl_setopt($device_location, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($device_location, CURLOPT_SSL_VERIFYPEER, false);
	print "<p>Request URL submitted for device location :</br>$device_location_Url </p>";
	$device_location_response = curl_exec($device_location);
	//print "<p>Response of device location request  :</br>$device_location_response</p>";

	$responseCode=curl_getinfo($device_location,CURLINFO_HTTP_CODE);

       /*
	  If URL invocation is successful fetch the device location information and display,
	  else display the error.
	*/
	if($responseCode==200)
        {
		$jsonObj = json_decode($device_location_response);//decode the response and display it.
		print "<table><tr><th>Name</th><th>Value</th></tr>";
		echo "<tr><td>accuracy</td><td>".$jsonObj->{'accuracy'}."</td></tr>";
		echo "<tr><td>altitude</td><td>".$jsonObj->{'altitude'}."</td></tr>";
		echo "<tr><td>latitude</td><td>".$jsonObj->{'latitude'}."</td></tr>";
		echo "<tr><td>longitude</td><td>".$jsonObj->{'longitude'}."</td></tr>";
		echo "<tr><td>timestamp</td><td>".$jsonObj->{'timestamp'}."</td></tr>";
		print "</table>";
	  }
	else{
		curl_error($device_location);
	}
		curl_close ($device_location);


}
?>
</body>
</html>
