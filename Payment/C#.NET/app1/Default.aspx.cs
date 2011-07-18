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

        HttpContext.Current.Response.Redirect("https://beta-api.att.com/oauth/authorize?scope=" + scope_value + "&client_id=" + api_key + "&redirect_uri=http://wincode-api-att.com/dotnet/payment/Subscription/Default.aspx");

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
                // OAuthentication oauth_obj = new OAuthentication();
                get_access_code(api_key, secret_key, auth_code);
                access_token = Session["access_token"].ToString();

                //Get the access token from the json response
                JavaScriptSerializer deserializer_object = new JavaScriptSerializer();
                Test myDeserializedObj = (Test)deserializer_object.Deserialize(access_token, typeof(Test));
                access_token = myDeserializedObj.access_token.ToString();

                //Display the access token in UI text box
                txtAccTokNewSubs.Text = access_token.ToString();
                txtAccTokSubsDet.Text = access_token.ToString();
                txtAcceTokCommitTrns.Text = access_token.ToString();
            }
            /*
             * get the redirect response action 
             */
            if (Request["action"] == "UserConfirmed")
            {
                Response.Write("User has confirmed AOC");
            }


            if (Request["action"] == "UserCancelled")
            {


                Response.Write("User has cancelled AOC");
            }


            if (Request["action"] == "Status")
            {


                Response.Write("Status callback URL has been invoked");
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
     * User invoked Event for New Subscription
     * Invoke AT&T transaction api through http web request along with access token 
     * and post the New Subscription
     */
    protected void btnNewSubscription_Click(object sender, EventArgs e)
    {
        try
        {

            String strResult;
            WebResponse objResponse;
            WebRequest objRequest = (WebRequest)System.Net.WebRequest.Create("https://beta-api.att.com/1/payments/transactions?access_token=" + txtAccTokNewSubs.Text);

            string strReq = "{'amount':'" + txtAmountNS.Text + "','category':'" + txtCategoryNS.Text + "','channel':'" + txtChannelNS.Text + "','currency':'" + txtCurrencyNS.Text + "','description':'" + txtDescriptionNS.Text + "','externalMerchantTransactionID':'" + txtExtMerTransIdNS.Text + "','merchantApplicationID':'" + txtAppId.Text + "','merchantCancelRedirectUrl':'" + txtCancelRedirectUrl.Text + "','merchantFulfillmentRedirectUrl':'" + txtFullfillmentUrl.Text + "','merchantProductID':'" + txtProductIdNS.Text + "','purchaseOnNoActiveSubscription':'" + txtPurcActSubsNS.Text + "','transactionStatusCallbackUrl':'" + txtStatusUrl.Text + "','merchantSubscriptionIdList':'" + txtMerSubsIdListNS.Text + "','subscriptionRecurringNumber':'" + txtSubsRecuNumberNS.Text + "','subscriptionRecurringPeriod':'" + txtSubsRecPeriodNS.Text + "','subscriptionRecurringPeriodAmount':'" + txtSubsRecPeriodAmtNS.Text + "','autoCommit':'" + txtautocommit.Text + "'}";

            objRequest.Method = "POST";
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
                Response.Redirect(strResult.ToString());
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
    * User invoked Event to get Subscription Details
    * Invoke AT&T Subscription api through http web request along with access token 
    * and get the  Subscription details
    */
    protected void btnSubscripDet_Click(object sender, EventArgs e)
    {
        try
        {

            String strResult;
            WebResponse objResponse;
            WebRequest objRequest = (WebRequest)System.Net.WebRequest.Create("https://beta-api.att.com/1/payments/subscriptions/'" + txtSubscriptionId.Text.ToString() + "'?access_token=" + txtAccTokSubsDet.Text);

            string strReq = txtSubscriptionId.Text;

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

                Session["RediectUrl"] = strResult;
                Response.Redirect(strResult.ToString());
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
    * User invoked Event to commit transaction
    * Invoke AT&T Subscription api through http web request along with access token 
    * and commit transaction.
    */

    protected void btnCommitTrans_Click(object sender, EventArgs e)
    {
        try
        {

            String strResult;
            WebResponse objResponse;
            WebRequest objRequest = (WebRequest)System.Net.WebRequest.Create("https://beta-api.att.com/1/payments/transactions/'" + txtTransIdCommitPay.Text.ToString() + "'?access_token=" + txtAcceTokCommitTrns.Text);

            string strReq = "{\"transactionStatus\":\"COMMITTED\"}";

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
                Response.Redirect(strResult.ToString());
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