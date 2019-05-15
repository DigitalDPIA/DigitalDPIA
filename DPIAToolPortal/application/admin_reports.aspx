<%@ Page Title="" Language="vb" ValidateRequest="false" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="admin_reports.aspx.vb" Inherits="InformationSharingPortal.admin_reports" %>
<%@ Register Src="~/OrgDetailsModal.ascx" TagPrefix="uc1" TagName="OrgDetailsModal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <script src="ammap/ammap.js"></script>
    <script src="ammap/maps/js/unitedKingdomLow.js"></script>
    <script src="ammap/themes/dark.js"></script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageHeading" runat="server">
    <h1>DPIA Usage Dashboard</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<script src="../Scripts/jquery.loading.min.js"></script>
     <asp:Panel ID="pnlSADashboard" runat="server">
         <h3>Overall DPIA Usage</h3>
         <hr />
    <div class="table-responsive">
                <div class="panel panel-default">
                    <table Class="table table-striped">
                        <tr>
                            <td style="width:50%;">Total registered organisations:</td>
                            <td>
                                <asp:Label ID="lblSARegisteredOrganisations" runat="server" Text="Label"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Registered lead organisations:</td>
                            <td>
                                <asp:Label ID="lblSARegisteredLeadOrgs" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Registered supported organisations:</td>
                            <td>
                                <asp:Label ID="lblSARegisteredSponsoredOrgs" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Total registered users:</td>
                            <td>
                                <asp:Label ID="lblSARegisteredUsers" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Total current data flows:</td>
                            <td>
                                <asp:Label ID="lblSATotalDataflows" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                    </table>
                    </div>
        </div>
         <hr />
                    </asp:Panel>
    <div class="row">
        <div class="col-md-6">
<h3>Admin Group Details</h3>
        </div>
        <div class="col-md-6">
            <br />
 <asp:Panel ID="pnlAGFilter" runat="server" CssClass="form-inline pull-right"><div runat="server" id="divAGFilter" class="form-group"><asp:Label ID="lblAdminGroup" CssClass="filter-col" runat="server" Text="Admin Group:" AssociatedControlID="ddAdminGroupFilter"></asp:Label>
               <asp:DropDownList ID="ddAdminGroupFilter" CssClass="form-control input-sm" AutoPostBack="true" runat="server" DataSourceID="dsAdminGroups" DataTextField="GroupName" DataValueField="AdminGroupID">              
               </asp:DropDownList></div></asp:Panel>
        </div>
    </div>
    <asp:ObjectDataSource ID="dsAdminGroups" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveLimitedByAG" TypeName="InformationSharingPortal.adminTableAdapters.isp_AdminGroupsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="False" Name="IsCentralSA" SessionField="IsCentralSA" Type="Boolean" />
            <asp:SessionParameter DefaultValue="0" Name="SuperAdminID" SessionField="SuperAdminID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsAGDashboard" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.adminTableAdapters.isp_AdminGroupDashboardTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddAdminGroupFilter" DefaultValue="-1" Name="AdminGroupID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
     </asp:ObjectDataSource>
     <asp:ObjectDataSource ID="dsRegions" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.adminTableAdapters.isp_MapRegionsTableAdapter"></asp:ObjectDataSource>
    <div class="row">
   <div class="col-md-6">
    <asp:FormView ID="fvAGDashboard" RenderOuterTable="False" runat="server"  DataKeyNames="AdminGroupID" DataSourceID ="dsAGDashboard">
        <ItemTemplate>
            <div class="table-responsive">
                <div class="panel panel-default">

                    <table Class="table table-striped">
                         <tr>
                            <td style="width:50%;">Admin group name:</td>
                            <td>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("GroupName")%>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Region:</td>
                            <td>                     
                                <asp:HiddenField ClientIDMode="Static" ID="hfRegionID" runat="server" Value='<%# Eval("RegionID")%>'/>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Region")%>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Contact:</td>
                            <td>
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("GroupContact")%>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Email address:</td>
                            <td>
                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("EmailAddress")%>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Address:</td>
                            <td>
                                <asp:Label ID="Label5" runat="server" Text='<%# FixCrLf(Eval("Address"))%>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Telephone:</td>
                            <td>
                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("Telephone")%>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Contract renewal date:</td>
                            <td>
                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("ContractEndDate", "{0:d}")%>'></asp:Label></td>
                        </tr>
                        <tr runat="server" style='<%# HideIfZero((Eval("OrganisationLicences")))%>'>
                            <td style="width:50%;">Organisation licences:</td>
                            <td>
                                <asp:Label ID="Label8" runat="server" Text='<%# Eval("OrganisationLicences")%>'></asp:Label></td>
                        </tr>
                        </table>

                        </div>
      </div>
            <asp:LinkButton ID="lbtEdit" CssClass="btn btn-default pull-right" CommandName="Edit" runat="server">Edit details</asp:LinkButton>
            <div class="clearfix"></div>
    <hr />
    <h4>Admin Group DPIA Usage Stats</h4>
    <div class="table-responsive">
                <div class="panel panel-default">
                    <table Class="table table-striped">
                        <tr runat="server" style='<%# HideIfZero((Eval("OrganisationLicences")))%>'>
                            <td style="width:50%;">Licence usage:</td>
                            <td>
                                <div class="progress" style="min-width:150px;" Title='<%# "DPIA organisation setup " & Eval("UsagePercentage") & "% licences used."%>'>
  <div id="Div1" runat="server" class='<%# GetProgClass((Eval("UsagePercentage")))%>' role="progressbar" aria-valuenow='<%# Eval("UsagePercentage")%>'
  aria-valuemin="0" aria-valuemax="100" style='<%# "Width:" & Eval("UsagePercentage") & "%;"%>'>
                    <asp:Label ID="lblSetupPercent" runat="server" Text='<%# Eval("UsagePercentage") & "%"%>'></asp:Label>
       </div>
</div>

                            </td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Total registered organisations:</td>
                            <td>
                                <asp:Label ID="lblAGTotalOrgs" runat="server" Text='<%# Eval("TotalOrgs")%>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Registered lead organisations:</td>
                            <td>
                                <asp:Label ID="lblAGLeadOrgs" runat="server" Text='<%# Eval("LeadOrgs")%>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Registered supported organisations:</td>
                            <td>
                                <asp:Label ID="lblAGSponsoredOrgs" runat="server" Text='<%# Eval("SponsoredOrgs")%>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Organisation licences assigned:</td>
                            <td>
                                <asp:Label ID="Label9" runat="server" Text='<%# Eval("LicencesUsed")%>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Total registered users:</td>
                            <td>
                                <asp:Label ID="lblAGUser" runat="server" Text='<%# Eval("ActiveUsers")%>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Total current data flows:</td>
                            <td>
                                <asp:Label ID="lblAGDataflows" runat="server" Text='<%# Eval("DataFlows")%>'></asp:Label></td>
                        </tr>
                        </table>
                    </div>
         </div>
        </ItemTemplate>
        <EditItemTemplate>
            <div class="table-responsive">
                <div class="panel panel-default">

                    <table Class="table table-striped">
                         <tr>
                            <td style="width:50%;">Admin group name:</td>
                            <td>
                                <asp:TextBox ID="TextBox1" CssClass="form-control" runat="server" Text='<%# Bind("GroupName")%>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Region:</td>
                            <td>
                                <asp:DropDownList ID="ddRegionEdit" CssClass="form-control" runat="server" DataSourceID="dsRegions" DataTextField="Region" DataValueField="RegionID" SelectedValue='<%# Bind("RegionID")%>'></asp:DropDownList>
                               </td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Contact:</td>
                            <td>
                                <asp:TextBox ID="TextBox4" CssClass="form-control" runat="server" Text='<%# Bind("GroupContact") %>'></asp:TextBox>
                                </td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Email address:</td>
                            <td><asp:TextBox ID="TextBox2" CssClass="form-control" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:TextBox>
                                </td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Address:</td>
                            <td>
                                <asp:TextBox TextMode="MultiLine" CssClass="form-control small" Rows="5" ID="TextBox3" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Telephone:</td>
                            <td>
                                <asp:TextBox ID="TextBox6" CssClass="form-control" runat="server" Text='<%# Bind("Telephone") %>'></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Contract renewal date:</td>
                            <td>
                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("ContractEndDate", "{0:d}")%>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Organisation licences:</td>
                            <td>
                                <asp:Label ID="Label8" runat="server" Text='<%# Eval("OrganisationLicences")%>'></asp:Label></td>
                        </tr>
                        </table>
                        </div>
      </div>
            
              <asp:LinkButton ID="UpdateButton" cssclass="btn btn-primary pull-right" runat="server" CausesValidation="True" CommandName="Update"><i aria-hidden="true" class="icon-checkmark"></i> Update</asp:LinkButton>
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" cssclass="btn btn-default pull-left" runat="server" CausesValidation="False" CommandName="Cancel"><i aria-hidden="true" class="icon-close"></i> Cancel</asp:LinkButton>
<div class="clearfix"></div>
            <hr />
    <h4>Admin Group DPIA Usage Stats</h4>
    <div class="table-responsive">
                <div class="panel panel-default">
                    <table Class="table table-striped">
                        <tr>
                            <td style="width:50%;">Licence usage:</td>
                            <td>
                                <div class="progress" style="min-width:150px;" Title='<%# "DPIA organisation setup " & Eval("UsagePercentage") & "% licences used."%>'>
  <div id="Div1" runat="server" class='<%# GetProgClass((Eval("UsagePercentage")))%>' role="progressbar" aria-valuenow='<%# Eval("UsagePercentage")%>'
  aria-valuemin="0" aria-valuemax="100" style='<%# "Width:" & Eval("UsagePercentage") & "%;"%>'>
                    <asp:Label ID="lblSetupPercent" runat="server" Text='<%# Eval("UsagePercentage") & "%"%>'></asp:Label>
       </div>
</div>

                            </td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Total registered organisations:</td>
                            <td>
                                <asp:Label ID="lblAGTotalOrgs" runat="server" Text='<%# Eval("TotalOrgs")%>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Registered lead organisations:</td>
                            <td>
                                <asp:Label ID="lblAGLeadOrgs" runat="server" Text='<%# Eval("LeadOrgs")%>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Registered supported organisations:</td>
                            <td>
                                <asp:Label ID="lblAGSponsoredOrgs" runat="server" Text='<%# Eval("SponsoredOrgs")%>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Total registered users:</td>
                            <td>
                                <asp:Label ID="lblAGUser" runat="server" Text='<%# Eval("ActiveUsers")%>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:50%;">Total current data flows:</td>
                            <td>
                                <asp:Label ID="lblAGDataflows" runat="server" Text='<%# Eval("DataFlows")%>'></asp:Label></td>
                        </tr>
                        </table>
                    </div>
         </div>
        </EditItemTemplate>
    </asp:FormView>
      </div>
        <div class="col-md-6">
            <asp:HiddenField ID="hfAdminGroupID" ClientIDMode="Static" runat="server" />
            
            <asp:HiddenField ID="hfMapOrgID" ClientIDMode="Static" runat="server" />
            <div id="mapdiv" style="background: #3f3f4f; color: #ffffff; width: 100%; height: 670px; font-size: 11px;">
                </div>
        </div>
    </div>
     <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                    <ContentTemplate>
                        <asp:Button ID="btnGetOrgInfo" ClientIDMode="Static" runat="server" Text="Button" CssClass="hidden" />
                        <uc1:OrgDetailsModal runat="server" ID="OrgDetailsModal" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnGetOrgInfo" />
                    </Triggers>
                </asp:UpdatePanel>
    <script src="../Scripts/agmap.js"></script>
</asp:Content>
