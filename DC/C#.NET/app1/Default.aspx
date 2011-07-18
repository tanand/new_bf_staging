<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default"  %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Developer Sample .Net Application</title>
   
</head>
<body>
    <div class="demo">
        <div id="tabs">
            <form id="frmSms" runat="server" method="post" style="font-size: 'larger'">
            <div id="tabs-5">
                <h1 style="color: Navy; font-size: large" align="center">
                    Device Capabilities
                </h1>
                <br />
                <%--************************************************************************************************************ --%>
                <%-- This table includes the controls which is used for Device Information --%>
                <%--************************************************************************************************************ --%>
                <table width="45%" id="Table4" align="center">
                    <tr>
                        <td>
                            <asp:LinkButton runat="server" ID="lnkbtnAccessCode" Text="Fetch Access Token" OnClick="lnkbtnAccessCode_Click"></asp:LinkButton>
                        </td>
                    </tr>
                    <tr style="font-size: larger">
                        <td align="right">
                            <asp:Label runat="server" ID="lblAcceTokGetDelStatus" Text="Access Token :"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtAcceTokGetDelStatus" TabIndex="1" Columns="40"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="font-size: larger">
                        <td align="right">
                            <asp:Label runat="server" ID="lblDeviceId" Text="Device Id :"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtDeviceId" TabIndex="2"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="font-size: larger" align="center">
                        <td>
                        </td>
                        <td align="left">
                            <asp:Button runat="server" ID="btnGetDeviceInfo" Text="Device Information" TabIndex="3"
                                BorderStyle="NotSet" ForeColor="Olive" OnClick="btnGetDeviceInfo_Click" />
                        </td>
                    </tr>
                </table>
                <%-- --%>
                <table width="45%" id="Table3" align="center">
                    <asp:Panel runat="server" ID="panel1">
                    </asp:Panel>
                </table>
              
            </div>
            </form>
        </div>
    </div>
</body>
</html>
