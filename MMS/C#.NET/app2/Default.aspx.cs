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

public partial class Default : System.Web.UI.Page
{
    string api_key, secret_key, short_code, auth_code, access_token;
    string scope_value = "MMS";

    /* 
     * Function to invoke authorize interface of Oauth with scope, client id and redirect uri
     * to get authorization code 
     */

    public void get_auth_code(string api_key, string scope_value)
    {
  
        HttpContext.Current.Response.Redirect("https://beta-api.att.com/oauth/authorize?scope=" + scope_value + "&client_id=" + api_key + "&redirect_uri=http://wincode-api-att.com/dotnet/mms/SendMMS/Default.aspx");

    }


    /*
     * Function invokes acess_token interface of Oauth with client id, client secret and auth code
     * and stores the access token received in the session
     */

    public void get_access_code(string api_key, string secret_key, string auth_code)
    {

        WebRequest objRequest = System.Net.HttpWebRequest.Create("https://beta-api.att.com/oauth/access_token?client_id=" + api_key.ToString() + "&client_secret=" + secret_key.ToString() + "&code=" + auth_code.ToString() + "&grant_type=authorization_code");

        objRequest.ContentType = "application/x-www-form-urlencoded";
        objRequest.Method = "GET";

        // the using keyword will automatically dispose the object 
        // once complete

        WebResponse objResponse = objRequest.GetResponse();
        using (StreamReader sr =
        new StreamReader(objResponse.GetResponseStream()))
        {

            HttpContext.Current.Session["access_token"] = sr.ReadToEnd().ToString();
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
                access_token = Session["access_token"].ToString();

                //Get the access token from the json response

                JavaScriptSerializer deserializer_object = new JavaScriptSerializer();
                Test myDeserializedObj = (Test)deserializer_object.Deserialize(access_token, typeof(Test));
                access_token = myDeserializedObj.access_token.ToString();

                //Display the access token in UI text box
                txtAccessToken.Text = access_token.ToString();
                txtAccTokGetDeleStatus.Text = access_token.ToString();

            }

        }
        catch (Exception ert)
        {
            Response.Write(ert.ToString());
        }
    }

    /*
    * User invoked Event for sending mms
    * Invoke AT&T send mms api through http web request along with access token 
    * and post the mms message to destination msisdn 
    */
    protected void btnSendMMS_Click(object sender, EventArgs e)
    {

        try
        {

            
            string boundary = "----------------------------" +DateTime.Now.Ticks.ToString("x");


            //Converts Image File content into binary data and stored in binary array.

            FileStream fs = new FileStream(FileUpload1.PostedFile.FileName, FileMode.Open, FileAccess.Read);



            BinaryReader br = new BinaryReader(fs);



            byte[] image = br.ReadBytes((int)fs.Length);



            br.Close();



            fs.Close();

            // Form Http Web Request

            HttpWebRequest httpWebRequest2 = (HttpWebRequest)WebRequest.Create("https://beta-api.att.com/1/messages/outbox/mms?access_token=" + txtAccessToken.Text);
            httpWebRequest2.ContentType = "multipart/form-data; boundary=" +boundary;
            httpWebRequest2.Method = "POST";
            httpWebRequest2.KeepAlive = true;

            httpWebRequest2.AllowAutoRedirect = false;
            httpWebRequest2.UseDefaultCredentials = true;

            httpWebRequest2.PreAuthenticate = true;

            httpWebRequest2.Credentials =
            System.Net.CredentialCache.DefaultCredentials;

            string sendMMSData = "address=" + System.Text.Encoding.ASCII.GetBytes("tel:+14252337701") + "&subject=" + System.Text.Encoding.ASCII.GetBytes("mms test") + "&priority=" + System.Text.Encoding.ASCII.GetBytes("high");

            //MMS Data 
            string data = "";
            data += "--" + boundary + "\r\n";
            data += "Content-Type:application/x-www-form-urlencoded;charset=UTF-8\r\nContent-Transfer-Encoding:8bit\r\nContent-ID:<startpart>\r\n\r\n" + sendMMSData + "\r\n";
            data += "--" + boundary + "\r\n";
            data += "Content-Disposition:attachment;name=\"picture1.jpeg\"\r\n";
            data += "Content-Type:image/jpeg\r\n";
            data += "Content-ID:<picture1.jpeg>\r\n";
            data += "Content-Transfer-Encoding:binary\r\n\r\n";

            UTF8Encoding encoding = new UTF8Encoding();
            byte[] postBytes = encoding.GetBytes(data);

            byte[] boundary_data = encoding.GetBytes("\r\n");
            byte[] post_image = CombineByteArrays(image, boundary_data);
            byte[] result1 = CombineByteArrays(postBytes, post_image);

            string data1 = "--" + boundary + "--\r\n";

            
            byte[] postBytes_boundary = encoding.GetBytes(data1);


            byte[] final_result = CombineByteArrays(result1, postBytes_boundary);


            httpWebRequest2.ContentLength = final_result.Length;

            

            Stream postStream = httpWebRequest2.GetRequestStream();
            postStream.Write(final_result, 0, final_result.Length);
            postStream.Close();


            WebResponse objResponse = httpWebRequest2.GetResponse();
            using (StreamReader sr = new StreamReader(objResponse.GetResponseStream()))
            {
                string strResult = sr.ReadToEnd();
                Response.Write(strResult.ToString());
                // Close and clean up the StreamReader
                sr.Close();
            }

            httpWebRequest2 = null;



        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }

    }

    /*
   * User invoked Event to get mms status
   * Invoke AT&T  mms api through http web request along with access token 
   * and get the mms status message.
   */

    protected void btnStatusMms_Click(object sender, EventArgs e)
    {
        try
        {

            string mms_id = txtMmsId.Text.ToString();
            String strResult;
            HttpWebResponse objResponse;
            HttpWebRequest objRequest = (HttpWebRequest)System.Net.WebRequest.Create("https://beta-api.att.com/1/messages/outbox/mms/" + mms_id.ToString() + "?access_token=" + txtAccessToken.Text);

            //string strReq = txtMmsId.Text;

            objRequest.Method = "GET";
            objRequest.ContentType = "application/x-www-form-urlencoded";

            UTF8Encoding encoding = new UTF8Encoding();
            byte[] postBytes = encoding.GetBytes(mms_id);
            objRequest.ContentLength = postBytes.Length;

            Stream postStream = objRequest.GetRequestStream();
            postStream.Write(postBytes, 0, postBytes.Length);
            postStream.Close();

            objResponse = (HttpWebResponse)objRequest.GetResponse();
            // the using keyword will automatically dispose the object 
            // once complete
            using (StreamReader sr2 = new StreamReader(objResponse.GetResponseStream()))
            {
                strResult = sr2.ReadToEnd();
                lbl_delivery_status.Text = strResult;
                // Close and clean up the StreamReader
                sr2.Close();
            }

        }
        catch (Exception ex)
        {
           Response.Write(ex.ToString());
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
           Response.Write( ex.ToString());
        }
    }

    //Function to concatenate arrays.
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

}

public class Test
{
    public string access_token;

}