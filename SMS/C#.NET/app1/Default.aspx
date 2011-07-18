<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Developer Sample .Net Application</title>
   </head>
<body>
    <div class="demo">
        <div id="tabs">
            <form id="frmSms" runat="server" method="post" style="font-size: 'larger'">
            <div id="tabs-1">
                <h1 style="color: Navy; font-size: large" align="center">
                    Receive SMS
                </h1>
                </div>
                <div>
                <asp:LinkButton runat="server" ID="lnkbtnAccessCode" Text="Fetch Access Token" OnClick="lnkbtnAccessCode_Click"></asp:LinkButton>
                <%--************************************************************************************************************ --%>
                <%-- This table includes the controls which is used for send sms --%>
                <%--************************************************************************************************************ --%>
            </div>
                <table width="45%" id="tlbSendMMS" runat="server" align="center">
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
                            <asp:Button runat="server" ID="btnReceiveSMS" Text="Receive SMS" TabIndex="2" BorderStyle="NotSet"
                                ForeColor="Olive" OnClick="btnReceiveSMS_Click" />
                        </td>
                    </tr>
                </table>
               
            </form>
        </div>
    </div>
</body>
</html>
