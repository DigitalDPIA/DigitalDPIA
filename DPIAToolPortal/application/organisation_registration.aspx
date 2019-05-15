<%@ Page Title="Organisation Registration" Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="organisation_registration.aspx.vb" Inherits="InformationSharingPortal.organisation_registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeading" runat="server">
    <script src="../Scripts/bs.pagination.js"></script>
    <script src="../Scripts/bsasper.js"></script>
    <script src="../Scripts/geo.js"></script>
    <script src="../Scripts/odssearch.js"></script>
    <script src="../Scripts/jquery.loading.min.js"></script>
    <h1>Organisation Registration</h1>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">

        function BindEvents() {
            //Lets do bootstrap form validation:
            $("input[type=text], textarea, select").bsasper({
                placement: "bottom", createContent: function (errors) {
                    return '<span class="text-danger">' + errors[0] + '</span>';
                }
            });
            //$('#form1').validator()
            $(document).on('change', '.btn-file :file', function () {
                var input = $(this),
                    numFiles = input.get(0).files ? input.get(0).files.length : 1,
                    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                input.trigger('fileselect', [numFiles, label]);
            });
            $('[data-toggle="popover"]').popover();
            $('#ddCategory').on('change', function () {

                if ($('#ddCategory option:selected').text().trim() !== "Other" && $('#divOther').hasClass('collapse in')) {
                    $('#divOther').collapse('hide');
                };
                if ($('#ddCategory option:selected').text().trim() === "Other") {

                    $('#divOther').collapse('show');
                    $('#tbOtherCategory').focus();
                };

            });

            $(document).ready(function () {
                var ti = $('#hfTabIndex').val();
                $('#myTabs li:eq(' + ti + ') a').tab('show');
                $('.bs-pagination td table').each(function (index, obj) {
                    convertToPagination(obj)
                });
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
            });
        };
        function copyEmail() {
            document.getElementById('MainContent_tbContact').value = document.getElementById('MainContent_tbEmail').value;
        };
    </script>

    <asp:HiddenField ID="hfTabIndex" ClientIDMode="Static" Value="0" runat="server" />
    <asp:ObjectDataSource ID="dsLeadOrgs" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveLeadOrganisations" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_OrganisationsTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">

        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="OrganisationID" Type="Int32" />
        </SelectParameters>

    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsAdminGroups" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="InformationSharingPortal.adminTableAdapters.isp_AdminGroupsTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_AdminGroupID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="GroupName" Type="String" />
            <asp:Parameter Name="GroupContact" Type="String" />
            <asp:Parameter Name="CreatedDate" Type="DateTime" />
            <asp:Parameter Name="ContractEndDate" Type="DateTime" />
            <asp:Parameter Name="EmailAddress" Type="String" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="Telephone" Type="String" />
            <asp:Parameter Name="RegionID" Type="Int32" />
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="OrganisationLicences" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="GroupName" Type="String" />
            <asp:Parameter Name="GroupContact" Type="String" />
            <asp:Parameter Name="CreatedDate" Type="DateTime" />
            <asp:Parameter Name="ContractEndDate" Type="DateTime" />
            <asp:Parameter Name="EmailAddress" Type="String" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="Telephone" Type="String" />
            <asp:Parameter Name="RegionID" Type="Int32" />
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="OrganisationLicences" Type="Int32" />
            <asp:Parameter Name="Original_AdminGroupID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsICOOrgs" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByICOorODS" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_OrganisationsTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
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
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="ICONumber" Type="String" />
            <asp:Parameter Name="ODSCode" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="OrganisationName" Type="String" />
            <asp:Parameter Name="OrganisationTypeID" Type="Int32" />
            <asp:Parameter Name="SponsorOrganisationID" Type="Int32" />
            <asp:Parameter Name="OrganisationAddress" Type="String" />
            <asp:Parameter DbType="Guid" Name="ISPFirstRegisteredBy" />
            <asp:Parameter Name="ISPFirstRegisteredDate" Type="DateTime" />
            <asp:Parameter Name="ICORegistrationNumber" Type="String" />
            <asp:Parameter Name="RegEvidenceFileID" Type="Int32" />
            <asp:Parameter Name="Original_OrganisationID" Type="Int32" />
            <asp:Parameter Name="InactivatedDate" Type="DateTime" />
            <asp:Parameter Name="Longitude" Type="Double" />
            <asp:Parameter Name="Latitude" Type="Double" />
            <asp:Parameter Name="OrgContactEmail" Type="String" />
            <asp:Parameter Name="OrgContactPhone" Type="String" />
            <asp:Parameter Name="OrgContactName" Type="String" />
            <asp:Parameter Name="RequestClosureDate" Type="DateTime" />
            <asp:Parameter Name="RequestClosureReason" Type="String" />
            <asp:Parameter Name="County" Type="String" />
            <asp:Parameter Name="Aliases" Type="String" />
            <asp:Parameter Name="Identifiers" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>


    <asp:ObjectDataSource ID="dsRoles" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_RolesTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsCategories" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_OrganisationCategoriesTableAdapter"></asp:ObjectDataSource>

    <div class="row">
        <div id="wizard-1">
            <div id="bootstrap-wizard-1" class="col-sm-12">
                <div class="form-bootstrapWizard">
                    <ul id="myTabs" class="bootstrapWizard form-wizard">
                        <li class="active" data-target="#step1">
                            <asp:HyperLink ID="hlStep1" ClientIDMode="Static" data-toggle="tab"  NavigateUrl="#tab1" cssclass="active" onclick="$('#hfTabIndex').val('0');" runat="server"><span class="step">1</span> <span class="title">Organisation Category</span> </asp:HyperLink>
                            
                        </li>
                        <li data-target="#step2" class="disabled">
                            <asp:HyperLink ID="hlStep2" ClientIDMode="Static" data-toggle="tab"  NavigateUrl="#tab2" cssclass="active" onclick="$('#hfTabIndex').val('1');" runat="server"><span class="step">2</span> <span class="title">ODS Lookup</span> </asp:HyperLink>
                            
                        </li>
                        <li data-target="#step3" class="disabled">
                            <asp:HyperLink ID="hlStep3" ClientIDMode="Static" runat="server" data-toggle="tab"  NavigateUrl="#tab3" cssclass="active" onclick="$('#hfTabIndex').val('2');"><span class="step">3</span> <span class="title">ICO Lookup</span> </asp:HyperLink>
                            
                        </li>
                        <li data-target="#step4" class="disabled">
                            <asp:HyperLink ID="hlStep4" ClientIDMode="Static" runat="server" data-toggle="tab"  NavigateUrl="#tab4" cssclass="active" onclick="$('#hfTabIndex').val('3');"><span class="step">4</span> <span class="title">Details</span> </asp:HyperLink>
                           
                        </li>
                        
                        
<li data-target="#step5">
    <asp:HyperLink ID="hlComplete" Enabled="false" runat="server" NavigateUrl="#tab5"><span class="step">5</span> <span class="title">Complete</span> </asp:HyperLink>
                           <%-- <a href="#tab5"><span class="step">5</span> <span class="title">Complete</span> </a>--%>
                        </li>
                        
                        
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <br />
                <br />
                <div class="tab-content">
                    <div class="tab-pane active" id="tab1">
                        <div class="panel panel-primary">
                            <div class="panel-body">
                                <h3><strong>Step 1 </strong>- Organisation Category</h3>
                                
                                <p>To ensure that your organisation is registered efficiently and can be found by other organisations and integrated systems easily. Please complete the following simple steps.</p>
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <asp:Label ID="Label3" CssClass="control-label col-sm-3" runat="server" Text="Category:"></asp:Label>
                                        <div class="col-sm-9">
                                            <asp:DropDownList AppendDataBoundItems="True" ClientIDMode="Static" CssClass="form-control" ID="ddCategory" runat="server" DataSourceID="dsCategories" DataTextField="OrganisationCategory" DataValueField="OrganisationCategoryID">
                                                <asp:ListItem Text="Please select.." Selected="True" Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="orgCategory" InitialValue="0" ControlToValidate="ddCategory" Display="Dynamic" runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                    <div id="divOther" class="collapse">
                                        <div class="form-group">
                                            <div class="col-sm-9 col-sm-offset-3">
                                                <asp:TextBox ID="tbOtherCategory" ClientIDMode="static" CssClass="form-control" placeholder="Please specify other organisation category" runat="server"></asp:TextBox>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer clearfix">
                                <asp:LinkButton ID="lbtStep1Next" ValidationGroup="orgCategory" CausesValidation="true" CssClass="btn btn-primary pull-right" runat="server">Next</asp:LinkButton><%--OnClientClick="$('#myTabs li:eq(1) a').tab('show');return false;"--%>
                                <%--<asp:HyperLink ID="hlStep1Next" data-toggle="tab" NavigateUrl="javascript:void(0)"  runat="server">Next</asp:HyperLink>--%>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="tab2">
                        <asp:HiddenField ID="hfODS" runat="server" />
                        <div class="panel panel-primary">
                            <div class="panel-body">
                                <h3><strong>Step 2</strong> - ODS Lookup</h3>
                                <div id="div1" runat="server" class="alert alert-info" role="alert">
                                    We will use your organisation's ODS code to identify your organisation in the system. This will make it easier for people and integrated systems to find your organisation in the DPIA.
                                    </div>
                                <div class="form-horizontal">
                                    <div id="odscheckgroup" class="form-group has-feedback">
                                        <asp:Panel ID="Panel1" DefaultButton="btnCheckODS" runat="server">
                                        <asp:Label ID="lblODS" AssociatedControlID="tbODSCode" CssClass="col-sm-3 control-label" runat="server" Text="ODS Code:"></asp:Label>
                                        <div class="col-sm-7 col-md-7 col-lg-8">

                                            <asp:TextBox ID="tbODSCode" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>

                                            <span id="odsicon" class="glyphicon hidden form-control-feedback" aria-hidden="true"></span>
                                        </div>
                                        <div class="col-sm-2 col-md-2 col-lg-1">
                                            <asp:Button ID="btnCheckODS" OnClientClick="return false;" cssclass="btn btn-info btn-block" ClientIDMode="Static" runat="server" Text="Check" />
                                            <%--<button id="btnCheckODS" class="btn btn-info btn-wrap" type="button">Check</button>--%>
                                        </div></asp:Panel>
                                    </div>
                                    
                                        <asp:Panel ID="Panel2"  cssclass="form-group" runat="server" DefaultButton="btnSearchODS">
                                        <asp:Label ID="lblSearch" AssociatedControlID="tbODSSearch" CssClass="col-sm-3 control-label" runat="server" Text="Or search:"></asp:Label>
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <asp:TextBox ID="tbODSSearch" CssClass="form-control" placeholder="all or part of organisation name" ClientIDMode="Static" runat="server"></asp:TextBox>
                                                <span class="input-group-btn">
                                                    <asp:LinkButton ID="btnSearchODS" cssclass="btn btn-default" ClientIDMode="Static" OnClientClick="return false;" runat="server"><i aria-hidden="true" class="icon-search"></i>Find</asp:LinkButton>
                                                    <asp:LinkButton ID="lbtSearchODSCB" cssclass="btn btn-info" Visible="false" runat="server"><i aria-hidden="true" class="icon-search"></i> Find</asp:LinkButton>
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
                                </div>
                            </div>
                            <div class="panel-footer clearfix">
                                <asp:LinkButton ID="lbtStep2Previous" CausesValidation="false" OnClientClick="$('#hfTabIndex').val('0');$('#myTabs li:eq(0) a').tab('show');return false;" CssClass="btn btn-default pull-left" runat="server">Previous</asp:LinkButton>
                                <asp:LinkButton ID="lbtStep2Next" ValidationGroup="validateODS" OnClientClick="$('#hfTabIndex').val('2');$('#myTabs li:eq(2) a').tab('show');return false;" CssClass="btn btn-primary pull-right" runat="server">Next</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="tab3">
                      <div class="panel panel-primary">
                            <div class="panel-body">
                        <h3><strong>Step 3</strong> - ICO Lookup</h3>
                                
                       
                            <div id="divInst" runat="server" class="alert alert-warning" role="alert">
                                <asp:Label ID="lblInstructions" runat="server" Text="Label">Your ICO registration number will be used to identify you to other organisations in the DPIA and forms part of your IG Assurance credentials.</asp:Label>
                            </div>
                            <div class="form-horizontal">
                               <div id="icocheckgroup" class="form-group has-feedback">
                                   <asp:Panel ID="Panel3" runat="server" DefaultButton="btnCheckICO">
                                    <label  Class="col-sm-3 control-label" for="tbOrgName">ICO Reg Number:</label>
                                    <div class="col-md-7 col-sm-7 col-lg-8">
                                        <asp:TextBox CssClass="form-control" ID="tbICONumber" ClientIDMode="Static" runat="server" PlaceHolder="ICO registration number"></asp:TextBox>
                                         <span id="icoicon" class="glyphicon hidden form-control-feedback" aria-hidden="true"></span>
                                    </div>
                                     <div class="col-md-2 col-sm-2 col-lg-1">
                                         <asp:Button ID="btnCheckICO" OnClientClick="return false;" cssclass="btn btn-info btn-block" ClientIDMode="Static" runat="server" Text="Check" />
                                          
                                            <%--<button id="btnCheckICO" class="btn btn-info btn-wrap" type="button">Check</button>--%>
                                        </div>
                                       </asp:Panel>
                                </div>
                                
                                     <asp:Panel ID="Panel4" class="form-group" DefaultButton="btnSearchICO" runat="server">
                                        <asp:Label ID="Label2" AssociatedControlID="tbICOSearch" CssClass="col-sm-3 control-label" runat="server" Text="Or search:"></asp:Label>
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <asp:TextBox ID="tbICOSearch" CssClass="form-control" placeholder="all or part of organisation name or postcode" ClientIDMode="Static" runat="server"></asp:TextBox>
                                                <span class="input-group-btn">
                                                      <asp:LinkButton ID="btnSearchICO" cssclass="btn btn-default" ClientIDMode="Static" OnClientClick="return false;" runat="server"><i aria-hidden="true" class="icon-search"></i>Find</asp:LinkButton>
                                                 
                                                   <%-- <button class="btn btn-default" id="btnSearchICO" type="button"><i aria-hidden="true" class="icon-search"></i>Find</button>--%>
                                                </span>
                                            </div>
                                        </div></asp:Panel>
                                    
                                    <div class="collapse" id="collapseICOResults">
                                        <div class="col-sm-9 col-sm-offset-3">
                                            <div class="panel panel-default">
                                                <div id="Div3" class="panel-heading">Results</div>
                                                <ul class='list-group' id='ico-list-box'>
                                                    <!--odschoices-->
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                            </div>
                                </div>

                             <div class="panel-footer clearfix">
                                <asp:LinkButton ID="LinkButton2" CausesValidation="false" OnClientClick="$('#hfTabIndex').val('1');$('#myTabs li:eq(1) a').tab('show');return false;" CssClass="btn btn-default pull-left" runat="server">Previous</asp:LinkButton>
                                <asp:LinkButton ID="LinkButton3" ValidationGroup="validateICO" OnClientClick="$('#hfTabIndex').val('3');$('#myTabs li:eq(3) a').tab('show');return false;" CssClass="btn btn-primary pull-right" runat="server">Next</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="tab4">
                        <div class="panel panel-primary">
                            <div class="panel-body">
                        <h3><strong>Step 4</strong> - Details</h3>
                       <div class="form-horizontal">
                                <div class="form-group" id="orggroup">

                <label class="control-label col-xs-2" for="tbOrgName">Organisation Name:</label>
                <div class="col-xs-10">
                    
                        <asp:TextBox ID="tbOrgName" ClientIDMode="Static" CssClass="form-control placeholder required" runat="server" PlaceHolder="Enter ICO number, part of organisation name or postcode" Enabled="True" data-error="Organisation name is required"></asp:TextBox>
                        
                    
                    <asp:RequiredFieldValidator SetFocusOnError="true" ValidationGroup="vgOrgRegistration" ID="rfvOrgName" runat="server" ErrorMessage="Organisation name required" Text="Organisation name required" ControlToValidate="tbOrgName" ToolTip="Organisation name required" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                </div>


            </div>

            
                    <div class="form-group">
                        <label class="control-label col-xs-2" for="tbAliases">Aliases:</label>
                        <div class="col-xs-10">
                            <asp:TextBox ID="tbAliases" ClientIDMode="Static" placeholder="Optional - e.g. Trading Name / AKA" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2" for="tbIdentifiers">Identifiers:</label>
                        <div class="col-xs-10">
                                <asp:TextBox ID="tbIdentifiers" ClientIDMode="Static" placeholder="Optional - e.g. Organisation Code" CssClass="form-control" runat="server"></asp:TextBox>
                                
                            </div>
                        </div>
                    <asp:panel runat="server" ID="pnlType" class="form-group">
                        <label class="control-label col-xs-2" for="ddOrgType">Type:</label>
                        <div class="col-xs-10">
                            <asp:DropDownList CssClass="form-control" ID="ddOrgType" runat="server" AutoPostBack="True">
                                <asp:ListItem Selected="True" Text="Please select..." Value="0" />
                                <asp:ListItem Selected="False" Text="Lead Organisation" Value="1" />
                                <asp:ListItem Selected="False" Text="Supported Organisation" Value="2" />
                            </asp:DropDownList>
                        </div>
                        <asp:CompareValidator Display="Dynamic" ID="cvOrgType" runat="server" ErrorMessage="*" ControlToValidate="ddOrgType" Operator="GreaterThan" ValueToCompare="0" ToolTip="Select an organisation type"></asp:CompareValidator>
                    </asp:panel>

                    <div id="divSponsorOrg" runat="server" class="form-group" visible="false">
                        <label class="control-label col-xs-2" for="ddSponsorOrg">Supporting Organisation:</label>
                        <div class="col-xs-10">
                            <asp:DropDownList CssClass="form-control" ID="ddSponsorOrg" runat="server" DataSourceID="dsLeadOrgs" DataTextField="OrganisationName" DataValueField="OrganisationID" AppendDataBoundItems="True">
                                <asp:ListItem Selected="True" Text="Please select..." Value="0" />
                            </asp:DropDownList>
                        </div>
                        <asp:CompareValidator Display="Dynamic" ID="cvSponsorOrg" runat="server" ErrorMessage="*" ControlToValidate="ddSponsorOrg" Operator="GreaterThan" ValueToCompare="0" Enabled="False" SetFocusOnError="True" ToolTip="Select your supporing organisation"></asp:CompareValidator>
                    </div>
            <div class="form-group">
                <label class="control-label col-xs-2" for="tbAddress">Organisation Address:</label>
                <div class="col-xs-10">
                    <asp:TextBox CssClass="form-control" ID="tbAddress" PlaceHolder="Full address and postcode" runat="server" TextMode="MultiLine" Rows="5" ClientIDMode="Static"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-xs-2" for="tbAddress">Map Location:</label>
                <div class="col-xs-10">
                    <div class="input-group">
                        <span class="input-group-addon">Area:</span><asp:TextBox ID="hfCounty" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox><span class="input-group-addon">Latitude:</span><asp:TextBox ID="hfLattitude" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox><span class="input-group-addon">Longitude:</span><asp:TextBox ID="hfLongitude" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox><span class="input-group-btn"><asp:Button ID="Button1" CssClass="btn btn-success" runat="server" CausesValidation="false" OnClientClick="javascript:getGeoCode(); return false;" Text="Find" Font-Size="8pt" /></span>
                    </div>
                    <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvLong" data-placement="bottom" ValidationGroup="vgOrgRegistration" Display="Dynamic" runat="server" CssClass="bg-danger" ErrorMessage="Click find to locate your organisation on the map." Text="Click find to locate your organisation on the map." ControlToValidate="hfLongitude" ToolTip="Click find to locate your organisation on the map."></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-xs-2" for="tbUserName">Your Name:</label>
                <div class="col-xs-10">
                    <asp:TextBox CssClass="form-control" ID="tbUserName" runat="server" PlaceHolder="Full name"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvUserName" ValidationGroup="vgOrgRegistration" runat="server" ErrorMessage="Full name required" Text="Full name required" ControlToValidate="tbUserName" ToolTip="Full name required" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label class="control-label col-xs-2" for="tbEmail">Your E-mail:</label>
                <div class="col-xs-10">
                    <asp:TextBox CssClass="form-control" ID="tbEmail" runat="server" PlaceHolder="Verification e-mail will be sent here" TextMode="Email"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-xs-2" for="ddRole">Your Role:</label>
                <div class="col-xs-10">
                    <div class="input-group">
                        <a tabindex="0" title="Organisation Role" class="input-group-addon btn-tooltip" style="background-color: rgb(238, 238, 238); color: rgb(51, 122, 183); font-size: 12px;" role="button" data-toggle="popover" data-trigger="focus" data-container="body" data-placement="auto" data-content="As the user registering your organisaiton, you will automatically be given Administrator access to the system for your organisation. If you need an additional role, select it from the drop down."><i aria-hidden="true" class="icon-info"></i></a>
                        <asp:DropDownList CssClass="form-control" ID="ddRole" runat="server" DataSourceID="dsRoles" DataTextField="Role" DataValueField="RoleID"></asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-xs-2" for="tbContact">Contact E-mail:</label>
                <div class="col-xs-9">
                    <asp:TextBox CssClass="form-control" ID="tbContact" runat="server" PlaceHolder="Contact e-mail address for IG at organisation" TextMode="Email"></asp:TextBox>
                    <asp:RegularExpressionValidator
                        runat="server" ID="RegularExpressionValidator2" Display="Dynamic" ControlToValidate="tbContact" ValidationGroup="vgOrgRegistration"
                        ValidationExpression="(?:[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*|'(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*')@(?:(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"
                        ToolTip="Enter a valid email address" ErrorMessage="Enter a valid email address"
                        Text="Invalid email" SetFocusOnError="true" />
                         <asp:RequiredFieldValidator SetFocusOnError="true" ValidationGroup="vgOrgRegistration" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Organisation contact required" Text="Organisation contact required" ControlToValidate="tbContact" ToolTip="Organisation contact required" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
           
                </div>
                <div class="col-xs-1">
                    <button title="Copy my e-mail address" class="btn btn-default" onclick="javascript:copyEmail();return false;"><i class="glyphicon glyphicon-repeat" aria-hidden="true"></i></button>
                </div>
            </div>
            <%--<asp:Panel runat="server" ID="pnlAutoApprove" CssClass="form-group">
                <div class="col-xs-offset-2 col-xs-10">
                    <label for="cbConfirm">
                        <asp:CheckBox ID="cbAutoApprove" runat="server" />

                        Sponsorship does not require approval by senior officer.
                    </label>

                </div>

            </asp:Panel>--%>
                           
                           <div class="form-group">
                                <label class="control-label col-xs-2" for="tbEmail">Licensing Group:</label>
                <div class="col-xs-10">
                    <asp:DropDownList CssClass="form-control" ID="ddAdminGroup" runat="server" DataSourceID="dsAdminGroups" AppendDataBoundItems="true" DataTextField="GroupName" DataValueField="AdminGroupID">
                                    <asp:ListItem Text="None / unknown" Value="0" />
                                </asp:DropDownList>
                    </div>
                               </div>
                            <div class="form-group">
                                 <div class="col-xs-offset-2 col-xs-10">
                    <label for="cbConfirm">
                        <asp:CheckBox ID="cbRequestLicence" runat="server" ToolTip="Tick to request assignment of a full DPIA licence for your organisation." />

                        Request a licence.
                    </label>

                </div>
                                </div>
            <div class="form-group">
                <div class="col-xs-offset-2 col-xs-10">
                    <label for="cbConfirm">
                        <asp:CheckBox ID="cbConfirm" runat="server" AutoPostBack="True" />

                        I confirm that I am authorised to register this organisation.
                    </label>

                </div>

            </div>
            <div class="form-group" id="divEvidence" runat="server" visible="false">
                <div class="col-xs-2">
                    <label for="cbConfirm">
                        Upload evidence (optional):
                    </label>
                </div>
                <div class="col-xs-10">
                    <div class="panel panel-default">
                        <asp:ObjectDataSource ID="dsOrganisationFiles" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_FilesByGroupTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="FileGroupID" SessionField="OrganisationFileGroupID" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <table class="table table-striped">
                            <asp:Repeater ID="rptFiles" runat="server" DataSourceID="dsOrganisationFiles">
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
                                        <td style="width: 20px;">
                                            <asp:LinkButton ID="lbtDelete" OnClientClick="return confirm('Are you sure you want delete this file?');" runat="server" CommandName="Delete" CommandArgument='<%# Eval("FileID")%>' CssClass="btn btn-danger btn-xs" ToolTip="Delete File" CausesValidation="false"><i aria-hidden="true" class="icon-minus"></i><!--[if lt IE 8]>Delete<![endif]--></asp:LinkButton></td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate></div></FooterTemplate>
                            </asp:Repeater>
                        </table>
                    </div>
                    <div class="input-group">
                        <span class="input-group-btn">
                            <span class="btn btn-default btn-file">Browse&hellip;
                            <asp:FileUpload ID="filEvidence" runat="server" AllowMultiple="True" />
                            </span>
                        </span>
                        <input type="text" placeholder="Optional (max 1 MB)" class="form-control" readonly>
                        <span class="input-group-btn">
                            <asp:LinkButton ID="lbtUpload" CausesValidation="false" CssClass="btn btn-default" runat="server"><i aria-hidden="true" class="icon-upload2"></i>  Upload</asp:LinkButton>
                        </span>
                    </div>

                </div>
            </div>
                            </div>
                                </div>
                             <div class="panel-footer clearfix">
                                <asp:LinkButton ID="LinkButton4" CausesValidation="false" OnClientClick="$('#hfTabIndex').val('2');$('#myTabs li:eq(2) a').tab('show');return false;" CssClass="btn btn-default pull-left" runat="server">Previous</asp:LinkButton>
                                  <asp:Button ID="btnSubmit" ValidationGroup="vgOrgRegistration" CssClass="btn btn-primary pull-right" runat="server" Text="Submit" Enabled="False" />
                                 <asp:LinkButton CssClass="btn btn-default pull-right" CausesValidation="false" ID="btnRegCancel" PostBackUrl="~/application/org_sponsored.aspx" runat="server" Enabled="True">Cancel</asp:LinkButton>
                            </div>
                            </div>
                    </div>

                    <div class="tab-pane" id="tab5">
                        <div class="panel panel-primary">
                            <div class="panel-body">
                        <h3><strong>Step 5</strong> - Registration Complete</h3>
                        
                        <br>
                        <h2 class="text-center text-success"><strong><i class="fa fa-check fa-lg"></i>Complete</strong></h2>
                                <br /><br>
                               <div class="col-sm-8 col-sm-offset-2">
                                <h4 class="modal-title">
                        <asp:Label ID="lblRegisteredHeading" runat="server" Text="Label"></asp:Label></h4>
                                 <p>
                        <asp:Label ID="lblRegisteredText" runat="server" Text="Label"></asp:Label>
                    </p>
                                 
                        <br></div></div>
                        <div class="panel-footer clearfix">
                            <asp:Button ID="btnFinish" CausesValidation="false" CssClass="btn btn-primary pull-right" runat="server" Text="Finish" />
                                
                            </div>
                        
                    
                            </div>

                </div>
            </div>
        </div>
    </div>
        <div id="modalMessage" class="modal fade">
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
        <div id="modalICOExists" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Organisation(s) With That ICO Number or ODS Code Already Registered</h4>
                    </div>
                    <div class="modal-body">
                        <p>
                            The following organisations are already registered on the Data Protection Impact Assessment Tool with the given ICO Number and / or ODS code:
                        </p>
                        <ul>
                            <asp:Repeater ID="rptICOOrgs" runat="server" DataSourceID="dsICOOrgs">
                                <ItemTemplate>
                                    <li>
                                        <asp:Label ID="lblOrgName" runat="server" Text='<%# Eval("OrganisationName")%>'></asp:Label></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                        <p>
                            Are you sure that you wish to register this as a new organisation. If the organisation is listed above, click <b>No</b>.
                        </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">No</button>
                        <asp:LinkButton CssClass="btn btn-primary pull-right" CausesValidation="false" ID="lbtConfirmICODup" runat="server">Yes</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        Sys.Application.add_load(BindEvents);
    </script>

    <h2></h2>
    <p>
    </p>
    <!-- ODS Lookup Modal Message  -->
    <div id="ODSSearchModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">
                        <span id="modalHeading"></span>
                    </h4>
                </div>
                <div class="modal-body">
                    
                        <div id="modalLabel"></div>
                    
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-primary pull-right" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Standard Modal Message  -->
    <div id="modalSponsorRegistered" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    
                </div>
                <div class="modal-body">
                   

                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="LinkButton1" CausesValidation="false" CssClass="btn btn-primary" runat="server" PostBackUrl="~/Default.aspx">OK</asp:LinkButton>
                    <%--<button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>--%>
                </div>
            </div>
        </div>
    </div>
   

</asp:Content>
