<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="SMSAPP_mms_ReceiveMMS_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Developer Sample .Net Application</title>
    <link rel="stylesheet" href="../../../CSS/jquery.ui.all.css" />
    <script src="../../../js/jquery-1.5.1.js" type=""></script>
    <script src="../../../js/jquery.ui.core.js" type=""></script>
    <script src="../../../js/jquery.ui.widget.js" type=""></script>
    <script src="../../../js/jquery.ui.tabs.js" type=""></script>
    <link rel="stylesheet" href="../../../CSS/demos.css" />
    <script language="JavaScript" src="../../../js/gen_validatorv4.js" type="text/javascript"
        xml:space="preserve"></script>
    <script type="">
    </script>
</head>
<body>
    <div id="tabs">
        <form id="frmMMS" runat="server" method="post" style="font-size: 'larger'">
        <ul class="demo">
            <li><a href="#tabs-2" class="parent">MMS</a> </li>
        </ul>
        <div id="tabs-1">
            <asp:Label runat="server" ID="lblText1" Text="MMS Id is " />
            <br />
            <h1 style="color: Navy; font-size: large" align="center">
                Receive MMS
            </h1>
            <form id="ReceiveMMSForm" name="ReceiveMMSForm" method="post" enctype="multipart/form-data"
            action="/sampleApp/mms/OauthSetupMMS.aspx">
            <table width="45%" id="tlbSendMMS" runat="server" align="center">
                <tr>
                    <td>
                        <asp:HyperLink ID="HyperLink1" Text="Fetch Access Token" runat="server" NavigateUrl="~/SMSAPP/mms/ReceiveMMS/Oauth.aspx"></asp:HyperLink>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblAccessTokenSMS" Text="Access Token :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAccessToken" TabIndex="1" Columns="40"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger" align="center">
                    <td align="right">
                        <asp:Button runat="server" ID="btnReceiveMMS" Text="Receive MMS" TabIndex="2" BorderStyle="NotSet"
                            ForeColor="Olive" />
                    </td>
                </tr>
            </table>
            </form>
        </div>
        </form>
    </div>
</body>
</html>
