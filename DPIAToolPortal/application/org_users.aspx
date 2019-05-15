<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="org_users.aspx.vb" Inherits="InformationSharingPortal.org_users" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Src="~/GridviewControlPanel.ascx" TagPrefix="uc1" TagName="GridviewControlPanel" %>
<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content3" ContentPlaceHolderID="PageHeading" runat="server">
    <link href="../Content/bootstrap-multiselect.css" rel="stylesheet" />
    <h1>Organisation Users</h1>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../Scripts/bsasper.js"></script>
    <script src="../Scripts/bs.pagination.js"></script>
    <script src="../Scripts/bootstrap/bootstrap-multiselect.js"></script>
    <script type="text/javascript">
        function BindEvents() {
            $(document).ready(function () {
                $('.bs-pagination td table').each(function (index, obj) {
                    convertToPagination(obj)
                });
                $('.multiselect').multiselect();
                $('[data-toggle="popover"]').popover();
                //$('.bsvalidate').bsasper(); 
                //Lets do bootstrap form validation:
                $("input, textarea").bsasper({
                    placement: "right", createContent: function (errors) {
                        return '<span class="text-danger">' + errors[0] + '</span>';
                    }
                });
            });
        };
    </script>
    <asp:ObjectDataSource ID="dsOrgUserRoles" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.isporgusersTableAdapters.isp_OrganisationUsersSummaryTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="OrganisationID" SessionField="UserOrganisationID" Type="Int32" />
            <asp:ControlParameter ControlID="cbIncludeArchived" Name="IncludeInactive" PropertyName="Checked" Type="Boolean" />
        </SelectParameters>

    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsRoles" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_RolesTableAdapter"></asp:ObjectDataSource>

    <asp:MultiView ID="mvOrgUsers" runat="server" ActiveViewIndex="0">
        <asp:View ID="vUserGrid" runat="server">
            <div id="divUserLimitReached" runat="server" class="alert alert-danger alert-dismissable" visible="false" role="alert">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <asp:Label ID="Label14" runat="server" Text="Label">Organisations accessing under a "free" DPIA licence are limited to 3 organisation users. Since you have reached this limit, you will not be able to add any more users. To discuss licencing options for your organisation please contact <a href='mailto:isg@mbhci.nhs.uk'>isg@mbhci.nhs.uk</a>.</asp:Label>
            </div>
            <div class="clearfix">
             <h3><asp:CheckBox ID="cbIncludeArchived" AutoPostBack="true" CssClass="pull-right no-bold-label small" Font-Bold="false" runat="server" Text=" Include Inactive" /></h3>
            </div>
            <div class="table-responsive">
                <dx:ASPxGridViewExporter ID="OrgUserGridViewExporter" GridViewID="bsgvOrgUsers" FileName="ISGOrganisationUsersExport" runat="server"></dx:ASPxGridViewExporter>
                <dx:BootstrapGridView ID="bsgvOrgUsers" CssClasses-Table="table table-striped" runat="server" AutoGenerateColumns="False" DataSourceID="dsOrgUserRoles" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick" SettingsCustomizationDialog-Enabled="true">
        <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                     <CssClasses Table="table table-striped" />
                        <SettingsPager PageSize="15"/>
                         <Settings ShowHeaderFilterButton="True" />
                        <SettingsCookies Enabled="True" Version="0.112" StoreSearchPanelFiltering="False" StorePaging="False" />
                    <Columns>
                        <dx:BootstrapGridViewTextColumn Name="Edit" ShowInCustomizationDialog="False" VisibleIndex="0">
                            <DataItemTemplate>
                                   <asp:LinkButton ID="LinkButton1" visible='<%# Session("UserRoleAdmin") %>' EnableViewState="false" CssClass="button-small btn btn-default" runat="server" CausesValidation="False" ToolTip="Edit" CommandArgument='<%# Eval("OrganisationUserEmail") %>' OnCommand="EditUser_Click"><i aria-hidden="true" class="icon-pencil"></i><!--[if lt IE 8]>Edit<![endif]--></asp:LinkButton>
                         
                            </DataItemTemplate>
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn Caption="Name" FieldName="OrganisationUserName" Name="Name" VisibleIndex="1">
                            <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn Caption="Email" FieldName="OrganisationUserEmail" Name="Email" VisibleIndex="2">
                            <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="Roles" Name="Roles" Caption="Roles" ReadOnly="True" VisibleIndex="3">
                            <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" Name="Active" Caption="Active" ReadOnly="True" VisibleIndex="4">
                            <Settings AllowHeaderFilter="False" />
                        </dx:BootstrapGridViewCheckColumn>
                        <dx:BootstrapGridViewCheckColumn Caption="Verified" FieldName="Confirmed" Name="Verified" ReadOnly="True" VisibleIndex="5">
                        </dx:BootstrapGridViewCheckColumn>
                         <dx:BootstrapGridViewTextColumn FieldName="LastAccess" Caption="Last Access" Name="Last Access" VisibleIndex="6">
                            <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">
                            </PropertiesTextEdit>
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn Caption="Resend" ShowInCustomizationDialog="False" Name="Resend" VisibleIndex="7">
                            <DataItemTemplate>
                                     <asp:LinkButton CausesValidation="false"  ID="lbtResend" CssClass="btn btn-info btn-sm" ToolTip="Resend Invite" OnCommand="ResendInvite_Click" Visible='<%# Eval("Confirmed").ToString() = "False" And Session("UserRoleAdmin") %>' CommandArgument='<%# Eval("OrganisationUserEmail")%>' runat="server"><i aria-hidden="true" class="glyphicon glyphicon-envelope"></i><!--[if lt IE 8]>Resend<![endif]--></asp:LinkButton>
                            </DataItemTemplate>
                        </dx:BootstrapGridViewTextColumn>
                    </Columns>
                    <Toolbars>
        <dx:BootstrapGridViewToolbar>
            <Items>
                <dx:BootstrapGridViewToolbarItem Command="ClearFilter" IconCssClass="glyphicon glyphicon-remove" Text="Clear filters" />
                <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" Text="Customise Grid" IconCssClass="glyphicon glyphicon-list-alt" />
                <dx:BootstrapGridViewToolbarItem Command="Custom" Name="Export" CssClass="btn btn-success" Text ="Export to Excel" IconCssClass="icon-file-excel" ToolTip="Export grid to Excel"/>
            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>
                    <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
                </dx:BootstrapGridView>
             
            </div>
            <asp:Panel ID="pnlNoDPO" CssClass="panel panel-danger" runat="server">
                <div class="panel-heading">Data Protection Officer Role Not Yet Assigned</div>
                <div class="panel-body">
                    <p>Noboby in this organisation has yet had the DPO role assigned. Please add your DPO to your list of organisation users at the earliest opportunity.</p>
                    <p>As of May 2018 all data flows involving the transfer of personal data will need reviewing by a DPO prior to being finalised.</p>
                    <p>If you think your organisation may be exempt from requiring a DPO, please <button type="button" class="btn btn-default" data-toggle="modal" data-target="#modalDPOExempt">
  click here
</button>.</p>
                </div>
            </asp:Panel>
            <asp:LinkButton ID="lbtAdd" CssClass="btn btn-primary pull-right" runat="server"><i aria-hidden="true" class="icon-user-add"></i> Add Organisation User</asp:LinkButton>

        </asp:View>
        <asp:View ID="vEditUser" runat="server">


            <div class="panel panel-primary" style="padding: 2%;">
                <h2>Edit Organisation User</h2>
                <fieldset class="form-horizontal">
                    <div class="form-group">
                        <asp:Label ID="Label1" CssClass="control-label col-xs-2" runat="server" AssociatedControlID="tbOrganisationUserNameEdit">Full Name:</asp:Label>

                        <div class="col-xs-10">
                            <asp:TextBox ID="tbOrganisationUserNameEdit" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required" ControlToValidate="tbOrganisationUserNameEdit" Text="*"></asp:RequiredFieldValidator>
                            <div class="alert alert-warning">
                                <p><b>Warning:</b> All records with a matching e-mail address will be updated if you edit the user's name. Only include the user's name, not their job title or other info.</p>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label4" CssClass="control-label col-xs-2" runat="server" AssociatedControlID="tbOrganisationUserEmailEdit">Email:</asp:Label>

                        <div class="col-xs-10">
                            <asp:TextBox ID="tbOrganisationUserEmailEdit" CssClass="form-control" runat="server" Enabled="False" />
                            <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required" ControlToValidate="tbOrganisationUserEmailEdit" Text="*"></asp:RequiredFieldValidator>

                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label6" CssClass="control-label col-xs-2" runat="server" Text="Label" AssociatedControlID="listRolesEdit">Roles:</asp:Label>
                        <div class="col-xs-10">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <a tabindex="0" title="User Roles per Organisation" class="btn btn-default" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="You may identify up to 5 individuals in the role of Senior Officer.<br/><br/>You may identify any number of users in any other role."><i aria-hidden="true" class="icon-info"></i></a>
                                </div>
                                <asp:ListBox ID="listRolesEdit" runat="server" DataTextField="Role" DataValueField="RoleID" SelectionMode="Multiple" ClientIDMode="Static" CssClass="multiselect" ViewStateMode="Enabled"></asp:ListBox>
                            </div>

                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label9" CssClass="control-label col-xs-2" runat="server" Text="Label" AssociatedControlID="cbActiveEdit">Active:</asp:Label>
                        <div class="col-xs-10">
                            <asp:CheckBox ID="cbActiveEdit" runat="server" />
                        </div>
                    </div>
                    <div class="form-group">

                        <div class="col-xs-offset-2 col-xs-10">
                            <asp:LinkButton ID="lbtEditSubmit" CssClass="btn btn-primary" runat="server" CausesValidation="True" CommandName="Insert"><i aria-hidden="true" class="icon-user-check"></i> Submit</asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="lbtEditCancel" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Cancel"><i aria-hidden="true" class="icon-close"></i> Cancel</asp:LinkButton>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label7" runat="server" Text="Error:" ForeColor="#CC3300" Font-Bold="True" Visible="False" /><asp:Label ID="Label8" runat="server" Text="" ForeColor="#CC3300" Visible="False"></asp:Label>
                    </div>
                </fieldset>
            </div>

        </asp:View>
        <asp:View ID="vAddUser" runat="server">
            <div class="panel panel-primary" style="padding: 2%;">
                <h2>Add Organisation User</h2>
                <fieldset class="form-horizontal">


                    <div class="form-group">
                        <asp:Label ID="lblUname" CssClass="control-label col-xs-2" runat="server" AssociatedControlID="tbOrganisationUserName">Full Name:</asp:Label>

                        <div class="col-xs-10">
                            <asp:TextBox ID="tbOrganisationUserName" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" Display="Dynamic" ErrorMessage="Required" ControlToValidate="tbOrganisationUserName" Text="Required"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblEmail" CssClass="control-label col-xs-2" runat="server" AssociatedControlID="tbOrganisationUserEmail">Email:</asp:Label>

                        <div class="col-xs-10">
                            <asp:TextBox ID="tbOrganisationUserEmail" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Required" Display="Dynamic" ControlToValidate="tbOrganisationUserEmail" Text="Required"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator
                                runat="server" ID="RegularExpressionValidator2" Display="Dynamic" ControlToValidate="tbOrganisationUserEmail"
                                ValidationExpression="(?:[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*|'(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*')@(?:(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"
                                ToolTip="A valid email address must be provided" ErrorMessage="A valid email address must be provided"
                                Text="Invalid email" SetFocusOnError="true" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblRole" CssClass="control-label col-xs-2" runat="server" Text="Label" AssociatedControlID="listRolesAdd">Role:</asp:Label>
                        <div class="col-xs-10">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <a tabindex="0" title="User Roles per Organisation" class="btn btn-default" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="You may identify up to ten individuals in the role of Senior Officer."><i aria-hidden="true" class="icon-info"></i></a>
                                </div>
                                <asp:ListBox ID="listRolesAdd" runat="server" DataTextField="Role" DataValueField="RoleID" SelectionMode="Multiple" ClientIDMode="Static" CssClass="multiselect" ViewStateMode="Enabled"></asp:ListBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">

                        <div class="col-xs-offset-2 col-xs-10">
                            <asp:LinkButton ID="lbtInsertUser" CssClass="btn btn-primary" runat="server" CausesValidation="True" CommandName="Insert"><i aria-hidden="true" class="icon-user-add"></i> Add user</asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="lbtCancelInsert" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Cancel"><i aria-hidden="true" class="icon-close"></i> Cancel</asp:LinkButton>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblErrorHead" runat="server" Text="Error:" ForeColor="#CC3300" Font-Bold="True" Visible="False" /><asp:Label ID="lblErrorDetail" runat="server" Text="" ForeColor="#CC3300" Visible="False"></asp:Label>
                    </div>
                </fieldset>
            </div>
        </asp:View>
    </asp:MultiView>
    <!-- Standard Modal Message  -->
    <div id="modalMessage" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
                    <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Standard Modal Message  -->
    <div id="modalDPOExempt" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">
                        Organisation DPO Role Exemption</h4>
                </div>
                <div class="modal-body">
                    <p>
                        According to the ICO, under GDPR, you must appoint a DPO if:
                    </p>
                    <ul>
                        <li>You are a public authority (except for courts acting in their judicial capacity)</li>
                        <li>your core activities require large scale, regular and systematic monitoring of individuals (for example, online behaviour tracking)</li>
                        <li>or your core activities consist of large scale processing of special categories of data or data relating to criminal convictions and offences</li>
                    </ul>
                    <p>This applies to both controllers and processors. You can appoint a DPO if you wish, even if you aren’t required to. If you decide to voluntarily appoint a DPO you should be aware that the same requirements of the position and tasks apply had the appointment been mandatory.</p>
                    <p>Regardless of whether the GDPR obliges you to appoint a DPO, you must ensure that your organisation has sufficient staff and resources to discharge your obligations under the GDPR. However, a DPO can help you operate within the law by advising and helping to monitor compliance. In this way, a DPO can be seen to play a key role in your organisation’s data protection governance structure and to help improve accountability.</p>
                    <hr />
                    <p>If, having read the above guidance, you believe your organisation is not required to appoint a DPO and you don't intend to, please mark your organisation as DPO Exempt.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton CssClass="btn btn-primary" ID="lbtDPOExemptionConfirmed" runat="server">Confirm DPO Exemption</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        Sys.Application.add_load(BindEvents);
    </script>


</asp:Content>
