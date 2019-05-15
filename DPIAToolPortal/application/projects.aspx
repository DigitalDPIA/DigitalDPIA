<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="projects.aspx.vb" Inherits="InformationSharingPortal.projects" %>


<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Data.Linq" TagPrefix="dx" %>
<%@ Register Src="~/GridviewControlPanel.ascx" TagPrefix="uc1" TagName="GridviewControlPanel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageHeading" runat="server">
    <h1>Projects</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<%--        <script type="text/javascript">
        var textSeparator = ";";
        function updateText() {
            var selectedItems = checkListBox.GetSelectedItems();
            checkComboBox.SetText(getSelectedItemsText(selectedItems));
        }
        function synchronizeListBoxValues(dropDown, args) {
            checkListBox.UnselectAll();
            var texts = dropDown.GetText().split(textSeparator);
            var values = getValuesByTexts(texts);
            checkListBox.SelectValues(values);
            updateText(); // for remove non-existing texts
        }
        function getSelectedItemsText(items) {
            var texts = [];
            for (var i = 0; i < items.length; i++) 
                    texts.push(items[i].text);
            return texts.join(textSeparator);
        }
        function getValuesByTexts(texts) {
            var actualValues = [];
            var item;
            for(var i = 0; i < texts.length; i++) {
                item = checkListBox.FindItemByText(texts[i]);
                if(item != null)
                    actualValues.push(item.value);
            }
            return actualValues;
        }
    </script>--%>
    <dx:LinqServerModeDataSource ID="LinqServerModeDataSource1" runat="server"  />
    <h3>Projects<asp:CheckBox ID="cbIncludeArchived" AutoPostBack="true" CssClass="pull-right no-bold-label small" Font-Bold="false" runat="server" Text=" Include Archived" /></h3>    
    <dx:BootstrapGridView ID="bsgvProjects" Settings-GridLines="None" runat="server" DataSourceID="LinqServerModeDataSource1" AutoGenerateColumns="False"  KeyFieldName="ID" >
        <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
        <CssClasses Table="table table-striped table-condensed" />
        <SettingsPager PageSize="20" />
        <Settings ShowHeaderFilterButton="True" />
        <SettingsCookies Enabled="True" Version="0.125" StoreSearchPanelFiltering="False" StorePaging="False" />
        <Columns>             
           <dx:BootstrapGridViewTextColumn ShowInCustomizationDialog="false" Caption="" Name="View / Edit" VisibleIndex="0">
                <DataItemTemplate>
                    <asp:LinkButton ID="lbtEdit" EnableViewState="false" visible=True runat="server" CssClass="btn btn-default btn-sm" CausesValidation="False" ToolTip="Edit Project" OnCommand="EditProject" CommandArgument='<%#Eval("ID")%>' Text=""><i aria-hidden="true" class="icon-pencil"></i></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="ID" FieldName="ID" HorizontalAlign="left" Name="ID" ReadOnly="True" VisibleIndex="1">
                <SettingsEditForm Visible="False" />
                <DataItemTemplate>
                    <asp:Label EnableViewState="false" Font-Bold="true" ID="Label3" runat="server" Text='<%# PadID(Eval("ID"))%>'></asp:Label>
                </DataItemTemplate>
                <Settings AllowHeaderFilter="False" />
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Name" FieldName="Name"  HorizontalAlign="left" Name="Name" ReadOnly="True" VisibleIndex="2">   
                <Settings AllowHeaderFilter="False" />
            </dx:BootstrapGridViewTextColumn>                                  
            <dx:BootstrapGridViewTextColumn ShowInCustomizationDialog="false" Caption="Screen" Name="Screening" VisibleIndex="3">
                <DataItemTemplate>
                    <asp:LinkButton ID="lbtEditScreening" EnableViewState="false" visible=True runat="server" CssClass="btn btn-default btn-sm" CausesValidation="False" ToolTip="Project Screening" OnCommand="Screening" CommandArgument='<%#Eval("ID")%>' Text=""><i aria-hidden="true" class="icon-question"></i></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn ShowInCustomizationDialog="false" Caption="DPIA" Name="DPIA" VisibleIndex="4">
                <DataItemTemplate>
                    <asp:LinkButton ID="lbtEditDPIA" EnableViewState="false" visible='<%#Eval("Status").ToString = "DPIA Required" Or Eval("Status").ToString = "DPIA In Progress"  %>' runat="server" CssClass="btn btn-default btn-sm" CausesValidation="False" ToolTip="Project DPIA" OnCommand="Dpia" CommandArgument='<%#Eval("ID")%>' Text=""><i aria-hidden="true" class="icon-star3"></i></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Status" FieldName="Status"  HorizontalAlign="left" Name="Status" ReadOnly="True" VisibleIndex="5">   
                <Settings AllowHeaderFilter="True" />
            </dx:BootstrapGridViewTextColumn>                       
            <dx:BootstrapGridViewTextColumn Caption="Assigned To" FieldName="Assigned_Name"  HorizontalAlign="left" Name="Assigned To" ReadOnly="True" VisibleIndex="6">   
                <Settings AllowHeaderFilter="True" />            
            </dx:BootstrapGridViewTextColumn>            
            <dx:BootstrapGridViewTextColumn Caption="Created By" FieldName="Created_Name"  HorizontalAlign="left" Name="Created By" ReadOnly="True" VisibleIndex="7">   
                <Settings AllowHeaderFilter="True" />            
            </dx:BootstrapGridViewTextColumn>            
            <dx:BootstrapGridViewDateColumn Caption="Created On" FieldName="Created_Date"  HorizontalAlign="left" Name="Created On" ReadOnly="True" VisibleIndex="8">   
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn Caption="Last Modified By" FieldName="Modified_Name"  HorizontalAlign="left" Name="Last Modified By" ReadOnly="True" Visible="false" VisibleIndex="9">   
                <Settings AllowHeaderFilter="True" />
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn Caption="Last Modified On" FieldName="Modified_Date"  HorizontalAlign="left" Name="Last Modified On" ReadOnly="True" Visible="false" VisibleIndex="10">   
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn Caption="IG Lead" FieldName="IG_Lead_Name"  HorizontalAlign="left" Name="IG Lead" ReadOnly="True"  Visible="false" VisibleIndex="11">   
                <Settings AllowHeaderFilter="True" />
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn Caption="IG Sign Off Date" FieldName="IG_Lead_Sign_Off_Date"  HorizontalAlign="left" Name="IG Sign Off Date" ReadOnly="True"  Visible="false" VisibleIndex="12">   
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn Caption="IAO Owner" FieldName="Asset_Owner_Name"  HorizontalAlign="left" Name="IAO Owner" ReadOnly="True"  Visible="false" VisibleIndex="13">   
                <Settings AllowHeaderFilter="True" />
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn Caption="IAO Sign Off Date" FieldName="Asset_Owner_Sign_Off_Date"  HorizontalAlign="left" Name="IAO Sign Off Date" ReadOnly="True"  Visible="false" VisibleIndex="14">   
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
            </dx:BootstrapGridViewDateColumn>            
            <dx:BootstrapGridViewTextColumn Caption="DPO Owner" FieldName="DPO_Name"  HorizontalAlign="left" Name="DPO Owner" ReadOnly="True"  Visible="false" VisibleIndex="15">   
                <Settings AllowHeaderFilter="True" />
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn Caption="DPO Sign Off Date" FieldName="DPO_Sign_Off_Date"  HorizontalAlign="left" Name="DPO Sign Off Date" ReadOnly="True"  Visible="false" VisibleIndex="16">   
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn Caption="ICO Owner" FieldName="ICO_Name"  HorizontalAlign="left" Name="ICO Owner" ReadOnly="True"  Visible="false" VisibleIndex="17">   
                <Settings AllowHeaderFilter="True" />
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn Caption="ICO Sign Off Date" FieldName="ICO_Sign_Off_Date"  HorizontalAlign="left" Name="ICO Sign Off Date" ReadOnly="True"  Visible="false" VisibleIndex="18">   
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewDateColumn Caption="Archived" FieldName="DFArchivedDate" Name="Archived" VisibleIndex="19">
                <DataItemTemplate>
                    <asp:LinkButton EnableViewState="false" ID="lbtArchive" runat="server" CssClass="btn btn-danger btn-sm" CausesValidation="False" ToolTip="Archive Project" OnCommand="ArchiveProject" visible='<%# (((Session("UserRoleAdmin") Or Session("UserRoleSIRO") Or Session("UserRoleIAO") Or Session("UserRoleIGO")) And Eval("Organisation_ID") = Session("UserOrganisationID")) Or Session("IsSuperAdmin")) And If(Eval("Archived_Date") Is Nothing, True, False) %>' CommandArgument='<%#Eval("ID")%>'><i aria-hidden="true" class="icon-remove"></i></asp:LinkButton>
                    <div runat="server" enableviewstate="false" visible='<%# If(Eval("Archived_Date") IsNot Nothing, True, False) %>' class="small"><asp:Label EnableViewState="false" ID="Label2" runat="server" CssClass="small" Text='<%# "Archived:<br/>" & Eval("Archived_Date", "{0:d}")%>'></asp:Label></div>
                </DataItemTemplate>
            </dx:BootstrapGridViewDateColumn>           
        </Columns>
        <Toolbars>
            <dx:BootstrapGridViewToolbar>
                <Items>
                    <dx:BootstrapGridViewToolbarItem Command="ClearFilter" IconCssClass="glyphicon glyphicon-remove" Text="Clear filters" />
                    <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" Text="Customise Grid" IconCssClass="glyphicon glyphicon-list-alt" />
                </Items>
            </dx:BootstrapGridViewToolbar>
        </Toolbars>
        <SettingsCustomizationDialog Enabled="True"></SettingsCustomizationDialog>
        <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
    </dx:BootstrapGridView>
    <br />

    <asp:LinkButton ID="lbtAdd" cssclass="btn btn-primary pull-right" runat="server"><i aria-hidden="true" class="icon-plus"></i> <b>Add Project</b> </asp:LinkButton>
    <asp:HiddenField ID="hfArchiveProjectID" runat="server" />
    <div id="modalMessage" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><asp:Label ID="lblModalHeading" runat="server"></asp:Label></h4>
                </div>
                <div class="modal-body">
                    <p><asp:Label ID="lblModalText" runat="server"></asp:Label></p>
                </div>
                <div class="modal-footer">
                    <button id="ModalOK" runat="server" type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

    <div id="modalArchive" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Archive Project</h4>                    
                </div>
                <div class="modal-body">
                     <div class="row">
                        <div class="col-sm-12">
                            <asp:LinkButton ID="lbtArchiveConfirm" CausesValidation="false" CommandArgument="0" CssClass="btn btn-danger" runat="server">Confirm Project Archive</asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="Button2" runat="server" type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
