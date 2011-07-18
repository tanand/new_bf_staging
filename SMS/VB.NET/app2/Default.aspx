<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="demo">
        <div id="tabs-1">
            <br />
            <h1 align="center" style="color: Navy; font-size: large">
                Send SMS
            </h1>
            <br />
            <asp:LinkButton ID="lnkbtnAccessCode" runat="server" 
                OnClick="lnkbtnAccessCode_Click" Text="Fetch&nbsp;Access Token"></asp:LinkButton>
            <%--************************************************************************************************************ --%>
            <%-- This table includes the controls which is used for send sms --%>
            <%--************************************************************************************************************ --%>
        </div>
        <table id="tblOne" runat="server" align="center">
            <tr style="font-size: larger">
                <td align="right" class="style1">
                    <asp:Label ID="lblAccessTokenSMS" runat="server" 
                        Text="Access&nbsp;Token&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAccessTokenSMS" runat="server" Columns="40" TabIndex="1"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right" class="style1">
                    <asp:Label ID="lblMsg" runat="server" Text="Message&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtmsg" runat="server" TabIndex="4" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right" class="style1">
                    <asp:Label ID="lblAddressSms" runat="server" Text="Address&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtmsisdn" runat="server" TabIndex="2"></asp:TextBox>
                </td>
            </tr>
            <tr align="center" style="font-size: larger">
                <td align="right" class="style1">
                    <asp:Button ID="btnSend" runat="server" BorderStyle="NotSet" ForeColor="Olive" 
                        OnClick="btnSend_Click" TabIndex="5" Text="Send" />
                </td>
                <td align="left">
                    <%--<asp:Button runat="server" ID="btnClear" Text="Clear" TabIndex="6" BorderStyle="NotSet"
                            ForeColor="Olive" OnClick="btnClear_Click" />--%>
                    <input id="Reset1" style="border-style: inherit; color: Olive" type="reset" 
                        value="Reset" />
                </td>
            </tr>
            <tr align="center" style="font-size: larger">
                <td align="right" class="style1">
                    <asp:Label ID="lblSMSID" runat="server" Text="" />
                </td>
                <td align="left">
                    <asp:Label ID="lbl_sms_id_value" runat="server" Text="" />
                </td>
            </tr>
        </table>
        <%--************************************************************************************************************ --%>
        <%-- This table includes the controls which is used for get delivery status of sms --%>
        <%--************************************************************************************************************ --%>
        <h1 align="center" style="color: Navy; font-size: large">
            Get SMS Delivery Status
        </h1>
        <table id="tblTwo" runat="server" align="center">
            <tr style="font-size: larger">
                <td align="right" class="style2">
                    <asp:Label ID="lblDeliverySmsId" runat="server" Text="Sms Id&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtSmsId" runat="server" TabIndex="1"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right" class="style2">
                    <asp:Label ID="lblAcceTokGetDelStatus" runat="server" 
                        Text="Access&nbsp;Token&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAcceTokGetDelStatus" runat="server" Columns="40" 
                        TabIndex="1"></asp:TextBox>
                </td>
            </tr>
            <tr align="center" style="font-size: larger">
                <td class="style2">
                </td>
                <td align="left">
                    <asp:Button ID="btnGetStatus" runat="server" BorderStyle="NotSet" 
                        ForeColor="Olive" OnClick="btnGetStatus_Click" TabIndex="2" Text="Status" />
                </td>
            </tr>
            <tr align="center" style="font-size: larger">
                <td class="style2">
                    <asp:Label ID="lbl_delivery_status" runat="server" Text=""></asp:Label>
                </td>
                <td align="left">
                    &nbsp;
                </td>
            </tr>
        </table>
        <%--************************************************************************************************************ --%>
        <%--Validation --%>
        <%--************************************************************************************************************ --%>
        <%-- <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtmsisdn"
                EnableClientScript="False" ErrorMessage="Enter your valid address." MaximumValue="9999999999"
                MinimumValue="7000000000" SetFocusOnError="True" Type="Double"></asp:RangeValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtmsisdn"
                ErrorMessage="Please enter your valid address." Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Double"></asp:CompareValidator>--%>
        </div>
    </form>
</body>
</html>
