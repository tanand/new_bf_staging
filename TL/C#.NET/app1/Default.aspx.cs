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
    string scope_value = "TL";

    /* 
     * Function to invoke authorize interface of Oauth with scope, client id and redirect uri
     * to get authorization code 
     */

    public void get_auth_code(string api_key, string scope_value)
    {
              
        HttpContext.Current.Response.Redirect("https://beta-api.att.com/oauth/authorize?scope=TL&client_id=" + api_key + "&redirect_uri=http://wincode-api-att.com/dotnet/dc/DeviceLocation/Default.aspx");

    }

    /*
     * Function invokes acess_token interface of Oauth with client id, client secret and auth code
     * and stores the access token received in the session
     */

    public void get_access_code(string api_key, string secret_key, string auth_code)
    {
        // Form Http Web Request
        WebRequest objRequest = System.Net.HttpWebRequest.Create("https://beta-api.att.com/oauth/access_token?client_id=" + api_key.ToString() + "&client_secret=" + secret_key.ToString() + "&code=" + auth_code.ToString() + "&grant_type=authorization_code");

        objRequest.ContentType = "application/x-www-form-urlencoded";
        objRequest.Method = "GET";

        // the using keyword will automatically dispose the object 
        // once complete

        WebResponse objResponse = objRequest.GetResponse();
        using (StreamReader sr =
        new StreamReader(objResponse.GetResponseStream()))
        {
            // Store the access token in the session
            Session["access_token"] = sr.ReadToEnd().ToString();
            // Close and clean up the StreamReader
            sr.Close();
        }


    }

    /*
     * On page load if query string 'code' is present, invoke get_access_token
     */

    protected void Page_Load(object sender, EventArgs e)
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
               
                get_access_code(api_key, secret_key, auth_code);
                string   access_token_json = Session["access_token"].ToString();

                //Get the access token from the json response

                JavaScriptSerializer deserializer_object = new JavaScriptSerializer();
                Test myDeserializedObj = (Test)deserializer_object.Deserialize(access_token_json, typeof(Test));
                access_token = myDeserializedObj.access_token.ToString();

                //Display the access token in UI text box
                txtAcceTokGetDelStatus.Text = access_token.ToString();
            }

        }
        catch (Exception ex)
        {
          
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
     * User invoked Event to get device location
     * Invoke AT&T Get Device Location api through http web request along with access token 
     * and Disaplys the Device Location of given msisdn 
     */
    protected void btnGetDeviceLocation_Click(object sender, EventArgs e)
    {
        try
        {
            string strReq = txtDeviceId.Text;
            string access_tkn = txtAcceTokGetDelStatus.Text.ToString();
            String strResult;

            // Form Http Web Request
            HttpWebResponse objResponse;
            HttpWebRequest objRequest = (HttpWebRequest)System.Net.WebRequest.Create("https://beta-api.att.com/1/devices/tel:"+strReq.ToString()+"/location?access_token="+access_tkn.ToString());

            objRequest.Method = "GET";
           
            objResponse = (HttpWebResponse)objRequest.GetResponse();
            // the using keyword will automatically dispose the object 
            // once complete
            using (StreamReader sr2 = new StreamReader(objResponse.GetResponseStream()))
            {
                strResult = sr2.ReadToEnd();
                Response.Write(strResult.ToString());
               
                // Close and clean up the StreamReader
                sr2.Close();
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