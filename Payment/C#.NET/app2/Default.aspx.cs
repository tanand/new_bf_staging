using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Text;
using System.IO;
using System.Configuration;
using System.Collections.Generic;
using System.Web.Script.Serialization; 

public partial class Default : System.Web.UI.Page
{

    string api_key, secret_key, short_code, auth_code, access_token;
    string scope_value = "PAYMENT";

    /* 
     * Function to invoke authorize interface of Oauth with scope, client id and redirect uri
     * to get authorization code 
     */
    public void get_auth_code(string api_key, string scope_value)
    {
               
        HttpContext.Current.Response.Redirect("https://beta-api.att.com/oauth/authorize?scope=" + scope_value + "&client_id=" + api_key + "&redirect_uri=http://wincode-api-att.com/dotnet/payment/Transaction/Default.aspx");

    }

    /*
     * Function invokes acess_token interface of Oauth with client id, client secret and auth code
     * and stores the access token received in the session
     */

    public void get_access_code(string api_key, string secret_key, string auth_code)
    {
        // Form Http Web Request
        WebRequest objRequest = System.Net.HttpWebRequest.Create("https://beta-api.att.com/oauth/access_token?client_id=" + api_key.ToString() + "&client_secret=" + secret_key.ToString() + "&code=" + auth_code.ToString() + "&grant_type=authorization_code");

        objRequest.ContentType = "application/json";
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
                //OAuthentication oauth_obj = new OAuthentication();
                get_access_code(api_key, secret_key, auth_code);
                access_token = Session["access_token"].ToString();

                //Get the access token from the json response
                JavaScriptSerializer deserializer_object = new JavaScriptSerializer();
                Test myDeserializedObj = (Test)deserializer_object.Deserialize(access_token, typeof(Test));
                access_token = myDeserializedObj.access_token.ToString();

                //Display the access token in UI text box
                txtAcesTokNewTrans.Text = access_token.ToString();
                txtAcceTokGetTrnsStatus.Text = access_token.ToString();
                txtAcceTokCommitTrans.Text = access_token.ToString();
                txtAccesTokRefTrans.Text = access_token.ToString();
            }

        }
        catch (Exception ert)
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
    * User invoked Event for New Payment Transaction
    * Invoke AT&T transaction api through http web request along with access token 
    */
    protected void btnNewTrns_Click(object sender, EventArgs e)
    {
        try
        {
           
            String strResult;
            WebResponse objResponse;
            // Form Http Web Request
            WebRequest objRequest = (WebRequest)System.Net.WebRequest.Create("https://beta-api.att.com/1/payments/transactions?access_token=" + txtAcesTokNewTrans.Text);

            string strReq ="{'amount':'" + txtAmountSPT.Text.ToString() + "','category':'" + txtCategorySPT.Text.ToString() + "','channel':'" + txtChannelSPT.Text.ToString() + "','currency':'" + txtCurrencySPT.Text.ToString() + "','description':'" + txtDescriptionSPT.Text.ToString() + "','externalMerchantTransactionID':'" + txtTransactionIdSPT.Text.ToString() + "','merchantApplicationID':'" + txtAppId.Text.ToString() + "','merchantCancelRedirectUrl':'" + txtCancelUrl.Text.ToString() + "','merchantFulfillmentRedirectUrl':'" + txtFullfillment.Text.ToString() + "','merchantProductID':'" + txtProductIdSPT.Text.ToString() + "','purchaseOnNoActiveSubscription':'" + txtPurchaseActiveSUb.Text.ToString() + "','transactionStatusCallbackUrl':'" + txtStatusUrl.Text.ToString() + "','autoCommit':'" + txt_auto_commit.Text.ToString() + "'}";

            objRequest.Method = "POST";
            objRequest.ContentType = "application/json";

            objRequest.Credentials = CredentialCache.DefaultCredentials;

            UTF8Encoding encoding = new UTF8Encoding();
            byte[] postBytes = encoding.GetBytes(strReq);
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
                single_pay_transaction_output.Text = strResult.ToString();
                Response.Write(strResult.ToString());
              
                // Close and clean up the StreamReader
                sr2.Close();
            }
          
        }
        catch (Exception ex)
        {
           Response.Write( ex.ToString());
        }
    }

    /*
    * User invoked Event to get transaction status
    * Invoke AT&T get transaction status api through http web request along with access token 
    * and displays status of transaction.
    */

    protected void btnGetTrnsStatus_Click(object sender, EventArgs e)
    {
        try
        {
           
            String strResult;
            
            WebResponse objResponse;

            string strReq = txtTransIdGetPay.Text;
            // Form Http Web Request
            WebRequest objRequest = (WebRequest)System.Net.WebRequest.Create("https://beta-api.att.com/1/payments/subscriptions/'" + strReq.ToString() + "'?access_token=" + txtAcceTokGetTrnsStatus.Text);

           


            objRequest.Method = "GET";
            objRequest.ContentType = "application/json";

            UTF8Encoding encoding = new UTF8Encoding();
            byte[] postBytes = encoding.GetBytes(strReq);
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
               
                Response.Write(strResult.ToString());
                // Close and clean up the StreamReader
                sr2.Close();
            }
            
        }
        catch (Exception ex)
        {
           Response.Write( ex.ToString());
        }
    }

    /*
    * User invoked Event for Refund transaction
    * Invoke AT&T refund transaction api through http web request along with access token.
    */

    protected void btnRefundTrans_Click(object sender, EventArgs e)
    {
        try
        {
            
            String strResult;
            WebResponse objResponse;

            string strReq = txtTransIdRefund.Text;
            // Form Http Web Request
            WebRequest objRequest = (WebRequest)System.Net.WebRequest.Create("https://beta-api.att.com/1/payments/transactions/'" + strReq.ToString() + "'?access_token=" + txtAccesTokRefTrans.Text);

           


            objRequest.Method = "GET";
            objRequest.ContentType = "application/json";

            UTF8Encoding encoding = new UTF8Encoding();
            byte[] postBytes = encoding.GetBytes(strReq);
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

    /*
   * User invoked Event for Commit transaction
   * Invoke AT&T Commit transaction api through http web request along with access token.
   */

    protected void btnCommitTrans_Click(object sender, EventArgs e)
    {
        try
        {
            
            String strResult;
            WebResponse objResponse;

            string strReq = txtTransIdCommitPay.Text;
            // Form Http Web Request
            WebRequest objRequest = (WebRequest)System.Net.WebRequest.Create("https://beta-api.att.com/1/payments/transactions/'" + strReq.ToString() + "'?access_token=" + txtAcceTokCommitTrans.Text);

            


            objRequest.Method = "GET";
            objRequest.ContentType = "application/json";

            UTF8Encoding encoding = new UTF8Encoding();
            byte[] postBytes = encoding.GetBytes(strReq);
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
