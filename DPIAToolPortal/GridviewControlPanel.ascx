<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="GridviewControlPanel.ascx.vb" Inherits="InformationSharingPortal.GridviewControlPanel" %>
<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<script type="text/javascript" language="javascript">
    function ShowHidePopUpControl(popUp) {
        if (!popUp.GetVisible()) 
            popUp.Show();
        else 
            popUp.Hide();
    }
</script>
<dx:ASPxHyperLink ID="hlPopupGVCustomise" runat="server" CssClass="btn btn-default" Text="ASPxHyperLink" EnableClientSideAPI="true" NavigateUrl="javascript:void(0);" OnInit="PopupGVCustomise_Init">
</dx:ASPxHyperLink>
<dx:BootstrapPopupControl ID="bsPopupGVCustomise" CloseAction="CloseButton" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" AllowDragging="true"  runat="server">
    <ContentCollection>
        <dx:ContentControl runat="server">
        </dx:ContentControl>
    </ContentCollection>
</dx:BootstrapPopupControl>
