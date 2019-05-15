<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Unsubscribe.aspx.vb" Inherits="InformationSharingPortal.Unsubscribe" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Unsubscribe</title>
    <link href="Content/Site.css" rel="stylesheet" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="padding:20%">
    <h2>Unsubscribe from Data Protection Impact Assessment Tool Notifications</h2>
        <asp:MultiView ID="mvUnsub" runat="server" ActiveViewIndex="0">
            <asp:View ID="vUnsubscribe" runat="server"> <p>You have chosen to unsubscribe from Data Protection Impact Assessment Tool e-mail notifications.</p>
        <p>You can unsubscribe from individual notifications using the checkboxes on the In Tray after <a href="/Account/Login.aspx">Logging in</a>.</p>
        <p>If you would prefer not to receive any e-mails from the Data Protection Impact Assessment Tool click <asp:LinkButton ID="lbtUnsubscribe" CssClass="btn btn-danger"  runat="server">Unsubscribe</asp:LinkButton>. </p>
  </asp:View>
            <asp:View ID="vDone" runat="server">
                <p>
                    You have successfully unsubscribed from all Data Protection Impact Assessment Tool e-mail notifications.
                    </p>
                <p>
                    If you wish to reinstate your subscription, please request it using the <a class="btn-link" href="Contact.aspx">Contact page</a>.
                </p>
            </asp:View>
            <asp:View ID="vIsAdmin" runat="server">
                <p>
                   The e-mail address provided cannot unsubscribe.</p>
                <p>
                    The e-mail address provided belongs to an DPIA Super Administrator or Admin Group contact e-mail address. These e-mail addresses cannot unsubscribe. Please contact us using the <a href="Contact.aspx">Contact page</a> to request unsubscription instead.
                </p>
            </asp:View>
            <asp:View ID="vError" runat="server">
                <p>
                    No e-mail address seems to have been provided to unsubscribe.</p>
                <p>
                    Please contact us using the <a href="Contact.aspx">Contact page</a> to request unsubscription instead.
                </p>
            </asp:View>
        </asp:MultiView>
        </div>
    </form>
</body>
</html>
