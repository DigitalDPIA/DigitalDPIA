<%@ Page Title="Log in" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.vb" Inherits="InformationSharingPortal.Login" %>

<%--<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>--%>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="PageContent">
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

                                <asp:MultiView ID="mvLogin" runat="server" ActiveViewIndex="0">
                                    <asp:View ID="vLogin" runat="server">
                                        <h2 class="title text-center">Log in to the <%: Session("SiteTitle") %></h2>
                                        <div class="row">
                                            <div class="form-container col-xs-12 col-md-8 col-md-offset-2">
                                                <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Always" ChildrenAsTriggers="true" runat="server"><ContentTemplate>
                                                <asp:Login runat="server" ViewStateMode="Disabled" RenderOuterTable="false" ID="ISSLogin">
                                                    <LayoutTemplate>
                                                        <div class="login-form">
                                                            <p>
                                                                <asp:Literal runat="server" ID="FailureText" />
                                                            </p>
                                                            <div class="form-group email">
                                                                <label class="sr-only" for="login-email">Email address</label>
                                                                <asp:TextBox runat="server" CssClass="form-control" ID="UserName" placeholder="E-mail address" />
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" SetFocusOnError="true" Display="Dynamic" runat="server" ControlToValidate="UserName" CssClass="bg-danger" ErrorMessage="The user name field is required." />
                                                                <asp:RegularExpressionValidator SetFocusOnError="true" runat="server" ID="RegularExpressionValidator1" Display="Dynamic" CssClass="bg-danger"
                                                                    ControlToValidate="UserName" ValidationExpression="(?:[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*|'(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*')@(?:(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"
                                                                    ErrorMessage="Enter a valid email address." />
                                                            </div>
                                                            <!--//form-group-->
                                                            <div class="form-group password">
                                                                <label class="sr-only" for="login-password">Password</label>
                                                                <asp:TextBox runat="server" CssClass="form-control" ID="Password" placeholder="Password" TextMode="Password" />
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" SetFocusOnError="true" runat="server" ControlToValidate="Password" CssClass="bg-danger" Display="Dynamic" ErrorMessage="The password field is required." />
                                                                <p class="forgot-password"><a href="recover">Forgot password?</a></p>
                                                            </div>
                                                            <!--//form-group-->
                                                            <asp:Button ID="btnLogin" runat="server" CommandName="Login" CssClass="btn btn-block btn-cta-primary" Text="Log in" />
                                                             <asp:Panel ID="pnlError" runat="server" cssclass="alert alert-danger alert-dismissible" role="alert" Visible="false">
                               <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
<asp:Label ID="LoginErrorDetails" runat="server" Text=""></asp:Label>
                           </asp:Panel>
                                                            <br />
                                                            <p class="lead">Don't have a Digital DPIA login yet? 
                                                                <a class="signup-link" href="register">Register now</a></p>
                                                        </div>
                                                    </LayoutTemplate>
                                                </asp:Login></ContentTemplate></asp:UpdatePanel>
                                            </div>
                                            <!--//form-container-->
                                            <%--<div class="social-btns col-md-offset-1 col-sm-offset-0 col-sm-offset-0 col-xs-12 col-md-5">  
                                    <div class="divider"><span>Or</span></div>                      
                                    <ul class="list-unstyled social-login">
                                        <li><button class="twitter-btn btn" type="button"><i class="fa fa-twitter"></i>Log in with Twitter</button></li>
                                        <li><button class="facebook-btn btn" type="button"><i class="fa fa-facebook"></i>Log in with Facebook</button></li>
                                        <li><button class="github-btn btn" type="button"><i class="fa fa-github-alt"></i>Log in with Github</button></li>
                                        <li><button class="google-btn btn" type="button"><i class="fa fa-google-plus"></i>Log in with Google</button></li>
                                    </ul>
                                </div><!--//social-btns-->--%>
                                        </div>
                                        <!--//row-->

                                    </asp:View>
                                    <asp:View ID="vSelectRole" runat="server">
                                         <h2 class="title text-center">Select your Organisation</h2>
                                        <div class="row">
                                             <div class="form-container col-xs-12 col-md-8 col-md-offset-2">
                                        <asp:ObjectDataSource ID="dsUserOrgs" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.isporgusersTableAdapters.UserOrgsTableAdapter">
                                            <SelectParameters>
                                                <asp:SessionParameter Name="Email" SessionField="UserEmail" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                                  <div class="login-form">
                                        <p>You are registered as a user at multiple organisations, please select the organisation that you wish to log in to:</p>
                                            <div class="form-horizontal">
                                        <div class="form-group">
                                            
                                                <asp:DropDownList ID="ddSelectOrganisation" CssClass="form-control" runat="server" DataValueField="OrganisationID" DataTextField="OrganisationName" DataSourceID="dsUserOrgs"></asp:DropDownList>
                                         </div>
                                           <div class="form-group">
                                                <asp:Button ID="btnSelect" runat="server" CommandName="SelectOrg" CssClass="btn btn-block btn-cta-primary" Text="Continue" />
                                            
                                        </div></div></div>
                                            </div>
                                            </div>

                                    </asp:View>

                                </asp:MultiView>
                            </div>
                            <!--//form-box-inner-->
                        </div>
                        <!--//form-box-->
                    </div>
                    <!--//row-->
                </div>
                <!--//container-->
            </section>
            <!--//contact-section-->
        </div>
    </div>
    
    <!-- Standard Modal Message  -->
    <div id="modalMessage" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">This is the Data Protection Impact Assessment Tool <strong>Sandpit</strong> Site</h4>
                </div>
                <div class="modal-body">
                    <p>
                        This is intended for evaluation and testing purposes only. Please do not use this site to record data about your organisation's actual business.
                    </p>
                    <p>None of the information stored in this system is intended to be accurate and no action should be taken in reliance on the information found here-in. </p>
                    <p>
                        If you have any queries about the system or would like to try the sandpit system out, please use the Contact tab to submit your query or request.
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
