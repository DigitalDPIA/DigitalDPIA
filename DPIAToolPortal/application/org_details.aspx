<%@ Page Title="Organisation Details" Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="org_details.aspx.vb" Inherits="InformationSharingPortal.org_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/geo.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageHeading" runat="server">
    <script src="../Scripts/bsasper.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //Lets do bootstrap form validation:
            $('[data-toggle="popover"]').popover();
            $("input, textarea").bsasper({
                placement: "right", createContent: function (errors) {
                    return '<span class="text-danger">' + errors[0] + '</span>';
                }
            });
        });
    </script>
    <h1>Organisation Details</h1>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ObjectDataSource ID="dsOrgTypes" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_OrgTypesTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsOrganisation" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_OrganisationsTableAdapter" UpdateMethod="Organisations_Update" DeleteMethod="Delete" InsertMethod="Insert">

        <DeleteParameters>
            <asp:Parameter Name="Original_OrganisationID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="OrganisationName" Type="String" />
            <asp:Parameter Name="OrganisationTypeID" Type="Int32" />
            <asp:Parameter Name="SponsorOrganisationID" Type="Int32" />
            <asp:Parameter Name="OrganisationAddress" Type="String" />
            <asp:Parameter Name="ISPFirstRegisteredDate" Type="DateTime" />
            <asp:Parameter Name="InactivatedDate" Type="DateTime" />
            <asp:Parameter DbType="Guid" Name="ISPFirstRegisteredBy" />
            <asp:Parameter Name="ICORegistrationNumber" Type="String" />
            <asp:Parameter Name="RegEvidenceFileID" Type="Int32" />
            <asp:Parameter Name="Longitude" Type="Double" />
            <asp:Parameter Name="Latitude" Type="Double" />
            <asp:Parameter Name="OrgContactPhone" Type="String" />
            <asp:Parameter Name="OrgContactEmail" Type="String" />
            <asp:Parameter Name="OrgContactName" Type="String" />
            <asp:Parameter Name="RequestClosureDate" Type="DateTime" />
            <asp:Parameter Name="RequestClosureReason" Type="String" />
            <asp:Parameter Name="County" Type="String" />
            <asp:Parameter Name="AdminGroupID" Type="Int32" />
            <asp:Parameter Name="Aliases" Type="String" />
            <asp:Parameter Name="Identifiers" Type="String" />
            <asp:Parameter Name="OrganisationCategoryID" Type="Int32" />
            <asp:Parameter Name="OrganisationCategoryOther" Type="String" />
            <asp:Parameter Name="PrivacyNoticeURL" Type="String" />
        </InsertParameters>

        <SelectParameters>
            <asp:SessionParameter Name="OrganisationID" SessionField="UserOrganisationID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="OrganisationName" Type="String" />
            <asp:Parameter Name="OrganisationTypeID" Type="Int32" />
            <asp:Parameter Name="SponsorOrganisationID" Type="Int32" />
            <asp:Parameter Name="OrganisationAddress" Type="String" />
            <asp:Parameter Name="ISPFirstRegisteredDate" Type="DateTime" />
            <asp:Parameter Name="InactivatedDate" Type="DateTime" />
            <asp:Parameter DbType="Guid" Name="ISPFirstRegisteredBy" />
            <asp:Parameter Name="ICORegistrationNumber" Type="String"></asp:Parameter>
            <asp:Parameter Name="RegEvidenceFileID" Type="Int32" />
            <asp:Parameter Name="Longitude" Type="Double" />
            <asp:Parameter Name="Latitude" Type="Double" />
            <asp:Parameter Name="OrgContactPhone" Type="String" />
            <asp:Parameter Name="OrgContactEmail" Type="String" />
            <asp:Parameter Name="OrgContactName" Type="String" />
            <asp:Parameter Name="RequestClosureDate" Type="DateTime" />
            <asp:Parameter Name="RequestClosureReason" Type="String" />
            <asp:Parameter Name="County" Type="String" />
            <asp:Parameter Name="AdminGroupID" Type="Int32" />
            <asp:Parameter Name="Aliases" Type="String" />
            <asp:Parameter Name="Identifiers" Type="String" />
            <asp:Parameter Name="OrganisationCategoryID" Type="Int32" />
            <asp:Parameter Name="OrganisationCategoryOther" Type="String" />
            <asp:Parameter Name="PrivacyNoticeURL" Type="String" />
            <asp:Parameter Name="Original_OrganisationID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsLeadOrgs" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveLeadOrganisations" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_OrganisationsTableAdapter">

        <SelectParameters>
            <asp:SessionParameter Name="OrganisationID" SessionField="UserOrganisationID" Type="Int32" />
        </SelectParameters>

    </asp:ObjectDataSource>
    <div class="panel panel-default">

        <asp:FormView ID="fvCentreDetails" runat="server" DataKeyNames="OrganisationID" DataSourceID="dsOrganisation" RenderOuterTable="False">
            <EditItemTemplate>
                <div class="panel-body">
                    <div class="col-md-6">
                        <asp:HiddenField ID="hfAdminGroupID" Value='<%# Bind("AdminGroupID")%>' runat="server" />
                        <asp:HiddenField ID="hfOrganisationID" Value='<%# Eval("OrganisationID")%>' runat="server" />
                        <asp:HiddenField ID="hfCategoryID" Value='<%# Bind("OrganisationCategoryID")%>' runat="server" />
                        <h3>DPIA Organisation ID</h3>
                        <asp:Label ID="lblISGID" runat="server" Text='<%# PadID(Eval("OrganisationID"))%>'></asp:Label>
                        <h3>Organisation Name</h3>
                        <asp:TextBox class="form-control" ID="OrganisationNameTextBox" runat="server" Text='<%# Bind("OrganisationName") %>' />
                        <asp:RequiredFieldValidator SetFocusOnError="true" ValidationGroup="vgOrgUpdate" ID="rfvOrgName" runat="server" ErrorMessage="Organisation name required" Text="Organisation name required" ControlToValidate="OrganisationNameTextBox" ToolTip="Organisation name required" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                        <h3>Organisation Aliases</h3>
                        <asp:TextBox class="form-control" ID="tbAliases" runat="server" Text='<%# Bind("Aliases")%>' />
                        <h3>Organisation Identifiers</h3>
                        <asp:TextBox class="form-control" ID="TextBox1" runat="server" Text='<%# Bind("Identifiers")%>' />
                        <h3>ICO Registration Number</h3>
                        <asp:TextBox class="form-control" ID="tbICORegistrationNumber" runat="server" Text='<%# Bind("ICORegistrationNumber")%>' />
                        <h3>ISG Administration Group</h3>
                        <asp:Label ID="lblAG" runat="server" Text='<%# Eval("AdminGroup")%>'></asp:Label>
                        <asp:UpdatePanel ID="upnlOrgReg1" runat="server" RenderMode="Inline">
                            <ContentTemplate>
                                <h3>Organisation Type</h3>
                                <p>
                                    <asp:DropDownList ID="ddOrgType" CssClass="form-control" runat="server" SelectedValue='<%# Bind("OrganisationTypeID") %>' AutoPostBack="True" OnSelectedIndexChanged="ddOrgType_SelectedIndexChanged" DataSourceID="dsOrgTypes" DataTextField="OrgType" DataValueField="OrgTypeID">
                                    </asp:DropDownList>
                                </p>
                                <asp:Panel ID="divSponsorOrg" Visible='<%# Eval("OrganisationTypeID") > 1%>' runat="server">
                                    <h3>Supporting Organisation</h3>
                                    <p>
                                        <asp:DropDownList ID="ddSponsorOrg" class="form-control" runat="server" DataSourceID="dsLeadOrgs" DataTextField="OrganisationName" DataValueField="OrganisationID" SelectedValue='<%# Bind("SponsorOrganisationID") %>'>
                                        </asp:DropDownList>
                                        <asp:CompareValidator Display="Dynamic" ID="cvSponsorOrg" runat="server" ErrorMessage="*" ControlToValidate="ddSponsorOrg" Operator="GreaterThan" ValueToCompare="0" Enabled="False" SetFocusOnError="True" ToolTip="Select your supporting organisation"></asp:CompareValidator>
                                    </p>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <h3>Organisation Address</h3>
                        <p>
                            <asp:TextBox ID="tbAddress" class="form-control" runat="server" Text='<%# Bind("OrganisationAddress") %>' TextMode="MultiLine" Rows="5" Style="min-width: 320px" ClientIDMode="Static" /></p>
                        <div class="form-group">
                            <label class="control-label" for="tbAddress">Map Location:</label>

                            <div class="input-group input-group-sm">
                                <span class="input-group-addon">County:</span>
                                <asp:TextBox ID="hfCounty" Text='<%# Bind("County")%>' runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                <span class="input-group-addon">Lat:</span>
                                <asp:TextBox ID="hfLattitude" Text='<%# Bind("Latitude")%>' CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                <span class="input-group-addon">Long:</span>
                                <asp:TextBox ID="hfLongitude" ClientIDMode="Static" Text='<%# Bind("Longitude")%>' CssClass="form-control" runat="server"></asp:TextBox>
                                <span class="input-group-btn">
                                    <asp:Button ID="Button1" CssClass="btn btn-success" runat="server" CausesValidation="false" OnClientClick="javascript:getGeoCode(); return false;" Text="Find" Font-Size="8pt" /></span>
                            </div>

                        </div>
                        <h3>Data Protection Officer</h3>
                        <p>
                            <asp:Label  ID="lblDPO" runat="server" Text='<%# Eval("DPO")%>' /><a tabindex="0" title="Specify Organisational DPO" class="btn btn-xs" role="button" data-toggle="popover" data-html="true"  data-container="body" data-trigger="focus" data-placement="auto" data-content="To specify your organisation's DPO or to mark your organisation as DPO exempt, please visit the <a href='org_users'>Organisation / Manage Users</a> tab."><i aria-hidden="true" class="icon-info"></i></a></p>
                        <h3>Registered By</h3>
                        <p>
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("RegisteredBy")%>' /></p>
                        <h3>First Registered</h3>
                        <p>
                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("ISPFirstRegisteredDate")%>' /></p>
                        <asp:TextBox ID="ISPFirstRegisteredByTextBox" runat="server" Text='<%# Bind("ISPFirstRegisteredBy") %>' Visible="False" />
                        <asp:TextBox ID="ISPFirstRegisteredDateTextBox" runat="server" Text='<%# Bind("ISPFirstRegisteredDate") %>' Visible="False" />
                        <asp:TextBox ID="InactivatedDateTextBox" runat="server" Text='<%# Bind("InactivatedDate") %>' Visible="False" />
                    </div>
                    <div class="col-md-6">
                        <div class="well">
                            <h3>Organisation Contact</h3>
                            <div class="form-group">
                                <asp:Label ID="Label7" CssClass="sr-only" AssociatedControlID="tbContactName" runat="server" Text="Name:"></asp:Label>
                                <div class="input-group">
                                    <div class="input-group-addon"><i class="glyphicon glyphicon-user" aria-hidden="true"></i></div>
                                    <asp:TextBox class="form-control" ID="tbContactName" runat="server" Text='<%# Bind("OrgContactName")%>' />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label8" CssClass="sr-only" AssociatedControlID="tbContactEmail" runat="server" Text="E-mail::"></asp:Label>
                                <div class="input-group">
                                    <div class="input-group-addon"><i class="glyphicon glyphicon-envelope" aria-hidden="true"></i></div>
                                    <asp:TextBox class="form-control" ID="tbContactEmail" runat="server" Text='<%# Bind("OrgContactEmail")%>' />
                                    <asp:RequiredFieldValidator SetFocusOnError="true" ValidationGroup="vgOrgDetails" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Organisation contact email required" Text="Organisation contact email required" ControlToValidate="tbContactEmail" ToolTip="Organisation contact email required" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label9" CssClass="sr-only" AssociatedControlID="tbContactPhone" runat="server" Text="Phone:"></asp:Label>
                                <div class="input-group">
                                    <div class="input-group-addon"><i class="glyphicon glyphicon-earphone" aria-hidden="true"></i></div>
                                    <asp:TextBox class="form-control" ID="tbContactPhone" runat="server" Text='<%# Bind("OrgContactPhone")%>' />
                                </div>
                            </div>
                        </div>
                          <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4>Organisation Privacy Notice</h4>
                            </div>
                            <div class="panel-body">
                                <asp:Panel ID="pnlPrivacy" CssClass="form-horizontal" runat="server">
                                    <div class="form-group">
                                    <asp:label runat="server" AssociatedControlID="tbPrivacyNotice" class="col-md-3 control-label">URL Link:</asp:label>
                                    <div class="col-md-9">
                                        <div class="input-group">

                                                     <span class="input-group-btn" id="discoverabilitytip">
                                                         <a tabindex="0" title="Discoverability level" class="btn btn-default btn-tooltip" role="button" data-toggle="popover"  data-container="body" data-trigger="focus" data-placement="auto" data-content="If your organisational privacy notice is available on the internet, please provide a web address here. This must include http://www or https://www"><i aria-hidden="true" class="icon-info"></i></a>
                                                     </span>
                                        <asp:TextBox ID="tbPrivacyNotice" CssClass="form-control" runat="server" Text='<%# Bind("PrivacyNoticeURL")%>'></asp:TextBox></div>
                                          <asp:RegularExpressionValidator ID="rxvPN" ControlToValidate="tbPrivacyNotice"
            Text="Provide a valid Internet URL including http: or https:" ValidationGroup="vgOrgDetails" Display="Dynamic" ValidationExpression="(http(s)?://)+([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?" runat="server" />
                                    </div></div>
                                
                                <div class="row">
                                    <asp:ObjectDataSource OnSelected="dsPNFiles_Selected" ID="dsPNFiles" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByGroupTypeAndID" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_FilesByGroupTableAdapter">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="orgprivacy" Name="GroupType" Type="String" />
                                    <asp:ControlParameter ControlID="hfOrganisationID" DefaultValue="0" Name="ID" PropertyName="Value" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                                    <div class="panel panel-default">
                                        <table class="table table-striped">
                                            <asp:Repeater ID="rptPrivacyFiles" OnItemCommand="rptFiles_ItemCommand" runat="server" DataSourceID="dsPNFiles">
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
                                                        <td style="width: 20px">
                                                            <asp:LinkButton  Visible='<%# Eval("OrganisationID") = Session("UserOrganisationID") Or Session("IsSuperAdmin")%>' ID="lbtDelete" OnClientClick="return confirm('Are you sure you want delete this file?');" runat="server" CommandName="Delete" CommandArgument='<%# Eval("FileID")%>' CssClass="btn btn-danger btn-xs" ToolTip="Delete File" CausesValidation="false"><i aria-hidden="true" class="icon-minus"></i><!--[if lt IE 8]>Delete<![endif]--></asp:LinkButton></td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate></div></FooterTemplate>
                                            </asp:Repeater>
                                        </table>
                                    </div>
                                    </div>
                                    <div class="form-group">
                                         
                                    <asp:label runat="server" AssociatedControlID="filPrivacyNotice" class="col-md-3 control-label">Upload:</asp:label>
                                    <div class="col-md-9">
                                        <div class="input-group">
                                         <span class="input-group-btn">
                                            <span class="btn btn-default btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="true" ID="filPrivacyNotice" runat="server" />
                                            </span>
                                        </span>
                                        <input type="text" placeholder="Max 5MB" class="form-control" readonly="true">
                                        <span class="input-group-btn">
                                            <asp:LinkButton ID="lbtUploadPrivacyNotice" OnClick="lbtUploadPrivacyNotice_Click" CausesValidation="false" CssClass="btn btn-default" runat="server"><i aria-hidden="true" class="icon-upload2"></i>  Upload</asp:LinkButton>
                                        </span>
                                    </div></div></div>
                                    </asp:Panel>
                                </div>
                            </div>
                        </div>
                    </div>
                
                <%--            <asp:HiddenField ID="hfAdminGroupID" Value='<%# Bind("AdminGroupID")%>' runat="server" />--%>
                <div class="panel-footer">
                    <asp:LinkButton ID="UpdateButton" ValidationGroup="vgOrgDetails" CssClass="btn btn-primary" runat="server" CausesValidation="True" CommandName="Update"><i aria-hidden="true" class="icon-checkmark"></i> Update</asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Cancel"><i aria-hidden="true" class="icon-close"></i> Cancel</asp:LinkButton>
                </div></div>
            </EditItemTemplate>
            <ItemTemplate>
                
                <div class="panel-body">
                    <div class="col-md-6">
                        <h3>ISG Organisation ID</h3>
                        <p>
                            <asp:Label ID="lblISGID" runat="server" Text='<%# PadID(Eval("OrganisationID"))%>'></asp:Label></p>
                        <h3>Organisation Name</h3>
                        <p>
                            <asp:Label ID="OrganisationNameLabel" runat="server" Text='<%# Eval("OrganisationName")%>' /></p>
                        <h3>Organisation Category</h3>
                        <p>
                            <asp:Label ID="Label13" runat="server" Text='<%# Eval("OrganisationCategory")%>' /></p>
                        <asp:Panel ID="pnlAlias" Visible='<%# Eval("Aliases").ToString.Length > 0%>' runat="server">
                            <h3>Organisation Aliases</h3>
                            <p>
                                <asp:Label ID="Label10" runat="server" Text='<%# Eval("Aliases")%>' /></p>
                        </asp:Panel>
                        <asp:Panel ID="pnlIdentifiers" Visible='<%# Eval("Identifiers").ToString.Length > 0%>' runat="server">
                            <h3>Organisation Identifiers</h3>
                            <p>
                                <asp:Label ID="Label11" runat="server" Text='<%# Eval("Identifiers")%>' /></p>
                        </asp:Panel>
                        <h3>ICO Registration Number</h3>
                        <p>
                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("ICORegistrationNumber")%>' /></p>
                        <h3>ISG Administration Group</h3>
                        <p>
                            <asp:Label ID="Label12" runat="server" Text='<%# Eval("AdminGroup")%>' /></p>
                        <h3>Organisation Type</h3>
                        <p>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("OrganisationType")%>' /></p>

                        <div runat="server" visible='<%# Eval("OrganisationTypeID") > 1%>'>
                            <h3>Supporting Organisation</h3>
                            <p>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("SponsorOrganisation")%>' /></p>
                        </div>

                        <h3>Organisation Address</h3>
                        <p>
                            <asp:Label ID="Label3" runat="server" Text='<%# FixCrLf(Eval("OrganisationAddress"))%>' /></p>
  <h3>Data Protection Officer</h3>
                        <p>
                            <asp:Label ID="lblDPO" runat="server" Text='<%# Eval("DPO")%>' /><a tabindex="0" title="Specify Organisational DPO" class="btn btn-xs" role="button" data-toggle="popover" data-html="true"  data-container="body" data-trigger="focus" data-placement="auto" data-content="To specify your organisation's DPO or to mark your organisation as DPO exempt, please visit the <a href='org_users'>Organisation / Manage Users</a> tab."><i aria-hidden="true" class="icon-info"></i></a></p>
                        <h3>Registered By</h3>
                        <p>
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("RegisteredBy")%>' /></p>

                        <h3>First Registered</h3>
                        <p>
                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("ISPFirstRegisteredDate")%>' />
                           <asp:LinkButton  visible='<%# Not Session("orgLicenceType") = "Free, limited licence" %>' cssclass="btn btn-sm btn-default" ID="btnAddEvidence" runat="server" ToolTip="Upload evidence supporting registration" OnClientClick="javascript:$('#modalUpload').modal('show');BindEvents();return false;"><i aria-hidden="true" class="icon-upload2"></i>Upload evidence</asp:LinkButton>
                        </p>
                        <asp:Panel ID="divEvidence" runat="server">
                            <h3>Registration Evidence</h3>
                            <asp:HiddenField ID="hfOrganisationID" Value='<%# Eval("OrganisationID")%>' runat="server" />
                            <asp:ObjectDataSource OnSelected="dsFilesSelected" ID="dsFiles" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByGroupTypeAndID" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_FilesByGroupTableAdapter">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="organisation" Name="GroupType" Type="String" />
                                    <asp:ControlParameter ControlID="hfOrganisationID" DefaultValue="0" Name="ID" PropertyName="Value" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                            <div class="panel panel-default">
                                <table class="table table-striped">
                                    <asp:Repeater ID="rptFiles" runat="server" DataSourceID="dsFiles">
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
                        </asp:Panel>
                    </div>
                    <div class="col-md-6">

                        <div class="well">
                            <h3>Organisation Contact</h3>

                            <p>

                                <asp:Label ID="Label7" CssClass="sr-only" AssociatedControlID="lblContactName" runat="server" Text="Name:"></asp:Label></p>
                            <div class="row">
                                <div class="col-xs-1">
                                    <i class="glyphicon glyphicon-user" aria-hidden="true"></i>
                                </div>
                                <div class="col-xs-11">
                                    <asp:Label ID="lblContactName" runat="server" Text='<%# Eval("OrgContactName")%>'></asp:Label>
                                </div>
                            </div>
                            <p>
                                <asp:Label ID="Label8" CssClass="sr-only" AssociatedControlID="lblContactEmail" runat="server" Text="E-mail:"></asp:Label></p>
                            <div class="row">
                                <div class="col-xs-1">
                                    <i class="glyphicon glyphicon-envelope" aria-hidden="true"></i>
                                </div>
                                <div class="col-xs-11">
                                    <a id="A1" runat="server" href='<%# "mailto:" & Eval("OrgContactEmail")%>'>
                                        <asp:Label ID="lblContactEmail" runat="server" Text='<%# Eval("OrgContactEmail")%>'></asp:Label></a>
                                </div>
                            </div>
                            <p>
                                <asp:Label ID="Label9" CssClass="sr-only" AssociatedControlID="lblContactPhone" runat="server" Text="Phone:"></asp:Label></p>
                            <div class="row">
                                <div class="col-xs-1">
                                    <i class="glyphicon glyphicon-earphone" aria-hidden="true"></i>
                                </div>
                                <div class="col-xs-11">
                                    <asp:Label ID="lblContactPhone" runat="server" Text='<%# Eval("OrgContactPhone")%>'></asp:Label>
                                </div>
                            </div>
                        </div>
                        <asp:panel ID="pnlPrivacy" runat="server" class="panel panel-default">
                            <div class="panel-heading">
                                <h4>Organisation Privacy Notice</h4>
                            </div>
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
                        </asp:panel>
                        <asp:ObjectDataSource ID="dsLicenceInfo" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.adminTableAdapters.GetOrganisationLicenceStatusTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter Name="OrganisationID" SessionField="UserOrganisationID" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:FormView ID="fvLicenceInfo" RenderOuterTable="false" DefaultMode="ReadOnly" DataSourceID="dsLicenceInfo" DataKeyNames="OrganisationID" runat="server">
                            <ItemTemplate>
                                <div class="panel panel-info">
                                    <div class="panel-heading">
                                        <h4>Organisation ISG Licence Information</h4>
                                    </div>
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-md-4">Licence type:</div>
                                            <div class="col-md-8">
                                                <asp:Label ID="Label14" runat="server" Text='<%# Eval("LicenceType")%>'></asp:Label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">Licence end date:</div>
                                            <div class="col-md-8">
                                                <asp:Label ID="Label15" runat="server" Text='<%# IIf(Eval("EndDate").ToString.Length = 0, "Not applicable", Eval("EndDate", "{0:d}")) %>'></asp:Label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">Support administrator:</div>
                                            <div class="col-md-8">
                                                <asp:Label ID="Label16" runat="server" Text='<%# Eval("SuperAdmin")%>'></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:FormView>
                    </div>
                </div>
                <div class="panel-footer clearfix">
                    <asp:LinkButton ID="EditButton" CssClass="btn btn-primary" runat="server" CausesValidation="False" CommandName="Edit"><i aria-hidden="true" class="icon-pencil"></i> Edit</asp:LinkButton>

                    <asp:LinkButton Visible='<%#Eval("RequestClosureDate").ToString.Length = 0%>' ID="lbtRequestClosure" CssClass="btn btn-danger pull-right" runat="server" ToolTip="Request that this organisation is removed from the ISG" CausesValidation="False" CommandName="CloseOrg"><i aria-hidden="true" class="icon-notification"></i> Request Closure of Organisation</asp:LinkButton>
                    <span class="alert alert-warning pull-right" runat="server" visible='<%#Eval("RequestClosureDate").ToString.Length > 0%>' role="alert">Closure request submitted.</span>
                </div>


            </ItemTemplate>

        </asp:FormView>


    </div>
    <asp:HiddenField ID="hfUploadType" runat="server" />
    <div id="modalUpload" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">
                        <asp:Label ID="lblModalHeading" runat="server" Text="Upload Evidence Supporting Registration"></asp:Label></h4>
                </div>
                <div class="modal-body">


                    <div class="input-group">
                        <span class="input-group-btn">
                            <span class="btn btn-default btn-file">Browse&hellip;
                                <asp:FileUpload AllowMultiple="true" ID="filEvidence" runat="server" />
                            </span>
                        </span>
                        <input type="text" placeholder="(max 1 MB)" class="form-control" readonly />
                    </div>



                </div>
                <div class="modal-footer">
                    <asp:Label ID="lblModalText" runat="server" Text=""></asp:Label>
                    <asp:LinkButton CssClass="btn btn-primary" ID="lbtUploadEvidenceOK" CausesValidation="false" runat="server"><i aria-hidden="true" class="icon-upload2"></i> Upload</asp:LinkButton>
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
    <!-- Standard Modal Message  -->
    <div id="modalSupportingError" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">
                        Organisation Update Failed</h4>
                </div>
                <div class="modal-body">
                    <p>The organisation type could not be changed to "Supported Organisation" because this organisation is supporting other organisations itself.</p>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    <div id="modalRequestClose" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modalRequestCloseLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">
                        <asp:Label ID="modalRequestCloseTitle" runat="server" Text="Request organisation removal?"></asp:Label></h4>
                </div>
                <div class="modal-body">
                    <p>
                        <asp:Label ID="modalRequestCloseLabel" runat="server" Text="Are you sure that you would like to request the removal of this organisation from the ISG? The following Senior Officers and their delegates at this organisation will be notified by e-mail of the closure request:"></asp:Label>

                    </p>
                    <p class="alert alert-warning">
                        <asp:Label ID="lblSeniorUsers" runat="server" Text="Label"></asp:Label>
                    </p>
                    <div class="form-group">
                        <asp:Label ID="lblReason" runat="server" Text="Reason:" AssociatedControlID="tbReason"></asp:Label><asp:TextBox CssClass="form-control" ID="tbReason" runat="server" TextMode="MultiLine" Rows="2" MaxLength="255"></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="lbtRequestCloseConfirm" CssClass="btn btn-primary" runat="server" CausesValidation="True" CommandName="Update"><i aria-hidden="true" class="icon-checkmark"></i> Yes</asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="lbtRequestCloseCancel" CssClass="btn btn-default" data-dismiss="modal" runat="server" CausesValidation="False"><i aria-hidden="true" class="icon-close"></i> No</asp:LinkButton>

                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function BindEvents() {
            $(document).on('change', '.btn-file :file', function () {
                var input = $(this),
                    numFiles = input.get(0).files ? input.get(0).files.length : 1,
                    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                input.trigger('fileselect', [numFiles, label]);
            });

            $(document).ready(function () {
                $('.btn-file :file').on('fileselect', function (event, numFiles, label) {

                    var input = $(this).parents('.input-group').find(':text'),
                        log = numFiles > 1 ? numFiles + ' files selected' : label;

                    if (input.length) {
                        input.val(log);
                    } else {
                        if (log) alert(log);
                    }

                });
            });
        };
        Sys.Application.add_load(BindEvents);
    </script>
</asp:Content>
