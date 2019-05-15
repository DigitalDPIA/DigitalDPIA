<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="OrgDetailsModal.ascx.vb" Inherits="InformationSharingPortal.OrgDetailsModal" %>
 <asp:ObjectDataSource ID="dsOrganisationDetails" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.isporganisationsTableAdapters.OrganisationAssuranceDetailTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="OrganisationID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
<div id="modalOrgDetails" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>--%>
                <asp:FormView ID="fvOrgDetails" RenderOuterTable="false" DefaultMode="ReadOnly" runat="server" DataKeyNames="OrganisationID" DataSourceID="dsOrganisationDetails">
                    <ItemTemplate>
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">
                                <asp:Label ID="lblOrgName" runat="server" Text='<%# PadID(Eval("OrganisationID")) & " - " & Eval("OrganisationName")%>'></asp:Label></h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="panel panel-info">
                                        <div class="panel-heading">
                                            Organisation details
                                        </div>
                                        <div class="panel-body">
                                            <div class="well">
                                                <b>
                                                    <asp:Label ID="OrganisationNameLabel" runat="server" Text='<%# Eval("OrganisationName")%>' /></b><br />
                                                <asp:Label ID="lblAddress" runat="server" Text='<%# FixCrLf(Eval("OrganisationAddress"))%>' /><br />
                                            </div>
                                            <div class="list-group">
                                                <div class="list-group-item">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <b>DPIA Registered:</b>
                                                </div>
                                                <div class="col-xs-6">
                                                    <asp:Label ID="ISPFirstRegisteredDateLabel" runat="server" Text='<%# Eval("ISPFirstRegisteredDate", "{0:d}")%>' />
                                                </div>
                                                </div></div>
                                                <div class="list-group-item">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <b>DPIA MOU Signed:</b>
                                                </div>
                                                <div class="col-xs-6">
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("MOUSigned", "{0:d}")%>' />
                                                </div>
                                                </div></div>
                                                
                                                <div class="list-group-item">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <b>DPIA Admin Group:</b>
                                                </div>
                                                <div class="col-xs-6">
                                                    <asp:Label ID="AdminGroupLabel" runat="server" Text='<%# Eval("AdminGroup")%>' />
                                                </div>
                                                </div></div><div runat="server" Visible='<%# Not Eval("Sponsor") = "None"%>'  class="list-group-item">
                                            <div class="row">
                                                
                                                    <div class="col-xs-6">
                                                        <b>Supported by:</b>
                                                    </div>
                                                    <div class="col-xs-6">
                                                        <asp:Label ID="SponsorLabel" runat="server" Text='<%# Eval("Sponsor")%>' />
                                                    </div>
                                            
                                            </div></div>
                                                </div>
                                        </div>
                                    </div>
                                    <div runat="server" visible='<%# Eval("OrgContactName").ToString.Length + Eval("OrgContactEmail").ToString.Length + Eval("OrgContactEmail").ToString.Length > 0%>' class="panel panel-info">
                                        <div class="panel-heading">
                                            Contact details
                                        </div>
                                        <div class="panel-body">
                                            <p>
                                                <asp:Label ID="Label7" CssClass="sr-only" AssociatedControlID="lblContactName" runat="server" Text="Name:"></asp:Label>
                                            </p>
                                            <div runat="server" visible='<%# Eval("OrgContactName").ToString <> ""%>' class="row">
                                                <div class="col-xs-1">
                                                    <i class="glyphicon glyphicon-user" aria-hidden="true"></i>
                                                </div>
                                                <div class="col-xs-11">
                                                    <asp:Label ID="lblContactName" runat="server" Text='<%# Eval("OrgContactName")%>'></asp:Label>
                                                </div>
                                            </div>
                                            <p>
                                                <asp:Label ID="Label8" CssClass="sr-only" AssociatedControlID="lblContactEmail" runat="server" Text="E-mail:"></asp:Label>
                                            </p>
                                            <div runat="server" visible='<%# Eval("OrgContactEmail").ToString <> ""%>' class="row">
                                                <div class="col-xs-1">
                                                    <i class="glyphicon glyphicon-envelope" aria-hidden="true"></i>
                                                </div>
                                                <div class="col-xs-11">
                                                    <a id="A1" runat="server" href='<%# "mailto:" & Eval("OrgContactEmail")%>'>
                                                        <asp:Label ID="lblContactEmail" runat="server" Text='<%# Eval("OrgContactEmail")%>'></asp:Label></a>
                                                </div>
                                            </div>
                                            <p>
                                                <asp:Label ID="Label9" CssClass="sr-only" AssociatedControlID="lblContactPhone" runat="server" Text="Phone:"></asp:Label>
                                            </p>
                                            <div runat="server" visible='<%# Eval("OrgContactPhone").ToString <> ""%>' class="row">
                                                <div class="col-xs-1">
                                                    <i class="glyphicon glyphicon-earphone" aria-hidden="true"></i>
                                                </div>
                                                <div class="col-xs-11">
                                                    <asp:Label ID="lblContactPhone" runat="server" Text='<%# Eval("OrgContactPhone")%>'></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <h4></h4>

                                </div>
                                <div class="col-md-6">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">Privacy Notice</div>
                                        
                                            <div class="panel-body">
                                <asp:Label ID="lblNoPrivacyNotice" Visible="false" runat="server" Text="Privacy Notice not yet supplied."></asp:Label>
                                <asp:Panel ID="pnlPrivacyURL" CssClass="row" Visible='<%# Eval("PrivacyNoticeURL").ToString.Length > 4%>' runat="server">

                                    <div class="col-md-4">Privacy Notice Link:</div>
                                    <div class="col-md-8 clearfix">
                                        <a runat="server" target="_blank" href='<%# Eval("PrivacyNoticeURL")%>'>
                                            <%# Eval("OrganisationName")%> Privacy Notice</a>
                                    </div>
                                </asp:Panel>
                                <asp:panel id="pnlPNFiles" runat="server" class="row">
                                    <asp:HiddenField ID="hfOrganisationID" runat="server" Value='<%# Eval("OrganisationID")%>' />
                                    <asp:ObjectDataSource OnSelected="dsPNFiles_Selected" ID="dsPNFiles" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByGroupTypeAndID" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_FilesByGroupTableAdapter">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="orgprivacy" Name="GroupType" Type="String" />
                                    <asp:ControlParameter ControlID="hfOrganisationID" DefaultValue="0" Name="ID" PropertyName="Value" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                                    <div class="panel panel-default">
                                        <table class="table table-striped">
                                            <asp:Repeater ID="rptPNFiles" runat="server" DataSourceID="dsPNFiles">
                                                <HeaderTemplate>
                                                    <div class="table-responsive">
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <asp:HyperLink ID="hlFile" runat="server"
                                                                NavigateUrl='<%# Eval("FileID", "GetFile.aspx?FileID={0}")%>'>
                                                                <i id="I1" aria-hidden="true" class='<%# Eval("Type")%>' runat="server"></i>
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("FileName")%>'></asp:Label>
                                                            </asp:HyperLink>
                                                        </td>
                                                      </tr>
                                                </ItemTemplate>
                                                <FooterTemplate></div></FooterTemplate>
                                            </asp:Repeater>
                                        </table>
                                    </div>
                                </asp:panel>
                            </div>
                                    </div>
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            Data Protection Officer
                                        </div>
                                        <div class="panel-body">
                                           
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("DPO")%>' />
                                        
                                           
                                        </div>
                                    </div>
                                    <div class='<%# "panel " + GetPanelClass(Eval("AssuranceScore"))%>'>
                                        <div class="panel-heading">
                                            <span id="Span1" runat="server" visible='<%# Eval("AssuranceScore") = 0%>'>Assurance Level: Significant Assurance
                                            </span>
                                            <span id="Span2" runat="server" visible='<%# Eval("AssuranceScore") = 1%>'>Assurance Level: Limited Assurance
                                            </span>
                                            <span id="Span3" runat="server" visible='<%# Eval("AssuranceScore") > 1%>'>Assurance Level: No Assurance
                                            </span>
                                            <span id="Span4" runat="server" visible='<%# Eval("AssuranceScore") = -10%>'>Assurance Expired
                                            </span>
                                            <span id="Span5" runat="server" visible='<%# Eval("AssuranceScore") = -1%>'>Assurance Not Yet Submitted
                                            </span>
                                        </div>
                                        <div class="list-group">
                                            <div class="list-group-item">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <b>ICO Number:</b>
                                                </div>
                                                <div class="col-xs-6">
                                                    <asp:Label ID="ICORegistrationNumberLabel" runat="server" Text='<%# Eval("ICORegistrationNumber") %>' />
                                                </div>
                                            </div></div>
                                            <div class="list-group-item">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <b>ICO Review Date:</b>
                                                </div>
                                                <div class="col-xs-6">
                                                    <asp:Label ID="AssuranceValidToLabel" runat="server" Text='<%# Eval("AssuranceValidTo", "{0:d}") %>' />
                                                </div>
                                            </div></div>
                                            
                                            <%--<asp:Panel ID="Panel1" runat="server" Visible='<%# Eval("AssuranceScore") >= 0%>'>--%>
                                          
                                                <div runat="server" Visible='<%# Eval("AssuranceScore") >= 0%>' class="list-group-item"><div class="row">
                                                <div class="col-xs-6">
                                                    <b>Assurance Framework:</b>
                                                </div>

                                                <div class="col-xs-6">
                                                    <asp:Label ID="AssuranceFrameworkLabel" runat="server" Text='<%# Eval("AssuranceFramework") %>' />
                                                </div>
                                            </div>
                                                </div>
                                            
                                            <div runat="server" Visible='<%# Not Eval("IGComplianceVersion").ToString = "" >= 0%>' class="list-group-item">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <b>Framework Version:</b>
                                                </div>
                                                <div class="col-xs-6">
                                                    <asp:Label ID="IGComplianceVersionLabel" runat="server" Text='<%# Eval("IGComplianceVersion") %>' />
                                                </div>
                                            </div>
                                                </div>
                                            <div runat="server" Visible='<%# Not Eval("IGComplianceScore").ToString = "" %>' class="list-group-item">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <b>Framework Score:</b>
                                                </div>
                                                <div class="col-xs-6">
                                                    <asp:Label ID="IGComplianceScoreLabel" runat="server" Text='<%# Eval("IGComplianceScore") %>' />
                                                </div>
                                            </div>
                                                </div>
                                            <div runat="server" Visible='<%# Not Eval("IGNonComplianceReason").ToString = "" %>' class="list-group-item"><div class="row">
                                                <div class="col-xs-6">
                                                    <b>Assurance comments:</b>
                                                </div>

                                                <div class="col-xs-6">
                                                    <asp:Label ID="IGNonComplianceReason" runat="server" Text='<%# Eval("IGNonComplianceReason") %>' />
                                                </div>
                                            </div>
                                                </div>
                                            <div runat="server" Visible='<%# Eval("AssuranceScore") >= 0%>' class="list-group-item">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <b>Staff Screened?</b>
                                                </div>
                                                <div class="col-xs-6">
                                                    <asp:CheckBox ID="StaffScreenedCheckBox" runat="server" Checked='<%# Eval("StaffScreened") %>' Enabled="false" />
                                                </div>
                                            </div>
                                                </div>
                                            <div runat="server" Visible='<%# Eval("AssuranceScore") >= 0%>' class="list-group-item">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <b>Staff IG Trained?</b>
                                                </div>
                                                <div class="col-xs-6">
                                                    <asp:CheckBox ID="IGTrainingCheckBox" runat="server" Checked='<%# Eval("IGTraining") %>' Enabled="false" />
                                                </div>
                                            </div>
                                                </div>
                                            <div runat="server" Visible='<%# Eval("AssuranceScore") >= 0%>' class="list-group-item">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <b>Cyber Essentials Status:</b>
                                                </div>
                                                <div class="col-xs-6">
                                                    <asp:Label ID="CyberEssentialsStatusLabel" runat="server" Text='<%# Eval("CyberEssentialsStatus") %>' />
                                                </div>
                                            </div>
                                                </div>
                                                
                                        </div>
                                    </div>
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            DPIA Usage Overview
                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <b>Data Assets registered:</b>
                                                </div>
                                                <div class="col-xs-6">
                                                    <asp:Label ID="Label10" runat="server" Text='<%# Eval("DataAssets")%>' />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <b>Data Sharing Summaries:</b>
                                                </div>
                                                <div class="col-xs-6">
                                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("SharingSummaries")%>' />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <b>Data Flows:</b>
                                                </div>
                                                <div class="col-xs-6">
                                                    <asp:Label ID="DataFlowsLabel" runat="server" Text='<%# Eval("DataFlows") %>' />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:FormView>
                <%--</ContentTemplate><Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvOrgsSharing" />
                          </Triggers></asp:UpdatePanel>--%>

                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>