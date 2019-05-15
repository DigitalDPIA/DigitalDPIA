<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="admin_registered.aspx.vb" Inherits="InformationSharingPortal.config_admin" %>

<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Src="~/GridviewControlPanel.ascx" TagPrefix="uc1" TagName="GridviewControlPanel" %>
<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageHeading" runat="server">
    <h1>Registered DPIA Users</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function BindEvents() {
            $(document).ready(function () {
                $('.bs-pagination td table').each(function (index, obj) {
                    convertToPagination(obj)
                });
                $('[data-toggle="popover"]').popover();
            });
        };
    </script>
    <script src="../Scripts/bs.pagination.js"></script>
    <asp:ObjectDataSource ID="dsRegUsers" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetForSA" TypeName="InformationSharingPortal.adminTableAdapters.RegUsersTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddAdminGroupFilter" Name="AdminGroupID" PropertyName="SelectedValue" Type="Int32" />
            <asp:SessionParameter DefaultValue="False" Name="IsCentralSA" SessionField="IsCentralSA" Type="Boolean" />
            <asp:SessionParameter Name="SuperAdminID" SessionField="SuperAdminID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <%--<div class="row">
        <div class="col-sm-12">
            <div class="btn-group pull-right" role="group" aria-label="...">
                <asp:LinkButton ID="lbtClearFilters" CausesValidation="false" CssClass="btn btn-default" ToolTip="Clear filters of Data Asset grid" runat="server"><i aria-hidden="true" class="icon-filter"></i>Clear Filters</asp:LinkButton>&nbsp;&nbsp;
       <uc1:GridviewControlPanel runat="server" ID="daGridviewControlPanel" HeaderText="Show / Hide Columns" LinkText="Choose Columns" GridID="bsgvRegisteredUsers" />
                <asp:LinkButton ID="lbtExportList" CssClass="btn btn-success" CausesValidation="false" runat="server"><i aria-hidden="true" class="icon-file-excel"></i> <b>Export to Excel</b> </asp:LinkButton>
            </div>
        </div>
    </div>--%>
    <asp:ObjectDataSource ID="dsAdminGroups" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveLimitedByAG" TypeName="InformationSharingPortal.adminTableAdapters.isp_AdminGroupsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="False" Name="IsCentralSA" SessionField="IsCentralSA" Type="Boolean" />
            <asp:SessionParameter DefaultValue="0" Name="SuperAdminID" SessionField="SuperAdminID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Panel ID="pnlAGFilter" runat="server" CssClass="form-inline pull-right clearfix"><div runat="server" id="divAGFilter" class="form-group"><asp:Label ID="lblAdminGroup" CssClass="filter-col" runat="server" Text="Admin Group:" AssociatedControlID="ddAdminGroupFilter"></asp:Label>
               <asp:DropDownList ID="ddAdminGroupFilter" AppendDataBoundItems="true" CssClass="form-control input-sm" AutoPostBack="true" runat="server" DataSourceID="dsAdminGroups" DataTextField="GroupName" DataValueField="AdminGroupID">              
                   <asp:ListItem Value="0" Text="All"></asp:ListItem>
               </asp:DropDownList></div></asp:Panel>
    <br /><br />
    <dx:ASPxGridViewExporter ID="bsgvRegisteredUsersExporter" GridViewID="bsgvRegisteredUsers" runat="server"></dx:ASPxGridViewExporter>
    <dx:BootstrapGridView SettingsCustomizationDialog-Enabled="true" ID="bsgvRegisteredUsers" runat="server" AutoGenerateColumns="False" DataSourceID="dsRegUsers" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick">
    <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
        <CssClasses Table="table table-striped" />
        <SettingsPager PageSize="15" />
        <Settings ShowHeaderFilterButton="True" />
        <SettingsCookies Enabled="True" Version="0.11" StoreSearchPanelFiltering="False" StorePaging="False" />
        <Columns>
            <dx:BootstrapGridViewTextColumn FieldName="Email" VisibleIndex="0">
                <DataItemTemplate>
                    <asp:LinkButton ID="lbtEditEmail" EnableViewState="false" ToolTip="Update Email Address" CssClass="btn btn-default btn-xs" OnCommand="EditEmail_Click" CommandArgument='<%#Eval("Email")%>' runat="server"><i aria-hidden="true" class="icon-pencil"></i></asp:LinkButton>
                    <asp:LinkButton ID="lbtUser" EnableViewState="false" runat="server" Text='<%# Eval("Email") & " (" & Eval("UserRoles").ToString() & " roles) "%>' PostBackUrl='<%# "admin_orgusers?email=" & Eval("Email")%>'></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewCheckColumn Caption="Locked" FieldName="IsLockedOut" Name="Locked" VisibleIndex="1">
                <DataItemTemplate>
                    <asp:CheckBox EnableViewState="false" ID="CheckBox1" runat="server" Checked='<%# Eval("IsLockedOut")%>' Enabled="false" />
                    <asp:LinkButton EnableViewState="false" Visible='<%# Eval("IsLockedOut")%>' ID="lbtUnlock" OnCommand="Unlock_Click" ToolTip="Unlock" CommandArgument='<%# Eval("Email")%>' runat="server"><i class="icon-unlocked"></i></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewCheckColumn>
            <dx:BootstrapGridViewDateColumn Caption="Registered" FieldName="CreateDate" Name="Registered" VisibleIndex="2">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewDateColumn Caption="Last login" FieldName="LastLoginDate" Name="Last login" VisibleIndex="3">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Comment" VisibleIndex="4">
                <DataItemTemplate>
                    <asp:Label EnableViewState="false" ID="Label1" runat="server" Text='<%# Eval("Comment")%>'></asp:Label>
                    <asp:LinkButton EnableViewState="false" ID="lbtComment" ToolTip="Add/edit comment" OnCommand="Comment_Click" CommandArgument='<%# Eval("Email")%>' runat="server"><i class="icon-bubbles"></i></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Name="Delete" ShowInCustomizationDialog="False" VisibleIndex="5">
                <DataItemTemplate>
                    <asp:LinkButton ID="lbtRemoveUser" EnableViewState="false" OnCommand="Remove_Click" CommandArgument='<%# Eval("Email")%>' ToolTip="Remove user" OnClientClick="return confirm('Are you sure that you wish to COMPLETELY remove this ISG user and inactivate all associated organisation user roles?');" CssClass="btn btn-danger btn-sm" runat="server"><i aria-hidden="true" class="icon-remove"></i></asp:LinkButton>
                </DataItemTemplate>
                <SettingsEditForm Visible="False" />
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

    <!-- Comment Modal Message  -->
    <div id="modalComment" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="commentsTitle" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <asp:HiddenField ID="hfEmail" runat="server" />
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><i class="icon-bubbles"></i>
                        <asp:Label ID="commentsTitle" runat="server"> Comments</asp:Label></h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox ID="tbComments" CssClass="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtCommentsOK" class="btn btn-primary pull-right" runat="server">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!-- Update Email Modal Message  -->
    <div id="modalUpdateEmail" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><i class="icon-bubbles"></i>
                        <asp:Label ID="lblUpdateHeading" runat="server">Update User Email Address</asp:Label></h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <asp:Label ID="Label3" CssClass="col-xs-3 control-label" runat="server" Text="Old e-mail:"></asp:Label>
                            <div class="col-xs-9">
                                <asp:TextBox Enabled="false" ValidationGroup="UpdateEmail" CssClass="form-control" ID="tbOldEmail" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label4" CssClass="col-xs-3 control-label" runat="server" Text="New e-mail:"></asp:Label>
                            <div class="col-xs-9">
                                <asp:TextBox CssClass="form-control" ID="tbNewEmail" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator ValidationGroup="UpdateEmail"
                                    runat="server" ID="RegularExpressionValidator2" Display="Dynamic" ControlToValidate="tbNewEmail"
                                    ValidationExpression="(?:[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*|'(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*')@(?:(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"
                                    ToolTip="Enter a valid email address" ErrorMessage="Enter a valid email address"
                                    Text="Invalid email" SetFocusOnError="true" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="tbNewEmail" runat="server" SetFocusOnError="true" Display="Dynamic" ValidationGroup="UpdateEmail" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtConfirmEmailChange" ValidationGroup="UpdateEmail" CausesValidation="true" class="btn btn-primary pull-right" runat="server">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!-- Standard Modal Message  -->
    <div id="modalMessage" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">
                        <asp:Label ID="modalTitle" runat="server"></asp:Label></h4>
                </div>
                <div class="modal-body">
                    <p>
                        <asp:Label ID="modalText" runat="server"></asp:Label></p>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        Sys.Application.add_load(BindEvents);
    </script>
</asp:Content>
