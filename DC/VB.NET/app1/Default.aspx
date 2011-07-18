<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="demo">
        <div id="tabs-5">
            <h1 align="center" style="color: Navy; font-size: large">
                Device Capabilities
            </h1>
            <br />
            <%--************************************************************************************************************ --%>
            <%-- This table includes the controls which is used for Device Information --%>
            <%--************************************************************************************************************ --%>
            <table id="Table4" align="center" width="45%">
                <tr>
                    <td>
                        <asp:LinkButton ID="lnkbtnAccessCode" runat="server" 
                            OnClick="lnkbtnAccessCode_Click" Text="Fetch&nbsp;Access Token"></asp:LinkButton>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label ID="lblAcceTokGetDelStatus" runat="server" 
                            Text="Access&nbsp;Token&nbsp;:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAcceTokGetDelStatus" runat="server" Columns="40" 
                            TabIndex="1"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label ID="lblDeviceId" runat="server" Text="Device&nbsp;Id&nbsp;:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDeviceId" runat="server" TabIndex="2"></asp:TextBox>
                    </td>
                </tr>
                <tr align="center" style="font-size: larger">
                    <td>
                    </td>
                    <td align="left">
                        <asp:Button ID="btnGetDeviceInfo" runat="server" BorderStyle="NotSet" 
                            ForeColor="Olive" OnClick="btnGetDeviceInfo_Click" TabIndex="3" 
                            Text="Device&nbsp;Information" />
                    </td>
                </tr>
                <tr align="center" style="font-size: small">
                    <td align="right" class="style1">
                        <%--<asp:Label runat="server" ID="lblText1" Text="Device Information:" />--%>
                    </td>
                    <td align="left">
                        <asp:Label ID="lbl_device_info_value" runat="server" Text="" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
