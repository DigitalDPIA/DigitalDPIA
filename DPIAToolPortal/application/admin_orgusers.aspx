<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="admin_orgusers.aspx.vb" Inherits="InformationSharingPortal.admin_orgusers" %>

<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Src="~/GridviewControlPanel.ascx" TagPrefix="uc1" TagName="GridviewControlPanel" %>
<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageHeading" runat="server">
    <h1>Organisation Users</h1>
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
   
      <%--<div class="row">
                <div class="col-sm-12">
            <div class="btn-group pull-right" role="group" aria-label="...">
              <asp:LinkButton ID="lbtClearFilters" CausesValidation="false" CssClass="btn btn-default" ToolTip="Clear table filters" runat="server"><i aria-hidden="true" class="icon-filter"></i>Clear Filters</asp:LinkButton>&nbsp;&nbsp;
       <uc1:GridviewControlPanel runat="server" id="daGridviewControlPanel" HeaderText="Show / Hide Columns" LinkText="Choose Columns" GridID="bsgvOrganisationUsers" />
                 <asp:LinkButton ID="lbtExportOUList" CssClass="btn btn-success" ToolTip="Export table to Excel" CausesValidation="false" runat="server"><i aria-hidden="true" class="icon-file-excel"></i> <b>Export to Excel</b> </asp:LinkButton>
                   
           </div></div></div>--%>
    <asp:ObjectDataSource ID="dsOrgUsers" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByAdminGroupID" TypeName="InformationSharingPortal.adminTableAdapters.OrgUsersTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddAdminGroupFilter" Name="AdminGroupID" PropertyName="SelectedValue" Type="Int32" />
            <asp:SessionParameter Name="IsCentralSA" SessionField="IsCentralSA" Type="Boolean" DefaultValue="False" />
            <asp:SessionParameter DefaultValue="0" Name="SuperAdminID" SessionField="SuperAdminID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
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
    <br />
    <br />
    <dx:ASPxGridViewExporter ID="bsgvOrganisationUsersExporter" GridViewID="bsgvOrganisationUsers" FileName="ISGSAOrgUsersExport" runat="server"></dx:ASPxGridViewExporter>
    <dx:BootstrapGridView ID="bsgvOrganisationUsers" runat="server" AutoGenerateColumns="False" DataSourceID="dsOrgUsers"  OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick" SettingsCustomizationDialog-Enabled="true">
        <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
        <CssClasses Table="table table-striped" />
                        <SettingsPager PageSize="15"/>
                         <Settings ShowHeaderFilterButton="True" />
                        <SettingsCookies Enabled="True" Version="0.11" StoreSearchPanelFiltering="False" StorePaging="False"/>
        <Columns>
            <dx:BootstrapGridViewTextColumn Caption="User Name" FieldName="OrganisationUserName" Name="User Name" VisibleIndex="0">
                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Email" FieldName="OrganisationUserEmail" Name="Email" VisibleIndex="1">
                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Roles" ReadOnly="True" VisibleIndex="2">
                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="OrganisationName" Name="Organisation" Caption="Organisation" VisibleIndex="3">
                <DataItemTemplate>
                      <asp:LinkButton Visible='<%# Eval("InactivatedDate").ToString.Length = 0%>' EnableViewState="false" OnCommand="ViewOrg_Click" CausesValidation="false" CommandArgument='<%# Eval("OrganisationID")%>' ID="lbtViewOrg" ToolTip="View Organisation in DPIA" runat="server" Text='<%# Eval("OrganisationName")%>'></asp:LinkButton>
                    <asp:Label Visible='<%# Eval("InactivatedDate").ToString.Length > 0%>'  ID="Label1" runat="server" CssClass="muted" Text='<%# Eval("OrganisationName")%>'></asp:Label>
                </DataItemTemplate>
                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewCheckColumn Caption="Email Verified" FieldName="Confirmed" Name="Email Verified" VisibleIndex="4">
                <DataItemTemplate>
                     <asp:CheckBox EnableViewState="false" ID="CheckBox1" runat="server" Checked='<%# Eval("Confirmed")%>' Enabled="false" Visible='<%# Eval("Confirmed")%>' />
                    <asp:LinkButton EnableViewState="false" ID="lbtVerify" OnCommand="Verify_Click" ToolTip="Verify user" Visible='<%# Not Eval("Confirmed")%>' CommandArgument='<%# Eval("OrganisationUserEmail")%>'  runat="server"><span class="icon-thumbs-up"></span></asp:LinkButton>
                </DataItemTemplate>
                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
            </dx:BootstrapGridViewCheckColumn>
            <dx:BootstrapGridViewCheckColumn Caption="Domain Validated" FieldName="Validated" Name="Domain Validated" VisibleIndex="5">
                <DataItemTemplate>
                     <asp:CheckBox EnableViewState="false" ID="CheckBox2" runat="server" Checked='<%# Eval("Validated")%>' Enabled="false" Visible='<%# Eval("Validated")%>' />
                    <asp:LinkButton EnableViewState="false" ID="lbtValidateDomain" OnCommand="ValidateDomain_Click" Visible='<%# Not Eval("Validated")%>' CommandArgument='<%# Eval("OrganisationUserEmail")%>' runat="server"><span class="icon-thumbs-up"></span></asp:LinkButton>
                </DataItemTemplate>
                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
            </dx:BootstrapGridViewCheckColumn>
            <dx:BootstrapGridViewTextColumn FieldName="LastAccess" Caption="Last Access" Name="Last Access" VisibleIndex="6">
                            <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">
                            </PropertiesTextEdit>
                        </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn FieldName="ResignDate" Visible="False" VisibleIndex="7">
            </dx:BootstrapGridViewDateColumn>
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
    

    <script type="text/javascript">
        Sys.Application.add_load(BindEvents);
    </script>
</asp:Content>
