using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Configuration;
using System.IO;
using System.Xml;
using System.Text;
using System.Web.Script.Serialization;

public partial class Default : System.Web.UI.Page
{
    string api_key, secret_key, short_code, auth_code, access_token;
    string scope_value = "SMS";

    /* 
     * Function to invoke authorize interface of Oauth with scope, client id and redirect uri
     * to get authorization code 
     */
    public void get_auth_code(string api_key, string scope_value)
    {
        
        HttpContext.Current.Response.Redirect("https://beta-api.att.com/oauth/authorize?scope=" + scope_value + "&client_id=" + api_key + "&redirect_uri=http://wincode-api-att.com/dotnet/sms/SendSMS/Default.aspx");

    }

    /*
     * Function invokes acess_token interface of Oauth with client id, client secret and auth code
     * and stores the access token received in the session
     */

    public void get_access_token(string api_key, string secret_key, string auth_code)
    {
        // Form Http Web Request
        WebRequest objRequest = System.Net.HttpWebRequest.Create("https://beta-api.att.com/oauth/access_token?client_id=" + api_key.ToString() + "&client_secret=" + secret_key.ToString() + "&code=" + auth_code.ToString() + "&grant_type=authorization_code");

        objRequest.ContentType = "application/json";
        objRequest.Method = "GET";
        
        WebResponse objResponse = objRequest.GetResponse();
        using (StreamReader sr =
        new StreamReader(objResponse.GetResponseStream()))
        {
            // Store the access token in the session
            HttpContext.Current.Session["access_token"] = sr.ReadToEnd().ToString();
            
            // Close and clean up the StreamReader
            sr.Close();
        }


    }

    /*
     * On page load if query string 'code' is present, invoke get_access_token
     */
    public void Page_Load(object sender, EventArgs e)
    {
       
        try
        {

            // Get the api key, secre key and short code values for the application from web.config.

            api_key = ConfigurationManager.AppSettings["api_key"].ToString();
            secret_key = ConfigurationManager.AppSettings["secret_key"].ToString();
            short_code = ConfigurationManager.AppSettings["short_code"].ToString();
            auth_code = Request["code"].ToString();

            // If query string contains auth code, extract it and invoke get_access_token 
            if (auth_code != "")
            {
                
                get_access_token(api_key, secret_key, auth_code);

               string  json_response = Session["access_token"].ToString();

                //Get the access token from the json response
                JavaScriptSerializer deserializer_object = new JavaScriptSerializer();
                Test myDeserializedObj = (Test)deserializer_object.Deserialize(json_response, typeof(Test));
                access_token = myDeserializedObj.access_token.ToString();

                //Display the access token in UI text box
                txtAccessTokenSMS.Text = access_token.ToString();
                txtAcceTokGetDelStatus.Text = access_token.ToString();
            }

        }
        catch (Exception ert)
        {
           // Response.Write(ert.ToString());
        }
    }

    /*
     * User invoked Event for getting the access token
     */
    protected void lnkbtnAccessCode_Click(object sender, EventArgs e)
    {
        try
        {
           get_auth_code(api_key, scope_value);
        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }
    }

    /*
     * User invoked Event for sending sms
     * Invoke AT&T send sms api through http web request along with access token 
     * and post the sms message to destination msisdn 
     */
    protected void btnSendSms_Click(object sender, EventArgs e)
    {
        try
        {

            String strResult;
            HttpWebResponse objResponse;

            // Form Http Web Request
            HttpWebRequest objRequest = (HttpWebRequest)System.Net.WebRequest.Create("https://beta-api.att.com/1/messages/outbox/sms?access_token=" + txtAccessTokenSMS.Text);

            string strReq = "{'address':'tel:+" + txtmsisdn.ToString() + "','message':" + txtmsg.ToString() + "}";

            objRequest.Method = "POST";
            objRequest.ContentType = "application/json";
            objRequest.Accept = "application/json";


            UTF8Encoding encoding = new UTF8Encoding();
            byte[] postBytes = encoding.GetBytes(strReq);
            objRequest.ContentLength = postBytes.Length;

            //Sending Sms Data as a stream
            Stream postStream = objRequest.GetRequestStream();
            postStream.Write(postBytes, 0, postBytes.Length);
            postStream.Close();

            objResponse = (HttpWebResponse)objRequest.GetResponse();
            // the 'using' keyword will automatically dispose the object 
            // once complete
            using (StreamReader sr = new StreamReader(objResponse.GetResponseStream()))
            {
                strResult = sr.ReadToEnd();
                Response.Write(strResult.ToString());

                // Close and clean up the StreamReader
                sr.Close();
            }
            //
        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }
    }


    /* 
     * User invoked Event for getting delivery status
     */
    protected void btnGetDeliveryStatus_Click(object sender, EventArgs e)
    {
        try
        {

            string sms_id = txtSmsId.Text.ToString();
            String strResult;

            // Form Http Web Request

            HttpWebResponse objResponse;
            HttpWebRequest objRequest = (HttpWebRequest)System.Net.WebRequest.Create("https://beta-api.att.com/1/messages/outbox/sms/" + sms_id.ToString() + "?access_token=" + txtAcceTokGetDelStatus.Text);

            //string strReq = txtSmsId.Text;

            objRequest.Method = "GET";
            objRequest.ContentType = "application/JSON";
            objRequest.Accept = "application/json";


            objResponse = (HttpWebResponse)objRequest.GetResponse();
            // the using keyword will automatically dispose the object 
            // once complete
            using (StreamReader sr = new StreamReader(objResponse.GetResponseStream()))
            {
                strResult = sr.ReadToEnd();
                Response.Write(strResult.ToString());

                // Close and clean up the StreamReader
                sr.Close();
            }

        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }
    }
}
public class Test
{
    public string access_token;

}