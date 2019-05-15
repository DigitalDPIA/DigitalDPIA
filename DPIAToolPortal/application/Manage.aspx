<%@ Page Title="Change Password" Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="Manage.aspx.vb" Inherits="InformationSharingPortal.Manage" %>
<asp:Content ID="Content3" ContentPlaceHolderID="PageHeading" runat="server">
   <h1> <%: Title %></h1>
</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
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
       <section id="passwordForm">
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="message-success"><%: SuccessMessageText %></p>
        </asp:PlaceHolder>

        <p>You're logged in as <strong><%: User.Identity.Name %></strong>.</p>

        <asp:PlaceHolder runat="server" ID="setPassword" Visible="false">
            <p>
                You do not have a local password for this site. Add a local
                password so you can log in without an external login.
            </p>
            <fieldset >
                <legend>Set password form</legend>
                <ol>
                    <li>
                        <asp:Label runat="server" AssociatedControlID="password">Password</asp:Label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="password" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="password"
                            CssClass="bg-danger" ErrorMessage="The password field is required."
                            Display="Dynamic" ValidationGroup="SetPassword" />
                        
                        <asp:ModelErrorMessage runat="server" ModelStateKey="NewPassword" AssociatedControlID="password"
                            CssClass="bg-danger" SetFocusOnError="true" />
                        
                    </li>
                    <li>
                        <asp:Label runat="server" AssociatedControlID="confirmPassword">Confirm password</asp:Label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="confirmPassword" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="confirmPassword"
                            CssClass="bg-danger" Display="Dynamic" ErrorMessage="The confirm password field is required."
                            ValidationGroup="SetPassword" />
                        <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="confirmPassword"
                            CssClass="bg-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match."
                            ValidationGroup="SetPassword" />
                    </li>
                </ol>
                <asp:Button runat="server" Text="Set Password" ValidationGroup="SetPassword" OnClick="setPassword_Click" />
            </fieldset>
        </asp:PlaceHolder>

        <asp:PlaceHolder runat="server" ID="changePassword" Visible="false">
            
            <asp:ChangePassword runat="server" CancelDestinationPageUrl="~/" ViewStateMode="Disabled" RenderOuterTable="false" SuccessPageUrl="Manage?m=ChangePwdSuccess">
                <ChangePasswordTemplate>
                    <div class="panel panel-primary" style="padding:2%;">
                        <h2>Choose a new password</h2>
                    <p class="validation-summary-errors">
                        <asp:Literal runat="server" ID="FailureText" />
                    </p>
                    <fieldset class="form-horizontal">
                        
                        <div class="form-group">
                                <asp:Label runat="server" CssClass="control-label col-xs-2" ID="CurrentPasswordLabel" AssociatedControlID="CurrentPassword">Current password</asp:Label>
                                <div class="col-xs-10"><asp:TextBox CssClass="form-control passwordEntry" runat="server" ID="CurrentPassword"  TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword" Display="Dynamic"
                                    CssClass="bg-danger" ErrorMessage="The current password field is required."
                                    ValidationGroup="ChangePassword" /></div>
                          </div>
                            <div class="form-group">
                                <asp:Label runat="server" CssClass="control-label col-xs-2" ID="NewPasswordLabel" AssociatedControlID="NewPassword">New password</asp:Label>
                                <div class="col-xs-10"><asp:TextBox CssClass="form-control passwordEntry" runat="server" ID="NewPassword"  TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword"
                                    CssClass="bg-danger" ErrorMessage="The new password is required." Display="Dynamic"
                                    ValidationGroup="ChangePassword" /></div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" CssClass="control-label col-xs-2" ID="ConfirmNewPasswordLabel" AssociatedControlID="ConfirmNewPassword">Confirm new password</asp:Label>
                                <div class="col-xs-10"><asp:TextBox CssClass="form-control passwordEntry" runat="server" ID="ConfirmNewPassword"  TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword"
                                    CssClass="bg-danger" Display="Dynamic" ErrorMessage="Confirm new password is required."
                                    ValidationGroup="ChangePassword" />
                                <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                    CssClass="bg-danger" Display="Dynamic" ErrorMessage="The new password and confirmation password do not match."
                                    ValidationGroup="ChangePassword" /></div>
                           </div>
                          <div class="form-group"><div class="col-xs-offset-2 col-xs-10">
                        <asp:Button ID="btnChange" runat="server" cssclass="btn btn-primary" CommandName="ChangePassword" Text="Change password" ValidationGroup="ChangePassword" />
                              </div></div>
                    </fieldset></div>
                </ChangePasswordTemplate>
            </asp:ChangePassword>
        </asp:PlaceHolder>
    </section>
    <!-- Standard Modal Message  -->
<div id="modalMessage" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title"><asp:Label ID="lblModalHeading" runat="server">Manage Account</asp:Label></h4>
            </div>
            <div class="modal-body">
                <p><%: SuccessMessageText %></p>
                
            </div>
            <div class="modal-footer">
                <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary pull-right" CausesValidation="false" runat="server" PostBackUrl="~/application/home_intray.aspx">OK</asp:LinkButton>
            </div>
        </div>
    </div>
</div>
    
</asp:Content>
