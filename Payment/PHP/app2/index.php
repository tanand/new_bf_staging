<?php
    session_start();
    
    /* Extract the session variables */
    $accessToken = $_SESSION["payment_access_token"];
    $TrxRequest = $_REQUEST[newTransaction];
    $TrxStatusRequest = $_REQUEST[getTransactionStatus];
    $TrxCommitRequest = $_REQUEST[commitTransaction];
    $RefundRequest = $_REQUEST[refundTransaction];
    $trxID = $_SESSION["trxID"];
?>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <title>Creating new Payment Transaction</title>
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
<form name="newTransaction" method="post">
    Access Token <input type="text" name="access_token" value="<?php echo $accessToken ?>" size=40/><br/>
    Amount <input type="text" name="amount" value="0.05" /><br />
    Auto Commit <input type="text" name="autoCommit" value="false" /><br />
    Category <input type="text" name="category" value="1" /><br />
    Channel <input type="text" name="channel" value="MOBILE_WEB" /><br />
    Currency <input type="text" name="currency" value="USD" /><br />
    Description <input type="text" name="description" value="ProductByMe" /><br />
    Transaction ID <input type="text" name="extTrxID" value="Transaction151" /><br />
    App ID <input type="text" name="appID" value="" /><br />
    Cancel Redirect Url <input type="text" name="cancelUrl" value="http://www.dwestern.com/bf_staging/Payment/Php/Transaction/AOC_Cancelled.php" size=60/><br />
    Fulfillment Url <input type="text" name="fulfillUrl" value="http://www.dwestern.com/bf_staging/Payment/Php/Transaction/AOC_Confirmed.php" size=60/><br />
    Product ID <input type="text" name="productID" value="Product252" /><br />
    PurhcaseOnNoActiveSubscription <input type="text" name="purchaseNoSub" value="false" /><br />
    Status Url <input type="text" name="statusUrl" value="http://www.dwestern.com/bf_staging/Payment/Php/Transaction/Status.php" size=60/><br />
 <input type="submit" name="newTransaction" value="Click to make new transaction" />
</form>

<?php
     	/* If request submitted is new Transaction,
	  then extract the POST parameters.
	  and invoke the URL to create new Transaction status along with access token
	*/
	if ($TrxRequest != null) {
	
	$amount = $_POST['amount'];
	$autoCommit = $_POST['autoCommit'];
	$category = $_POST['category'];
	$channel = $_POST['channel'];
	$currency = $_POST['currency'];
	$description = $_POST['description'];
	$extTrxID = $_POST['extTrxID'];
	$appID = $_POST['appID'];
	$cancelUrl = $_POST['cancelUrl'];
	$fulfillUrl = $_POST['fulfillUrl'];
	$productID = $_POST['productID'];
	$purchaseNoSub = $_POST['purchaseNoSub'];
	$statusUrl = $_POST['statusUrl'];

 	//Form the request body
	
	$trx_RequestBody = '{"amount":'.$amount.',"category":'.$category.',"channel":"'.$channel;
	$trx_RequestBody .= '","currency":"'.$currency.'","description":"'.$description;
	$trx_RequestBody .= '","externalMerchantTransactionID":"'.$extTrxID.'","merchantApplicationID":"'.$appID;
	$trx_RequestBody .= '","merchantCancelRedirectUrl":"'.$cancelUrl;
	$trx_RequestBody .= '","merchantFulfillmentRedirectUrl":"'.$fulfillUrl.'","merchantProductID":"'.$productID;
	$trx_RequestBody .= '","purchaseOnNoActiveSubscription":'.$purchaseNoSub;
	$trx_RequestBody .= ',"transactionStatusCallbackUrl":"'.$statusUrl.'","autoCommit":'.$autoCommit.'}';
        
	//Form the URL for new payment transaction
        $trx_Url = "httpS://beta-api.att.com/1/payments/transactions?access_token=".$accessToken;
	$trx_headers = array(
	'Content-Type: application/json'
	);
	
	//Invoke the URL
	$paymentTrx = curl_init();
	curl_setopt($paymentTrx, CURLOPT_URL, $trx_Url);
	curl_setopt($paymentTrx, CURLOPT_POST, 1);
	curl_setopt($paymentTrx, CURLOPT_HEADER, 0);
	curl_setopt($paymentTrx, CURLINFO_HEADER_OUT, 0);
	curl_setopt($paymentTrx, CURLOPT_HTTPHEADER, $trx_headers);
	curl_setopt($paymentTrx, CURLOPT_POSTFIELDS, $trx_RequestBody);
	curl_setopt($paymentTrx, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($paymentTrx, CURLOPT_SSL_VERIFYPEER, false);
	$paymentTrx_response = curl_exec($paymentTrx);
                   print "<p>Request submitted for new transaction :</br>$trx_RequestBody </p>";
	print "<p>Response of new transaction  :</br>$paymentTrx_response</p>";
	$responseCode=curl_getinfo($paymentTrx,CURLINFO_HTTP_CODE);
	
       /*
	  If URL invocation is successful fetch the Redirect URL for AOC
	  and redirect the user to AOC page,
	  else display the error.
	*/
        if($responseCode==200)
        {
            $jsonObj = json_decode($paymentTrx_response);
		$redirectUrl = $jsonObj->{'redirectUrl'};//get the redirect url
		$_SESSION["trxID"] = $jsonObj->{'trxID'};//store the response id to session
		echo "<a href= $redirectUrl  >Please click AOC page</a>";
        }
        else{
	print "<p>paymentTrx_response  :</br>$paymentTrx_response</p>";
            echo curl_error($paymentTrx);
        }

	curl_close ($paymentTrx);


}
?>
<hr>
 <?php //form for get transaction status ?>   
<form name="getTransactionStatus" action="" method="get">
    Transaction ID <input type="text" name="trxID" value="<?php echo $trxID ?>" size=40/><br />
    Access Token <input type="text" name="access_token" value="<?php echo $accessToken ?>" size=40/><br>
    <input type="submit" name="getTransactionStatus" value="Get Transaction Status" /></form><br>

<?php
	/* If request submitted is get Transaction status,
	  then extract the transaction ID for the transaction.
	  and invoke the URL to get Transaction status along with access token 
	*/
	if ($TrxStatusRequest != null) {
        $TxnId = $_GET['trxID'];
	
 	// Form the URL to get Transaction status
	
	$getPaymentTrxStatus_Url = "https://beta-api.att.com/1/payments/transactions/";
	$getPaymentTrxStatus_Url .= $TxnId;
	$getPaymentTrxStatus_Url .= "?access_token=".$accessToken;
	$getPaymentTrxStatus_headers = array(
		'Content-Type: application/x-www-form-urlencoded'
	);	
	
	// Invoke the URL
	$getPaymentTxnStatus = curl_init();	
	curl_setopt($getPaymentTxnStatus, CURLOPT_URL, $getPaymentTrxStatus_Url);
	curl_setopt($getPaymentTxnStatus, CURLOPT_HTTPGET, 1);
	curl_setopt($getPaymentTxnStatus, CURLOPT_HEADER, 0);
	curl_setopt($getPaymentTxnStatus, CURLINFO_HEADER_OUT, 0);
	curl_setopt($getPaymentTxnStatus, CURLOPT_HTTPHEADER, $getPaymentTrxStatus_headers);
	curl_setopt($getPaymentTxnStatus, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($getPaymentTxnStatus, CURLOPT_SSL_VERIFYPEER, false);
        $getPaymentTxnStatus_response = curl_exec($getPaymentTxnStatus);
	
	$responseCode=curl_getinfo($getPaymentTxnStatus,CURLINFO_HTTP_CODE);
	
	/*
	  If URL invocation is successful displaythe transaction status,
	  else display the error.
	*/
	if($responseCode==200)
        {
            echo "Delivery Status for Transaction : ".$getPaymentTxnStatus_response;
        }
        else{
            echo curl_error($getPaymentTxnStatus);
        }
        curl_close($getPaymentTxnStatus);
}
?>
<hr>
 <?php //form for commit transaction ?>   
<form name="commitTransaction" action="" method="get">
    Transaction ID <input type="text" name="trxID" value="<?php echo $trxID ?>" size=40/><br />
    Access Token <input type="text" name="access_token" value="<?php echo $accessToken ?>" size=40/><br>
    <input type="submit" name="commitTransaction" value="Commit Transaction" /></form><br>

<?php
	/* If request submitted is get commit Transaction,
	  then extract the transaction ID for the transaction
	  and invoke the URL to commit the Transaction along with access token
	*/	
	if ($TrxCommitRequest != null){
	$TxnId = $_GET["trxID"];
	
 	// Form the URL to commit the Transaction
	$getPaymentCommit_Url = "https://beta-api.att.com/1/payments/transactions/";
	$getPaymentCommit_Url .= $TxnId;
	$getPaymentCommit_Url .= "?access_token=".$accessToken;
	$getPaymentCommit_Url .= "&action=commit";
	$getPaymentCommit_headers = array(
		'Content-Type: application/json'
	);
	
        $sendPaymentCommit_RequestBody = '{"transactionStatus":"COMMITTED"}';
	
	// Invoke the URL
	$getPaymentCommit = curl_init();
	curl_setopt($getPaymentCommit, CURLOPT_URL, $getPaymentCommit_Url);
	curl_setopt($getPaymentCommit, CURLOPT_POST, 1);
	curl_setopt($getPaymentCommit, CURLOPT_HEADER, 0);
	curl_setopt($getPaymentCommit, CURLINFO_HEADER_OUT, 0);
	curl_setopt($getPaymentCommit, CURLOPT_HTTPHEADER, $getPaymentCommit_headers);
	curl_setopt($getPaymentCommit, CURLOPT_POSTFIELDS, $sendPaymentCommit_RequestBody);
	curl_setopt($getPaymentCommit, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($getPaymentCommit, CURLOPT_SSL_VERIFYPEER, false);
        $getPaymentCommit_response = curl_exec($getPaymentCommit);
	
        $responseCode=curl_getinfo($getPaymentCommit,CURLINFO_HTTP_CODE);
	/*
	  If URL invocation is successful display the commit response,
	  else display the error.
	*/
        if($responseCode==200)
        {
            echo "Status for Commit Transaction : ".$getPaymentCommit_response;
        }
        else{
            echo curl_error($getPaymentCommit);
        }
        curl_close($getPaymentCommit);
}
?>
<hr>
 <?php //form for refund transaction ?>   
<form name="refundTransaction" action="" method="get">
    Transaction ID <input type="text" name="trxID" value="<?php echo $trxID ?>" size=40/><br />
    Access Token <input type="text" name="access_token" value="<?php echo $accessToken ?>" size=40/><br>
    <input type="submit" name="refundTransaction" value="Refund Transaction" /></form>

<?php

 	/* If request submitted is Refund Transaction,
	  then extract the transaction ID for the transaction to be refunded.
	  and invoke the URL to get Transaction status along with access token
	*/
	if ($RefundRequest != null){
	$TxnId = $_GET["trxID"];
	
	//Form the URL to get Transaction status
	$getRefund_Url = "https://beta-api.att.com/1/payments/transactions/";
	$getRefund_Url .= $TxnId;
	$getRefund_Url .= "?access_token=".$accessToken;
	$getRefund_Url .= '&action=refund';
	
	//http header values
	$getRefund_headers = array(
		'Content-Type: application/json'
	);
	//Form post data
	$getRefund_RequestBody = '{"refundReasonCode":"111","refundReasonText":"Customer was unhappy","proxyRequest":null,"merchantRequest":null,"tenantId":null}';
	
	print "<p>URL to for refund request:</br>$getRefund_Url</p>";
	print "<p>Refund_RequestBody to be sent:</br>$getRefund_RequestBody</p>";

	// Invoke the URL
	$getRefund = curl_init();
	curl_setopt($getRefund, CURLOPT_URL, $getRefund_Url);
	curl_setopt($getRefund, CURLOPT_POST, 1);
	curl_setopt($getRefund, CURLOPT_HEADER, 0);
	curl_setopt($getRefund, CURLINFO_HEADER_OUT, 0);
	curl_setopt($getRefund, CURLOPT_HTTPHEADER, $getRefund_headers);
	curl_setopt($getRefund, CURLOPT_POSTFIELDS, $getRefund_RequestBody);
	curl_setopt($getRefund, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($getRefund, CURLOPT_SSL_VERIFYPEER, false);
        $getRefund_response = curl_exec($getRefund);
	
	//Error Catching	
        $responseCode=curl_getinfo($getRefund,CURLINFO_HTTP_CODE);

	/*
	If URL invocation is successful display the refund response,else display the error
	*/
        if($responseCode==200)
        {
            echo "Status for Refund Transaction : ".$getRefund_response;
        }
        else{
            echo curl_error($getRefund);
        }
        curl_close($getRefund);
}
?>
</body>
</html>
