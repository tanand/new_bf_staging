<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Developer Sample .Net Application</title>
    </head>
<body>
    <div class="demo">
        <div id="tabs">
            <form id="frmSubscription" runat="server" method="post" style="font-size: 'larger'"
            >
            <div id="tabs-4">
                <h1 style="color: Navy; font-size: large" align="center">
                    Payment
                    Subscription</h1>
                <%--************************************************************************************************************ --%>
                <%-- This form includes the controls which is used for New Subscription --%>
                <%--************************************************************************************************************ --%>
            </div>
            <div>
                <asp:LinkButton runat="server" ID="lnkbtnAccessCode" Text="Fetch Access Token" OnClick="lnkbtnAccessCode_Click"></asp:LinkButton>
            </div>
            <table width="45%" id="Table1" align="center">
                <tr style="font-size: larger">
                    <td>
                        <h1 style="color: Black; font-size: small" align="left">
                            New Subscription
                        </h1>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblAccTokNewSubs" Text="Access Token :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAccTokNewSubs" TabIndex="1" Columns="40"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblAmountNS" Text="Amount :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAmountNS" TabIndex="2"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblCategoryNS" Text="Category :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtCategoryNS" TabIndex="3"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right" class="style1">
                        <asp:Label runat="server" ID="lblChannelNS" Text="Channel :"></asp:Label>
                    </td>
                    <td class="style1">
                        <asp:TextBox runat="server" ID="txtChannelNS" TabIndex="4"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblCurrencyNS" Text="Currency :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtCurrencyNS" TabIndex="5"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblDescriptionNS" Text="Description :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtDescriptionNS" TabIndex="6"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblExtMerTransIdNS" Text="Transaction Id :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtExtMerTransIdNS" TabIndex="7"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblAppId" Text="App ID :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAppId" TabIndex="8"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblCancelRedirectUrl" Text="Cancel Redirect Url :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtCancelRedirectUrl" TabIndex="9" Text="http://localhost:8080/Transaction/index.jsp?action=UserCancelled"
                            Width="400px"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblFullfillmentUrl" Text="Fullfillment Url :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFullfillmentUrl" TabIndex="10" Text="http://localhost:8080/Transaction/index.jsp?action=UserConfirmed"
                            Width="400px"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblProductIdNS" Text="Product ID :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtProductIdNS" TabIndex="11"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblPurcActSubsNS" Text="Purchase On No Active Subscription :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtPurcActSubsNS" TabIndex="13" Text="false"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblSatusUrl" Text="Status Url :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtStatusUrl" TabIndex="10" Text="http://localhost:8080/Transaction/index.jsp?action=Status"
                            Width="400px"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblMerSubsIdListNS" Text="Merchant Subscription Id List :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtMerSubsIdListNS" TabIndex="13"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblSubsRecuNumberNS" Text="Subscription Recurring Number :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtSubsRecuNumberNS" TabIndex="10"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblSubsRecPeriodNS" Text="Subscription Recurring Period :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtSubsRecPeriodNS" TabIndex="11"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblSubsRecPeriodAmtNS" Text="Subscription Recurring Period Amount :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtSubsRecPeriodAmtNS" TabIndex="12"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        Auto Commit:
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtautocommit" TabIndex="12">False</asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Button runat="server" ID="btnNewSubscription" Text="Submit" TabIndex="15" BorderStyle="NotSet"
                            ForeColor="Olive" OnClick="btnNewSubscription_Click" />
                    </td>
                    <td>
                        <input id="Reset3" type="reset" style="border-style: inherit; color: Olive" value="Cancel"
                            tabindex="16" />
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
            <table width="45%" id="Table7" align="center">
                <tr style="font-size: larger">
                    <td>
                        <h1 style="color: Black; font-size: small; width: 234px;" align="left">
                            Subscription Details
                        </h1>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblSubscriptionId" Text="Subscription Id :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtSubscriptionId" TabIndex="1"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblAccTokSubsDet" Text="Access Token :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAccTokSubsDet" TabIndex="2" Columns="40"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style33" align="right">
                        <asp:Button runat="server" ID="btnSubscripDet" Text="Submit" TabIndex="3" BorderStyle="NotSet"
                            ForeColor="Olive" OnClick="btnSubscripDet_Click" />
                    </td>
                    <td>
                        <input id="Reset9" type="reset" style="border-style: inherit; color: Olive" value="Cancel"
                            tabindex="4" />
                    </td>
                </tr>
            </table>
            <%--</form>--%>
            <%--************************************************************************************************************ --%>
            <%-- This form includes the controls which is used for Commit Transaction --%>
            <%--************************************************************************************************************ --%>
            <%--<form id="frmCommitTransaction" name="frmCommitTransaction" method="get" action=""
            runat="server">--%>
            <table width="45%" id="Table4" align="center">
                <tr style="font-size: larger">
                    <td>
                        <h1 style="color: Black; font-size: small; width: 235px;" align="left">
                            Commit Transaction
                        </h1>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblTransIdCommitPay" Text="Transaction Id :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtTransIdCommitPay" TabIndex="1"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblAcceTokCommitTrns" Text="Access Token :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAcceTokCommitTrns" TabIndex="2" Columns="40"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style33" align="right">
                        <asp:Button runat="server" ID="btnCommitTrans" Text="Submit" TabIndex="3" BorderStyle="NotSet"
                            ForeColor="Olive" OnClick="btnCommitTrans_Click" />
                    </td>
                    <td>
                        <input id="Reset6" type="reset" style="border-style: inherit; color: Olive" value="Cancel"
                            tabindex="4" />
                    </td>
                </tr>
            </table>
            </form>
        </div>
    </div>
</body>
</html>
