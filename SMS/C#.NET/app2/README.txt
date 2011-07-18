To utilize the functions in Default.aspx, you must first get an Access Token.
Default.aspx will display a link to get the access token.On clicking the link, 
authentication and Oauth flow is invoked and control is returned to Default.aspx 
along with the access token.
Once received, Default.aspx will save this access token in a session variable and 
will use it in service invocations.

Installation:
	1. Install IIS server 6.0 or higher version
        2. Create Virtual Directory in IIS Manager    
        3. Download the application files and configure the virtual directory created in IIS manager 
           to point to the local path of application.
	4. Access the scriptlet by directing your browser to http://localhost:8080/{Application NAME}, for example.

Configuration:
	1. Open Web.config with an editor and update the variables API_Key , Secret_key and short_code with 
           the respective values that were provided when you registered your app.
	2. You may also wish to configure the Default.aspx scriptlet for external access by changing the 
           redirectUri variable in Default.aspx to include your web server's external IP address.
	3. If you are using a payment method, open  Default.aspx with an editor and change the default values 
           for the three redirect URIs, i.e. fulfillment redirect URI, cancel redirect URI, status 
           callback redirect URI. These should be set to your external IP address.