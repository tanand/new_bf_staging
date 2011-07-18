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
Imports System.Net.Sockets
Imports System.Security.Cryptography.X509Certificates
Imports System.Net.Security
Imports System.Collections.Specialized

Partial Public Class [Default]
    Inherits System.Web.UI.Page
    Private api_key As String, secret_key As String, short_code As String, auth_code As String, access_token As String
    Private scope_value As String = "WAP"
    ' Function to invoke authorize interface of Oauth with scope, client id and redirect uri
    ' to get authorization code
    Public Sub get_auth_code(ByVal api_key As String, ByVal scope_value As String)
        Try

            HttpContext.Current.Response.Redirect("https://beta-api.att.com/oauth/authorize?scope=" & scope_value & "&client_id=" & api_key & "&redirect_uri=http://wincode-api-att.com/VBDotNet/wap/Default.aspx")
        Catch thex As Exception
            Response.Write(thex.ToString())
        End Try
    End Sub
    ' Function invokes acess_token interface of Oauth with client id, client secret and auth code
    ' and stores the access token received in the session
    Public Sub get_access_code(ByVal api_key As String, ByVal secret_key As String, ByVal auth_code As String)
        Try
            Dim objRequest As WebRequest = System.Net.HttpWebRequest.Create("https://beta-api.att.com/oauth/access_token?client_id=" & api_key.ToString() & "&client_secret=" & secret_key.ToString() & "&code=" & auth_code.ToString() & "&grant_type=authorization_code")

            'objRequest.ContentType = "application/json"
            objRequest.Method = "GET"

            Dim objResponse As WebResponse = objRequest.GetResponse()
            Using sr As New StreamReader(objResponse.GetResponseStream())

                HttpContext.Current.Session("access_token") = sr.ReadToEnd().ToString()
                ' Close and clean up the StreamReader
                sr.Close()
            End Using
        Catch thex As Exception
            Response.Write(thex.ToString())
        End Try
    End Sub

    Public Function CombineByteArrays(ByVal ParamArray arrays As Byte()()) As Byte()
        Dim rv As Byte() = New Byte(arrays.Sum(Function(a) a.Length) - 1) {}
        Dim offset As Integer = 0
        For Each array As Byte() In arrays
            System.Buffer.BlockCopy(array, 0, rv, offset, array.Length)
            offset += array.Length
        Next
        Return rv
    End Function
    ' On page load if query string 'code' is present, invoke get_access_token
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles MyBase.Load
        Try

            ' Get the api key, secre key and short code values for the application from web.config.

            api_key = ConfigurationManager.AppSettings("api_key").ToString()
            secret_key = ConfigurationManager.AppSettings("secret_key").ToString()
            short_code = ConfigurationManager.AppSettings("short_code").ToString()
            If Len(Request.QueryString("code")) = 0 Then
                auth_code = ""
            Else
                auth_code = Request("code").ToString()
            End If


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

                access_token = myDeserializedObj.access_token.ToString()
            End If
        Catch ex As Exception
            ex.ToString()
        End Try
    End Sub
    ' User invoked Event for sending WAP 
    ' Invoke AT&T wap push api through http web request along with access token 
    ' and post the Wap Push message.
    Protected Sub btnSendWAP_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSendWAP.Click
        Try
            'If the user submitted the sendWAP form, then get the values and try to send the WAP PUSH message.  

            Dim boundary As String = "----------------------------" & DateTime.Now.Ticks.ToString("x")
            Dim fs As New FileStream(FileUpload1.PostedFile.FileName, FileMode.Open, FileAccess.Read)
            Dim br As New BinaryReader(fs)
            Dim fileContents As Byte() = br.ReadBytes(CInt(fs.Length))
            br.Close()
            fs.Close()

            'Form Http Web Request
            Dim httpWebRequest As HttpWebRequest = DirectCast(WebRequest.Create("https://beta-api.att.com/1/messages/outbox/wapPush?access_token=" + txtAccessToken.Text), HttpWebRequest)
            httpWebRequest.ContentType = "multipart/form-data; type=""application/x-www-form-urlencoded""; start=""<startpart>""; boundary=" & boundary
            httpWebRequest.Method = "POST"
            httpWebRequest.Headers.Add("Accept-Language", "vb,en-us;q=0.7,en;q=0.3")
            httpWebRequest.Headers.Add("MIME-Version: 1.0" & vbCr & vbLf)
            httpWebRequest.Headers.Add("X-HostCommonName: beta-api.att.com" & vbCr & vbLf)
            httpWebRequest.Headers.Add("Cookie: api.att-stg.amdocshub.com=""R533090545""" & vbCr & vbLf)
            httpWebRequest.Headers.Add("X-Forwarded-For: 135.214.40.30" & vbCr & vbLf)
            httpWebRequest.Headers.Add("X-Target-URI: https://beta-api.att.com" & vbCr & vbLf)
            httpWebRequest.KeepAlive = True
            httpWebRequest.AllowAutoRedirect = False

            Dim sendMMSData As String = "{'address':'" & txtAddressWAPPush.Text.ToString() & "','subject':'" & txtSubjectWAPPush.Text.ToString() & "','priority':'high'}"

            'Wap Push Data 
            Dim data As String = ""
            Dim data1 As String = ""
            data += "--" & boundary & vbCr & vbLf
            data += "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" & vbCr & vbLf
            data += "Content-Transfer-Encoding: 8bit" & vbCr & vbLf
            data += "Content-ID: <startpart>" & vbCr & vbLf
            data += "Content-Disposition: form-data; name=""" & System.IO.Path.GetFileName(FileUpload1.PostedFile.FileName) & "" & vbCr & vbLf & sendMMSData & vbCr & vbLf
            data += "Content-type: application/xml" & vbCr & vbLf & vbCr & vbLf
            data += "--" & boundary & vbCr & vbLf
            data += "Content-Type: text/plain" & vbCr & vbLf
            data += "Content-Transfer-Encoding: binary" & vbCr & vbLf
            data += "Content-ID: " & System.IO.Path.GetFileName(FileUpload1.PostedFile.FileName) & vbCr & vbLf
            data += "Content-Disposition: attachment; name=" & System.IO.Path.GetFileName(FileUpload1.PostedFile.FileName) & vbCr & vbLf
            data1 = fileContents(fs.Length) & vbCr & vbLf
            data1 += "--" & boundary & "--" & vbCr & vbLf

            Dim encoding As New UTF8Encoding()
            Dim postBytes As Byte() = encoding.GetBytes(data)

            Dim content As Byte() = CombineByteArrays(postBytes, fileContents)

            Dim encoding1 As New UTF8Encoding()
            Dim postBytes1 As Byte() = encoding.GetBytes(data1)
            Dim content1 As Byte() = CombineByteArrays(content, postBytes1)

            httpWebRequest.ContentLength = content1.Length

            'Sending WAP push Data as a stream
            Using writeStream As Stream = httpWebRequest.GetRequestStream()
                writeStream.Write(content1, 0, content1.Length)
                writeStream.Close()
            End Using
            Dim objResponse As HttpWebResponse = DirectCast(httpWebRequest.GetResponse(), HttpWebResponse)

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
    ' User invoked Event for getting WAP status 
    ' Invoke AT&T Wap Push api through http web request along with access token 
    ' and post the Wap Push Status.
    Protected Sub btnStatusWAP_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnStatusWAP.Click
        Try

        Catch ex As Exception
            ex.ToString()
        End Try
    End Sub
    'User invoked Event for getting the access token
    Protected Sub lnkbtnAccessCode_Click(ByVal sender As Object, ByVal e As EventArgs)
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

