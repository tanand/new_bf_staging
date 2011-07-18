<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Developer Sample .Net Application</title>
   
    <style type="text/css">
        #tblOne
        {
            width: 54%;
        }
        .style1
        {
            width: 190px;
        }
        #tblTwo
        {
            width: 511px;
        }
        .style2
        {
            width: 193px;
            font-weight: 700;
        }
    </style>
</head>
<body>
    <div class="demo">
        <div id="tabs">
            <form id="frmSms" runat="server" method="post" style="font-size: 'larger'">
            <div id="tabs-1">
                <h1 style="color: Navy; font-size: large" align="center">
                    Send SMS
                </h1>
                <br />
                <asp:LinkButton runat="server" ID="lnkbtnAccessCode" Text="Fetch Access Token" OnClick="lnkbtnAccessCode_Click"></asp:LinkButton>
                <%--************************************************************************************************************ --%>                <%-- This table includes the controls which is used for send sms --%>                <%--************************************************************************************************************ --%>
            </div>
            <table id="tblOne" runat="server" align="center">
                <tr style="font-size: larger">
                    <td align="right" class="style1">
                        <asp:Label runat="server" ID="lblAccessTokenSMS" Text="Access Token :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAccessTokenSMS" TabIndex="1" Columns="40"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right" class="style1">
                        <asp:Label runat="server" ID="lblMsg" Text="Message :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtmsg" TextMode="MultiLine" TabIndex="4"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right" class="style1">
                        <asp:Label runat="server" ID="lblAddressSms" Text="Address :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtmsisdn" TabIndex="2"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger" align="center">
                    <td align="right" class="style1">
                        <asp:Button runat="server" ID="btnSend" Text="Send" TabIndex="5" BorderStyle="NotSet"
                            ForeColor="Olive" OnClick="btnSendSms_Click" />
                    </td>
                    <td align="left">
                        <%--<asp:Button runat="server" ID="btnClear" Text="Clear" TabIndex="6" BorderStyle="NotSet"
                            ForeColor="Olive" OnClick="btnClear_Click" />--%>
                        <input id="Reset1" type="reset" value="Reset" style="border-style: inherit; color: Olive" />
                    </td>
                </tr>
                <tr style="font-size: larger" align="center">
                    <td align="right" class="style1">
                        &nbsp;</td>
                    <td align="left">
                        &nbsp;</td>
                </tr>
            </table>
            <%--************************************************************************************************************ --%>            <%-- This table includes the controls which is used for get delivery status of sms --%>            <%--************************************************************************************************************ --%>
            <h1 style="color: Navy; font-size: large" align="center">
                Get SMS Delivery Status
            </h1>
            <table id="tblTwo" runat="server" align="center">
                <tr style="font-size: larger">
                    <td align="right" class="style2">
                        <asp:Label runat="server" ID="lblSmsId" Text="Sms Id :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtSmsId" TabIndex="1"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right" class="style2">
                        <asp:Label runat="server" ID="lblAcceTokGetDelStatus" Text="Access Token :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAcceTokGetDelStatus" TabIndex="1" Columns="40"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger" align="center">
                    <td class="style2">
                    </td>
                    <td align="left">
                        <asp:Button runat="server" ID="btnGetStatus" Text="Status" TabIndex="2" BorderStyle="NotSet"
                            ForeColor="Olive" OnClick="btnGetDeliveryStatus_Click" />
                    </td>
                </tr>
                <tr style="font-size: larger" align="center">
                    <td class="style2">
                        &nbsp;</td>
                    <td align="left">
                        &nbsp;
                    </td>
                </tr>
            </table>
            <%--************************************************************************************************************ --%>            <%--Validation --%>            <%--************************************************************************************************************ --%>           <%-- <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtmsisdn"
                EnableClientScript="False" ErrorMessage="Enter your valid address." MaximumValue="9999999999"
                MinimumValue="7000000000" SetFocusOnError="True" Type="Double"></asp:RangeValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtmsisdn"
                ErrorMessage="Please enter your valid address." Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Double"></asp:CompareValidator>--%>
            </form>
        </div>
    </div>
</body>
</html>
