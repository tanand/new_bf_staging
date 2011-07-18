<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Developer Sample .Net Application</title>
    
</head>
<body>
    <div class="demo">
        <div id="tabs">
            <form id="frmTransaction" runat="server" method="post" style="font-size: 'larger'">
            <div id="tabs-4">
                <h1 style="color: Navy; font-size: large" align="center">
                    Payment
                    Transaction</h1>
                <%--************************************************************************************************************ --%>                <%-- This form includes the controls which is used for New single payTransaction --%>                <%--************************************************************************************************************ --%>
            </div>
            <div>
                <asp:LinkButton runat="server" ID="lnkbtnAccessCode" Text="Fetch Access Token" OnClick="lnkbtnAccessCode_Click"></asp:LinkButton>
            </div>
            <table width="45%" id="tlbOpe1" align="center">
                <tr style="font-size: larger">
                    <td>
                        <h1 style="color: Black; font-size: small" align="left">
                            New single Pay Transaction
                        </h1>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblAcesTokNewTrans" Text="Access Token :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAcesTokNewTrans" TabIndex="1" Columns="40"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblAmount" Text="Amount :"></asp:Label>
                    </td>
                    <td style="margin-left: 80px">
                        <asp:TextBox runat="server" ID="txtAmountSPT" TabIndex="2">0.05</asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblCategory" Text="Category :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtCategorySPT" TabIndex="3">1</asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right" class="style1">
                        <asp:Label runat="server" ID="lblChannel" Text="Channel :"></asp:Label>
                    </td>
                    <td class="style1">
                        <asp:TextBox runat="server" ID="txtChannelSPT" TabIndex="4">MOBILE_WEB</asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblCurrency" Text="Currency :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtCurrencySPT" TabIndex="5">USD</asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblDescription" Text="Description :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtDescriptionSPT" TabIndex="6">ProductByMe</asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblTransactionId" Text="TransactionId :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtTransactionIdSPT" TabIndex="7">Transaction151</asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblAppId" Text="App Id :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAppId" TabIndex="8"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblCancelUrl" Text="CancelUrl :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtCancelUrl" TabIndex="9"
                            Width="400px">http://www.desapp.com//payment//Transaction//AOC_Cancelled.aspx</asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblFullfillment" Text="Fullfillment :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFullfillment" TabIndex="10"
                            Width="400px">http://www.desapp.com//payment//Transaction//AOC_Confirmed.aspx</asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblProductId" Text="Product ID :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtProductIdSPT" TabIndex="11">Product252</asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblPurchaseActiveSUb" Text="Purchase On NoActive Subscription :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtPurchaseActiveSUb" TabIndex="12" 
                            Text="false" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblStatusUrl" Text="Status Url :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtStatusUrl" TabIndex="13"
                            Width="400px">http://www.dwestern.com/bf_staging/Payment/Php/Transaction/Status.aspx</asp:TextBox>
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
                        <asp:Button runat="server" ID="btnNewTrns" Text="Submit" TabIndex="14" BorderStyle="NotSet"
                            ForeColor="Olive" OnClick="btnNewTrns_Click" />
                    </td>
                    <td>
                        <input id="Reset4" type="reset" style="border-style: inherit; color: Olive" value="Cancel"
                            tabindex="15" />
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr style="font-size: larger">
                    <td align="center" colspan="2">
                        <asp:Label ID="single_pay_transaction_output" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
            </table>
            <%--************************************************************************************************************ --%>            <%-- This form includes the controls which is used for Get Transaction Status --%>            <%--************************************************************************************************************ --%>
            <table width="45%" id="tlbGetTrnsStatus" align="center">
                <tr style="font-size: larger">
                    <td>
                        <h1 style="color: Black; font-size: small; width: 279px;" align="left">
                            Get Payment Transaction Status
                        </h1>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblTransIdGetPay" Text="Transaction Id :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtTransIdGetPay" TabIndex="2"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblAcceTokGetTrnsStatus" Text="Access Token :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAcceTokGetTrnsStatus" TabIndex="1" Columns="40"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style33" align="right">
                        <asp:Button runat="server" ID="btnGetTrnsStatus" Text="Submit" TabIndex="3" BorderStyle="NotSet"
                            ForeColor="Olive" OnClick="btnGetTrnsStatus_Click" />
                    </td>
                    <td>
                        <input id="Reset5" type="reset" style="border-style: inherit; color: Olive" value="Cancel"
                            tabindex="4" />
                    </td>
                </tr>
                <tr>
                    <td class="style33" align="right">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="style33" align="right">
                        <asp:Label ID="lbl_getpayment_trans_result" runat="server"></asp:Label>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <%--************************************************************************************************************ --%>            <%-- This form includes the controls which is used for Commit Transaction --%>            <%--************************************************************************************************************ --%>
            <table width="45%" id="Table4" align="center">
                <tr style="font-size: larger">
                    <td>
                        <h1 style="color: Black; font-size: small; width: 279px;" align="left">
                            Commit Payment Transaction
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
                        <asp:Label runat="server" ID="lblAcceTokCommitTrans" Text="Access Token :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAcceTokCommitTrans" TabIndex="2" Columns="40"></asp:TextBox>
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
                <tr>
                    <td class="style33" align="right">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="style33" align="right">
                        <asp:Label ID="lbl_commit_payment_trans" runat="server"></asp:Label>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <%--************************************************************************************************************ --%>            <%-- This form includes the controls which is used for Commit Transaction --%>            <%--************************************************************************************************************ --%>
            <table width="45%" id="Table8" align="center">
                <tr style="font-size: larger">
                    <td>
                        <h1 style="color: Black; font-size: small; width: 279px;" align="left">
                            Refund Transaction
                        </h1>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblTransIdrefund" Text="Transaction Id :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtTransIdRefund" TabIndex="1"></asp:TextBox>
                    </td>
                </tr>
                <tr style="font-size: larger">
                    <td align="right">
                        <asp:Label runat="server" ID="lblAccesTokRefTrans" Text="Access Token :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtAccesTokRefTrans" TabIndex="2" Columns="40"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style33" align="right">
                        <asp:Button runat="server" ID="btnRefundTrans" Text="Submit" TabIndex="2" BorderStyle="NotSet"
                            ForeColor="Olive" OnClick="btnRefundTrans_Click" />
                    </td>
                    <td>
                        <input id="Reset10" type="reset" style="border-style: inherit; color: Olive" value="Cancel"
                            tabindex="3" />
                    </td>
                </tr>
                <tr>
                    <td class="style33" align="right">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="style33" align="right">
                        <asp:Label ID="lbl_refund_trans" runat="server"></asp:Label>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            </form>
        </div>
    </div>
</body>
</html>
