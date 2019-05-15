<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="admin_config.aspx.vb" Inherits="InformationSharingPortal.admin_config" %>

<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageHeading" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div id="media" class="tab-pane">
        <ul class="nav nav-tabs">
            <li id="tabICO" runat="server" class="active">
                <asp:LinkButton ID="lbtICO" runat="server">ICO Reg</asp:LinkButton></li>
            <li id="tabMOU" runat="server">
                <asp:LinkButton ID="lbtMOU" runat="server">MOU</asp:LinkButton></li>
             <li id="tabTOU" runat="server">
                <asp:LinkButton ID="lbtTOU" runat="server">Terms of Use</asp:LinkButton></li>
            <li id="tabPrivacy" runat="server">
                <asp:LinkButton ID="lbtPrivacy" runat="server">Privacy</asp:LinkButton></li>
            <li id="tabSecurity" runat="server">
                <asp:LinkButton ID="lbtSecurity" runat="server">Security</asp:LinkButton></li>
        </ul>
    </div>
    <asp:MultiView ID="mvConfig" runat="server" ActiveViewIndex="0">
        <asp:View ID="vICO" runat="server">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>ICO Register Lookup</h4>
                </div>
                <div class="panel-body">
                    <p>Update the ICO register:</p><asp:Panel ID="pnlFileUpload" runat="server" CssClass="input-group">

                                    <span class="input-group-btn">
                                        <span class="btn btn-default btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="true" ID="fupICOCSV" runat="server" />
                                        </span>
                                    </span>
                                    <input type="text" placeholder="Optional (max 1 MB)" class="form-control freeze-on-sign" readonly="true">
                                    <span class="input-group-btn">
                                        <asp:LinkButton ID="lbtUpload" CausesValidation="false" CssClass="btn btn-default" runat="server"><i aria-hidden="true" class="icon-upload2"></i>  Upload</asp:LinkButton>
                                    </span>
                                </asp:Panel>
                    </div>
                 </div>
            </asp:View>
        <asp:View ID="vMOU" runat="server">
            <asp:MultiView ID="mvMOU" runat="server" ActiveViewIndex="0">
        <asp:View ID="vMOUView" runat="server">
             <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>Memorandum of Understanding <small>Last changed: <asp:Label ID="lblMOULastChanged" runat="server" Text="N/A"></asp:Label></small></h4> 
                </div>
         <div class="panel-body">
             Current Wording:
             <div class="well">
                 <asp:Literal ID="litMOUDetail" runat="server"></asp:Literal>
             </div>
             Summary:
  <div class="well">
                 <asp:Literal ID="litMOUSummary" runat="server"></asp:Literal>
             </div>
             <asp:LinkButton ID="lbtUpdateMOU" CssClass="btn btn-primary pull-right" runat="server">Update MOU</asp:LinkButton>
              </div>
          </div>
</asp:View>
        <asp:View ID="vMOUEdit" runat="server">
             <div class="panel panel-primary">
                <div class="panel-heading">
                    <h4>Update MOU</h4> 
                </div>
         <div class="panel-body">
             <asp:Label ID="Label4" CssClass="control-label" AssociatedControlID="htmlMOUDetail" runat="server" Text="Wording:"></asp:Label>
             <dx:ASPxHtmlEditor ID="htmlMOUDetail" runat="server" Width="100%" Height="350px"></dx:ASPxHtmlEditor>
             <asp:Label ID="Label5" CssClass="control-label" AssociatedControlID="htmlMOUSummary" runat="server" Text="Summary:"></asp:Label>
             <dx:ASPxHtmlEditor ID="htmlMOUSummary" runat="server" Width="100%" Height="200px"></dx:ASPxHtmlEditor>
             </div>
                 <div class="panel-footer clearfix">
                     <asp:LinkButton ID="lbtUpdateMOUCancel" CssClass="btn btn-default pull-left" runat="server">Cancel</asp:LinkButton>
                     <asp:LinkButton ID="lbtUpdateMOUConfirm" CssClass="btn btn-primary pull-right" runat="server">Update</asp:LinkButton>
                 </div>
          </div>
        </asp:View>
    </asp:MultiView>
        </asp:View>
<asp:View ID="vTOU" runat="server">
    <asp:MultiView ID="mvTOU" runat="server" ActiveViewIndex="0">
        <asp:View ID="vTOUView" runat="server">
             <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>Terms of Use <small>Last changed: <asp:Label ID="lblLastChanged" runat="server" Text="N/A"></asp:Label></small></h4> 
                </div>
         <div class="panel-body">
             Current Wording:
             <div class="well">
                 <asp:Literal ID="litDetail" runat="server"></asp:Literal>
             </div>
             Summary:
  <div class="well">
                 <asp:Literal ID="litSummary" runat="server"></asp:Literal>
             </div>
             <asp:LinkButton ID="lbtUpdate" CssClass="btn btn-primary pull-right" runat="server">Update Terms of Use</asp:LinkButton>
              </div>
          </div>
</asp:View>
        <asp:View ID="vEditTOU" runat="server">
             <div class="panel panel-primary">
                <div class="panel-heading">
                    <h4>Update Terms of Use</h4> 
                </div>
         <div class="panel-body">
             <asp:Label ID="Label1" CssClass="control-label" AssociatedControlID="htmlDetail" runat="server" Text="Wording:"></asp:Label>
             <dx:ASPxHtmlEditor ID="htmlDetail" runat="server" Width="100%" Height="350px"></dx:ASPxHtmlEditor>
             <asp:Label ID="Label2" CssClass="control-label" AssociatedControlID="htmlSummary" runat="server" Text="Summary:"></asp:Label>
             <dx:ASPxHtmlEditor ID="htmlSummary" runat="server" Width="100%" Height="200px"></dx:ASPxHtmlEditor>
             </div>
                 <div class="panel-footer clearfix">
                     <asp:LinkButton ID="lbtUpdateCancel" CssClass="btn btn-default pull-left" runat="server">Cancel</asp:LinkButton>
                     <asp:LinkButton ID="lbtUpdateConfirm" CssClass="btn btn-primary pull-right" runat="server">Update</asp:LinkButton>
                 </div>
          </div>
        </asp:View>
    </asp:MultiView>
    </asp:View>
        <asp:View ID="vPrivacy" runat="server">
            <asp:MultiView ID="mvPrivacy" runat="server" ActiveViewIndex="0">
        <asp:View ID="vPrivacyView" runat="server">
             <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>Privacy Statement <small>Last changed: <asp:Label ID="lblPrivacyLastChanged" runat="server" Text="N/A"></asp:Label></small></h4> 
                </div>
         <div class="panel-body">
             Current Wording:
             <div class="well">
                 <asp:Literal ID="litPrivacyDetail" runat="server"></asp:Literal>
             </div>
             Summary:
  <div class="well">
                 <asp:Literal ID="litPrivacySummary" runat="server"></asp:Literal>
             </div>
             <asp:LinkButton ID="lbtPrivacyUpdate" CssClass="btn btn-primary pull-right" runat="server">Update Privacy Statement</asp:LinkButton>
              </div>
          </div>
</asp:View>
        <asp:View ID="vPrivacyEdit" runat="server">
             <div class="panel panel-primary">
                <div class="panel-heading">
                    <h4>Update Privacy Statement</h4> 
                </div>
         <div class="panel-body">
             <asp:Label ID="Label6" CssClass="control-label" AssociatedControlID="htmlPrivacyDetail" runat="server" Text="Wording:"></asp:Label>
             <dx:ASPxHtmlEditor ID="htmlPrivacyDetail" runat="server" Width="100%" Height="350px"></dx:ASPxHtmlEditor>
             <asp:Label ID="Label7" CssClass="control-label" AssociatedControlID="htmlPrivacySummary" runat="server" Text="Summary:"></asp:Label>
             <dx:ASPxHtmlEditor ID="htmlPrivacySummary" runat="server" Width="100%" Height="200px"></dx:ASPxHtmlEditor>
             </div>
                 <div class="panel-footer clearfix">
                     <asp:LinkButton ID="lbtPrivacyUpdateCancel" CssClass="btn btn-default pull-left" runat="server">Cancel</asp:LinkButton>
                     <asp:LinkButton ID="lbtPrivacyUpdateConfirm" CssClass="btn btn-primary pull-right" runat="server">Update</asp:LinkButton>
                 </div>
          </div>
        </asp:View>
    </asp:MultiView>
        </asp:View>
        <asp:View ID="vSecurity" runat="server">
            <asp:MultiView ID="mvSecurity" runat="server" ActiveViewIndex="0">
        <asp:View ID="vSecurityView" runat="server">
             <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>Security Statement <small>Last changed: <asp:Label ID="lblSecurityLastChanged" runat="server" Text="N/A"></asp:Label></small></h4> 
                </div>
         <div class="panel-body">
             Current Wording:
             <div class="well">
                 <asp:Literal ID="litSecurityDetail" runat="server"></asp:Literal>
             </div>
             Summary:
  <div class="well">
                 <asp:Literal ID="litSecuritySummary" runat="server"></asp:Literal>
             </div>
             <asp:LinkButton ID="lbtSecurityUpdate" CssClass="btn btn-primary pull-right" runat="server">Update Security Statement</asp:LinkButton>
              </div>
          </div>
</asp:View>
        <asp:View ID="vSecurityEdit" runat="server">
             <div class="panel panel-primary">
                <div class="panel-heading">
                    <h4>Update Security Statement</h4> 
                </div>
         <div class="panel-body">
             <asp:Label ID="Label8" CssClass="control-label" AssociatedControlID="htmlSecurityDetail" runat="server" Text="Wording:"></asp:Label>
             <dx:ASPxHtmlEditor ID="htmlSecurityDetail" runat="server" Width="100%" Height="350px"></dx:ASPxHtmlEditor>
             <asp:Label ID="Label9" CssClass="control-label" AssociatedControlID="htmlSecuritySummary" runat="server" Text="Summary:"></asp:Label>
             <dx:ASPxHtmlEditor ID="htmlSecuritySummary" runat="server" Width="100%" Height="200px"></dx:ASPxHtmlEditor>
             </div>
                 <div class="panel-footer clearfix">
                     <asp:LinkButton ID="lbtSecurityUpdateCancel" CssClass="btn btn-default pull-left" runat="server">Cancel</asp:LinkButton>
                     <asp:LinkButton ID="lbtSecurityUpdateConfirm" CssClass="btn btn-primary pull-right" runat="server">Update</asp:LinkButton>
                 </div>
          </div>
        </asp:View>
    </asp:MultiView>
        </asp:View>
    </asp:MultiView>
    <div id="modalMessage" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">
                        <asp:Label ID="lblModalHeading" runat="server"></asp:Label></h4>
                </div>
                <div class="modal-body">
                    <p>
                        <asp:Label ID="lblModalText" runat="server"></asp:Label>
                    </p>

                </div>
                <div class="modal-footer">
                    <button id="ModalOK" runat="server" type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
