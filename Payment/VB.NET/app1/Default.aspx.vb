Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Net
Imports System.Text
Imports System.IO
Imports System.Configuration
Imports System.Web.Script.Serialization

Partial Public Class [Default]
    Inherits System.Web.UI.Page

    Private api_key As String, secret_key As String, short_code As String, auth_code As String, access_token As String
    Private scope_value As String = "PAYMENT"
    ' Function to invoke authorize interface of Oauth with scope, client id and redirect uri
    ' to get authorization code
    Public Sub get_auth_code(ByVal api_key As String, ByVal scope_value As String)
        Dim folder As String = scope_value.ToString().ToLower()

        HttpContext.Current.Response.Redirect("https://beta-api.att.com/oauth/authorize?scope=" & scope_value & "&client_id=" & api_key & "&redirect_uri=http://wincode-api-att.com/VBDotNet/payment/Subscription/Default.aspx")

    End Sub
    ' Function invokes acess_token interface of Oauth with client id, client secret and auth code
    ' and stores the access token received in the session
    Public Sub get_access_code(ByVal api_key As String, ByVal secret_key As String, ByVal auth_code As String)

        Dim objRequest As WebRequest = System.Net.HttpWebRequest.Create("https://beta-api.att.com/oauth/access_token?client_id=" & api_key.ToString() & "&client_secret=" & secret_key.ToString() & "&code=" & auth_code.ToString() & "&grant_type=authorization_code")

        objRequest.ContentType = "application/json"
        objRequest.Method = "GET"

        ' the using keyword will automatically dispose the object 
        ' once complete

        Dim objResponse As WebResponse = objRequest.GetResponse()
        Using sr As New StreamReader(objResponse.GetResponseStream())

            HttpContext.Current.Session("access_token") = sr.ReadToEnd().ToString()
            ' Close and clean up the StreamReader
            sr.Close()
        End Using


    End Sub
    ' On page load if query string 'code' is present, invoke get_access_token
    Public Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles MyBase.Load
        Try

            ' Get the api key, secre key and short code values for the application from web.config.

            api_key = ConfigurationManager.AppSettings("api_key").ToString()
            secret_key = ConfigurationManager.AppSettings("secret_key").ToString()
            short_code = ConfigurationManager.AppSettings("short_code").ToString()
            auth_code = Request("code").ToString()

            'If query string contains auth code, extract it and invoke get_access_token
            If auth_code <> "" Then
                get_access_code(api_key, secret_key, auth_code)
                Dim access_token_json As String = Session("access_token").ToString()

                'Get the access token from the json response
                Dim deserializer_object As New JavaScriptSerializer()
                Dim myDeserializedObj As Test = DirectCast(deserializer_object.Deserialize(access_token_json, GetType(Test)), Test)
                access_token = myDeserializedObj.access_token.ToString()

                'Display the access token in UI text box
                txtAccTokNewSubs.Text = access_token.ToString()
                txtAccTokSubsDet.Text = access_token.ToString()
                txtAcceTokCommitTrns.Text = access_token.ToString()

            End If
            ' Response.Write(ert.ToString());
        Catch ert As Exception
        End Try
    End Sub
    'User invoked Event for getting the access token
    Protected Sub lnkbtnAccessCode_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkbtnAccessCode.Click
        Try
            get_auth_code(api_key, scope_value)
        Catch ex As Exception
            Response.Write(ex.ToString())
        End Try
    End Sub
    ' User invoked Event For New Subscription
    ' Invoke AT&T New Subscription api through http web request along with access token 
    ' and post the Payment New Subscription.
    Protected Sub btnNewSubscription_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNewSubscription.Click
        Try
            Dim strResult As [String]
            Dim objResponse As WebResponse
            'Form Http Web Request
            Dim objRequest As WebRequest = DirectCast(System.Net.WebRequest.Create("https://beta-api.att.com/1/payments/transactions?access_token=" + txtAccTokNewSubs.Text.ToString()), WebRequest)

            Dim strReq As String = "{'amount':'" + txtAmountNS.Text.ToString() & "','category':'" + txtCategoryNS.Text.ToString() & "','channel':'" + txtChannelNS.Text.ToString() & "','currency':'" + txtCurrencyNS.Text.ToString() & "','description':'" + txtDescriptionNS.Text.ToString() & "','externalMerchantTransactionID':'" + txtExtMerTransIdNS.Text.ToString() & "','merchantApplicationID':'" + txtAppId.Text.ToString() & "','merchantCancelRedirectUrl':'" + txtCancelRedirectUrl.Text.ToString() & "','merchantFulfillmentRedirectUrl':'" + txtFullfillmentUrl.Text.ToString() & "','merchantProductID':'" + txtProductIdNS.Text.ToString() & "','purchaseOnNoActiveSubscription':'" + txtPurcActSubsNS.Text.ToString() & "','transactionStatusCallbackUrl':'" + txtStatusUrl.Text.ToString() & "','merchantSubscriptionIdList':'" + txtMerSubsIdListNS.Text.ToString() & "','subscriptionRecurringNumber':'" + txtSubsRecuNumberNS.Text.ToString() & "','subscriptionRecurringPeriod':'" + txtSubsRecPeriodNS.Text.ToString() & "','subscriptionRecurringPeriodAmount':'" + txtSubsRecPeriodAmtNS.Text.ToString() & "','autoCommit':'" + txtautocommit.Text.ToString() & "'}"

            objRequest.Method = "POST"
            objRequest.ContentType = "application/json"

            Dim encoding As New UTF8Encoding()
            Dim postBytes As Byte() = encoding.GetBytes(strReq)
            objRequest.ContentLength = postBytes.Length

            'Sending New Subscription Data as a stream
            Dim postStream As Stream = objRequest.GetRequestStream()
            postStream.Write(postBytes, 0, postBytes.Length)
            postStream.Close()

            objResponse = DirectCast(objRequest.GetResponse(), HttpWebResponse)
            ' the using keyword will automatically dispose the object 
            ' once complete
            Using sr As New StreamReader(objResponse.GetResponseStream())
                strResult = sr.ReadToEnd()
                Response.Redirect(strResult.ToString())
                ' Close and clean up the StreamReader
                sr.Close()

            End Using
        Catch ex As Exception
            Response.Write(ex.ToString())
        End Try
    End Sub
    ' User invoked Event for getting Subscription
    ' Invoke AT&T get subscription api through http web request along with access token 
    ' and get the payment subscription.
    Protected Sub btnSubscripDet_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSubscripDet.Click
        Try

            Dim strResult As [String]
            Dim objResponse As WebResponse
            'Form Http Web Request
            Dim objRequest As WebRequest = DirectCast(System.Net.WebRequest.Create(("https://beta-api.att.com/1/payments/subscriptions/'" & txtSubscriptionId.Text.ToString() & "'?access_token=") + txtAccTokSubsDet.Text), WebRequest)

            Dim strReq As String = txtSubscriptionId.Text

            objRequest.Method = "GET"
            objRequest.ContentType = "application/json"

            Dim encoding As New UTF8Encoding()
            Dim postBytes As Byte() = encoding.GetBytes(strReq)
            objRequest.ContentLength = postBytes.Length

            'Sending Get Subscription Status Data as a stream
            Dim postStream As Stream = objRequest.GetRequestStream()
            postStream.Write(postBytes, 0, postBytes.Length)
            postStream.Close()

            objResponse = DirectCast(objRequest.GetResponse(), HttpWebResponse)
            ' the using keyword will automatically dispose the object 
            ' once complete
            Using sr As New StreamReader(objResponse.GetResponseStream())
                strResult = sr.ReadToEnd()

                Session("RediectUrl") = strResult
                Response.Redirect(strResult.ToString())
                ' Close and clean up the StreamReader
                sr.Close()

            End Using
        Catch ex As Exception
            Response.Write(ex.ToString())
        End Try
    End Sub
    ' User invoked Event For Commit Transaction
    ' Invoke AT&T Commit Transaction api through http web request along with access token 
    ' and get the Commit Transaction.
    Protected Sub btnCommitTrans_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCommitTrans.Click
        Try

            Dim strResult As [String]
            Dim objResponse As WebResponse
            'Form Http Web Request
            Dim objRequest As WebRequest = DirectCast(System.Net.WebRequest.Create(("https://beta-api.att.com/1/payments/subscriptions/'" & txtTransIdCommitPay.Text.ToString() & "'?access_token=") + txtAcceTokCommitTrns.Text), WebRequest)

            Dim strReq As String = txtTransIdCommitPay.Text

            objRequest.Method = "GET"
            objRequest.ContentType = "application/json"

            Dim encoding As New UTF8Encoding()
            Dim postBytes As Byte() = encoding.GetBytes(strReq)
            objRequest.ContentLength = postBytes.Length

            'Sending Commit Transaction Data as a stream
            Dim postStream As Stream = objRequest.GetRequestStream()
            postStream.Write(postBytes, 0, postBytes.Length)
            postStream.Close()

            objResponse = DirectCast(objRequest.GetResponse(), HttpWebResponse)
            ' the using keyword will automatically dispose the object 
            ' once complete
            Using sr As New StreamReader(objResponse.GetResponseStream())
                strResult = sr.ReadToEnd()
                Response.Redirect(strResult.ToString())
                ' Close and clean up the StreamReader
                sr.Close()

            End Using
        Catch ex As Exception
            Response.Write(ex.ToString())
        End Try
    End Sub
End Class
Public Class Test
    Public access_token As String
End Class
