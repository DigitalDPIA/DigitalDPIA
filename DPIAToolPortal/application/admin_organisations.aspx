<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="admin_organisations.aspx.vb" Inherits="InformationSharingPortal.admin_organisations" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Src="~/OrgDetailsModal.ascx" TagPrefix="uc1" TagName="OrgDetailsModal" %>
<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Src="~/GridviewControlPanel.ascx" TagPrefix="uc1" TagName="GridviewControlPanel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/geo.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageHeading" runat="server">
    <h1>Organisations</h1>
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
            $('#ddCategory').on('change', function () {

                if ($('#ddCategory option:selected').text().trim() !== "Other" && $('#divOther').hasClass('collapse in')) {
                    $('#divOther').collapse('hide');
                };
                if ($('#ddCategory option:selected').text().trim() === "Other") {

                    $('#divOther').collapse('show');
                    $('#tbOtherCategory').focus();
                };

            });
            $("#cbSOLicence").click(function () {
                if ($(this).is(':checked')) {
                    $("#tbSOLicenceEndDate").val("").prop('disabled', false); edt = new Date(new Date().setFullYear(new Date().getFullYear() + 1)); var dd = edt.getDate();
                    var mm = edt.getMonth() + 1; //January is 0!

                    var yyyy = edt.getFullYear();
                    if (dd < 10) {
                        dd = '0' + dd;
                    }
                    if (mm < 10) {
                        mm = '0' + mm;
                    }
                    var edt = dd + '/' + mm + '/' + yyyy;
                    $("#tbSOLicenceEndDate").val(edt);
                } else { $("#tbSOLicenceEndDate").val("").prop('disabled', true); };
            });
        };
    </script>
    <script src="../Scripts/bs.pagination.js"></script>
    <asp:ObjectDataSource ID="dsLicenceStatus" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.adminTableAdapters.GetLicenceStatusForAdminGroupTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddAdminGroupFilter" DefaultValue="-1" Name="AdminGroupID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="dsOrganisations" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.adminTableAdapters.OrganisationsTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddAdminGroupFilter" DefaultValue="-1" Name="AdminGroupID" PropertyName="SelectedValue" Type="Int32" />
            <asp:SessionParameter DefaultValue="False" Name="IsCentralSA" SessionField="IsCentralSA" Type="String" />
            <asp:SessionParameter DefaultValue="0" Name="SuperAdminID" SessionField="SuperAdminID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <%--<div class="row">
        <div class="col-sm-12">
            <div class="btn-group pull-right" role="group" aria-label="...">
                <asp:LinkButton ID="lbtClearFilters" CausesValidation="false" CssClass="btn btn-default" ToolTip="Clear filters of Data Asset grid" runat="server"><i aria-hidden="true" class="icon-filter"></i>Clear Filters</asp:LinkButton>
       <uc1:GridviewControlPanel runat="server" ID="daGridviewControlPanel" HeaderText="Show / Hide Columns" LinkText="Choose Columns" GridID="bsgvOrganisations" />
                <asp:LinkButton runat="server" ID="lbtResetGrid" CausesValidation="false" CssClass="btn btn-default"  Text="Reset grid"
                             />
                <asp:LinkButton ID="lbtExportList" CssClass="btn btn-success" ToolTip="Export filtered data assets to Excel" CausesValidation="false" runat="server"><i aria-hidden="true" class="icon-file-excel"></i> <b>Export to Excel</b> </asp:LinkButton>
            </div>
        </div>
    </div>--%>
    <asp:Panel ID="pnlAGFilter" runat="server" CssClass="form-inline pull-right clearfix"><div runat="server" id="divAGFilter" class="form-group"><asp:Label ID="lblAdminGroup" CssClass="filter-col" runat="server" Text="Admin Group:" AssociatedControlID="ddAdminGroupFilter"></asp:Label>
               <asp:DropDownList ID="ddAdminGroupFilter" AppendDataBoundItems="true" CssClass="form-control input-sm" AutoPostBack="true" runat="server" DataSourceID="dsAdminGroups" DataTextField="GroupName" DataValueField="AdminGroupID">              
                   <asp:ListItem Value="0" Text="All"></asp:ListItem>
               </asp:DropDownList></div></asp:Panel>
    <br />
    <br />
    <asp:FormView ID="fvLicenceUsage" DefaultMode="ReadOnly" RenderOuterTable="False" runat="server" DataSourceID="dsLicenceStatus">

        <ItemTemplate>
            <asp:Panel ID="pnlLicenceUsage" Visible='<%# Eval("LicTotal").ToString.Length > 0 %>' CssClass='<%# IIf(Eval("Active"), "panel panel-info", "panel panel-danger") %>' runat="server">
                <div class="panel-heading">
                    Admin group licence usage <%# IIf(Eval("Active"), "", " (Admin Group Inactive)") %>
                </div>
                <div class=" panel-body">
                    <div class="row">
                        <div class="col-sm-4">
                            Total licences:
                    <asp:Label ID="LicTotalLabel" Font-Bold="true" runat="server" Text='<%# Eval("LicTotal") %>' />
                        </div>
                        <div class="col-sm-4">
                            Licences assigned:
                    <asp:Label ID="LicUsedLabel" Font-Bold="true" runat="server" Text='<%# Eval("LicUsed") %>' />
                        </div>
                        <div class="col-sm-4">
                            Licences remaining:
                    <asp:Label ID="LicRemainingLabel" Font-Bold="true" runat="server" Text='<%# Eval("LicRemaining") %>' />
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </ItemTemplate>
    </asp:FormView>
    <dx:ASPxGridViewExporter ID="bsgvOrganisationsExporter" GridViewID="bsgvOrganisations" runat="server"></dx:ASPxGridViewExporter>
    <dx:BootstrapGridView  ID="bsgvOrganisations" runat="server" AutoGenerateColumns="False" DataSourceID="dsOrganisations" KeyFieldName="OrganisationID" SettingsCustomizationDialog-Enabled="true" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick">
         <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
        <CssClasses Table="table table-striped table-condensed small" />
        <SettingsPager PageSize="15" />
        <Settings ShowHeaderFilterButton="True" />
        <SettingsCookies Enabled="True" Version="0.174" StoreSearchPanelFiltering="False" StorePaging="False" />
        <Columns>
            <dx:BootstrapGridViewTextColumn FieldName="ISGID" Name="ID" Caption="ID" CssClasses-DataCell="text-bold" ReadOnly="True" VisibleIndex="0">
                <CssClasses DataCell="text-bold"></CssClasses>

                <Settings AllowHeaderFilter="False" />
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="OrganisationName" VisibleIndex="1" Caption="Organisation Name" Name="Organisation Name">
                <Settings AllowHeaderFilter="False" />
                <DataItemTemplate>
                    <asp:Label ID="Label7" Visible='<%# Not Session("IsCentralSA") And Eval("AdminGroup") = "None" %>' runat="server" Text='<%# Eval("OrganisationName")%>'></asp:Label>
                    <asp:LinkButton OnCommand="ViewOrg_Click"  Visible='<%# Session("IsCentralSA") Or Not Eval("AdminGroup") = "None" %>' EnableViewState="false" CausesValidation="false" CommandArgument='<%# Eval("OrganisationID")%>' ID="lbtViewOrg" ToolTip="View Organisation in DPIA" runat="server" Text='<%# Eval("OrganisationName")%>'></asp:LinkButton><br />
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
<%--            <dx:BootstrapGridViewCheckColumn FieldName="SingleOrgLicenceEnd" Name="Single Organisation Licence" Caption="Single Lic" VisibleIndex="2">
                <DataItemTemplate>
                    <asp:CheckBox ID="cbSingleOrg" Visible='<%# Not Session("IsCentralSA") %>' Checked='<%# Eval("SingleOrgLicence") %>' Enabled="false" runat="server" />
                    <asp:LinkButton EnableViewState="false" Visible='<%# Session("IsCentralSA") %>' OnCommand="ToggleSingleLicence_Click" CausesValidation="false" ToolTip='<%# IIf(Eval("SingleOrgLicence"), "Edit licence", "Grant licence")%>' CssClass='<%# IIf(Eval("SingleOrgLicence"), "text-success", "text-danger")%>' CommandArgument='<%# Eval("OrganisationID")%>' ID="lbtSOLicenceToggle" runat="server"><span class='<%# IIf(Eval("SingleOrgLicence"), "glyphicon glyphicon-check", "glyphicon glyphicon-unchecked")%>'></span></asp:LinkButton><br />
                    <asp:Label EnableViewState="false" ID="lblEndDate" ToolTip="Single Organisation Licence End Date" runat="server" Text='<%# Eval("SingleOrgLicenceEnd", "{0:d}")%>'></asp:Label>
                </DataItemTemplate>
            </dx:BootstrapGridViewCheckColumn>--%>
            <dx:BootstrapGridViewTextColumn FieldName="ICORegistrationNumber" VisibleIndex="3" Caption="ICO Number" Name="ICO Number">
                <Settings AllowHeaderFilter="False" />
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Identifiers" VisibleIndex="4" Caption="Identifiers (ODS)" Name="Identifiers (ODS)" Visible="False">
                <Settings AllowHeaderFilter="False" />
                <DataItemTemplate>
                    <asp:Label ID="lblIdentifiers" EnableViewState="false" runat="server" Text='<%# Eval("Identifiers")%>'></asp:Label>&nbsp;<asp:LinkButton CausesValidation="false" ID="lbtODSLookup" CommandArgument='<%# Eval("OrganisationID")%>' OnCommand="ODSLookup_Click" ToolTip="ODS Lookup" runat="server"><span class="icon-search"></span></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Category" ReadOnly="True" VisibleIndex="5">
                <DataItemTemplate>
                    <table>
                        <tr>
                            <td style="width:100%">
                                <asp:Label EnableViewState="false" ID="lblCategory" CausesValidation="false" runat="server" Text='<%# Eval("Category")%>'></asp:Label></td>
                            <td style="padding-left:1px;">
                                <asp:LinkButton EnableViewState="false" Visible='<%# Session("IsCentralSA") Or Not Eval("AdminGroup") = "None" %>' CausesValidation="false" ID="lbtEditCat" CssClass="pull-right" CommandArgument='<%# Eval("OrganisationID")%>' OnCommand="EditCategory_Click" ToolTip="Edit category" runat="server"><span class="icon-pencil"></span></asp:LinkButton></td>
                        </tr>
                    </table>
                </DataItemTemplate>
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Contact" VisibleIndex="6" Visible="False">
                <Settings AllowHeaderFilter="False" />
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="OrgContactEmail" VisibleIndex="7" Caption="Contact Email" Name="Contact Email">
                <Settings AllowHeaderFilter="False" />
                <DataItemTemplate>
                    <a enableviewstate="false" href='<%# "mailto:" + Eval("OrgContactEmail")%>'>
                        <asp:Label EnableViewState="false" ID="Label2" runat="server" Text='<%# Eval("OrgContactEmail")%>'></asp:Label></a>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
<%--            <dx:BootstrapGridViewTextColumn FieldName="SponsoredBy" VisibleIndex="8" Caption="Supported by" Name="Sponsor" ReadOnly="True" Visible="False">
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:BootstrapGridViewTextColumn>--%>
            <dx:BootstrapGridViewTextColumn FieldName="County" VisibleIndex="9" Visible="False">
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:BootstrapGridViewTextColumn>
<%--            <dx:BootstrapGridViewTextColumn FieldName="RegisteredBy" Name="Registered By" Caption="Registered By" ReadOnly="True" VisibleIndex="10" Visible="False">
                <Settings AllowHeaderFilter="False" />
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn FieldName="ISPFirstRegisteredDate" VisibleIndex="11" Caption="Registered" Name="Registered date" Visible="False">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy">
                </PropertiesDateEdit>
            </dx:BootstrapGridViewDateColumn>--%>
            <dx:BootstrapGridViewDateColumn FieldName="InactivatedDate" VisibleIndex="12" Caption="Inactivated" Name="Inactivated date" Visible="False">
            </dx:BootstrapGridViewDateColumn>
<%--            <dx:BootstrapGridViewDateColumn FieldName="AssuranceSubmitted" ReadOnly="True" VisibleIndex="13" Caption="Assurance Submitted" Name="Assurance Submitted" Visible="False">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Assurance" ReadOnly="True" VisibleIndex="14">
                <DataItemTemplate>
                    <asp:LinkButton EnableViewState="false" ID="lbtViewOrgDetails" CausesValidation="false" ToolTip="View organisation details" runat="server" OnCommand="ViewOrgDetails_Click" CommandArgument='<%# Eval("OrganisationID")%>'>
                        <asp:Label EnableViewState="false" ID="lblSignificant" Width="85px" runat="server" CssClass="label label-success" Visible='<%# Eval("Assurance") = "Significant"%>'>Significant</asp:Label>
                        <asp:Label EnableViewState="false" ID="Label3" Width="85px" runat="server" CssClass="label label-warning" Visible='<%# Eval("Assurance") = "Limited"%>'>Limited</asp:Label>
                        <asp:Label EnableViewState="false" ID="Label4" Width="85px" runat="server" CssClass="label label-danger" Visible='<%# Eval("Assurance") = "None"%>'>None</asp:Label>
                        <asp:Label EnableViewState="false" ID="Label5" Width="85px" runat="server" CssClass="label label-default" Visible='<%# Eval("Assurance") = "Not submitted"%>'>Not submitted</asp:Label>
                        <asp:Label EnableViewState="false" ID="Label6" Width="85px" runat="server" CssClass="label label-default" Visible='<%# Eval("Assurance") = "Expired"%>'>Expired</asp:Label>
                    </asp:LinkButton>
                    <asp:Label EnableViewState="false" ID="Label1" Width="85px" runat="server" CssClass="label label-default" Visible='<%# Eval("Assurance") = "DPIA Inactive"%>'>DPIA Inactive</asp:Label>
                </DataItemTemplate>
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:BootstrapGridViewTextColumn>--%>
<%--            <dx:BootstrapGridViewDateColumn FieldName="MOUSigned" ReadOnly="True" VisibleIndex="15" Caption="MOU Signed" Name="MOU Signed" Visible="False">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy">
                </PropertiesDateEdit>
            </dx:BootstrapGridViewDateColumn>--%>

            <dx:BootstrapGridViewTextColumn FieldName="AdminGroup" Name="Admin Group" ReadOnly="True" VisibleIndex="16">
                <DataItemTemplate>
                    <asp:Label ID="Label3" EnableViewState="false" runat="server" Text='<%# Bind("AdminGroup") %>'></asp:Label>&nbsp;<asp:LinkButton CausesValidation="false" EnableViewState="false" ID="lbtEditAG" CssClass="pull-right" CommandArgument='<%# Eval("OrganisationID")%>' OnCommand="EditAdminGroup_Click" ToolTip="Edit Admin Group" runat="server"><span class="icon-pencil"></span></asp:LinkButton>
                </DataItemTemplate>
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:BootstrapGridViewTextColumn>
<%--            <dx:BootstrapGridViewCheckColumn FieldName="LicenceGranted" Name="Franchise Licenced" VisibleIndex="17" Caption="Lic">
                <DataItemTemplate>
                    <asp:LinkButton EnableViewState="false" OnCommand="ToggleLicence_Click" CausesValidation="false" ToolTip='<%# IIf(Eval("LicenceGranted"), "Remove licence", "Grant licence")%>' CssClass='<%# IIf(Eval("LicenceGranted"), "text-success", "text-danger")%>' CommandArgument='<%# Eval("OrganisationID")%>' ID="lbtLicenceToggle" runat="server"><span class='<%# IIf(Eval("LicenceGranted"), "glyphicon glyphicon-check", "glyphicon glyphicon-unchecked")%>'></span></asp:LinkButton>

                </DataItemTemplate>
            </dx:BootstrapGridViewCheckColumn>--%>
            <dx:BootstrapGridViewTextColumn FieldName="SuperAdmin" ReadOnly="True" Visible="false" VisibleIndex="18" Caption="Super Admin" Name="Super Administrator">
                <DataItemTemplate>
                    <asp:Label ID="Label6" EnableViewState="false" runat="server" Text='<%# Bind("SuperAdmin") %>'></asp:Label>&nbsp;<asp:LinkButton EnableViewState="false" CssClass="pull-right" CausesValidation="false" ID="lbtEditSA" CommandArgument='<%# Eval("OrganisationID")%>' OnCommand="EditSA_Click" ToolTip="Edit Super Admin" runat="server"><span class="icon-pencil"></span></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
<%--            <dx:BootstrapGridViewTextColumn Caption="Admins Verified" FieldName="AdminsVerified" Name="Admins Verified" ReadOnly="True" Visible="False" VisibleIndex="19">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="SeniorUsersVerified" ReadOnly="True" VisibleIndex="20" Caption="Senior Officers Verified" Name="Senior Officers Verified" Visible="False">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="DPOUsersVerified" ReadOnly="True" VisibleIndex="21" Caption="DPOs Registered" Name="DPOs Registered" Visible="False">
            </dx:BootstrapGridViewTextColumn>            
            <dx:BootstrapGridViewCheckColumn FieldName="PNExists" Visible="False" VisibleIndex="22">
            </dx:BootstrapGridViewCheckColumn>
            <dx:BootstrapGridViewCheckColumn FieldName="OnMap" ReadOnly="True" VisibleIndex="23" Visible="False">
                <DataItemTemplate>
                    <asp:Label EnableViewState="false" ID="lblOnMapCheck" Visible='<%# Eval("OnMap") %>' runat="server"><span class="glyphicon glyphicon-ok"></span></asp:Label>
                    <asp:LinkButton EnableViewState="false" CssClass="pull-right" CausesValidation="false" ID="lbtPin" Visible='<%# Not Eval("OnMap") %>' CommandArgument='<%# Eval("OrganisationAddress")%>' OnCommand="PinOnMap_Click" runat="server"><span class="icon-pushpin"></span></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewCheckColumn>--%>
<%--            <dx:BootstrapGridViewTextColumn FieldName="OrganisationSetupPercent" ReadOnly="True" VisibleIndex="24" Caption="Setup %" Name="Setup %">
                <DataItemTemplate>
                    <div class="progress" style="min-width: 100px;">
                        <div id="Div1" runat="server" enableviewstate="false" class='<%# GetProgClass((Eval("OrganisationSetupPercent")))%>' role="progressbar" aria-valuenow='<%# Eval("OrganisationSetupPercent")%>'
                            aria-valuemin="0" aria-valuemax="100" style='<%# "Width:" & Eval("OrganisationSetupPercent") & "%;"%>'>
                            <asp:Label EnableViewState="false" ID="Label4" runat="server" Text='<%# Eval("OrganisationSetupPercent") & "%"%>'></asp:Label>
                        </div>
                    </div>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>--%>
<%--            <dx:BootstrapGridViewTextColumn FieldName="DataFlowsInv" ReadOnly="True" Name="Data Flows Involved" VisibleIndex="25" Visible="False" Caption="Data Flows Inv">
            </dx:BootstrapGridViewTextColumn> 
            <dx:BootstrapGridViewTextColumn Caption="Draft Flows Inv" FieldName="DataFlowsInvDraft" Name="Draft Data Flows Involved" Visible="False" VisibleIndex="26">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Final Flows Inv" FieldName="DataFlowsInvFinal" Name="Final Data Flows Involved" Visible="False" VisibleIndex="27">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Flows Owned" FieldName="DataFlowsOwned" Name="Data Flows Owned" Visible="False" VisibleIndex="28">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Draft Flows Owned" FieldName="DataFlowsOwnedDraft" Name="Draft Data Flows Owned" Visible="False" VisibleIndex="29">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Final Flows Owned" FieldName="DataFlowsOwnedFinal" Name="Final Data Flows Owned" Visible="False" VisibleIndex="30">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn FieldName="RequestClosureDate" VisibleIndex="31" Caption="Close Requested" Name="Close Requested" Visible="False">
                <DataItemTemplate>
                     <asp:Label ID="Label6" EnableViewState="false" runat="server" Text='<%# Eval("RequestClosureDate", "{0:d}") %>'></asp:Label>
               
                    <asp:LinkButton EnableViewState="false" ID="lbtRemoveOrg" OnCommand="Remove_Click" Visible='<%# Eval("InactivatedDate").ToString.Length = 0%>' CausesValidation="false" CommandArgument='<%# Eval("OrganisationID")%>' ToolTip="Inactivate organisation" OnClientClick="return confirm('Are you sure that you wish to inactivate this DPIA organisation?');" CssClass="btn btn-danger btn-sm" runat="server"><i aria-hidden="true" class="icon-remove"></i></asp:LinkButton>
                    <asp:LinkButton EnableViewState="false" ID="lbtReopenOrg" OnCommand="Reactivate_Click" Visible='<%# Eval("InactivatedDate").ToString.Length > 0%>' CausesValidation="false" CommandArgument='<%# Eval("OrganisationID")%>' ToolTip="Reactivate organisation" OnClientClick="return confirm('Are you sure that you wish to reactivate this DPIA organisation?');" CssClass="btn btn-success btn-sm" runat="server"><i aria-hidden="true" class="icon-checkmark-circle"></i></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewDateColumn>--%>
        </Columns>
        <Toolbars>
         <dx:BootstrapGridViewToolbar>
            <Items>
                <dx:BootstrapGridViewToolbarItem Command="Custom" Name="Reset" CssClass="btn btn-default" Text ="Reset" IconCssClass="glyphicon glyphicon-refresh" ToolTip="Reset grid to default view"/>
                <dx:BootstrapGridViewToolbarItem Command="ClearFilter" IconCssClass="glyphicon glyphicon-remove" Text="Clear filters" />
                <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" Text="Customise Grid" IconCssClass="glyphicon glyphicon-list-alt" />
                <dx:BootstrapGridViewToolbarItem Command="Custom" Name="Export" CssClass="btn btn-success" Text ="Export to Excel" IconCssClass="icon-file-excel" ToolTip="Export grid to Excel"/>
            </Items>
        </dx:BootstrapGridViewToolbar></Toolbars>

<SettingsCustomizationDialog Enabled="True"></SettingsCustomizationDialog>

        <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" ColumnNames="OrganisationName; ICORegistrationNumber; OrgContactEmail; Identifiers" /> 
    </dx:BootstrapGridView>


    <div id="modalPin" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <asp:HiddenField ID="hfEmail" runat="server" />
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><i class="icon-pushpin"></i>Locate on Map</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <asp:TextBox ID="tbAddress" ClientIDMode="Static" CssClass="form-control" Enabled="false" Rows="5" TextMode="MultiLine" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-xs-2" for="tbAddress">Map Location:</label>
                            <div class="col-xs-10">
                                <div class="input-group">
                                    <span class="input-group-addon">County:</span><asp:TextBox ID="hfCounty" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    <span class="input-group-addon">Lat:</span><asp:TextBox ID="hfLattitude" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                                    <span class="input-group-addon">Long:</span><asp:TextBox ID="hfLongitude" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                                    <span class="input-group-btn">
                                        <asp:Button ID="Button1" CssClass="btn btn-success" runat="server" CausesValidation="false" OnClientClick="javascript:getGeoCode(); return false;" Text="Find" Font-Size="8pt" /></span>
                                </div>
                                <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvLong" data-placement="bottom" Display="Dynamic" runat="server" CssClass="bg-danger" ErrorMessage="Click find to locate your organisation on the map." Text="Click find to locate your organisation on the map." ControlToValidate="hfLongitude" ToolTip="Click find to locate your organisation on the map."></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtGeoOK" class="btn btn-primary pull-right" runat="server">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <asp:ObjectDataSource ID="dsAdminGroups" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveLimitedByAG" TypeName="InformationSharingPortal.adminTableAdapters.isp_AdminGroupsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="False" Name="IsCentralSA" SessionField="IsCentralSA" Type="Boolean" />
            <asp:SessionParameter DefaultValue="0" Name="SuperAdminID" SessionField="SuperAdminID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsCategory" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.isporganisationsTableAdapters.isp_OrganisationCategoriesTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsSuperAdmins" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.adminTableAdapters.SuperAdminsForAGTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="hfAdminGroupID" DefaultValue="0" Name="AdminGroupID" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div id="modalEditAG" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Edit admin group</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">

                        <div class="form-group">
                            <asp:HiddenField ID="hfOrgID" runat="server" />
                            <asp:TextBox ID="tbOrganisation" ClientIDMode="Static" CssClass="form-control" Enabled="false" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-xs-2" for="tbAddress">Admin Group:</label>
                            <div class="col-xs-10">
                                <asp:DropDownList CssClass="form-control" ID="ddAdminGroup" runat="server" DataSourceID="dsAdminGroups" AppendDataBoundItems="true" DataTextField="GroupName" DataValueField="AdminGroupID">
                                    <asp:ListItem Text="None" Value="0" />
                                </asp:DropDownList>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtConfirmAG" CausesValidation="false" class="btn btn-primary pull-right" runat="server">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <div id="modalEditSA" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Edit Organisation Super Administrator</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <asp:HiddenField ID="hfAdminGroupID" runat="server" />
                        <asp:HiddenField ID="hfCurrentSA" runat="server" />
                        <div class="form-group">
                            <asp:TextBox ID="tbOrganisationSA" ClientIDMode="Static" CssClass="form-control" Enabled="false" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-xs-2" for="ddSuperAdmin">Super Administrator:</label>
                            <div class="col-xs-10">
                                <asp:DropDownList CssClass="form-control" ID="ddSuperAdmin" runat="server" AppendDataBoundItems="true" DataSourceID="dsSuperAdmins" DataTextField="SAEmail" DataValueField="SuperAdminID">
                                    <asp:ListItem Text="Default" Value="0" />
                                </asp:DropDownList>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtConfirmSA" CausesValidation="false" class="btn btn-primary pull-right" runat="server">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <div id="modalEditCategory" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <asp:HiddenField ID="hfCategoryID" runat="server" />
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Edit organisation category</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <asp:TextBox ID="tbOrganisation2" ClientIDMode="Static" CssClass="form-control" Enabled="false" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-xs-2" for="tbAddress">Category:</label>
                            <div class="col-xs-10">
                                <asp:DropDownList CssClass="form-control" ClientIDMode="Static" ID="ddCategory" runat="server" DataSourceID="dsCategory" AppendDataBoundItems="true" DataTextField="OrganisationCategory" DataValueField="OrganisationCategoryID">
                                    <asp:ListItem Text="None" Value="0" />
                                </asp:DropDownList>

                            </div>
                        </div>
                        <div id="divOther" class="collapse">
                            <div class="form-group">
                                <div class="col-xs-10 col-xs-offset-2">
                                    <asp:TextBox ID="tbOtherCategory" ClientIDMode="static" CssClass="form-control" placeholder="Please specify other organisation category" runat="server"></asp:TextBox>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtSubmitCategory" CausesValidation="false" class="btn btn-primary pull-right" runat="server">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <div id="modalLookupODS" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">ODS Lookup</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div id="odscheckgroup" class="form-group has-feedback">
                            <asp:Panel ID="Panel1" DefaultButton="btnCheckODS" runat="server">
                                <asp:Label ID="lblODS" AssociatedControlID="tbODSCode" CssClass="col-sm-3 control-label" runat="server" Text="ODS Code:"></asp:Label>
                                <div class="col-sm-7 col-md-7 col-lg-7">

                                    <asp:TextBox ID="tbODSCode" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>

                                    <span id="odsicon" class="glyphicon hidden form-control-feedback" aria-hidden="true"></span>
                                </div>
                                <div class="col-sm-2 col-md-2 col-lg-2">
                                    <asp:Button ID="btnCheckODS" OnClientClick="return false;" CssClass="btn btn-info btn-block" ClientIDMode="Static" runat="server" Text="Check" />
                                    <%--<button id="btnCheckODS" class="btn btn-info btn-wrap" type="button">Check</button>--%>
                                </div>
                            </asp:Panel>
                        </div>

                        <asp:Panel ID="Panel2" CssClass="form-group" runat="server" DefaultButton="btnSearchODS">
                            <asp:Label ID="Label5" AssociatedControlID="tbODSSearch" CssClass="col-sm-3 control-label" runat="server" Text="Or search:"></asp:Label>
                            <div class="col-sm-9">
                                <div class="input-group">
                                    <asp:TextBox ID="tbODSSearch" CssClass="form-control" placeholder="all or part of organisation name" ClientIDMode="Static" runat="server"></asp:TextBox>
                                    <span class="input-group-btn">
                                        <asp:LinkButton ID="btnSearchODS" CssClass="btn btn-default" ClientIDMode="Static" OnClientClick="return false;" runat="server"><i aria-hidden="true" class="icon-search"></i>Find</asp:LinkButton>

                                        <%-- <button class="btn btn-default" id="btnSearchODS" type="button"></button>--%>
                                    </span>
                                </div>
                            </div>
                        </asp:Panel>

                        <div class="collapse" id="collapseODSResults">
                            <div class="col-sm-9 col-sm-offset-3">
                                <div class="panel panel-default">
                                    <div id="odsresultsheading" class="panel-heading">Results</div>
                                    <ul class='list-group' id='ods-list-box'>
                                        <!--odschoices-->
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div id="modalLabel"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtSubmitIdentifier" CausesValidation="false" class="btn btn-primary pull-right" runat="server">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <div id="modalEditSingleOrg" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">
                        <asp:Label ID="lblSOOrgTitle" runat="server" Text="Label"></asp:Label>
                        single organisation licence</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label class="control-label col-xs-4" for="tbAddress">Licensed:</label>
                            <div class="col-xs-8">
                                <asp:CheckBox ID="cbSOLicence" ClientIDMode="Static" runat="server" />

                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-xs-4" for="tbAddress">Licence end date:</label>
                            <div class="col-xs-8">
                                <asp:TextBox ID="tbSOLicenceEndDate" CssClass="form-control" ClientIDMode="Static" runat="server"></asp:TextBox>

                            </div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtUpdateSOLicence" CausesValidation="false" class="btn btn-primary pull-right" runat="server">OK</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!-- Standard Modal Message  -->
    <div id="modalMessage" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="lblModalHeading" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">
                        <asp:Label ID="lblModalHeading" runat="server" Text="Label"></asp:Label></h4>
                </div>
                <div class="modal-body">
                    <p>
                        <asp:Label ID="lblModalText" runat="server" Text="Label"></asp:Label>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
   
            <uc1:OrgDetailsModal runat="server" ID="OrgDetailsModal" />
        
    <script src="../Scripts/odssearch.js"></script>
    <script type="text/javascript">
        Sys.Application.add_load(BindEvents);
    </script>
</asp:Content>
