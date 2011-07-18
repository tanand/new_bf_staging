
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Net
Imports System.IO
Imports System.Web.Services
Imports System.Text
Imports System.Configuration
Imports System.Web.Script.Serialization

Partial Public Class [Default]
    Inherits System.Web.UI.Page
    Private api_key As String, secret_key As String, short_code As String, auth_code As String, access_token As String
    Private scope_value As String = "MMS"

    ' Function to invoke authorize interface of Oauth with scope, client id and redirect uri
    ' to get authorization code
    Public Sub get_auth_code(ByVal api_key As String, ByVal scope_value As String)
        Dim folder As String = scope_value.ToString().ToLower()

        HttpContext.Current.Response.Redirect("https://beta-api.att.com/oauth/authorize?scope=" & scope_value & "&client_id=" & api_key & "&redirect_uri=http://wincode-api-att.com/dotnet/mms/SendMMS/Default.aspx")

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

            HttpContext.Current.Session("access_token") = sr.ReadToEnd().ToString()
            ' Close and clean up the StreamReader
            sr.Close()
        End Using
    End Sub
    ' On page load if query string 'code' is present, invoke get_access_token
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles MyBase.Load
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
                txtAccessToken.Text = access_token.ToString()
                txtAccTokGetDeleStatus.Text = access_token.ToString()

            End If
        Catch ert As Exception
        End Try
    End Sub
    ' User invoked Event for sending mms
    ' Invoke AT&T send mms api through http web request along with access token 
    ' and post the mms message to destination msisdn
    Protected Sub btnSendMMS_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSendMMS.Click
        Try


            Dim length As Long = 0
            Dim boundary As String = "----------------------------" & DateTime.Now.Ticks.ToString("x")

            Dim fs As New FileStream(FileUpload1.PostedFile.FileName, FileMode.Open, FileAccess.Read)
            Dim br As New BinaryReader(fs)
            Dim image As Byte() = br.ReadBytes(CInt(fs.Length))
            br.Close()
            fs.Close()
            'Form Http Web Request
            Dim httpWebRequest As HttpWebRequest = DirectCast(WebRequest.Create("https://beta-api.att.com/1/messages/outbox/mms?access_token=" + txtAccessToken.Text), HttpWebRequest)
            httpWebRequest.ContentType = "multipart/form-data; boundary=" & boundary
            httpWebRequest.Method = "POST"
            httpWebRequest.KeepAlive = True
            httpWebRequest.AllowAutoRedirect = False
            httpWebRequest.UseDefaultCredentials = True
            httpWebRequest.PreAuthenticate = True
            httpWebRequest.Credentials = System.Net.CredentialCache.DefaultCredentials

            Dim sendMMSData As String = "{'address':'" & txtAddressMMS.Text.ToString() & "','subject':'" & txtSubjectMMS.Text.ToString() & "','priority':'high'}"

            'MMS Data 
            Dim data As String = ""
            data += "--" & boundary & vbCr & vbLf
            data += "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" & vbCr & vbLf & "Content-Transfer-Encoding: 8bit" & vbCr & vbLf & "Content-ID: <startpart>" & vbCr & vbLf & vbCr & vbLf & sendMMSData.ToString() & vbCr & vbLf
            data += "--" & boundary & vbCr & vbLf
            data += "Content-Disposition: attachment; name=" + FileUpload1.PostedFile.FileName & vbCr & vbLf
            data += "Content-Type: " & System.IO.Path.GetExtension(FileUpload1.PostedFile.FileName) & vbCr & vbLf
            data += "Content-ID: " + FileUpload1.PostedFile.FileName & vbCr & vbLf
            data += "Content-Transfer-Encoding: binary" & vbCr & vbLf & vbCr & vbLf
            data += Convert.ToString(image) & vbCr & vbLf
            data += "--" & boundary & "--" & vbCr & vbLf



            Dim encoding As New UTF8Encoding()
            Dim postBytes As Byte() = encoding.GetBytes(data)
            httpWebRequest.ContentLength = postBytes.Length

            Dim postStream As Stream = httpWebRequest.GetRequestStream()
            postStream.Write(postBytes, 0, postBytes.Length)
            postStream.Close()


            Dim objResponse As WebResponse = httpWebRequest.GetResponse()
            Using sr As New StreamReader(objResponse.GetResponseStream())
                Dim strResult As String = sr.ReadToEnd()
                Response.Write(strResult.ToString())
                ' Close and clean up the StreamReader
                sr.Close()
            End Using

            httpWebRequest = Nothing
        Catch ex As Exception
            Response.Write(ex.ToString())
        End Try

    End Sub
    'User invoked Event for getting delivery status
    Protected Sub btnStatusMms_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnStatusMms.Click
        Try

            Dim mms_id As String = txtMmsId.Text.ToString()
            Dim strResult As [String]
            Dim objResponse As HttpWebResponse
            'Form Http Web Request
            Dim objRequest As HttpWebRequest = DirectCast(System.Net.WebRequest.Create(("https://beta-api.att.com/1/messages/outbox/mms/" & mms_id.ToString() & "?access_token=") + txtAccessToken.Text), HttpWebRequest)

            objRequest.Method = "GET"
            objRequest.ContentType = "application/x-www-form-urlencoded"

            Dim encoding As New UTF8Encoding()
            Dim postBytes As Byte() = encoding.GetBytes(mms_id)
            objRequest.ContentLength = postBytes.Length

            'Sending Get Delivery Status Data as a stream
            Dim postStream As Stream = objRequest.GetRequestStream()
            postStream.Write(postBytes, 0, postBytes.Length)
            postStream.Close()

            objResponse = DirectCast(objRequest.GetResponse(), HttpWebResponse)
            ' the using keyword will automatically dispose the object 
            ' once complete
            Using sr As New StreamReader(objResponse.GetResponseStream())
                strResult = sr.ReadToEnd()
                lbl_delivery_status.Text = strResult
                ' Close and clean up the StreamReader
                sr.Close()

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
            Response.Write(ex.ToString())
        End Try
    End Sub
End Class
Public Class Test
    Public access_token As String
End Class
