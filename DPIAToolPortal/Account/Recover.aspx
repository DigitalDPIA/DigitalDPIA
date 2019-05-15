<%@ Page Title="Password recovery" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Recover.aspx.vb" Inherits="InformationSharingPortal.Recover" %>

<asp:Content ID="Content3" ContentPlaceHolderID="PageContent" runat="server">
 
     <script src="../Scripts/bsasper.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //Lets do bootstrap form validation:
            
            $("input, textarea").bsasper({
                placement: "right", createContent: function (errors) {
                    return '<span class="text-danger">' + errors[0] + '</span>';
                }
            });
        });
</script>
     <div class="login-page access-page has-full-screen-bg">
        <div class="upper-wrapper">
            <section class="login-section access-section section">
                <div class="container">
                    <div class="row">
                        <div class="form-box col-md-offset-2 col-sm-offset-0 xs-offset-0 col-xs-12 col-md-8">
                            <div class="form-box-inner">
                                 <h2 class="title text-center">Password Reset</h2>
                                <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Always" ChildrenAsTriggers="true" runat="server"><ContentTemplate>
<asp:PasswordRecovery RenderOuterTable="false" ID="pwRecovery" runat="server" SubmitButtonStyle-CssClass="btn btn-block btn-cta-primary" UserNameLabelText="E-mail address:"  InstructionTextStyle-CssClass="hidden" UserNameInstructionText="Enter your E-mail address to reset your password." LabelStyle-CssClass="control-label col-xs-3" TextBoxStyle-CssClass="form-control" MailDefinition-From="admin@dpiatool.org.uk" MailDefinition-Subject="Data Protection Impact Assessment Tool Password Reset" MailDefinition-BodyFileName="~/emailtemplates/passwordrecovery.txt" MailDefinition-IsBodyHtml="true" TitleTextStyle-CssClass="hidden"></asp:PasswordRecovery>
                                    </ContentTemplate></asp:UpdatePanel>
                                </div>
                            </div></div></div></section></div></div>
</asp:Content>
