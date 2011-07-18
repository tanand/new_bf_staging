//
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using System.Web.Services;
using System.Text;
using System.Configuration;
using System.Web.Script.Serialization;
using System.Net.Sockets;
using System.Security.Cryptography.X509Certificates;
using System.Net.Security;
using System.Collections.Specialized;
//
public partial class Default : System.Web.UI.Page
{

    string api_key, secret_key, short_code, auth_code, access_token;
    string scope_value = "WAP";
    //Function to invoke authorize interface of Oauth with scope, client id and redirect uri
    // to get authorization code
    public void get_auth_code(string api_key, string scope_value)
    {
        string folder = scope_value.ToString().ToLower();
        string sub_folder = HttpContext.Current.Session["sub_folder"].ToString();
        HttpContext.Current.Response.Redirect("https://beta-api.att.com/oauth/authorize?scope=" + scope_value + "&client_id=" + api_key + "&redirect_uri=http://wincode-api-att.com/att/" + folder + "/" + sub_folder + "/Default.aspx");
    }
    // Function invokes acess_token interface of Oauth with client id, client secret and auth code
    // and stores the access token received in the session
    public void get_access_code(string api_key, string secret_key, string auth_code)
    {

        WebRequest objRequest = System.Net.HttpWebRequest.Create("https://beta-api.att.com/oauth/access_token?client_id=" + api_key.ToString() + "&client_secret=" + secret_key.ToString() + "&code=" + auth_code.ToString() + "&grant_type=authorization_code");

        objRequest.ContentType = "application/json";
        objRequest.Method = "GET";
               
        WebResponse objResponse = objRequest.GetResponse();
        using (StreamReader sr =
        new StreamReader(objResponse.GetResponseStream()))
        {
            //store access token in session variable.
            HttpContext.Current.Session["access_token"] = sr.ReadToEnd().ToString();
            // Close and clean up the StreamReader
            sr.Close();
        }


    }
    //Function to concatenate arrays
    public byte[] CombineByteArrays(params byte[][] arrays)
    {
        byte[] rv = new byte[arrays.Sum(a => a.Length)];
        int offset = 0;
        foreach (byte[] array in arrays)
        {
            System.Buffer.BlockCopy(array, 0, rv, offset, array.Length);
            offset += array.Length;
        }
        return rv;
    }
    //On page load if query string 'code' is present, invoke get_access_token
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            //Get the api key, secre key and short code values for the application from web.config.

            api_key = ConfigurationManager.AppSettings["api_key"].ToString();
            secret_key = ConfigurationManager.AppSettings["secret_key"].ToString();
            short_code = ConfigurationManager.AppSettings["short_code"].ToString();
            auth_code = Request["code"].ToString();

            //If query string contains auth code, extract it and invoke get_access_token
            if (auth_code != "")
            {
                //Get the access token from the json response
                get_access_code(api_key, secret_key, auth_code);
                string access_token_json = Session["access_token"].ToString();

                JavaScriptSerializer deserializer_object = new JavaScriptSerializer();
                Test myDeserializedObj = (Test)deserializer_object.Deserialize(access_token_json, typeof(Test));
                access_token = myDeserializedObj.access_token.ToString();

                //Display the access token in UI text box
                txtAccessToken.Text = access_token.ToString();
               
            }
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }
    //User invoked Event for sending WAP 
    //Invoke AT&T wap push api through http web request along with access token 
    //and post the Wap Push message.
    protected void btnSendWAP_Click(object sender, EventArgs e)
    {

        try
        {
            //if the user submitted the sendWAP form, then get the values and try to send the WAP PUSH message.  

            //HttpWebRequest httpWebRequest;

            //TEST WAP PUSH

            string boundary = "----------------------------" + DateTime.Now.Ticks.ToString("x");
            FileStream fs = new FileStream(FileUpload1.PostedFile.FileName, FileMode.Open, FileAccess.Read);
            BinaryReader br = new BinaryReader(fs);
            byte[] image = br.ReadBytes((int)fs.Length);
            br.Close();
            fs.Close();

            HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create("https://beta-api.att.com/1/messages/outbox/wapPush?access_token=" + txtAccessToken.Text);
            httpWebRequest.ContentType = "multipart/form-data; type=\"application/x-www-form-urlencoded\"; start=\"<startpart>\"; boundary=" + boundary;
            httpWebRequest.Method = "POST";
            httpWebRequest.Headers.Add("MIME-Version: 1.0\r\n");
            httpWebRequest.Headers.Add("X-HostCommonName: beta-api.att.com\r\n");
            httpWebRequest.Headers.Add("Cookie: api.att-stg.amdocshub.com=\"R533090545\"\r\n");
            httpWebRequest.Headers.Add("X-Forwarded-For: 135.214.40.30\r\n");
            httpWebRequest.Headers.Add("X-Target-URI: https://beta-api.att.com\r\n");
            httpWebRequest.KeepAlive = true;
            httpWebRequest.AllowAutoRedirect = false;

            System.Net.WebProxy pry = new System.Net.WebProxy("http://proxy4.wipro.com:8080", true);
            //The DefaultCredentials automically get username and password.

            pry.Credentials = new NetworkCredential("ubrah", "URBjai29$$");
            httpWebRequest.Proxy = pry;

            ServicePointManager.ServerCertificateValidationCallback = delegate(object sender1, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
            {
                return true;
            };
            System.Net.ServicePointManager.Expect100Continue = false;

            //string sendMMSData = "address=%2B" + txtAddressWAPPush.Text.ToString() + "&subject=" + txtSubjectWAPPush.Text.ToString() + "&priority=high";
            string sendMMSData = "address=" + txtAddressWAPPush.Text.ToString() + " & subject=" + txtSubjectWAPPush.Text.ToString() + " & priority=high";

            //Wap Push Data 
            string data = "";
            string data1 = "";
            data += "--" + boundary + "\r\n";
            data += "Content-Type: application/x-www-form-urlencoded; charset=UTF-8\r\n";
            data += "Content-Transfer-Encoding: 8bit\r\n";
            data += "Content-ID: <startpart>\r\n";
            data += "Content-Disposition: form-data; name=\"" + System.IO.Path.GetFileName(FileUpload1.PostedFile.FileName) + "\"\r\n" + sendMMSData + "\r\n";
            data += "Content-type: application/xml\r\n\r\n";
            data += "--" + boundary + "\r\n";
            data += "Content-Type: text/plain\r\n";
            data += "Content-Transfer-Encoding: binary\r\n";
            data += "Content-ID: " + System.IO.Path.GetFileName(FileUpload1.PostedFile.FileName) + "\r\n";
            data += "Content-Disposition: attachment; name=" + System.IO.Path.GetFileName(FileUpload1.PostedFile.FileName) + "\r\n";
            data += "Content-Transfer-Encoding: binary\r\n\r\n";

            data1 += "\r\n";
            //data1 = "" + wappush_data + "\r\n";
            data1 += "--" + boundary + "--\r\n";
            

            UTF8Encoding encoding = new UTF8Encoding();
            byte[] postBytes = encoding.GetBytes(data);

            byte[] content = CombineByteArrays(postBytes, image);

            UTF8Encoding encoding1 = new UTF8Encoding();
            byte[] postBytes1 = encoding.GetBytes(data1);

            byte[] content1 = CombineByteArrays(content, postBytes1);


            httpWebRequest.ContentLength = content1.Length;


            using (Stream writeStream = httpWebRequest.GetRequestStream())
            {
                writeStream.Write(content1, 0, content1.Length);
                writeStream.Close();
            }


            HttpWebResponse objResponse = (HttpWebResponse)httpWebRequest.GetResponse();

            using (StreamReader sr = new StreamReader(objResponse.GetResponseStream()))
            {
                string strResult = sr.ReadToEnd();
                Response.Write(strResult.ToString());
                // Close and clean up the StreamReader
                sr.Close();
            }

            httpWebRequest = null;
        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }
    }
    //User invoked Event for getting WAP Push Status 
    //Invoke AT&T wap push api through http web request along with access token 
    //and get the Wap Push Status.
    protected void btnStatusWAP_Click(object sender, EventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }
    //User invoked Event for getting the access token
    protected void lnkbtnAccessCode_Click(object sender, EventArgs e)
    {
        try
        {
            get_auth_code(api_key, scope_value);
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }
}
public class Test
{
    public string access_token;
}
