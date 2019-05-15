<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="project_summary.aspx.vb" Inherits="InformationSharingPortal.project_summary" MaintainScrollPositionOnPostback="true" %>

<%@ Register Src="~/OrgDetailsModal.ascx" TagPrefix="uc1" TagName="OrgDetailsModal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Content/bootstrap-multiselect.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageHeading" runat="server">
    <h1>Project Summary</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../Scripts/bs.pagination.js"></script>
    <script src="../Scripts/bootstrap/bootstrap-multiselect.js"></script>
    <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.0/css/bootstrap-toggle.min.css" rel="stylesheet">
    <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.0/js/bootstrap-toggle.min.js"></script>
    <script src="../Scripts/bsasper.js"></script>
    <script src="../Scripts/autosize.min.js"></script>
    <script>
        function doMultiSelect() {
            $('.multiselector').multiselect();
            $('.multiselect-dt').multiselect(
                {                    
                    onChange: function (option, checked, select) {
                        var pnl2 = false;
                        var pnl3 = false;
                        $.each($('.multiselect-dt > option:selected'), function () {
                            //alert($(this).text());
                            if ($(this).text() == 'Personal') {
                                pnl2 = true;
                            }
                            if ($(this).text() == 'Personal Sensitive' || $(this).text() == 'Special Category Personal Data') {
                                pnl2 = true;
                                pnl3 = true
                            }
                        });
                        if (pnl2) { $("#pnlSchedTwo").collapse('show'); } else { $("#pnlSchedTwo").collapse('hide');};
                        if (pnl3) { $("#pnlSchedThree").collapse('show'); } else { $("#pnlSchedThree").collapse('hide'); };;

                       }
                }

            );
        };
    </script>
    <script type="text/javascript">
        function BindEvents() {
            $("#pnlSchedTwo").collapse({ 'toggle': false });
            $("#pnlSchedThree").collapse({ 'toggle': false });
            $(document).ready(function () {
                $('.bs-pagination td table').each(function (index, obj) {
                    convertToPagination(obj)
                });
                autosize($('input, textarea'));
                //Lets do bootstrap form validation:
                $("input, textarea").bsasper({
                    placement: "right", createContent: function (errors) {
                        return '<span class="text-danger">' + errors[0] + '</span>';
                    }
                });
                
                doMultiSelect();
                $('[data-toggle="popover"]').popover();
                $(".date-picker").datepicker({ dateFormat: 'dd/mm/yy' });
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
            $(document).on('change', '.btn-file :file', function () {
                var input = $(this),
                    numFiles = input.get(0).files ? input.get(0).files.length : 1,
                    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                input.trigger('fileselect', [numFiles, label]);
            });
        };
    </script>
    <asp:HiddenField ID="hfProjectFileGroup" runat="server" Value="0" />
    <asp:HiddenField ID="hfProjectID" runat="server" Value="0" />
    <asp:HiddenField ID="hfReadOnly" runat="server" Value="0" />
    <asp:HiddenField ID="hfPFrozen" runat="server" />
    <div class="container">
        <div class="row">
            <div id="form-content" class="col-xs-12 scroll-area">
                <asp:Panel ID="pnlSummary" runat="server">
                   <h2 id="summary">
                        <asp:Label ID="lblFormTitle" runat="server" Text="Add Project"></asp:Label>
                    </h2>
                     <hr />
                    <div class="form-horizontal">
                        <div class="form-group">
                            <asp:Label ID="Label1" runat="server" CssClass="control-label col-xs-5" AssociatedControlID="tbProjectName">Project name / Project identifier:</asp:Label>
                            <div class="col-xs-7">
                                <div class="input-group">
                                    <asp:TextBox CssClass="form-control freeze-on-sign" runat="server" ID="tbProjectName" MaxLength="255" />
                                    <span class="input-group-btn">
                                        <a tabindex="0" title="Project Name / Project identifier" class="btn btn-default btn-tooltip" role="button" data-toggle="popover" data-container="body" data-trigger="focus" data-placement="auto" data-content="The project name / project identifier should enable you and your colleagues to identify the project at a glance. Using a consistent approach will aid in locating the project at a later date. Your organisation may have a policy on naming conventions which could be relevant to your choice of project name / project identifier."><i aria-hidden="true" class="icon-info"></i></a>
                                    </span>
                                </div>
                                <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="tbProjectName" ID="rxvProjectName" ValidationExpression="^[\s\S]{0,255}$" runat="server" ErrorMessage="Maximum 255 characters."></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbProjectName" CssClass="bg-danger" ErrorMessage="The project name field is required." SetFocusOnError="True" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label2" runat="server" CssClass="control-label col-xs-5" AssociatedControlID="tbProjectDescription">Project description:</asp:Label>
                            <div class="col-xs-7">
                                <div class="input-group">
                                    <asp:TextBox CssClass="form-control freeze-on-sign" runat="server" ID="tbProjectDescription" MaxLength="2000" TextMode="MultiLine" />
                                    <span class="input-group-addon">
                                        <a tabindex="0" title="Project description" class="btn btn-xs" role="button" data-toggle="popover" data-container="body" data-trigger="focus" data-placement="auto" data-content="Please provide a brief description of your project."><i aria-hidden="true" class="icon-info"></i></a>
                                    </span>
                                </div>
                                <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="tbProjectDescription" ID="RegularExpressionValidator1" ValidationExpression="^[\s\S]{0,2000}$" runat="server" ErrorMessage="Maximum 2000 characters."></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label3" runat="server" CssClass="control-label col-xs-5" AssociatedControlID="ddIGLead">IG Lead:</asp:Label>
                            <div class="col-xs-7">
                                <div class="input-group">
                                    <span class="input-group-btn" id="igleadtip">
                                        <a tabindex="0" title="IG Lead" class="btn btn-default btn-tooltip" role="button" data-toggle="popover"  data-container="body" data-trigger="focus" data-placement="auto" data-content="Select the appropriate IG Lead from you organisation."><i aria-hidden="true" class="icon-info"></i></a>
                                    </span>
                                    <asp:DropDownList AppendDataBoundItems="true" ID="ddIGLead" CssClass="form-control freeze-on-sign" runat="server" DataSourceID="lds_GetOrgIGRoles" DataTextField="OrganisationUserName" DataValueField="UserID">
                                        <asp:ListItem Value="0">Please select...</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <asp:LinqDataSource ID="lds_GetOrgIGRoles" runat="server" ContextTypeName="DPIAProjectsDataContext"></asp:LinqDataSource>
                        <div class="form-group">
                            <asp:Label ID="Label4" runat="server" CssClass="control-label col-xs-5" AssociatedControlID="ddDPOLead">DPO Lead:</asp:Label>
                            <div class="col-xs-7">
                                <div class="input-group">
                                    <span class="input-group-btn" id="dpotip">
                                        <a tabindex="0" title="DPO Lead" class="btn btn-default btn-tooltip" role="button" data-toggle="popover"  data-container="body" data-trigger="focus" data-placement="auto" data-content="Select the appropriate DPO Lead from you organisation."><i aria-hidden="true" class="icon-info"></i></a>
                                    </span>
                                    <asp:DropDownList AppendDataBoundItems="true" ID="ddDPOLead" CssClass="form-control freeze-on-sign" runat="server" DataSourceID="lds_GetOrgDPORoles" DataTextField="OrganisationUserName" DataValueField="UserID">
                                        <asp:ListItem Value="0">Please select...</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <asp:LinqDataSource ID="lds_GetOrgDPORoles" runat="server" ContextTypeName="DPIAProjectsDataContext"></asp:LinqDataSource>
                        <div class="form-group">
                            <asp:Label ID="Label5" runat="server" CssClass="control-label col-xs-5" AssociatedControlID="ddIALead">Information Asset Owner Lead:</asp:Label>
                            <div class="col-xs-7">
                                <div class="input-group">
                                    <span class="input-group-btn" id="iatip">
                                        <a tabindex="0" title="Information Asset Owner Lead" class="btn btn-default btn-tooltip" role="button" data-toggle="popover"  data-container="body" data-trigger="focus" data-placement="auto" data-content="Select the appropriate Information Asset Owner Lead from you organisation."><i aria-hidden="true" class="icon-info"></i></a>
                                    </span>
                                    <asp:DropDownList AppendDataBoundItems="true" ID="ddIALead" CssClass="form-control freeze-on-sign" runat="server" DataSourceID="lds_GetOrgIARoles" DataTextField="OrganisationUserName" DataValueField="UserID">
                                        <asp:ListItem Value="0">Please select...</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <asp:LinqDataSource ID="lds_GetOrgIARoles" runat="server" ContextTypeName="DPIAProjectsDataContext"></asp:LinqDataSource>                                                                                         
                    </div>
                    <hr />
                </asp:Panel>
                <div class="form-group" id="divEvidence" runat="server">
                    <label for="filEvidence" class="control-label col-xs-5">
                        Additional files (optional):
                    </label>
                    <div class="col-xs-7">
                        <div class="panel panel-default">
                            <asp:LinqDataSource ID="lds_SummaryFiles" runat="server" ContextTypeName="DPIAProjectsDataContext"></asp:LinqDataSource>     
                            <table class="table table-striped">
                                <asp:Repeater ID="rptFiles" runat="server" DataSourceID="lds_SummaryFiles">
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
                                            <td style="width: 20px"><asp:LinkButton ID="lbtDelete" Visible='<%# Eval("OrganisationID") = Session("UserOrganisationID") Or Session("IsSuperAdmin")%>' OnClientClick="return confirm('Are you sure you want to delete this file?');" runat="server" CommandName="Delete" CommandArgument='<%# Eval("FileID")%>' CssClass="btn btn-danger btn-xs" ToolTip="Delete File" CausesValidation="false"><i aria-hidden="true" class="icon-minus"></i><!--[if lt IE 8]>Delete<![endif]--></asp:LinkButton></td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate></div></FooterTemplate>
                                </asp:Repeater>
                            </table>
                        </div>
                        <asp:Panel ID="pnlFileUpload" runat="server" CssClass="input-group">                                                                    
                            <span class="input-group-btn">
                                <span class="btn btn-default btn-file">Browse&hellip;
                                    <asp:FileUpload AllowMultiple="true" ID="filEvidence" runat="server" />
                                </span>
                            </span>
                            <input type="text" placeholder="Optional (max 5 MB)" class="form-control freeze-on-sign">
                            <span class="input-group-btn">
                                <asp:LinkButton ID="lbtUpload" CausesValidation="false" CssClass="btn btn-default" runat="server"><i aria-hidden="true" class="icon-upload2"></i>  Upload</asp:LinkButton>
                            </span>
                        </asp:Panel>
                    </div>
                </div>
                &nbsp;
            </div>
            <div class="form-group">
                <asp:LinkButton Visible="false" ID="lbtUpdateSummary" CssClass="btn btn-primary pull-right" runat="server"><i aria-hidden="true" class="icon-checkmark"></i> Update Project</asp:LinkButton>
                <asp:LinkButton ID="lbtSaveProject" CssClass="btn btn-primary pull-right" runat="server"><i aria-hidden="true" class="icon-checkmark"></i> Save Project</asp:LinkButton>
            </div>
        </div>
    </div>

    <div id="modalMessage" class="modal fade" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" runat="server" id="btnCloseModal" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><asp:Label ID="lblModalHeading" runat="server"></asp:Label></h4>
                </div>
                <div class="modal-body">
                    <p><asp:Label ID="lblModalText" runat="server"></asp:Label></p>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="lbtAddedReturn" CausesValidation="false" CssClass="btn btn-default pull-left" runat="server" PostBackUrl="~/application/projects.aspx">Return to Project List</asp:LinkButton>
                    <asp:LinkButton ID="lbtAddDetail" CausesValidation="false" CommandArgument="0" CssClass="btn btn-default pull-right" runat="server" PostBackUrl="~/application/screening_questions_v2?action=Add">Perform Screening</asp:LinkButton>
                    <button id="ModalOK" runat="server" type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>



    <script type="text/javascript">
        Sys.Application.add_load(BindEvents);
    </script>


</asp:Content>
