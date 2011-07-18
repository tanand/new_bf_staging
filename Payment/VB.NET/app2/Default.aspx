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
            <%-- This form includes the controls which is used for New single payTransaction --%>
            <%--************************************************************************************************************ --%>
        </div>
        <div>
            <asp:LinkButton ID="lnkbtnAccessCode" runat="server" OnClick="lnkbtnAccessCode_Click"
                Text="Fetch&nbsp;Access Token"></asp:LinkButton>
        </div>
        <table id="tlbOpe1" align="center" width="45%">
            <tr style="font-size: larger">
                <td>
                    <h1 align="left" style="color: Black; font-size: small">
                        New single Pay Transaction
                    </h1>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblAcesTokNewTrans" runat="server" Text="Access&nbsp;Token&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAcesTokNewTrans" runat="server" Columns="40" TabIndex="1"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblAmount" runat="server" Text="Amount&nbsp;:"></asp:Label>
                </td>
                <td style="margin-left: 80px">
                    <asp:TextBox ID="txtAmountSPT" runat="server" TabIndex="2">0.05</asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblCategory" runat="server" Text="Category&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtCategorySPT" runat="server" TabIndex="3">1</asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right" class="style1">
                    <asp:Label ID="lblChannel" runat="server" Text="Channel&nbsp;:"></asp:Label>
                </td>
                <td class="style1">
                    <asp:TextBox ID="txtChannelSPT" runat="server" TabIndex="4">MOBILE_WEB</asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblCurrency" runat="server" Text="Currency&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtCurrencySPT" runat="server" TabIndex="5">USD</asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblDescription" runat="server" Text="Description&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtDescriptionSPT" runat="server" TabIndex="6">ProductByMe</asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblTransactionId" runat="server" Text="TransactionId&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtTransactionIdSPT" runat="server" TabIndex="7">Transaction151</asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblAppId" runat="server" Text="App Id&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAppId" runat="server" TabIndex="8"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblCancelUrl" runat="server" Text="CancelUrl :"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtCancelUrl" runat="server" TabIndex="9" Width="400px">http://wincode-api-att.com/VBDotNet/payment/Transaction/AOC_Cancelled.aspx</asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblFullfillment" runat="server" Text="Fullfillment&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtFullfillment" runat="server" TabIndex="10" Width="400px">http://wincode-api-att.com/VBDotNet/payment/Subscription/AOC_Confirmed.aspx</asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblProductId" runat="server" Text="Product&nbsp;ID&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtProductIdSPT" runat="server" TabIndex="11">Product252</asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblPurchaseActiveSUb" runat="server" Text="Purchase&nbsp;On&nbsp;NoActive&nbsp;Subscription&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtPurchaseActiveSUb" runat="server" ReadOnly="True" TabIndex="12"
                        Text="false"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblStatusUrl" runat="server" Text="Status Url&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtStatusUrl" runat="server" TabIndex="13" Width="400px">http://wincode-api-att.com/VBDotNet/payment/Subscription/Status.aspx</asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    AutoCommit:
                </td>
                <td>
                    <asp:TextBox ID="txt_auto_commit" runat="server">false</asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Button ID="btnNewTrns" runat="server" BorderStyle="NotSet" ForeColor="Olive"
                        OnClick="btnNewTrns_Click" TabIndex="14" Text="Submit" />
                </td>
                <td>
                    <input id="Reset4" style="border-style: inherit; color: Olive" tabindex="15" type="reset"
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
                <td align="center" colspan="2">
                    <asp:Label ID="single_pay_transaction_output" runat="server"></asp:Label>
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
        </table>
        <%--************************************************************************************************************ --%>
        <%-- This form includes the controls which is used for Get Transaction Status --%>
        <%--************************************************************************************************************ --%>
        <table id="tlbGetTrnsStatus" align="center" width="45%">
            <tr style="font-size: larger">
                <td>
                    <h1 align="left" style="color: Black; font-size: small; width: 279px;">
                        Get Payment Transaction Status
                    </h1>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblTransIdGetPay" runat="server" Text="Transaction&nbsp;Id&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtTransIdGetPay" runat="server" TabIndex="2"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblAcceTokGetTrnsStatus" runat="server" Text="Access&nbsp;Token&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAcceTokGetTrnsStatus" runat="server" Columns="40" TabIndex="1"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" class="style33">
                    <asp:Button ID="btnGetTrnsStatus" runat="server" BorderStyle="NotSet" ForeColor="Olive"
                        OnClick="btnGetTrnsStatus_Click" TabIndex="3" Text="Submit" />
                </td>
                <td>
                    <input id="Reset5" style="border-style: inherit; color: Olive" tabindex="4" type="reset"
                        value="Cancel" />
                </td>
            </tr>
            <tr>
                <td align="right" class="style33">
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="right" class="style33">
                    <asp:Label ID="lbl_getpayment_trans_result" runat="server"></asp:Label>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
        <%--************************************************************************************************************ --%>
        <%-- This form includes the controls which is used for Commit Transaction --%>
        <%--************************************************************************************************************ --%>
        <table id="Table4" align="center" width="45%">
            <tr style="font-size: larger">
                <td>
                    <h1 align="left" style="color: Black; font-size: small; width: 279px;">
                        Commit Payment Transaction
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
                    <asp:Label ID="lblAcceTokCommitTrans" runat="server" Text="Access&nbsp;Token&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAcceTokCommitTrans" runat="server" Columns="40" TabIndex="2"></asp:TextBox>
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
            <tr>
                <td align="right" class="style33">
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="right" class="style33">
                    <asp:Label ID="lbl_commit_payment_trans" runat="server"></asp:Label>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
        <%--************************************************************************************************************ --%>
        <%-- This form includes the controls which is used for Commit Transaction --%>
        <%--************************************************************************************************************ --%>
        <table id="Table8" align="center" width="45%">
            <tr style="font-size: larger">
                <td>
                    <h1 align="left" style="color: Black; font-size: small; width: 279px;">
                        Refund Transaction
                    </h1>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblTransIdrefund" runat="server" Text="Transaction&nbsp;Id&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtTransIdRefund" runat="server" TabIndex="1"></asp:TextBox>
                </td>
            </tr>
            <tr style="font-size: larger">
                <td align="right">
                    <asp:Label ID="lblAccesTokRefTrans" runat="server" Text="Access&nbsp;Token&nbsp;:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAccesTokRefTrans" runat="server" Columns="40" TabIndex="2"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" class="style33">
                    <asp:Button ID="btnRefundTrans" runat="server" BorderStyle="NotSet" ForeColor="Olive"
                        OnClick="btnRefundTrans_Click" TabIndex="2" Text="Submit" />
                </td>
                <td>
                    <input id="Reset10" style="border-style: inherit; color: Olive" tabindex="3" type="reset"
                        value="Cancel" />
                </td>
            </tr>
            <tr>
                <td align="right" class="style33">
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="right" class="style33">
                    <asp:Label ID="lbl_refund_trans" runat="server"></asp:Label>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
