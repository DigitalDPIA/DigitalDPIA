<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="admin_lists.aspx.vb" Inherits="InformationSharingPortal.admin_lists" %>

<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxSpellChecker" Assembly="DevExpress.Web.ASPxSpellChecker.v17.2, Version=17.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageHeading" runat="server">

    <h1>Lists</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../Scripts/bootstrap/bootstrap-multiselect.js"></script>
    <script type="text/javascript">
        function BindEvents() {
            $(document).ready(function () {
                $('.multiselector').multiselect();
                $('.bs-pagination td table').each(function (index, obj) {
                    convertToPagination(obj)
                });

                $('[data-toggle="popover"]').popover();
                $(".date-picker").datepicker({ dateFormat: 'dd/mm/yy' });
                //$('input, textarea').placeholder({ customClass: 'my-placeholder' });
                $('.btn-file :file').on('fileselect', function (event, numFiles, label) {

                    var input = $(this).parents('.input-group').find(':text'),
                        log = numFiles > 1 ? numFiles + ' files selected' : label;

                    if (input.length) {
                        input.val(log);
                    } else {
                        if (log) alert(log);
                    }

                });
                //$('.toggleme').bootstrapToggle();
                //$("body").scrollspy({ target: "#MainContent_myScrollNav" })
            });
            $(document).on('change', '.btn-file :file', function () {
                var input = $(this),
                    numFiles = input.get(0).files ? input.get(0).files.length : 1,
                    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                input.trigger('fileselect', [numFiles, label]);
            });
        };
    </script>
    <div id="media" class="tab-pane">
        <ul class="nav nav-tabs">
            <li id="tabSuperAdmins" runat="server" class="active">
                <asp:LinkButton ID="lbtSuperAdmins" runat="server">Super Admins</asp:LinkButton></li>
            <li id="tabDomains" runat="server">
                <asp:LinkButton ID="lbtDomains" runat="server">Domains</asp:LinkButton></li>
<%--            <li id="tabAdminGroups" runat="server">
                <asp:LinkButton ID="lbtAdminGroups" runat="server">Admin Groups</asp:LinkButton></li>
            <li id="tabNotifications" runat="server">
                <asp:LinkButton ID="lbtNotifications" runat="server">Notifications</asp:LinkButton></li>
            <li id="tabApiKeys" runat="server">
                <asp:LinkButton ID="lbtAPIKeys" runat="server">Sharing Platforms / API Keys</asp:LinkButton></li>
            <li id="tabPickLists" runat="server">
                <asp:LinkButton ID="lbtPickLists" runat="server">Pick Lists</asp:LinkButton></li>--%>

        </ul>
    </div>
    <asp:ObjectDataSource ID="dsRegions" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.adminTableAdapters.isp_MapRegionsTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsDomains" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.adminTableAdapters.isp_DomainsTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_DomainID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Domain" Type="String" />
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="ShowInList" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Domain" Type="String" />
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="ShowInList" Type="Boolean" />
            <asp:Parameter Name="Original_DomainID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsSuperAdmins" runat="server" DeleteMethod="DeleteSuperAdmin"  SelectMethod="GetData" TypeName="InformationSharingPortal.adminTableAdapters.isp_SuperAdminsTableAdapter" >
        <DeleteParameters>
            <asp:Parameter Name="SuperAdminID" Type="Int32" />
        </DeleteParameters>
       
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="dsAdminGroups" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="InformationSharingPortal.adminTableAdapters.isp_AdminGroupsTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsAdminGroupsFull" runat="server" DeleteMethod="Delete" InsertMethod="InsertQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.adminTableAdapters.isp_AdminGroupsTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_AdminGroupID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="GroupName" Type="String" />
            <asp:Parameter Name="GroupContact" Type="String" />
            <asp:Parameter Name="ContractEndDate" Type="DateTime" />
            <asp:Parameter Name="EmailAddress" Type="String" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="Telephone" Type="String" />
            <asp:Parameter Name="RegionID" Type="Int32" />
            <asp:Parameter Name="OrganisationLicences" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="GroupName" Type="String" />
            <asp:Parameter Name="GroupContact" Type="String" />
            <asp:Parameter Name="ContractEndDate" Type="DateTime" />
            <asp:Parameter Name="EmailAddress" Type="String" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="Telephone" Type="String" />
            <asp:Parameter Name="RegionID" Type="Int32" />
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="Original_AdminGroupID" Type="Int32" />
            <asp:Parameter Name="OrganisationLicences" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsAPIKeys" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.adminTableAdapters.APIKeysTableAdapter" UpdateMethod="UpdateAPIKey" InsertMethod="InsertAPIKey">
        <InsertParameters>
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="OrganisationName" Type="String" />
            <asp:Parameter Name="ContactEmail" Type="String" />
            <asp:Parameter Name="IPApproved" Type="String" />
            <asp:Parameter Name="DFDTransferSystemPlatformID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="OrganisationName" Type="String" />
            <asp:Parameter Name="ContactEmail" Type="String" />
            <asp:Parameter Name="IPApproved" Type="String" />
            <asp:Parameter Name="DFDTransferSystemPlatformID" Type="Int32" />
            <asp:Parameter Name="Original_APIKeyID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsDFDTransferSystemPlatform" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.DFDTransferSystemPlatformTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsTransferPlatforms" runat="server" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.DFDTransferSystemPlatformTableAdapter" UpdateMethod="Update">
        <InsertParameters>
            <asp:Parameter Name="TransferSystemPlatform" Type="String" />
            <asp:Parameter Name="Active" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="TransferSystemPlatform" Type="String" />
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="Original_DFDTransferSystemPlatformID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:MultiView ID="mvManageLists" runat="server" ActiveViewIndex="1">
        <asp:View ID="vDomains" runat="server">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>Manage Approved Domains List</h4>
                </div>
                <div class="panel-body">
                    <asp:GridView ID="gvDomains" runat="server" CssClass="table table-striped" EmptyDataText="No domains found." HeaderStyle-CssClass="sorted-none" GridLines="None" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="DomainID" DataSourceID="dsDomains">
                        <Columns>
                            <asp:TemplateField ItemStyle-Width="100" ShowHeader="False">
                                
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbtEditDomain" CssClass="btn btn-default btn-sm" runat="server" CausesValidation="False" CommandName="EditD"   CommandArgument='<%# Eval("DomainID") %>'><i aria-hidden="true" class="icon-pencil"></i></asp:LinkButton>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Domain" ControlStyle-CssClass="form-control" HeaderText="Domain" SortExpression="Domain" />
                            <asp:CheckBoxField DataField="Active" HeaderText="Active" SortExpression="Active" />
                            <asp:CheckBoxField DataField="ShowInList" HeaderText="ShowInList" SortExpression="ShowInList" />
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbtDeleteDomain" runat="server" OnClientClick="return confirm('Are you sure that you wish to remove this domain?');" CssClass="btn btn-danger btn-xs" CausesValidation="False" CommandName="Delete" Text="" ToolTip="Remove"><i aria-hidden="true" class="icon-minus"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="sorted-none"></HeaderStyle>
                    </asp:GridView>
                </div>
                <div class="panel-footer">
                    <h4>Add Domain</h4>
                    <div class="form-horizontal">
                        <div class="form-group">
                            <asp:Label ID="lblDomainAdd" AssociatedControlID="tbDomainAdd" CssClass="col-md-2 control-label" runat="server" Text="Domain:"></asp:Label>
                            <div class="col-xs-7">
                                <asp:TextBox ID="tbDomainAdd" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvDomainAdd" ValidationGroup="AddDomain" ControlToValidate="tbDomainAdd" runat="server" Display="Dynamic" ErrorMessage="Required"></asp:RequiredFieldValidator>

                            </div>
                            <div class="col-xs-1">
                                <asp:CheckBox ID="cbShowInListAdd" ToolTip="Publish in accepted domains list" runat="server" />
                            </div>
                            <div class="col-xs-2">
                                <span class="input-group-btn">
                                    <asp:LinkButton ID="lbtAddDomain" ValidationGroup="AddDomain" CausesValidation="true" CssClass="btn btn-primary" ToolTip="Add Domain" runat="server"><i aria-hidden="true" class="icon-plus"></i> Add</asp:LinkButton>
                                </span>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </asp:View>
        <asp:View ID="vSuperAdmins" runat="server">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>Manage Super Administrator List</h4>
                </div>
                <div class="panel-body">
                    <asp:GridView ID="gvSuperAdmins" runat="server" CssClass="table table-striped" EmptyDataText="No super admins found." HeaderStyle-CssClass="sorted-none" GridLines="None" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="SuperAdminID" DataSourceID="dsSuperAdmins">
                        <Columns>
                            <asp:TemplateField ItemStyle-Width="100" ShowHeader="False">
                             
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbtEditSA" CssClass="btn btn-default btn-sm" runat="server" CausesValidation="False" CommandName="EditSA" CommandArgument='<%# Eval("SuperAdminID") %>'><i aria-hidden="true" class="icon-pencil"></i></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Width="100px" />
                            </asp:TemplateField>
                            <asp:BoundField  DataField="SuperAdminEmail" HeaderText="Super Admin Email" SortExpression="SuperAdminEmail">
                            </asp:BoundField>
                            <asp:BoundField  DataField="AdminGroups" HeaderText="Admin Groups" SortExpression="AdminGroups">
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="ContentManager" HeaderText="Content Manager" SortExpression="ContentManager" />
                            <asp:CheckBoxField DataField="CentralSA" HeaderText="Central SA" SortExpression="CentralSA" /> 
                            <asp:CheckBoxField DataField="Active" HeaderText="Active" SortExpression="Active" />
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbtDeleteSuperAdmin" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-danger btn-xs" OnClientClick="return confirm('Are you sure that you wish to remove this administrator?');" Text="" ToolTip="Remove"><i aria-hidden="true" class="icon-minus"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="sorted-none"></HeaderStyle>
                    </asp:GridView>
                </div>
                <div class="panel-footer clearfix">
                    <asp:LinkButton ID="lbtAddNewSA" CssClass="btn btn-primary pull-right" runat="server">Add Super Admin</asp:LinkButton>
                    </div>
            </div>

        </asp:View>
        <asp:View ID="vAdminGroups" runat="server">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>Admin Groups</h4>
                </div>
                <div class="panel-body">
                    <asp:GridView ID="gvAdminGroups" CssClass="table table-striped small" EmptyDataText="No admin groups found." HeaderStyle-CssClass="sorted-none" GridLines="None" AllowSorting="True" runat="server" AutoGenerateColumns="False" DataKeyNames="AdminGroupID" DataSourceID="dsAdminGroupsFull">
                        <Columns>
                            <asp:TemplateField ItemStyle-Width="100" ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success btn-sm" CausesValidation="True" CommandName="Update"><i aria-hidden="true" class="icon-checkmark"></i></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-danger btn-sm" CausesValidation="False" CommandName="Cancel"><i aria-hidden="true" class="icon-cross"></i></asp:LinkButton>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbtEditSA" CssClass="btn btn-default btn-sm" runat="server" CausesValidation="False" CommandName="Edit"><i aria-hidden="true" class="icon-pencil"></i></asp:LinkButton>
                                    <asp:LinkButton ID="lbtEmailLink" CssClass="btn btn-default btn-sm" ToolTip="E-mail admin group link" CommandName="EmailLink" CommandArgument='<%# Eval("GroupName")%>' runat="server"><i aria-hidden="true" class="icon-mail"></i><!--[if lt IE 8]>Email<![endif]--></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Width="100px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Group Name" SortExpression="GroupName">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" TextMode="MultiLine" Rows="5" CssClass="form-control" runat="server" Text='<%# Bind("GroupName") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>

                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("GroupName") %>'></asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Contact" SortExpression="GroupContact">
                                <EditItemTemplate>
                                    <div class="form-group-sm">
                                        <asp:TextBox ID="TextBox4" CssClass="form-control" runat="server" Text='<%# Bind("GroupContact") %>'></asp:TextBox>
                                    </div>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("GroupContact") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Contract End" SortExpression="ContractEndDate">
                                <EditItemTemplate>
                                    <div class="form-group-sm">
                                        <asp:TextBox ID="TextBox5" CssClass="form-control date-picker" runat="server" Text='<%# Bind("ContractEndDate") %>'></asp:TextBox>
                                    </div>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("ContractEndDate", "{0:d}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email" SortExpression="EmailAddress">
                                <EditItemTemplate>
                                    <div class="form-group-sm">
                                        <asp:TextBox ID="TextBox1" CssClass="form-control" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:TextBox>
                                    </div>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                <EditItemTemplate>
                                    <asp:TextBox TextMode="MultiLine" CssClass="form-control small" Rows="5" ID="TextBox2" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# (Eval("Address")).Replace(vbCr, "").Replace(vbLf, vbCrLf).Replace(Environment.NewLine, "<br />") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Telephone" SortExpression="Telephone">
                                <EditItemTemplate>
                                    <div class="form-group-sm">
                                        <asp:TextBox ID="TextBox6" CssClass="form-control" runat="server" Text='<%# Bind("Telephone") %>'></asp:TextBox>
                                    </div>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("Telephone") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Region" SortExpression="Region">
                                <EditItemTemplate>
                                    <div class="form-group-sm">
                                        <asp:DropDownList ID="ddRegionEdit" CssClass="form-control" runat="server" DataSourceID="dsRegions" DataTextField="Region" DataValueField="RegionID" SelectedValue='<%# Bind("RegionID")%>'></asp:DropDownList>
                                    </div>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Region") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Org Licences" SortExpression="OrganisationLicences">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox7" CssClass="form-control" runat="server" Text='<%# Bind("OrganisationLicences") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Eval("RegisteredOrgs") & " / " & Eval("OrganisationLicences")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CheckBoxField DataField="Active" HeaderText="Active" SortExpression="Active" />
                        </Columns>

                        <HeaderStyle CssClass="sorted-none"></HeaderStyle>
                    </asp:GridView>
                </div>
                <div class="panel-footer">
                    <h4>Add Admin Group</h4>
                    <div class="form-horizontal">
                        <div class="form-group">
                            <asp:Label ID="lblGroupNameAdd" AssociatedControlID="tbGroupNameAdd" CssClass="col-md-3 control-label" runat="server" Text="Admin group name:"></asp:Label>
                            <div class="col-md-9">
                                <asp:TextBox ID="tbGroupNameAdd" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblGroupContactAdd" AssociatedControlID="tbGroupContactAdd" CssClass="col-md-3 control-label" runat="server" Text="Contact name:"></asp:Label>
                            <div class="col-md-9">
                                <asp:TextBox ID="tbGroupContactAdd" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblContractEndDateAdd" AssociatedControlID="tbContractEndDateAdd" CssClass="col-md-3 control-label" runat="server" Text="Contract End Date:"></asp:Label>
                            <div class="col-md-9">
                                <asp:TextBox ID="tbContractEndDateAdd" CssClass="form-control date-picker" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblEmailAdd" AssociatedControlID="tbEmailAdd" CssClass="col-md-3 control-label" runat="server" Text="Email:"></asp:Label>
                            <div class="col-md-9">
                                <asp:TextBox ID="tbEmailAdd" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblAddressAdd" AssociatedControlID="tbAddressAdd" CssClass="col-md-3 control-label" runat="server" Text="Address:"></asp:Label>
                            <div class="col-md-9">
                                <asp:TextBox ID="tbAddressAdd" TextMode="MultiLine" Rows="5" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblTelephoneAdd" AssociatedControlID="tbTelephoneAdd" CssClass="col-md-3 control-label" runat="server" Text="Telephone:"></asp:Label>
                            <div class="col-md-9">
                                <asp:TextBox ID="tbTelephoneAdd" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblOrganisationLicences" AssociatedControlID="tbTelephoneAdd" CssClass="col-md-3 control-label" runat="server" Text="Organisations licences:"></asp:Label>
                            <div class="col-md-9">
                                <asp:TextBox ID="tbOrganisationLicences" CssClass="form-control" Text="100" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblRegionAdd" AssociatedControlID="ddRegionAdd" CssClass="col-md-3 control-label" runat="server" Text="Region:"></asp:Label>
                            <div class="col-md-9">
                                <asp:DropDownList ID="ddRegionAdd" CssClass="form-control" runat="server" DataSourceID="dsRegions" DataTextField="Region" DataValueField="RegionID"></asp:DropDownList>

                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-12">
                                <span class="pull-right">
                                    <asp:LinkButton ID="lbtAddAdminGroup" ValidationGroup="AddAdminGroup" CausesValidation="true" CssClass="btn btn-primary" ToolTip="Add Admin Group" runat="server"><i aria-hidden="true" class="icon-plus"></i> Add</asp:LinkButton>
                                </span>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </asp:View>
        <asp:View ID="vNotifications" runat="server">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>Push Notifications</h4>
                </div>
                <div class="panel-body">
                    <dx:BootstrapCheckBox ID="bscbIncludeOld" runat="server" Text="Show expired notifications" Checked="False" AutoPostBack="true"></dx:BootstrapCheckBox>
                    <asp:ObjectDataSource ID="dsSANotifications" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.adminTableAdapters.SANotificationsTableAdapter" InsertMethod="InsertQuery" UpdateMethod="UpdateQuery">

                        <InsertParameters>
                            <asp:Parameter Name="SubjectLine" Type="String" />
                            <asp:Parameter Name="BodyHTML" Type="String" />
                            <asp:Parameter Name="ExpiryDate" Type="DateTime" />
                        </InsertParameters>

                        <SelectParameters>
                            <asp:ControlParameter ControlID="bscbIncludeOld" Name="IncludeOld" PropertyName="Value" Type="Boolean" />
                        </SelectParameters>

                        <UpdateParameters>
                            <asp:Parameter Name="SubjectLine" Type="String" />
                            <asp:Parameter Name="BodyHTML" Type="String" />
                            <asp:Parameter Name="ExpiryDate" Type="DateTime" />
                            <asp:Parameter Name="original_SANotificationID" Type="Int32" />
                        </UpdateParameters>

                    </asp:ObjectDataSource>
                    <dx:BootstrapGridView ID="bsgvSANotifications" runat="server" AutoGenerateColumns="False" DataSourceID="dsSANotifications" KeyFieldName="SANotificationID" EnableCallbackAnimation="True" SettingsBootstrap-Striped="True" SettingsCookies-Enabled="True" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">

                        <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" "></SettingsCommandButton>
                        <SettingsCookies Enabled="True" />
                        <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />
                        <SettingsBootstrap Striped="True" />
                        <Settings ShowHeaderFilterButton="True" />
                        <Columns>
                            <dx:BootstrapGridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0"></dx:BootstrapGridViewCommandColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="SubjectLine" VisibleIndex="1" SettingsEditForm-ColumnSpan="12">
                                <Settings AllowHeaderFilter="False" />
                                <SettingsEditForm ColumnSpan="12" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="BodyHTML" VisibleIndex="2" SettingsEditForm-ColumnSpan="12">
                                <Settings AllowHeaderFilter="False" />
                                <SettingsEditForm ColumnSpan="12" />
                                <DataItemTemplate>
                                    <asp:Literal ID="Literal1" runat="server" Text='<%# Eval("BodyHTML")%>'></asp:Literal>
                                </DataItemTemplate>
                                <EditItemTemplate>
                                    <dx:ASPxHtmlEditor ID="ASPxHtmlEditor1" runat="server" Html='<%# Bind("BodyHTML")%>' Width="100%"></dx:ASPxHtmlEditor>
                                </EditItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="DateAdded" ReadOnly="True" VisibleIndex="3">
                                <SettingsEditForm Visible="False" />
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="ExpiryDate" VisibleIndex="4" SettingsEditForm-ColumnSpan="12" Caption="Expiry Date" Name="Expiry Date">
                                <SettingsEditForm ColumnSpan="12" />
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Acks" FieldName="Acknolwedged" Name="Acknowledgements" ToolTip="User acknowledgements" VisibleIndex="5">
                                <SettingsEditForm Visible="False" />
                                <Settings AllowHeaderFilter="False" />
                            </dx:BootstrapGridViewTextColumn>
                        </Columns>
                        <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
                    </dx:BootstrapGridView>
                </div>
            </div>
        </asp:View>
        <asp:View ID="vAPIKeys" runat="server">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>Sharing Platforms</h4>
                </div>
                <div class="panel-body">
                    <dx:BootstrapGridView ID="bsGVTransferPlatforms" runat="server" AutoGenerateColumns="False" DataSourceID="dsTransferPlatforms" KeyFieldName="DFDTransferSystemPlatformID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                        <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />
                        <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                            <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                            <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                            <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                            <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                        </SettingsCommandButton>
                        <SettingsBootstrap Striped="True" />
                        <Columns>
                            <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                            </dx:BootstrapGridViewCommandColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="TransferSystemPlatform" VisibleIndex="1">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                            </dx:BootstrapGridViewCheckColumn>
                        </Columns>
                    </dx:BootstrapGridView>
                </div>
            </div>

            <div class="panel-body">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4>API Application Keys</h4>
                    </div>
                    <div class="panel-body">
                        <dx:BootstrapGridView ID="bsgvAPIKeys" runat="server" AutoGenerateColumns="False" DataSourceID="dsAPIKeys" KeyFieldName="APIKeyID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                            <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                            <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                                <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                                <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                                <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                                <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                            </SettingsCommandButton>
                            <SettingsBootstrap Striped="True" />
                            <Columns>
                                <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                                </dx:BootstrapGridViewCommandColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="APIKeyGUID" VisibleIndex="1" ReadOnly="True">
                                    <SettingsEditForm Visible="False" />
                                </dx:BootstrapGridViewTextColumn>

                                <dx:BootstrapGridViewTextColumn Caption="Organisation" FieldName="OrganisationName" Name="Organisation" VisibleIndex="3">
                                    <SettingsEditForm ColumnSpan="12" />
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn Caption="Contact Email" FieldName="ContactEmail" Name="Contact Email" VisibleIndex="4">
                                    <SettingsEditForm ColumnSpan="12" />
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn Caption="IP Approved" FieldName="IPApproved" Name="IP Approved" VisibleIndex="5">
                                    <SettingsEditForm ColumnSpan="12" />
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn Caption="Transfer Platform" FieldName="DFDTransferSystemPlatformID" Name="Transfer Platform" VisibleIndex="7">
                                    <SettingsEditForm ColumnSpan="12" />
                                    <DataItemTemplate>
                                        <asp:Label ID="Label10" EnableViewState="false" runat="server" Text='<%# Eval("TransferPlatform") %>'></asp:Label>
                                    </DataItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList AppendDataBoundItems="true" ID="ddTransferPlatform" CssClass="form-control" runat="server" DataSourceID="dsDFDTransferSystemPlatform" DataTextField="TransferSystemPlatform" DataValueField="DFDTransferSystemPlatformID" SelectedValue='<%# Bind("DFDTransferSystemPlatformID") %>'>
                                            <asp:ListItem Value="" Text="Please select..."></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="8">
                                </dx:BootstrapGridViewCheckColumn>
                            </Columns>
                            <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
                        </dx:BootstrapGridView>
                    </div>
                </div>
            </div>
        </asp:View>
        <asp:View ID="vPickLists" runat="server">

            <div class="clearfix"><h3>Data Asset Pick Lists</h3></div>
            <asp:ObjectDataSource ID="dsSubjects" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_DataSubjectsTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DataSubjectID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="DataSubject" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="DataSubject" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DataSubjectID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvDataSubjects" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsSubjects" KeyFieldName="DataSubjectID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                        <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="DataSubject" SettingsEditForm-ColumnSpan="12" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <div class="col-lg-6">
                <asp:ObjectDataSource ID="dsFormats" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_DataFormatTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_DataFormatID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="DataFormat" Type="String" />
                        <asp:Parameter Name="Active" Type="Boolean" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="DataFormat" Type="String" />
                        <asp:Parameter Name="Active" Type="Boolean" />
                        <asp:Parameter Name="Original_DataFormatID" Type="Int32" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <dx:BootstrapGridView ID="bsgvDataFormats" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsFormats" KeyFieldName="DataFormatID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                        <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="DataFormat" SettingsEditForm-ColumnSpan="12" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <div class="col-lg-6">
                <asp:ObjectDataSource ID="dsTypes" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_DataTypesTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_DataTypeID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="DataType" Type="String" />
                        <asp:Parameter Name="Active" Type="Boolean" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="DataType" Type="String" />
                        <asp:Parameter Name="Active" Type="Boolean" />
                        <asp:Parameter Name="Original_DataTypeID" Type="Int32" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <dx:BootstrapGridView ID="bsgvDataTypes" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsTypes" KeyFieldName="DataTypeID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                        <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="DataType" SettingsEditForm-ColumnSpan="12" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <div class="row"><div class="col-lg-12"><h3>Data Sharing Summary Pick Lists</h3></div></div>
            <asp:ObjectDataSource ID="dsAccessors" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.adminTableAdapters.isp_DFAccessorsTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFAccessorID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="DFAccessorText" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="DFAccessorText" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFAccessorID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvAccessors" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsAccessors" KeyFieldName="DFAccessorID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                        <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="DFAccessorText" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsScheduleTwos" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.adminTableAdapters.isp_ScheduleTwosTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_ScheduleTwoID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ScheduleTwoText" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ScheduleTwoText" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_ScheduleTwoID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvScheduleTwos" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsScheduleTwos" KeyFieldName="ScheduleTwoID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                        <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="ScheduleTwoText" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsScheduleThrees" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.adminTableAdapters.isp_ScheduleThreesTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_ScheduleThreeID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ScheduleThreeText" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ScheduleThreeText" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_ScheduleThreeID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvScheduleThrees" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsScheduleThrees" KeyFieldName="ScheduleThreeID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                        <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="ScheduleThreeText" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <div class="row"><div class="col-lg-12"><h3>Data Flow Pick Lists</h3></div></div>
            <div class="row"><div class="col-lg-12"><h4>Data Flow Details</h4></div></div>
            <asp:ObjectDataSource ID="dsDFDDirectionOfFlow" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDDirectionOfFlowTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDDirectionOfFlowID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="DirectionOfFlow" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="DirectionOfFlow" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDDirectionOfFlowID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvDirectionOfFlow" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDDirectionOfFlow" KeyFieldName="DFDDirectionOfFlowID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="DirectionOfFlow" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
             <asp:ObjectDataSource ID="dsDFDFrequencyOfTransfer" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDFrequencyOfTransferTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDFrequencyOfTransferID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="FrequencyOfTransfer" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="FrequencyOfTransfer" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDFrequencyOfTransferID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
             <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvFrequencyOfTransfer" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDFrequencyOfTransfer" KeyFieldName="DFDFrequencyOfTransferID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="FrequencyOfTransfer" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDNumberOfRecords" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDNumberOfRecordsTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDNumberOfRecordsID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="NumberOfRecords" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="NumberOfRecords" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDNumberOfRecordsID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
             <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvNumberOfRecords" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDNumberOfRecords" KeyFieldName="DFDNumberOfRecordsID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="NumberOfRecords" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>

            <div class="row"><div class="col-lg-12"><h4>Transfer Modes and Controls</h4></div></div>
             <asp:ObjectDataSource ID="dsDFDElectronicAccessedOnSite" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDElectronicAccessedOnSiteTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDElectronicAccessedOnSiteID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ElectronicAccessedOnSite" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ElectronicAccessedOnSite" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDElectronicAccessedOnSiteID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
             <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvElectronicAccessedOnSite" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDElectronicAccessedOnSite" KeyFieldName="DFDElectronicAccessedOnSiteID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="ElectronicAccessedOnSite" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDElectronicByAutomated" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDElectronicByAutomatedTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDElectronicByAutomatedID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ElectronicByAutomated" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ElectronicByAutomated" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDElectronicByAutomatedID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
             <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvElectronicByAutomated" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDElectronicByAutomated" KeyFieldName="DFDElectronicByAutomatedID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="ElectronicByAutomated" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDElectronicByEmail" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDElectronicByEmailTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDElectronicByEmailID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ElectronicByEmail" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ElectronicByEmail" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDElectronicByEmailID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
             <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvElectronicByEmail" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDElectronicByEmail" KeyFieldName="DFDElectronicByEmailID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="ElectronicByEmail" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDElectronicByManual" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDElectronicByManualTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDElectronicByManualID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ElectronicByManual" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ElectronicByManual" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDElectronicByManualID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
             <div class="col-lg-6">
                <dx:BootstrapGridView ID="dsElectronicByManual" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDElectronicByManual" KeyFieldName="DFDElectronicByManualID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="ElectronicByManual" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDElectronicViaText" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDElectronicViaTextTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDElectronicViaTextID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ElectronicViaText" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ElectronicViaText" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDElectronicViaTextID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
             <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvElectronicViaText" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDElectronicViaText" KeyFieldName="DFDElectronicViaTextID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                        <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                         <dx:BootstrapGridViewTextColumn FieldName="ElectronicViaText" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDPaperByCourier" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDPaperByCourierTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDPaperByCourierID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="PaperByCourier" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="PaperByCourier" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDPaperByCourierID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
             <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvPaperByCourier" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDPaperByCourier" KeyFieldName="DFDPaperByCourierID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="PaperByCourier" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDPaperByDataSubject" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDPaperByDataSubjectTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDPaperByDataSubjectID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="PaperByDataSubject" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="PaperByDataSubject" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDPaperByDataSubjectID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
             <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvPaperByDataSubject" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDPaperByDataSubject" KeyFieldName="DFDPaperByDataSubjectID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="PaperByDataSubject" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDPaperByFax" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDPaperByFaxTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDPaperByFaxID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="PaperByFax" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="PaperByFax" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDPaperByFaxID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
             <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvPaperByFax" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDPaperByFax" KeyFieldName="DFDPaperByFaxID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="PaperByFax" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDPaperByStaff" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDPaperByStaffTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDPaperByStaffID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="PaperByStaff" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="PaperByStaff" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDPaperByStaffID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvPaperByStaff" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDPaperByStaff" KeyFieldName="DFDPaperByStaffID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="PaperByStaff" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDPaperByStandardPost" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDPaperByStandardPostTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDPaperByStandardPostID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="PaperByStandardPost" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="PaperByStandardPost" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDPaperByStandardPostID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvPaperByPost" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDPaperByStandardPost" KeyFieldName="DFDPaperByStandardPostID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="PaperByStandardPost" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDRemovableByCourier" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDRemovableByCourierTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDRemovableByCourierID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="RemovableByCourier" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="RemovableByCourier" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDRemovableByCourierID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvRemovableByCourier" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDPaperByCourier" KeyFieldName="DFDPaperByCourierID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="PaperByCourier" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDRemovableByStaff" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDRemovableByStaffTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDRemovableByStaffID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="RemovableByStaff" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="RemovableByStaff" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDRemovableByStaffID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvRemovableByStaff" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDRemovableByStaff" KeyFieldName="DFDRemovableByStaffID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="RemovableByStaff" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDRemovableByStandardPost" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDRemovableByStandardPostTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDRemovableByStandardPostID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="RemovableByStandardPost" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="RemovableByStandardPost" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDRemovableByStandardPostID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvRemovableByStandardPost" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDRemovableByStandardPost" KeyFieldName="DFDRemovableByStandardPostID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="RemovableByStandardPost" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>

            <div class="row"><div class="col-lg-12"><div class="alert alert-info">Manage the electronic system or platform for sharing options using the <b>Sharing Platform / API Keys</b> tab.</div></div></div>
            <div class="row"><div class="col-lg-12"><h4>Post Transfer Security</h4></div></div>
            <asp:ObjectDataSource ID="dsDFDStorageAfterTransfer" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDStorageAfterTransferTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDStorageAfterTransferID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="StorageAfterTransfer" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="StorageAfterTransfer" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDStorageAfterTransferID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvStorageAfterTransfer" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDStorageAfterTransfer" KeyFieldName="DFDStorageAfterTransferID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="StorageAfterTransfer" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDSecuredAfterTransfer" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDSecuredAfterTransferTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDSecuredAfterTransferID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="SecuredAfterTransfer" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SecuredAfterTransfer" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDSecuredAfterTransferID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvSecuredAfterTransfer" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDSecuredAfterTransfer" KeyFieldName="DFDSecuredAfterTransferID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="SecuredAfterTransfer" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
<asp:ObjectDataSource ID="dsDFDAccessedAfterTransfer" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDAccessedAfterTransferTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDAccessedAfterTransferID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="AccessedAfterTransfer" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="AccessedAfterTransfer" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDAccessedAfterTransferID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
             <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvAccessedAfterTransfer" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDAccessedAfterTransfer" KeyFieldName="DFDAccessedAfterTransferID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="AccessedAfterTransfer" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>

            <div class="row"><div class="col-lg-12"><h3>Privacy Impact Assessment</h3></div></div>
            <div class="row"><div class="col-lg-12"><h4>Assess the legal requirements and purpose</h4></div></div>
            <asp:ObjectDataSource ID="dsDFDPrivacyChanges" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDPrivacyChangesTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDPrivacyChangesID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="PrivacyChanges" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="PrivacyChanges" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDPrivacyChangesID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvPrivacyChanges" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDPrivacyChanges" KeyFieldName="DFDPrivacyChangesID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="PrivacyChanges" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>

            <asp:ObjectDataSource ID="dsDFDConsentModel" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDConsentModelTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDConsentModelID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ConsentModel" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ConsentModel" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDConsentModelID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvConsentModel" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDConsentModel" KeyFieldName="DFDConsentModelID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="ConsentModel" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>

            <div class="row"><div class="col-lg-12"><h4>Assess the provisions for the accuracy of the data</h4></div></div>
            <asp:ObjectDataSource ID="dsDFDUptodateAccurateComplete" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDUptodateAccurateCompleteTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDUptodateAccurateCompleteID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="UptodateAccurateComplete" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="UptodateAccurateComplete" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDUptodateAccurateCompleteID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvUptodateAccurateComplete" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDUptodateAccurateComplete" KeyFieldName="DFDUptodateAccurateCompleteID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="UptodateAccurateComplete" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <div class="row"><div class="col-lg-12"><h4>Assess the retention and disposal requirements</h4></div></div>
             <asp:ObjectDataSource ID="dsDFDRetentionDisposal" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDRetentionDisposalTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDRetentionDisposalID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="RetentionDisposal" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="RetentionDisposal" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDRetentionDisposalID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvRetentionDisposal" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDRetentionDisposal" KeyFieldName="DFDRetentionDisposalID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="RetentionDisposal" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <div class="row"><div class="col-lg-12"><h4>Assess the requirements for individuals to apply subject access requests</h4></div></div>
             <asp:ObjectDataSource ID="dsDFDSubjectAccessRequests" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDSubjectAccessRequestsTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDSubjectAccessRequestsID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="SubjectAccessRequests" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SubjectAccessRequests" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDSubjectAccessRequestsID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvSubjectAccessRequests" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDSubjectAccessRequests" KeyFieldName="DFDSubjectAccessRequestsID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="SubjectAccessRequests" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>

            <div class="row"><div class="col-lg-12"><h4>Assess the technical and organisational measures</h4></div></div>
             <asp:ObjectDataSource ID="dsDFDPoliciesProcessesSOPs" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDPoliciesProcessesSOPsTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDPoliciesProcessesSOPsID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="PoliciesProcessesSOPs" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="PoliciesProcessesSOPs" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDPoliciesProcessesSOPsID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvPoliciesProcessesSOPs" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDPoliciesProcessesSOPs" KeyFieldName="DFDPoliciesProcessesSOPsID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="PoliciesProcessesSOPs" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDIncidentManagement" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDIncidentManagementTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDIncidentManagementID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="IncidentManagement" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="IncidentManagement" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDIncidentManagementID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
             <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvIncidentManagement" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDIncidentManagement" KeyFieldName="DFDIncidentManagementID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="IncidentManagement" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDTrainingSystemData" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDTrainingSystemDataTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDTrainingSystemDataID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="TrainingSystemData" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="TrainingSystemData" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDTrainingSystemDataID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvTrainingSystemData" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDTrainingSystemData" KeyFieldName="DFDTrainingSystemDataID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="TrainingSystemData" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
<asp:ObjectDataSource ID="dsDFDBusinessContinuity" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDBusinessContinuityTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDBusinessContinuityID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="BusinessContinuity" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="BusinessContinuity" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDBusinessContinuityID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvBusinessContinuity" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDBusinessContinuity" KeyFieldName="DFDBusinessContinuityID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="BusinessContinuity" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            <asp:ObjectDataSource ID="dsDFDDisasterRecovery" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDDisasterRecoveryTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDDisasterRecoveryID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="DisasterRecovery" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="DisasterRecovery" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDDisasterRecoveryID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
             <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvDisasterRecovery" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDDisasterRecovery" KeyFieldName="DFDDisasterRecoveryID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="DisasterRecovery" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>

            <div class="row"><div class="col-lg-12"><h4>Assess the requirements of the data if it is being transferred outside of the EEA</h4></div></div>

            <asp:ObjectDataSource ID="dsDFDNonEEAExemptionsDerogations" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDNonEEAExemptionsDerogationsTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDNonEEAExemptionsDerogationsID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="NonEEAExemptionsDerogations" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="NonEEAExemptionsDerogations" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDNonEEAExemptionsDerogationsID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
             <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvNonEEAExemptionsDerogations" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDNonEEAExemptionsDerogations" KeyFieldName="DFDNonEEAExemptionsDerogationsID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="NonEEAExemptionsDerogations" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>







            
            
           
            
            
           
            
            <asp:ObjectDataSource ID="dsDFDSecuredReceivingOrg" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.DataFlowDetailTableAdapters.isp_DFDSecuredReceivingOrgTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_DFDSecuredReceivingOrgID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="SecuredReceivingOrg" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="IncludeInactive" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SecuredReceivingOrg" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Original_DFDSecuredReceivingOrgID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="col-lg-6">
                <dx:BootstrapGridView ID="bsgvSecuredReceivingOrg" SettingsPager-PageSize="20" runat="server" AutoGenerateColumns="False" DataSourceID="dsDFDSecuredReceivingOrg" KeyFieldName="DFDSecuredReceivingOrgID" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">
                    <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />

                    <SettingsPager PageSize="20">
                    </SettingsPager>

                    <SettingsCommandButton UpdateButton-CssClass="btn btn-primary pull-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-default" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-default" EditButton-RenderMode="button" EditButton-Text=" ">
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="icon-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary pull-right" IconCssClass="icon-checkmark" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-default" IconCssClass="icon-close" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-default" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsBootstrap Striped="True" />
                    <Columns>
                         <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="SecuredReceivingOrg" VisibleIndex="1">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="2">
                        </dx:BootstrapGridViewCheckColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
            
           
            
            
            
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

    <div id="modalManagSA" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="lblManageSATitle" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">
                        <asp:Label ID="lblManageSATitle" runat="server" Text="Add Super Administrator"></asp:Label></h4>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfSuperAdminID" runat="server" />
                  <div class="form-horizontal">
                        <div class="form-group">
                            <asp:Label ID="Label1" AssociatedControlID="tbSuperAdminEmail" CssClass="col-xs-4 control-label" runat="server" Text="Super Administrator E-mail:"></asp:Label>
                            <div class="col-xs-8">
                                <asp:TextBox ID="tbSuperAdminEmail" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="AddSA" ControlToValidate="tbSuperAdminEmail" runat="server" Display="Dynamic" ErrorMessage="Required"></asp:RequiredFieldValidator>

                            </div>
                        </div>
                      <div class="form-group">
                            <asp:Label ID="lblSAAdminGroup" AssociatedControlID="listAdminGroups" CssClass="col-xs-4 control-label" runat="server" Text="Admin group:"></asp:Label>
                            <div class="col-xs-8">
                                <asp:ListBox ID="listAdminGroups" runat="server" SelectionMode="Multiple" ClientIDMode="Static" CssClass="multiselector" DataSourceID="dsAdminGroups" DataTextField="GroupName" DataValueField="AdminGroupID"></asp:ListBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-8 col-xs-offset-4">
                            <asp:Label CssClass="control-label" ID="Label9" runat="server">
                                <asp:CheckBox ID="cbContentManager" runat="server" />
                                Pre-login Content Manager</asp:Label></div>
                        </div>
                      <div class="form-group">
                          <div class="col-xs-8 col-xs-offset-4">
                            <asp:Label CssClass="control-label" ID="Label11" runat="server">
                                <asp:CheckBox ID="cbCentralSA" runat="server" />
                                Central Super Administrator</asp:Label>
                              </div>
                        </div>
                        
                      

                    </div>

                </div>
                <div class="modal-footer">
                    <button id="Button1" runat="server" type="button" class="btn btn-default pull-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtAddSA" CssClass="btn btn-primary pull-right" runat="server">Insert</asp:LinkButton>
                    <asp:LinkButton ID="lbtUpdateSA" CssClass="btn btn-primary pull-right" runat="server">Update</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <div id="modalManagDomain" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="lblManageSATitle" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">
                        <asp:Label ID="lblManageDomainTitle" runat="server" Text="Add Domain"></asp:Label></h4>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfDomainID" runat="server" />
                  <div class="form-horizontal">                                              
                      <div class="form-group">
                            <asp:Label ID="Label17" AssociatedControlID="tbDomain" CssClass="col-xs-4 control-label" runat="server" Text="Domain:"></asp:Label>
                            <div class="col-xs-8">
                                <asp:TextBox ID="tbDomain" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="AddSA" ControlToValidate="tbDomain" runat="server" Display="Dynamic" ErrorMessage="Required"></asp:RequiredFieldValidator>

                            </div>
                      </div>
                      <div class="form-group">
                            <div class="col-xs-8 col-xs-offset-4">
                                <asp:Label CssClass="control-label" ID="Label18" runat="server">
                                    <asp:CheckBox ID="cbActive" runat="server" />
                                    Active</asp:Label>

                            </div>
                      </div>
                      <div class="form-group">
                          <div class="col-xs-8 col-xs-offset-4">
                            <asp:Label CssClass="control-label" ID="Label19" runat="server">
                                <asp:CheckBox ID="cbShowInList" runat="server" />
                                Show In List</asp:Label>
                          </div>
                      </div>                                              
                  </div>
                </div>
                <div class="modal-footer">
                    <button id="Button2" runat="server" type="button" class="btn btn-default pull-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtAddDom" CssClass="btn btn-primary pull-right" runat="server">Insert</asp:LinkButton>
                    <asp:LinkButton ID="lbtUpdateDomain" CssClass="btn btn-primary pull-right" runat="server">Update</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>


    
    <script>

        Sys.Application.add_load(BindEvents);
    </script>
</asp:Content>
