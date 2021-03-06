﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Developer Sample .Net Application</title>
    <link rel="stylesheet" href="../../CSS/jquery.ui.all.css" />
    <script src="../../js/jquery-1.5.1.js" type=""></script>
    <script src="../../js/jquery.ui.core.js" type=""></script>
    <script src="../../js/jquery.ui.widget.js" type=""></script>
    <script src="../../js/jquery.ui.tabs.js" type=""></script>
    <link rel="stylesheet" href="../../CSS/demos.css" />
    <script language="JavaScript" src="../../js/gen_validatorv4.js" type="text/javascript"
        xml:space="preserve"></script>
    <script type="">
        $(function () {
            $("#tabs").tabs();
        });
    </script>
</head>
<body>
    <div class="demo">
        <div id="tabs">
            <form id="frmSms" runat="server" method="post" style="font-size: 'larger'">
            <ul class="demo">
                <li><a href="#tabs-2">MMS</a></li>
            </ul>
            <div id="tabs-2">
                <h1 style="color: Navy; font-size: large" align="center">
                    Send MMS
                </h1>
                <%--************************************************************************************************************ --%>                <%-- This table includes the controls which is used for send mms --%>                <%--************************************************************************************************************ --%>
            </div>
            <table width="45%" id="tlbSendMMS" runat="server" align="center">
                <tr>
                    <td>
                <asp:LinkButton runat="server" ID="lnkbtnAccessCode" Text="Fetch Access Token" OnClick="lnkbtnAccessCode_Click"></asp:LinkButton>
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
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblAddressMMS" Text="Address :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAddressMMS" TabIndex="2"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="Label1" Text="Priority :"></asp:Label>
                    </td>
                    <td>
                        <select name="priority" tabindex="3">
                            <option value="Default" selected="selected">Default</option>
                            <option value="Low">Low</option>
                            <option value="Normal">Normal</option>
                            <option value="High">High</option>
                        </select>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblSubjectMMS" Text="Subject :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtSubjectMMS" TabIndex="4"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblAttachmentMMS" Text="Attachment :"></asp:Label>
                    </td>
                    <td>
                        <%-- <asp:FileUpload runat="server" ID="fileUpload" TabIndex="4" />--%>
                        <asp:FileUpload ID="FileUpload1" runat="server" />
                        &nbsp;
                    </td>
                </tr>
                <tr style="font-size: larger" align="center">
                    <td align="right">
                        <asp:Button runat="server" ID="btnSendMMS" Text="Send" TabIndex="6" BorderStyle="NotSet"
                            ForeColor="Olive" OnClick="btnSendMMS_Click" />
                    </td>
                    <td align="left">
                        <%--<asp:Button runat="server" ID="btnClear" Text="Clear" TabIndex="6" BorderStyle="NotSet"
                            ForeColor="Olive" OnClick="btnClear_Click" />--%>
                        <input id="Reset11" type="reset" value="Reset" style="border-style: inherit; color: Olive"
                            tabindex="7" />
                    </td>
                </tr>
            </table>
            <%--************************************************************************************************************ --%>            <%-- This table includes the controls which is used for get delivery status of mms --%>            <%--************************************************************************************************************ --%>
            <h1 style="color: Navy; font-size: large" align="center">
                Get MMS Delivery Status
            </h1>
            <table width="45%" id="tlbGetMMSDeliveryStatus" runat="server" align="center">
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblMMSId" Text="Mms Id :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtMmsId" TabIndex="1"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblAccTokGetDelStatus" Text="Access Token :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAccTokGetDeleStatus" TabIndex="2" Columns="40"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger" align="center">
                    <td>
                    </td>
                    <td align="left">
                        <asp:Button runat="server" ID="btnStatusMms" Text="Status" TabIndex="3" BorderStyle="NotSet"
                            ForeColor="Olive" onclick="btnStatusMms_Click" />
                    </td>
                </tr>
                <tr style="font-size: larger" align="center">
                    <td>
                        &nbsp;</td>
                    <td align="left">
                        &nbsp;</td>
                </tr>
                <tr style="font-size: larger" align="center">
                    <td colspan="2">
                        <asp:Label ID="lbl_delivery_status" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr style="font-size: larger" align="center">
                    <td>
                        &nbsp;</td>
                    <td align="left">
                        &nbsp;</td>
                </tr>
            </table>
            <%--************************************************************************************************************ --%>            <%--Validation --%>            <%--************************************************************************************************************ --%>
            <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="txtAddressMMS"
                EnableClientScript="False" ErrorMessage="Enter your valid address" MaximumValue="9999999999"
                MinimumValue="7000000000" SetFocusOnError="True" Type="Double"></asp:RangeValidator>
            <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="txtAddressMMS"
                ErrorMessage="Please enter your valid address." Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Double"></asp:CompareValidator>
            </form>
        </div>
    </div>
</body>
</html>
