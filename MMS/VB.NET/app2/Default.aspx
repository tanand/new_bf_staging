<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="tabs">
        <div id="tabs-2">
            <h1 align="center" style="color: Navy; font-size: large">
                Send MMS
            </h1>
            <%--************************************************************************************************************ --%>
            <%-- This table includes the controls which is used for send mms --%>
            <%--************************************************************************************************************ --%>
        </div>
        <table id="tlbSendMMS" runat="server" align="center" width="45%">
            <tr>
                <td>
                    <asp:LinkButton ID="lnkbtnAccessCode" runat="server" OnClick="lnkbtnAccessCode_Click"
                        Text="Fetch&nbsp;Access Token"></asp:LinkButton>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblAccessTokenSMS" runat="server" Text="Access&nbsp;Token&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAccessToken" runat="server" Columns="40" TabIndex="1"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblAddressMMS" runat="server" Text="Address&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAddressMMS" runat="server" TabIndex="2"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="Label1" runat="server" Text="Priority&nbsp;:"></asp:Label>
                </td>
                <td>
                    <select name="priority" tabindex="3">
                        <option selected="selected" value="Default">Default</option>
                        <option value="Low">Low</option>
                        <option value="Normal">Normal</option>
                        <option value="High">High</option>
                    </select>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblSubjectMMS" runat="server" Text="Subject&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtSubjectMMS" runat="server" TabIndex="4"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblAttachmentMMS" runat="server" Text="Attachment&nbsp;:"></asp:Label>
                </td>
                <td>
                    <%-- <asp:FileUpload runat="server" ID="fileUpload" TabIndex="4" />--%>
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                    &nbsp;
                </td>
            </tr>
            <tr align="center" style="font-size: larger">
                <td align="right">
                    <asp:Button ID="btnSendMMS" runat="server" BorderStyle="NotSet" ForeColor="Olive"
                        OnClick="btnSendMMS_Click" TabIndex="6" Text="Send" />
                </td>
                <td align="left">
                    <%--<asp:Button runat="server" ID="btnClear" Text="Clear" TabIndex="6" BorderStyle="NotSet"
                            ForeColor="Olive" OnClick="btnClear_Click" />--%>
                    <input id="Reset11" style="border-style: inherit; color: Olive" tabindex="7" type="reset"
                        value="Reset" />
                </td>
            </tr>
        </table>
        <%--************************************************************************************************************ --%>
        <%-- This table includes the controls which is used for get delivery status of mms --%>
        <%--************************************************************************************************************ --%>
        <h1 align="center" style="color: Navy; font-size: large">
            Get MMS Delivery Status
        </h1>
        <table id="tlbGetMMSDeliveryStatus" runat="server" align="center" width="45%">
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblMMSId" runat="server" Text="Mms Id&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtMmsId" runat="server" TabIndex="1"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblAccTokGetDelStatus" runat="server" Text="Access&nbsp;Token&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAccTokGetDeleStatus" runat="server" Columns="40" TabIndex="2"></asp:TextBox>
                </td>
            </tr>
            <tr align="center" style="font-size: larger">
                <td>
                </td>
                <td align="left">
                    <asp:Button ID="btnStatusMms" runat="server" BorderStyle="NotSet" ForeColor="Olive"
                        OnClick="btnStatusMms_Click" TabIndex="3" Text="Status" />
                </td>
            </tr>
            <tr align="center" style="font-size: larger">
                <td>
                    &nbsp;
                </td>
                <td align="left">
                    &nbsp;
                </td>
            </tr>
            <tr align="center" style="font-size: larger">
                <td colspan="2">
                    <asp:Label ID="lbl_delivery_status" runat="server"></asp:Label>
                </td>
            </tr>
            <tr align="center" style="font-size: larger">
                <td>
                    &nbsp;
                </td>
                <td align="left">
                    &nbsp;
                </td>
            </tr>
        </table>
        <%--************************************************************************************************************ --%>
        <%--Validation --%>
        <%--************************************************************************************************************ --%>
        <%--<asp:RangeValidator ID="RangeValidator3" runat="server" 
                ControlToValidate="txtAddressMMS" EnableClientScript="False" 
                ErrorMessage="Enter your valid address" MaximumValue="9999999999" 
                MinimumValue="7000000000" SetFocusOnError="True" Type="Double"></asp:RangeValidator>
            <asp:CompareValidator ID="CompareValidator3" runat="server" 
                ControlToValidate="txtAddressMMS" 
                ErrorMessage="Please enter your valid address." Operator="DataTypeCheck" 
                SetFocusOnError="True" Type="Double"></asp:CompareValidator>--%>
    </div>
    </form>
</body>
</html>
