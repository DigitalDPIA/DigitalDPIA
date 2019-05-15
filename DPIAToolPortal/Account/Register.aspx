<%@ Page Title="Register" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.vb" Inherits="InformationSharingPortal.Register" %>

<%@ Register Assembly="GoogleReCaptcha" Namespace="GoogleReCaptcha" TagPrefix="cc1" %>
<%--<%@ Register TagPrefix="ctrlGoogleReCaptcha" Namespace="Recaptcha" Assembly="Recaptcha" %>--%>

<%--<%@ Register Assembly="Recaptcha.Web" Namespace="Recaptcha.Web.UI.Controls" TagPrefix="cc1" %>--%>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="PageContent">
    <hgroup class="title">
       
       
    </hgroup>
    <script src="../Scripts/bsasper.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //Lets do bootstrap form validation:
            $('input:checkbox').bsasper({
                placement: "left", createContent: function (errors) {
                    return '<span class="text-danger">' + errors[0] + '</span>';
                }
            });
            $("input, textarea").bsasper({
                placement: "right", createContent: function (errors) {
                    return '<span class="text-danger">' + errors[0] + '</span>';
                }
            });
           
        });
        function CheckBoxRequired_ClientValidate(sender, e) {
            e.IsValid = jQuery(".AcceptedAgreement input:checkbox").is(':checked');
        }
</script>
    <div class="signup-page access-page has-full-screen-bg">
    <div class="upper-wrapper">
        <!-- ******HEADER****** -->
       
        
        <!-- ******Signup Section****** --> 
        <section class="signup-section access-section section">
            <div class="container">
                <div class="row">
                    <div class="form-box col-md-offset-2 col-sm-offset-0 xs-offset-0 col-xs-12 col-md-8">     
                        <div class="form-box-inner">
    <asp:CreateUserWizard runat="server" ID="RegisterUser" ViewStateMode="Disabled" CreatingUser="RegisterUser_CreatingUser" OnCreatedUser="RegisterUser_CreatedUser">
        <LayoutTemplate>
            <asp:PlaceHolder runat="server" ID="wizardStepPlaceholder" />
            <asp:PlaceHolder runat="server" ID="navigationPlaceholder" />
        </LayoutTemplate>
        <WizardSteps>
            <asp:CreateUserWizardStep runat="server" ID="RegisterUserWizardStep">
                <ContentTemplate>
                      <h2 class="title text-center">Register a new account</h2>  
                    
                     <%--<script type="text/javascript" src="Scripts/bsasper.js"></script>--%>
        <!--[if lte IE 8]>
        <p class="message-info">
                        Passwords are required to be a minimum of <%: Membership.MinRequiredPasswordLength %> characters in length with at least one symbol and one number.
                    </p>
<![endif]-->
                    <p class="validation-summary-errors">
                        <asp:Literal runat="server" ID="ErrorMessage" />
                    </p>
                    <asp:Panel ID="pnlRegOrgUser" class="alert alert-info" runat="server" Visible="false">
                        To access the Data Protection Impact Assessment Tool under the organisation user roles assigned to you, please complete the following registration details.
                    </asp:Panel>
                    
                    <fieldset class="form-horizontal">
                        
                        <div class="form-group">
                            <asp:Label runat="server" CssClass="sr-only" AssociatedControlID="UserName">Email address:</asp:Label>
                            
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="E-mail address" ID="UserName" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                                    CssClass="bg-danger" Display="Dynamic" ErrorMessage="The e-mail address field is required." SetFocusOnError="True" />
                                <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" Display="Dynamic" CssClass="bg-danger" SetFocusOnError="true"
                                             ControlToValidate="UserName" ValidationExpression="(?:[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*|'(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*')@(?:(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"
                                            ErrorMessage="A valid email address must be provided."  />
                           
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" CssClass="sr-only"  AssociatedControlID="Password">Password:</asp:Label>
                            
                                <asp:TextBox CssClass="form-control" placeholder="Password. Minimum 7 characters with at least 1 symbol, 1 letter and 1 numeral." runat="server" ID="Password" TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" Display="Dynamic"
                                    CssClass="bg-danger" ErrorMessage="The password field is required." SetFocusOnError="True" />
                            
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label1" CssClass="sr-only" runat="server" AssociatedControlID="ConfirmPassword">Confirm password:</asp:Label>
                            
                                <asp:TextBox CssClass="form-control" runat="server" placeholder="Retype password" ID="ConfirmPassword" TextMode="Password" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ConfirmPassword"
                                    CssClass="bg-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." SetFocusOnError="true" />
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                    CssClass="bg-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." SetFocusOnError="True" />
                            
                        </div>
                        <div class="form-group" style="display:none;">
                            <asp:Label runat="server" CssClass="sr-only" AssociatedControlID="Email">Email address:</asp:Label>
                            
                                <asp:TextBox CssClass="form-control" runat="server" ID="Email" TextMode="Email" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email" 
                                    CssClass="bg-danger" ErrorMessage="The email address field is required." SetFocusOnError="True" />
                            
                        </div>
                        <div class="form-group" style="display:none;">
                            <asp:Label ID="lblQuestion" CssClass="control-label col-xs-3" runat="server" AssociatedControlID="Email">Security question:</asp:Label>
                            <div class="col-xs-9">
                                <asp:TextBox CssClass="form-control" runat="server" ID="Question" TextMode="SingleLine" Text="1" />
                                <asp:RequiredFieldValidator ID="rfvQuestion" runat="server" ControlToValidate="Question" Display="Dynamic"
                                    CssClass="bg-danger" ErrorMessage="The security question field is required." SetFocusOnError="True" />
                            </div>
                        </div>
                        <div class="form-group" style="display:none;">
                            <asp:Label ID="lblAnswer" CssClass="control-label col-xs-3" runat="server" AssociatedControlID="Email">Security answer:</asp:Label>
                            <div class="col-xs-9">
                                <asp:TextBox CssClass="form-control" runat="server" ID="Answer" TextMode="SingleLine" Text="2" />
                                <asp:RequiredFieldValidator ID="rfvAnswer" runat="server" ControlToValidate="Answer" Display="Dynamic"
                                    CssClass="bg-danger" ErrorMessage="The security answer field is required." SetFocusOnError="True" />
                            </div>
                            </div>
                            <div class="form-group">
                            <asp:Label ID="Label2" CssClass="sr-only" runat="server" AssociatedControlID="Recaptcha1">Solve Captcha:</asp:Label>
                                <cc1:GoogleReCaptcha ID="Recaptcha1" runat="server" PublicKey="<%$ AppSettings:recaptchaPublicKey %>" PrivateKey="<%$ AppSettings:recaptchaPrivateKey %>" />

                                  <asp:Label ID="CaptchaErrorLabel" runat="server" CssClass="bg-danger" Visible="False"></asp:Label></div>
                            
                            <div class="form-group">
                        
                            <label for="cbConfirm" id="accepttermslabel">
                                <asp:CheckBox ID="cbConfirm" CssClass="AcceptedAgreement" runat="server" />

                                I confirm that I have read and agree to the Data Protection Impact Assessment Tool <a style="cursor:pointer;" data-toggle="modal" data-target="#termsMessage">Terms of Use</a>.
                                <br />
<%--                                <asp:CustomValidator runat="server" ID="CheckBoxRequired" EnableClientScript="true" 
                                        data-val-controltovalidate="MainContent_RegisterUser_CreateUserStepContainer_cbConfirm"  Display="Dynamic" SetFocusOnError="True"
                                    CssClass="bg-danger"
                                    ClientValidationFunction="CheckBoxRequired_ClientValidate" ErrorMessage="You must agree to the Terms of Use." />--%>
                                    <asp:CustomValidator runat="server" ID="CustomValidator1" EnableClientScript="true" SetFocusOnError="True" CssClass="bg-danger"
                                    OnServerValidate="CheckBoxRequired_ServerValidate"
                                    ClientValidationFunction="CheckBoxRequired_ClientValidate" ErrorMessage="You must agree to the Terms of Use." />
                            </label>
                            
                        </div>

                            
                                    <asp:Button runat="server" ID="btnRegister" OnClientClick="CrossPopulateMail()" CommandName="MoveNext" CssClass="btn btn-block btn-cta-primary" Text="Register" />
                                    <asp:Label ID="lblCreateUserError" runat="server" CssClass="bg-danger" Visible="False"></asp:Label>
                                
                    </fieldset>
                </ContentTemplate>
                <CustomNavigationTemplate />
            </asp:CreateUserWizardStep>
        </WizardSteps>
    </asp:CreateUserWizard>

                            </div></div></div></div></section></div></div>
    <script>
        function CrossPopulateMail() {
            var username = document.getElementById("PageContent_RegisterUser_CreateUserStepContainer_UserName");
            var email = document.getElementById("PageContent_RegisterUser_CreateUserStepContainer_Email");
            email.value = username.value;
            return true;
        }


    </script>
</asp:Content>
