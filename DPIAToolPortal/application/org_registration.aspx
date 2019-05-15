<%@ Page Title="Organisation Registration" Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="org_registration.aspx.vb" Inherits="InformationSharingPortal.org_registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeading" runat="server">
	<script src="../Scripts/bs.pagination.js"></script>
	<script src="../Scripts/bsasper.js"></script>
	<script src="../Scripts/geo.js"></script>
	<h1>Organisation Registration</h1>
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
	<script type="text/javascript">

		function BindEvents() {
			//Lets do bootstrap form validation:
			$("input[type=text], textarea").bsasper({
				placement: "bottom", createContent: function (errors) {
					return '<span class="text-danger">' + errors[0] + '</span>';
				}});
			//$('#form1').validator()
			$(document).on('change', '.btn-file :file', function () {
				var input = $(this),
					numFiles = input.get(0).files ? input.get(0).files.length : 1,
					label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
				input.trigger('fileselect', [numFiles, label]);
			});
			$('[data-toggle="popover"]').popover();
			$(document).ready(function () {
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
	<div class="panel panel-primary" style="padding: 2%;">

		<asp:ObjectDataSource ID="dsLeadOrgs" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveLeadOrganisations" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_OrganisationsTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">

			<SelectParameters>
				<asp:Parameter DefaultValue="0" Name="OrganisationID" Type="Int32" />
			</SelectParameters>

		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="dsICOOrgs" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByICONumber" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_OrganisationsTableAdapter" >
			<SelectParameters>
				<asp:Parameter Name="ICONumber" Type="String" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="dsRoles" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.ispdatasetTableAdapters.isp_RolesTableAdapter"></asp:ObjectDataSource>
	   <div id="divNoAdminWarning" runat="server" class="alert alert-danger" role="alert">
							<asp:Label ID="Label14" runat="server" Text="Label">You are not currently accessing the DPIA under an administration group. If you continue to register your organisation, it will not be registered to an administrative group. This may cause problems accessing support and restrict functionality. If you are part of an administrative group, please access the DPIA using the web address they supllied to correct this.</asp:Label>
						</div>
				<div id="divInst" runat="server" class="alert alert-warning" role="alert"><asp:Label ID="lblInstructions" runat="server" Text="Label">If your organisation is registered with the ICO, please type either part of the organisation name or the full ICO registration number and then click Lookup.</asp:Label></div>
				<fieldset class="form-horizontal">
				
					<div class="form-group" id="orggroup">

						<label class="control-label col-xs-2" for="tbOrgName">Organisation Name:</label>
						<div class="col-xs-5">
							<asp:TextBox ID="tbOrgName" CssClass="form-control placeholder required" runat="server" PlaceHolder="Enter part of organisation name" Enabled="True" data-error="Organisation name is required"></asp:TextBox>
							<asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvOrgName" runat="server" ErrorMessage="Organisation name required" Text="Organisation name required" ControlToValidate="tbOrgName" ToolTip="Organisation name required" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
						</div>
						<label class="control-label col-xs-2" for="tbOrgName">ICO Reg Number:</label><div class="col-xs-2">
											<asp:TextBox CssClass="form-control" ID="tbICONumber" runat="server" PlaceHolder="or ICO reg number"></asp:TextBox></div>
						 
						<div class="col-xs-1">
							<asp:Button CssClass="btn btn-primary" ID="btnLookup" runat="server" Text="Lookup" CausesValidation="False" /></div>
					   
					</div>
					 <asp:UpdatePanel ID="upnlCentreLookup" runat="server">
			<ContentTemplate>
<div class="form-group">
	<label class="control-label col-xs-2" for="tbAliases">Aliases:</label>
	<div class="col-xs-10">
		<asp:TextBox ID="tbAliases" placeholder="Optional - e.g. Trading Name / AKA" CssClass="form-control" runat="server"></asp:TextBox>
	</div>
</div>
				<div class="form-group">
	<label class="control-label col-xs-2" for="tbIdentifiers">Identifiers:</label>
	<div class="col-xs-10">
		<asp:TextBox ID="tbIdentifiers" placeholder="Optional - e.g. Organisation Code" CssClass="form-control" runat="server"></asp:TextBox>
	</div>
</div>
					<div class="form-group">
						<label class="control-label col-xs-2" for="ddOrgType">Type:</label>
						<div class="col-xs-10">
							<asp:DropDownList CssClass="form-control" ID="ddOrgType" runat="server" AutoPostBack="True">
								<asp:ListItem Selected="True" Text="Please select..." Value="0" />
								<asp:ListItem Selected="False" Text="Lead Organisation" Value="1" />
								<asp:ListItem Selected="False" Text="Sponsored Organisation" Value="2" />
							</asp:DropDownList>
						</div>
						<asp:CompareValidator Display="Dynamic" ID="cvOrgType" runat="server" ErrorMessage="*" ControlToValidate="ddOrgType" Operator="GreaterThan" ValueToCompare="0" ToolTip="Select an organisation type"></asp:CompareValidator>
					</div>

					<div id="divSponsorOrg" runat="server" class="form-group" visible="false">
						<label class="control-label col-xs-2" for="ddSponsorOrg">Sponsor Organisation:</label>
						<div class="col-xs-10">
							<asp:DropDownList CssClass="form-control" ID="ddSponsorOrg" runat="server" DataSourceID="dsLeadOrgs" DataTextField="OrganisationName" DataValueField="OrganisationID" AppendDataBoundItems="True">
								<asp:ListItem Selected="True" Text="Please select..." Value="0" />
							</asp:DropDownList>
						</div>
						<asp:CompareValidator Display="Dynamic" ID="cvSponsorOrg" runat="server" ErrorMessage="*" ControlToValidate="ddSponsorOrg" Operator="GreaterThan" ValueToCompare="0" Enabled="False" SetFocusOnError="True" ToolTip="Select your sponsor organisation"></asp:CompareValidator>
					</div>
				</ContentTemplate>

		</asp:UpdatePanel>
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
		<span class="input-group-addon">Area:</span><asp:TextBox ID="hfCounty" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox><span class="input-group-addon">Latitude:</span><asp:TextBox ID="hfLattitude" ClientIDMode="Static" CssClass="form-control" runat="server" ></asp:TextBox><span class="input-group-addon">Longitude:</span><asp:TextBox ID="hfLongitude" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox><span class="input-group-btn"><asp:Button ID="Button1" CssClass="btn btn-success" runat="server" CausesValidation="false"  OnClientClick="javascript:getGeoCode(); return false;" Text="Find"  Font-Size="8pt"/></span>
	</div>
	<asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvLong" data-placement="bottom" Display="Dynamic" runat="server" CssClass="bg-danger" ErrorMessage="Click find to locate your organisation on the map." Text="Click find to locate your organisation on the map." ControlToValidate="hfLongitude" ToolTip="Click find to locate your organisation on the map."></asp:RequiredFieldValidator>
</div>
						</div>
					<div class="form-group">
						<label class="control-label col-xs-2" for="tbUserName">Your Name:</label>
						<div class="col-xs-10">
							<asp:TextBox CssClass="form-control" ID="tbUserName" runat="server" PlaceHolder="Full name"></asp:TextBox></div>
						<asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvUserName" runat="server" ErrorMessage="Full name required" Text="Full name required" ControlToValidate="tbUserName" ToolTip="Full name required" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
					</div>
					<div class="form-group">
						<label class="control-label col-xs-2" for="tbEmail">Your E-mail:</label>
						<div class="col-xs-10">
							<asp:TextBox CssClass="form-control" ID="tbEmail" runat="server" PlaceHolder="Verification e-mail will be sent here" TextMode="Email"></asp:TextBox></div>
					</div>
					<div class="form-group">
						<label class="control-label col-xs-2" for="ddRole">Your Role:</label>
						<div class="col-xs-10">
							<div class="input-group">
		<a tabindex="0" title="Organisation Role" class="input-group-addon btn-tooltip" style="background-color: rgb(238, 238, 238);color: rgb(51, 122, 183);font-size: 12px;"  role="button" data-toggle="popover" data-trigger="focus" data-container="body" data-placement="auto" data-content="As the user registering your organisaiton, you will automatically be given Administrator access to the system for your organisation. If you need an additional role, select it from the drop down."><i aria-hidden="true" class="icon-info"></i></a>
							<asp:DropDownList CssClass="form-control" ID="ddRole" runat="server" DataSourceID="dsRoles" DataTextField="Role" DataValueField="RoleID"></asp:DropDownList></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-xs-2" for="tbContact">Contact E-mail:</label>
						<div class="col-xs-9">
						<asp:TextBox CssClass="form-control" ID="tbContact" runat="server" PlaceHolder="Contact e-mail address for IG at organisation" TextMode="Email"></asp:TextBox>
							<asp:RegularExpressionValidator
										runat="server" ID="RegularExpressionValidator2" Display="Dynamic" ControlToValidate="tbContact"
										ValidationExpression="(?:[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*|'(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*')@(?:(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"
										ToolTip="Enter a valid email address" ErrorMessage="Enter a valid email address"
										Text="Invalid email" SetFocusOnError="true" />
						</div>
						<div class="col-xs-1">
							<button title="Copy my e-mail address" class="btn btn-default" onclick="javascript:copyEmail();return false;"><i class="glyphicon glyphicon-repeat" aria-hidden="true"></i></button>
						</div>
					</div>
				   <%-- <asp:panel runat="server" ID="pnlAutoApprove"  cssclass="form-group">
						<div class="col-xs-offset-2 col-xs-10">
							<label for="cbConfirm">
								<asp:CheckBox ID="cbAutoApprove" runat="server" />

								Sponsorship does not require approval by senior officer.
							</label>
							
						</div>

					</asp:panel>--%>
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
										
										<table class="table table-striped"><asp:Repeater ID="rptFiles" runat="server" DataSourceID="dsOrganisationFiles">
											<HeaderTemplate><div class="table-responsive"></HeaderTemplate>
											<ItemTemplate><tr><td>
												<asp:HyperLink ID="hlFile" runat="server"
							NavigateUrl='<%# Eval("FileID", "GetFile.aspx?FileID={0}")%>'><i id="I1" aria-hidden="true" class='<%# Eval("Type")%>' runat="server"></i> <asp:Label ID="Label1" runat="server" Text='<%# Eval("FileName")%>'></asp:Label></asp:HyperLink>
												 </td>
												<td style="width:20px;">
													<asp:LinkButton ID="lbtDelete" OnClientClick="return confirm('Are you sure you want delete this file?');"  runat="server" CommandName="Delete" CommandArgument='<%# Eval("FileID")%>'  CssClass="btn btn-danger btn-xs" ToolTip="Delete File" CausesValidation="false"><i aria-hidden="true" class="icon-minus"></i><!--[if lt IE 8]>Delete<![endif]--></asp:LinkButton></td>
														  </tr></ItemTemplate><FooterTemplate></div></FooterTemplate>
										</asp:Repeater></table></div>
							 <div class="input-group">
				<span class="input-group-btn">
					<span class="btn btn-default btn-file">
						Browse&hellip; <asp:FileUpload ID="filEvidence" runat="server" AllowMultiple="True" />
					</span>
				</span>
				<input type="text" placeholder="Optional (max 1 MB)" class="form-control" readonly>
								 <span class="input-group-btn">
											<asp:LinkButton ID="lbtUpload" CausesValidation="false" CssClass="btn btn-default" runat="server"><i aria-hidden="true" class="icon-upload2"></i>  Upload</asp:LinkButton>
											</span>
			</div>
					   
					</div></div>
						<div class="form-group">
						<div class="col-xs-offset-2 col-xs-10">    
							<asp:Button CssClass="btn btn-primary pull-right" ID="btnSubmit" runat="server" Text="Submit" Enabled="False" />
							<asp:LinkButton cssclass="btn btn-default pull-left" CausesValidation="false"  ID="btnRegCancel" PostBackUrl="~/application/org_sponsored.aspx" runat="server" Enabled="True">Cancel</asp:LinkButton>
							
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
										<asp:Label ID="lblModalText" runat="server" Text="Label"></asp:Label></p>

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
									<h4 class="modal-title">
										Organisation(s) With That ICO Number Already Registered</h4>
								</div>
								<div class="modal-body">
									<p>
										The following organisations are already registered on the Data Protection Impact Assessment Tool with that ICO Number:</p>
									<ul>
		<asp:Repeater ID="rptICOOrgs" runat="server" DataSourceID="dsICOOrgs">
			<ItemTemplate><li>
				<asp:Label ID="lblOrgName" runat="server" Text='<%# Eval("OrganisationName")%>'></asp:Label></li></ItemTemplate>
		</asp:Repeater></ul>
									<p>
										Are you sure that you wish to register this as a new organisation. If the organisation is listed above, click <b>No</b>.</p>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default pull-left" data-dismiss="modal">No</button>
									 <asp:LinkButton cssclass="btn btn-primary pull-right" CausesValidation="false"  ID="lbtConfirmICODup" runat="server">Yes</asp:LinkButton>
								</div>
							</div>
						</div>
					</div>
				</fieldset>
				<div id="modalCentreLookup" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
								<h4 class="modal-title">
									<asp:Label ID="Label1" runat="server" Text="Select your organisation"></asp:Label></h4>
							</div>
							<div class="modal-body">
							 
								<div class="table-responsive" style="max-height: 240px;">
									<asp:GridView  CssClass="table table-striped" ID="gvICORes" GridLines="None" runat="server" AutoGenerateColumns="False" DataKeyNames="Registration_number" EmptyDataText="To search, enter your ICO reg number or organisation above and click Search.">
										<Columns>
										 
											<asp:TemplateField ShowHeader="False">
												<ItemTemplate>
													<asp:LinkButton cssclass="btn btn-primary" ID="lbtSelectICOOrg" runat="server" CausesValidation="False" CommandArgument='<%# Eval("Registration_number")%>' CommandName="Select" Text="Select"></asp:LinkButton>
												</ItemTemplate>
											</asp:TemplateField>
											<asp:BoundField DataField="Registration_number" HeaderText="ICO Reg Num" SortExpression="Registration_number" />
											<asp:BoundField DataField="Organisation_name" HeaderText="Organisation Name" SortExpression="Organisation_name" />
											<asp:BoundField DataField="Postcode" HeaderText="Postcode" SortExpression="Postcode" />
										</Columns>
				</asp:GridView></div>
								
								</div>

							<div class="modal-footer">
								<asp:LinkButton cssclass="btn btn-default" CausesValidation="false"  ID="lbtSearchCancel" data-dismiss="modal" runat="server" Enabled="False">Cancel</asp:LinkButton>
								
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
	</div>

	<!-- Standard Modal Message  -->
	<div id="modalSponsorRegistered" class="modal fade">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
									<h4 class="modal-title">
										<asp:Label ID="lblRegisteredHeading" runat="server" Text="Label"></asp:Label></h4>
								</div>
								<div class="modal-body">
									<p>
										<asp:Label ID="lblRegisteredText" runat="server" Text="Label"></asp:Label></p>

								</div>
								<div class="modal-footer">
									<asp:LinkButton ID="LinkButton1" CausesValidation="false" cssclass="btn btn-primary"  runat="server" PostBackUrl="~/Default.aspx">OK</asp:LinkButton>
									<%--<button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>--%>
								</div>
							</div>
						</div>
					</div>
</asp:Content>
