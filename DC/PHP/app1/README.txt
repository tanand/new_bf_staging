To utilize the functions in index.php, you must first get an Access Token.
index.php will display a link to get the access token.On clicking the link, 
authentication and Oauth flow is invoked and control is returned to index.php
along with the access token.
Once received, index.php will save this access token in a session variable and 
will use it in service invocations.


Installation:
	1. Install Apache Tomcat 7.0 web server and configure php environment.
        2. Download the application files into htdocs
	3. Access the scriptlet by directing your browser to http://localhost:8080/{Application NAME}, for example.



Configuration:
	1. Open config.php with an editor and update the variables API_Key , Secret_key and short_code with 
           the respective values that were provided when you registered your app.
	2. You may also wish to configure the oauth.php scriptlet for external access by changing the 
           authorize_redirect_uri  variable in config.php to include your web server's external IP address.
	3. If you are using a payment method, open index.jsp with an editor and change the default values 
           for the three redirect URIs, i.e. fulfillment redirect URI, cancel redirect URI, status 
           callback redirect URI. These should be set to your external IP address.