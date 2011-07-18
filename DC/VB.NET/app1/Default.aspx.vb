Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Net
Imports System.Configuration
Imports System.IO
Imports System.Xml
Imports System.Text
Imports System.Web.Script.Serialization


Partial Public Class [Default]
    Inherits System.Web.UI.Page
    Private api_key As String, secret_key As String, short_code As String, auth_code As String, access_token As String
    Private scope_value As String = "DC"

    ' Function to invoke authorize interface of Oauth with scope, client id and redirect uri
    ' to get authorization code 
    Public Sub get_auth_code(ByVal api_key As String, ByVal scope_value As String)
        Dim folder As String = scope_value.ToString().ToLower()

        HttpContext.Current.Response.Redirect("https://beta-api.att.com/oauth/authorize?scope=" & scope_value & "&client_id=" & api_key & "&redirect_uri=http://wincode-api-att.com/VBDotNet/dc/DeviceInformation/Default.aspx")

    End Sub
    ' Function invokes acess_token interface of Oauth with client id, client secret and auth code
    ' and stores the access token received in the session
    Public Sub get_access_code(ByVal api_key As String, ByVal secret_key As String, ByVal auth_code As String)

        Dim objRequest As WebRequest = System.Net.HttpWebRequest.Create("https://beta-api.att.com/oauth/access_token?client_id=" & api_key.ToString() & "&client_secret=" & secret_key.ToString() & "&code=" & auth_code.ToString() & "&grant_type=authorization_code")

        objRequest.ContentType = "application/x-www-form-urlencoded"
        objRequest.Method = "GET"

        ' the using keyword will automatically dispose the object 
        ' once complete

        Dim objResponse As WebResponse = objRequest.GetResponse()
        Using sr As New StreamReader(objResponse.GetResponseStream())
            'Store the access token in the session
            Session("access_token") = sr.ReadToEnd().ToString()
            'Close and clean up the StreamReader
            sr.Close()
        End Using


    End Sub
    ' On page load if query string 'code' is present, invoke get_access_token
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles MyBase.Load
        Try

            'Get the api key, secre key and short code values for the application from web.config.
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
                txtAcceTokGetDelStatus.Text = access_token.ToString()

            End If
        Catch ex As Exception
            Response.Write(ex.ToString())
        End Try
    End Sub
    ' User invoked Event for getting device information
    ' Invoke AT&T Device Information api through http web request along with access token 
    ' and get the device information from destination msisdn
    Protected Sub btnGetDeviceInfo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGetDeviceInfo.Click
        Try
            Dim strReq As String = txtDeviceId.Text
            Dim access_tkn As String = txtAcceTokGetDelStatus.Text.ToString()
            Dim strResult As [String]

            Dim objResponse As HttpWebResponse
            'Form Http Web Request
            Dim objRequest As HttpWebRequest = DirectCast(System.Net.WebRequest.Create("https://beta-api.att.com/1/devices/tel:" & strReq.ToString() & "/info?access_token=" & access_tkn.ToString()), HttpWebRequest)

            objRequest.Method = "GET"

            objResponse = DirectCast(objRequest.GetResponse(), HttpWebResponse)
            ' the using keyword will automatically dispose the object 
            ' once complete
            Using sr2 As New StreamReader(objResponse.GetResponseStream())
                strResult = sr2.ReadToEnd()
                Response.Write(strResult.ToString())

                ' Close and clean up the StreamReader
                sr2.Close()
            End Using
        Catch ex As Exception
            Response.Write(ex.ToString())
        End Try
    End Sub

    'User invoked Event for getting the access token
    Protected Sub lnkbtnAccessCode_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkbtnAccessCode.Click
        Try
            get_auth_code(api_key, scope_value)
        Catch ex As Exception
            ex.ToString()
        End Try
    End Sub

End Class
Public Class Test
    Public access_token As String
End Class
