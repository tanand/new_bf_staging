<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <div class="demo">
        <form id="frmSms" runat="server" method="post" style="font-size: 'larger'">
        <div id="tabs-1">
            <br />
            <h1 align="center" style="color: Navy; font-size: large">
                Receive SMS
            </h1>
        </div>
        <div>
            <asp:LinkButton ID="lnkbtnAccessCode" runat="server" OnClick="lnkbtnAccessCode_Click"
                Text="Fetch&nbsp;Access Token"></asp:LinkButton>
            <%--************************************************************************************************************ --%>
            <%-- This table includes the controls which is used for send sms --%>
            <%--************************************************************************************************************ --%>
        </div>
        <table id="tlbSendMMS" runat="server" align="center" width="45%">
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblAccessTokenSMS" runat="server" Text="Access&nbsp;Token&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAccessToken" runat="server" Columns="40" TabIndex="1"></asp:TextBox>
                </td>
            </tr>
            <tr align="center" style="font-size: larger">
                <td align="right">
                    <asp:Button ID="btnReceiveSMS" runat="server" BorderStyle="NotSet" ForeColor="Olive"
                        OnClick="btnReceiveSMS_Click" TabIndex="2" Text="Receive&nbsp;SMS" />
                </td>
            </tr>
            <tr align="center" style="font-size: larger">
                <td align="right" class="style1">
                    <asp:Label ID="lblText1" runat="server" Text="" />
                </td>
                <td align="left">
                    <asp:Label ID="lbl_sms_id_value" runat="server" Text="" />
                </td>
            </tr>
        </table>
        </form>
    </div>
</body>
</html>
