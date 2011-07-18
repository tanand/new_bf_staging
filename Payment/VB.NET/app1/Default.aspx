<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="tabs">
        <div id="tabs-4">
            <h1 align="center" style="color: Navy; font-size: large">
                Payment
            </h1>
            <%--************************************************************************************************************ --%>
            <%-- This form includes the controls which is used for New Subscription --%>
            <%--************************************************************************************************************ --%>
        </div>
        <div>
            <asp:LinkButton ID="lnkbtnAccessCode" runat="server" OnClick="lnkbtnAccessCode_Click"
                Text="Fetch&nbsp;Access Token"></asp:LinkButton>
        </div>
        <table id="Table1" align="center" width="45%">
            <tr style="font-size: larger">
                <td>
                    <h1 align="left" style="color: Black; font-size: small">
                        New Subscription
                    </h1>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblAccTokNewSubs" runat="server" Text="Access&nbsp;Token&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAccTokNewSubs" runat="server" Columns="40" TabIndex="1"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblAmountNS" runat="server" Text="Amount&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAmountNS" runat="server" TabIndex="2" Text="0.05"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblCategoryNS" runat="server" Text="Category&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtCategoryNS" runat="server" TabIndex="3" Text="1"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right" class="style1">
                    <asp:Label ID="lblChannelNS" runat="server" Text="Channel&nbsp;:"></asp:Label>
                </td>
                <td class="style1">
                    <asp:TextBox ID="txtChannelNS" runat="server" TabIndex="4" Text="MOBILE_WEB"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblCurrencyNS" runat="server" Text="Currency&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtCurrencyNS" runat="server" TabIndex="5" Text="USD"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblDescriptionNS" runat="server" Text="Description&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtDescriptionNS" runat="server" TabIndex="6" Text="ProductByMe"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblExtMerTransIdNS" runat="server" Text="Transaction&nbsp;Id&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtExtMerTransIdNS" runat="server" TabIndex="7" Text="Transaction151"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblAppId" runat="server" Text="App&nbsp;ID&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAppId" runat="server" TabIndex="8" ></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblCancelRedirectUrl" runat="server" Text="Cancel&nbsp;Redirect&nbsp;Url&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtCancelRedirectUrl" runat="server" TabIndex="9" Text="http://wincode-api-att.com/VBDotNet/payment/Subscription/AOC_Cancelled.aspx"
                        Width="400px"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblFullfillmentUrl" runat="server" Text="Fullfillment&nbsp;Url&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtFullfillmentUrl" runat="server" TabIndex="10" Text="http://wincode-api-att.com/VBDotNet/payment/Subscription/AOC_Confirmed.aspx"
                        Width="400px"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblProductIdNS" runat="server" Text="Product&nbsp;ID&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtProductIdNS" runat="server" TabIndex="11" Text="Product252"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblPurcActSubsNS" runat="server" Text="Purchase&nbsp;On&nbsp;No&nbsp;Active&nbsp;Subscription&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtPurcActSubsNS" runat="server" TabIndex="13" Text="false"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblSatusUrl" runat="server" Text="Status Url&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtStatusUrl" runat="server" TabIndex="10" Text="http://wincode-api-att.com/VBDotNet/payment/Subscription/Status.aspx"
                        Width="400px"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblMerSubsIdListNS" runat="server" Text="Merchant&nbsp;Subscription&nbsp;Id&nbsp;List&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtMerSubsIdListNS" runat="server" TabIndex="13" Text="MySubscription3"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblSubsRecuNumberNS" runat="server" Text="Subscription&nbsp;Recurring&nbsp;Number&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtSubsRecuNumberNS" runat="server" TabIndex="10" Text="3"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblSubsRecPeriodNS" runat="server" Text="Subscription&nbsp;Recurring&nbsp;Period&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtSubsRecPeriodNS" runat="server" TabIndex="11" Text="MONTHLY"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblSubsRecPeriodAmtNS" runat="server" Text="Subscription&nbsp;Recurring&nbsp;Period&nbsp;Amount&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtSubsRecPeriodAmtNS" runat="server" TabIndex="12" Text="1"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    Auto Commit:
                </td>
                <td>
                    <asp:TextBox ID="txtautocommit" runat="server" TabIndex="12">False</asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Button ID="btnNewSubscription" runat="server" BorderStyle="NotSet" ForeColor="Olive"
                        OnClick="btnNewSubscription_Click" TabIndex="15" Text="Submit" />
                </td>
                <td>
                    <input id="Reset3" style="border-style: inherit; color: Olive" tabindex="16" type="reset"
                        value="Cancel" />
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="left" colspan="2">
                    &nbsp;
                </td>
            </tr>
        </table>
        <%--/<form>--%>
        <%--************************************************************************************************************ --%>
        <%-- This form includes the controls which is used for Subscription Details --%>
        <%--************************************************************************************************************ --%>
        <%--<form id="frmSubscritioDetails" name="frmSubscritioDetails" method="get" action=""
            runat="server">--%>
        <table id="Table7" align="center" width="45%">
            <tr style="font-size: larger">
                <td>
                    <h1 align="left" style="color: Black; font-size: small; width: 234px;">
                        Subscription Details
                    </h1>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblSubscriptionId" runat="server" Text="Subscription&nbsp;Id&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtSubscriptionId" runat="server" TabIndex="1"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblAccTokSubsDet" runat="server" Text="Access&nbsp;Token&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAccTokSubsDet" runat="server" Columns="40" TabIndex="2"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" class="style33">
                    <asp:Button ID="btnSubscripDet" runat="server" BorderStyle="NotSet" ForeColor="Olive"
                        OnClick="btnSubscripDet_Click" TabIndex="3" Text="Submit" />
                </td>
                <td>
                    <input id="Reset9" style="border-style: inherit; color: Olive" tabindex="4" type="reset"
                        value="Cancel" />
                </td>
            </tr>
        </table>
        <%--</form>--%>
        <%--************************************************************************************************************ --%>
        <%-- This form includes the controls which is used for Commit Transaction --%>
        <%--************************************************************************************************************ --%>
        <%--<form id="frmCommitTransaction" name="frmCommitTransaction" method="get" action=""
            runat="server">--%>
        <table id="Table4" align="center" width="45%">
            <tr style="font-size: larger">
                <td>
                    <h1 align="left" style="color: Black; font-size: small; width: 235px;">
                        Commit Transaction
                    </h1>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblTransIdCommitPay" runat="server" Text="Transaction&nbsp;Id&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtTransIdCommitPay" runat="server" TabIndex="1"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblAcceTokCommitTrns" runat="server" Text="Access&nbsp;Token&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAcceTokCommitTrns" runat="server" Columns="40" TabIndex="2"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" class="style33">
                    <asp:Button ID="btnCommitTrans" runat="server" BorderStyle="NotSet" ForeColor="Olive"
                        OnClick="btnCommitTrans_Click" TabIndex="3" Text="Submit" />
                </td>
                <td>
                    <input id="Reset6" style="border-style: inherit; color: Olive" tabindex="4" type="reset"
                        value="Cancel" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
