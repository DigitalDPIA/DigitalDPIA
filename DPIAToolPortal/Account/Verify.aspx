<%@ Page Title="Verified" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Verify.aspx.vb" Inherits="InformationSharingPortal.Verify" %>

<asp:Content ID="Content3" ContentPlaceHolderID="PageContent" runat="server">
     <div class="login-page access-page has-full-screen-bg">
        <div class="upper-wrapper">
            <section class="login-section access-section section">
                <div class="container">
                    <div class="row">
                         <div class="form-box col-md-offset-2 col-sm-offset-0 xs-offset-0 col-xs-12 col-md-8">
                            <div class="form-box-inner"><h2>
        <asp:Label ID="lblVerifyHead" runat="server" Text="Label"></asp:Label></h2>
    <p class="lead">
        <asp:Label ID="lblVerifyText" runat="server" Text="Label"></asp:Label></p>
        <p>
        <asp:LinkButton CssClass="btn btn-primary btn-lg" ID="btnLogin" runat="server" PostBackUrl="~/Account/Login.aspx?ReturnUrl=%2fapplication%2fhome_intray.aspx">Log in</asp:LinkButton>
            <asp:LinkButton  Visible="false" CssClass="btn btn-primary" ID="btnResend" runat="server">Resend verification e-mail</asp:LinkButton>
            <asp:Label ID="lblOutcome" runat="server" Text="" ForeColor="#CC0000"></asp:Label>
    </p>
        </div>
                            </div></div></div></section></div></div>
</asp:Content>
