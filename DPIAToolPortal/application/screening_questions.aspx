<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master"  CodeBehind="screening_questions.aspx.vb" Inherits="InformationSharingPortal.screening_questions" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Content/bootstrap-multiselect.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageHeading" runat="server">
    <h1>Project Screening</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    
    <link href="../Content/dpia-additional.css" rel="stylesheet" />
    <script src="../Scripts/bs.pagination.js"></script>
    <script src="../Scripts/bootstrap/bootstrap-multiselect.js"></script>
    <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.0/js/bootstrap-toggle.min.js"></script>
    <script src="../Scripts/bsasper.js"></script>
    <script src="../Scripts/autosize.min.js"></script>

    <script>
        function doFirstThreeSelect() {
            var q01value = $("input[name='<%=rblScreeningQ01.UniqueID%>']:radio:checked").val();
            var q02value = $("input[name='<%=rblScreeningQ02.UniqueID%>']:radio:checked").val();
            var q03value = $("input[name='<%=rblScreeningQ03.UniqueID%>']:radio:checked").val();
            if (q01value == "0" && q02value == "0" && q03value == "0") {
                $("#pnlSchedOne").collapse('show');
                $("#pnlSchedTwo").collapse('hide');

                var validator = $get('<%=RequiredFieldValidator04.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=RequiredFieldValidator05.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=RequiredFieldValidator06.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=RequiredFieldValidator07.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=RequiredFieldValidator08.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=RequiredFieldValidator09.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=RequiredFieldValidator10.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=RequiredFieldValidator11.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=RequiredFieldValidator12.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=RequiredFieldValidator13.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=RequiredFieldValidator14.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=RequiredFieldValidator15.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=RequiredFieldValidator16.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=RequiredFieldValidator17.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=RequiredFieldValidator18.ClientID %>');
                validator.enabled = true;
            } else {
                $("#pnlSchedOne").collapse('hide');
                $("#pnlSchedThree").collapse('hide');
                $("#pnlSchedFour").collapse('hide');
                var validator = $get('<%=RequiredFieldValidator04.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=RequiredFieldValidator05.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=RequiredFieldValidator06.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=RequiredFieldValidator07.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=RequiredFieldValidator08.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=RequiredFieldValidator09.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=RequiredFieldValidator10.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=RequiredFieldValidator11.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=RequiredFieldValidator12.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=RequiredFieldValidator13.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=RequiredFieldValidator14.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=RequiredFieldValidator15.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=RequiredFieldValidator16.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=RequiredFieldValidator17.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=RequiredFieldValidator18.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=RequiredIGLead.ClientID %>');
                validator.enabled = false;

                
                $('#<%=rblScreeningQ04.ClientID %> input[type=radio]:checked').removeAttr("checked");
                $('#<%=rblScreeningQ05.ClientID %> input[type=radio]:checked').removeAttr("checked");
                $('#<%=rblScreeningQ06.ClientID %> input[type=radio]:checked').removeAttr("checked");
                $('#<%=rblScreeningQ07.ClientID %> input[type=radio]:checked').removeAttr("checked");
                $('#<%=rblScreeningQ08.ClientID %> input[type=radio]:checked').removeAttr("checked");
                $('#<%=rblScreeningQ09.ClientID %> input[type=radio]:checked').removeAttr("checked");
                $('#<%=rblScreeningQ10.ClientID %> input[type=radio]:checked').removeAttr("checked");
                $('#<%=rblScreeningQ11.ClientID %> input[type=radio]:checked').removeAttr("checked");
                $('#<%=rblScreeningQ12.ClientID %> input[type=radio]:checked').removeAttr("checked");
                $('#<%=rblScreeningQ13.ClientID %> input[type=radio]:checked').removeAttr("checked");
                $('#<%=rblScreeningQ14.ClientID %> input[type=radio]:checked').removeAttr("checked");
                $('#<%=rblScreeningQ15.ClientID %> input[type=radio]:checked').removeAttr("checked");
                $('#<%=rblScreeningQ16.ClientID %> input[type=radio]:checked').removeAttr("checked");
                $('#<%=rblScreeningQ17.ClientID %> input[type=radio]:checked').removeAttr("checked");
                $('#<%=rblScreeningQ18.ClientID %> input[type=radio]:checked').removeAttr("checked"); 
                
                if ((q01value == "0" || q01value == "1") && (q02value == "0" || q02value == "1") && (q03value == "0" || q03value == "1")) {
                    $("#pnlSchedTwo").collapse('show');
                    $("#<%= hfScreeningStatus.ClientID %>").val("6"); // DPIA Required

                }
            } 

        };

        function doScreeningSelect() {

            var strScreenQuestions = [
                $("input[name='<%=rblScreeningQ04.UniqueID%>']:radio:checked").val(),
                $("input[name='<%=rblScreeningQ05.UniqueID%>']:radio:checked").val(),
                $("input[name='<%=rblScreeningQ06.UniqueID%>']:radio:checked").val(),
                $("input[name='<%=rblScreeningQ07.UniqueID%>']:radio:checked").val(),
                $("input[name='<%=rblScreeningQ08.UniqueID%>']:radio:checked").val(),
                $("input[name='<%=rblScreeningQ09.UniqueID%>']:radio:checked").val(),
                $("input[name='<%=rblScreeningQ10.UniqueID%>']:radio:checked").val(),
                $("input[name='<%=rblScreeningQ11.UniqueID%>']:radio:checked").val(),
                $("input[name='<%=rblScreeningQ12.UniqueID%>']:radio:checked").val(),
                $("input[name='<%=rblScreeningQ13.UniqueID%>']:radio:checked").val(),
                $("input[name='<%=rblScreeningQ14.UniqueID%>']:radio:checked").val(),
                $("input[name='<%=rblScreeningQ15.UniqueID%>']:radio:checked").val(),
                $("input[name='<%=rblScreeningQ16.UniqueID%>']:radio:checked").val(),
                $("input[name='<%=rblScreeningQ17.UniqueID%>']:radio:checked").val(),
                $("input[name='<%=rblScreeningQ18.UniqueID%>']:radio:checked").val()
            ];

            var nNoCount = 0;
            var nYesCount = 0;
            var nNullCount = 0;

            var i;
            for (i = 0; i < strScreenQuestions.length; i++) {
                if (strScreenQuestions[i] == "0") {
                    nNoCount++;
                } else if (strScreenQuestions[i] == "1") {
                    nYesCount++;
                } else {
                    nNullCount++;
                }
            }
            var validator = $get('<%=RequiredIGLead.ClientID %>');
            validator.enabled = false;

            if (nNoCount == 15) {
                $("#pnlSchedTwo").collapse('hide');
                $("#pnlSchedThree").collapse('hide');
                $("#pnlSchedFour").collapse('show');
                $("#<%= hfScreeningStatus.ClientID %>").val("3"); // DPIA Not Required
            } else if (nNoCount == 14 && nYesCount == 1) {
                $("#pnlSchedTwo").collapse('hide');
                $("#pnlSchedThree").collapse('show');
                $("#pnlSchedFour").collapse('hide');
                var validator = $get('<%=RequiredIGLead.ClientID %>');
                validator.enabled = true;
                $("#<%= hfScreeningStatus.ClientID %>").val("5"); // IG Review Required
            } else if (nNullCount == 0 && nYesCount >= 2) {
                $("#pnlSchedTwo").collapse('show');
                $("#pnlSchedThree").collapse('hide');
                $("#pnlSchedFour").collapse('hide');
                $("#<%= hfScreeningStatus.ClientID %>").val("6"); // DPIA Required
            }

        };

        function doStartPage() {

            doFirstThreeSelect();
            doScreeningSelect();
        };


    </script>

    <script type="text/javascript">
        function BindEvents() {
            $("#pnlSchedOne").collapse({ 'toggle': false });
            $("#pnlSchedTwo").collapse({ 'toggle': false });
            $("#pnlSchedThree").collapse({ 'toggle': false });
            $("#pnlSchedFour").collapse({ 'toggle': false });

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

        $(document).ready(function () {
            $("#<%=rblScreeningQ01.ClientID %>").change(function() { 
                doFirstThreeSelect();
            });
            $("#<%=rblScreeningQ02.ClientID %>").change(function() {
                doFirstThreeSelect();
            });
            $("#<%=rblScreeningQ03.ClientID %>").change(function() { 
                doFirstThreeSelect();
            });

            $("#<%=rblScreeningQ04.ClientID %>").change(function() { 
                doScreeningSelect();
            });
            $("#<%=rblScreeningQ05.ClientID %>").change(function() { 
                doScreeningSelect();
            });
            $("#<%=rblScreeningQ06.ClientID %>").change(function() { 
                doScreeningSelect();
            });
            $("#<%=rblScreeningQ07.ClientID %>").change(function() { 
                doScreeningSelect();
            });
            $("#<%=rblScreeningQ08.ClientID %>").change(function() { 
                doScreeningSelect();
            });
            $("#<%=rblScreeningQ09.ClientID %>").change(function() { 
                doScreeningSelect();
            });
            $("#<%=rblScreeningQ10.ClientID %>").change(function() { 
                doScreeningSelect();
            });
            $("#<%=rblScreeningQ11.ClientID %>").change(function() { 
                doScreeningSelect();
            });
            $("#<%=rblScreeningQ12.ClientID %>").change(function() { 
                doScreeningSelect();
            });
            $("#<%=rblScreeningQ13.ClientID %>").change(function() { 
                doScreeningSelect();
            });
            $("#<%=rblScreeningQ14.ClientID %>").change(function() { 
                doScreeningSelect();
            });
            $("#<%=rblScreeningQ15.ClientID %>").change(function() { 
                doScreeningSelect();
            });
            $("#<%=rblScreeningQ16.ClientID %>").change(function() { 
                doScreeningSelect();
            });
            $("#<%=rblScreeningQ17.ClientID %>").change(function() { 
                doScreeningSelect();
            });
            $("#<%=rblScreeningQ18.ClientID %>").change(function() { 
                doScreeningSelect();
            });

        });


    </script>
    <asp:HiddenField ID="hfProjectFileGroup" runat="server" Value="0" />
    <asp:HiddenField ID="hfProjectID" runat="server" Value="0" />
    <asp:HiddenField ID="hfReadOnly" runat="server" Value="0" />
    <asp:HiddenField ID="hfScreeningValidation" runat="server" Value="0" />
    <asp:HiddenField ID="hfPFrozen" runat="server" />
    <asp:HiddenField ID="hfScreeningStatus" runat="server" Value="0" />

    <div class="container">
        <div class="row">
            <div id="form-content" class="col-xs-12 scroll-area">
                <asp:Panel ID="pnlSummary" runat="server">
                   <h2 id="summary">
                        <asp:Label ID="lblFormTitle" runat="server" Text="Project Screening Questions"></asp:Label>
                    </h2>
                     <hr />
                    <div class="form-horizontal">
                        <div class="form-group">
                            <asp:Label ID="lblScreeningQ01" AssociatedControlID="rblScreeningQ01" CssClass="col-xs-10 text-left" runat="server" Text="1). Will you be evaluating or profiling large numbers of individuals? E.g. performance at work,economic situation, health, personal preferences or interests, reliability or behaviour, location or movements of individuals"></asp:Label>
                            <div class="radio radiobuttonlist col-sm-2">
                                <asp:RadioButtonList ID="rblScreeningQ01" CssClass="dpiaradio1" runat="server">
                                    <asp:ListItem Text="Yes" Value="1" />
                                    <asp:ListItem Text="No" Value="0" />
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator01" runat="server" ControlToValidate="rblScreeningQ01" CssClass="bg-danger" ErrorMessage="Screening Q1 is required." SetFocusOnError="True" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblScreeningQ02" AssociatedControlID="rblScreeningQ02" CssClass="control-label col-xs-10" runat="server" Text="2). Will the data being processed include special category data of large numbers of individuals? E.g. racial or ethnic origin; political opinions; religious or philosophical beliefs; trade union membership; genetic data; biometric data; health data; or data concerning a person's sex life or sexual orientation."></asp:Label>
                            <div class="radio radiobuttonlist col-sm-2">
                                <asp:RadioButtonList ID="rblScreeningQ02" CssClass="dpiaradio1" runat="server">
                                    <asp:ListItem Text="Yes" Value="1" />
                                    <asp:ListItem Text="No" Value="0" />
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator02" runat="server" ControlToValidate="rblScreeningQ02" CssClass="bg-danger" ErrorMessage="Screening Q2 is required." SetFocusOnError="True" />

                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblScreeningQ03" AssociatedControlID="rblScreeningQ03" CssClass="control-label col-xs-10" runat="server" Text="3). Use of CCTV in a publicly accessible area. CCTV includes use of cameras including ANPR, AFR, dashcams, drones, fixed cameras, mobile cameras etc."></asp:Label>
                            <div class="radio radiobuttonlist col-sm-2">
                                <asp:RadioButtonList ID="rblScreeningQ03" CssClass="dpiaradio1" runat="server">
                                    <asp:ListItem Text="Yes" Value="1" />
                                    <asp:ListItem Text="No" Value="0" />
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator03" runat="server" ControlToValidate="rblScreeningQ03" CssClass="bg-danger" ErrorMessage="Screening Q3 is required." SetFocusOnError="True" />
                            </div>
                        </div>
                        <asp:panel runat="server" ClientIDMode="Static" class="alert-warning clearfix collapse" id="pnlSchedOne">

                            <div class="form-group">
                                <asp:Label ID="lblScreeningQ04" AssociatedControlID="rblScreeningQ04" CssClass="col-sm-10 control-label" runat="server" Text="4). Does the project involve you using new or innovative technology?" ></asp:Label>
                                <div class="radio radiobuttonlist col-sm-2">
                                    <asp:RadioButtonList ID="rblScreeningQ04" CssClass="dpiaradio1" runat="server" >
                                        <asp:ListItem Text="Yes" Value="1"  />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                     <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator04" runat="server" ControlToValidate="rblScreeningQ04" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q4 is required." SetFocusOnError="True" />
                                </div>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="lblScreeningQ05" AssociatedControlID="rblScreeningQ05" CssClass="col-sm-10 control-label" runat="server" Text="5). Will you be making decisions about an individual’s access to a product, service, opportunity or benefit which is abased to any extent on automated decision-making (including profiling)?"></asp:Label>
                                <div class="radio radiobuttonlist col-sm-2">
                                    <asp:RadioButtonList ID="rblScreeningQ05" CssClass="dpiaradio1" runat="server" >
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator05" runat="server" ControlToValidate="rblScreeningQ05" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q5 is required." SetFocusOnError="True" />
                                </div>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="lblScreeningQ06" AssociatedControlID="rblScreeningQ06" CssClass="control-label col-xs-10" runat="server" Text="6). Will the processing consist of data belonging to large numbers of individuals?"></asp:Label>
                                <div class="radio radiobuttonlist col-sm-2">
                                    <asp:RadioButtonList ID="rblScreeningQ06" CssClass="dpiaradio1" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator06" runat="server" ControlToValidate="rblScreeningQ06" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q6 is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningQ07" AssociatedControlID="rblScreeningQ07" CssClass="control-label col-xs-10" runat="server" Text="7). Will the data being processed include special category data of a small to medium sized number of individuals? E.g. racial or ethnic origin; political opinions; religious or philosophical beliefs; trade union membership; genetic data; biometric data; health data; or data concerning a person’s sex life or sexual orientation."></asp:Label>
                                <div class="radio radiobuttonlist col-sm-2">
                                    <asp:RadioButtonList ID="rblScreeningQ07" CssClass="dpiaradio1" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator07" runat="server" ControlToValidate="rblScreeningQ07" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q7 is required." SetFocusOnError="True" />
                                </div>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="lblScreeningQ08" AssociatedControlID="rblScreeningQ08" CssClass="control-label col-xs-10" runat="server" Text="8). Will you be “evaluating”, “scoring” or “profiling” a small to medium sized number of individuals? E.g. performance at work, economic situation, health, personal preferences or interests, reliability or behaviour, location or movements of individuals."></asp:Label>
                                <div class="radio radiobuttonlist col-sm-2">
                                    <asp:RadioButtonList ID="rblScreeningQ08" CssClass="dpiaradio1" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator08" runat="server" ControlToValidate="rblScreeningQ08" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q8 is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningQ09" AssociatedControlID="rblScreeningQ09" CssClass="control-label col-xs-10" runat="server" Text="9). Will you be monitoring individuals (except CCTV), including data collected through computer networks?"></asp:Label>
                                <div class="radio radiobuttonlist col-sm-2">
                                    <asp:RadioButtonList ID="rblScreeningQ09" CssClass="dpiaradio1" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator09" runat="server" ControlToValidate="rblScreeningQ09" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q9 is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningQ10" AssociatedControlID="rblScreeningQ10" CssClass="control-label col-xs-10" runat="server" Text="10). Are you collecting data from any of the following groups: children; employees; people with disabilities; elderly people?"></asp:Label>
                                <div class="radio radiobuttonlist col-sm-2">
                                    <asp:RadioButtonList ID="rblScreeningQ10" CssClass="dpiaradio1" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator10" runat="server" ControlToValidate="rblScreeningQ10" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q10 is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningQ11" AssociatedControlID="rblScreeningQ11" CssClass="control-label col-xs-10" runat="server" Text="11). Will the processing include biometric data?"></asp:Label>
                                <div class="radio radiobuttonlist col-sm-2">
                                    <asp:RadioButtonList ID="rblScreeningQ11" CssClass="dpiaradio1" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator11" runat="server" ControlToValidate="rblScreeningQ11" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q11 is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningQ12" AssociatedControlID="rblScreeningQ12" CssClass="control-label col-xs-10" runat="server" Text="12). Will the processing include genetic data, other than that processed by an individual GP or health professional, for the provision of health care direct to the data subject?"></asp:Label>
                                <div class="radio radiobuttonlist col-sm-2">
                                    <asp:RadioButtonList ID="rblScreeningQ12" CssClass="dpiaradio1" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator12" runat="server" ControlToValidate="rblScreeningQ12" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q12 is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningQ13" AssociatedControlID="rblScreeningQ13" CssClass="control-label col-xs-10" runat="server" Text="13). Will you be combining, comparing or matching personal data obtained from multiple sources?"></asp:Label>
                                <div class="radio radiobuttonlist col-sm-2">
                                    <asp:RadioButtonList ID="rblScreeningQ13" CssClass="dpiaradio1" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator13" runat="server" ControlToValidate="rblScreeningQ13" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q13 is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningQ14" AssociatedControlID="rblScreeningQ14" CssClass="control-label col-xs-10" runat="server" Text="14). Will you be processing data received from a third party (i.e. not the data subject) in circumstances were it would be impossible or involve disproportionate effort to inform the data subject that you are processing their data?"></asp:Label>
                                <div class="radio radiobuttonlist col-sm-2">
                                    <asp:RadioButtonList ID="rblScreeningQ14" CssClass="dpiaradio1" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator14" runat="server" ControlToValidate="rblScreeningQ14" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q14 is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningQ15" AssociatedControlID="rblScreeningQ15" CssClass="control-label col-xs-10" runat="server" Text="15). Will the processing involve tracking an individual’s location, including but not limited to the online environment?"></asp:Label>
                                <div class="radio radiobuttonlist col-sm-2">
                                    <asp:RadioButtonList ID="rblScreeningQ15" CssClass="dpiaradio1" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator15" runat="server" ControlToValidate="rblScreeningQ15" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q15 is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningQ16" AssociatedControlID="rblScreeningQ16" CssClass="control-label col-xs-10" runat="server" Text="16). Will the processing involve monitoring an individual’s behaviour, including but not limited to the online environment?"></asp:Label>
                                <div class="radio radiobuttonlist col-sm-2">
                                    <asp:RadioButtonList ID="rblScreeningQ16" CssClass="dpiaradio1" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator16" runat="server" ControlToValidate="rblScreeningQ16" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q16 is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningQ17" AssociatedControlID="rblScreeningQ17" CssClass="control-label col-xs-10" runat="server" Text="17). Is the processing of such a nature that a personal data breach could jeopardise the physical health and safety of individuals?"></asp:Label>
                                <div class="radio radiobuttonlist col-sm-2">
                                    <asp:RadioButtonList ID="rblScreeningQ17" CssClass="dpiaradio1" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator17" runat="server" ControlToValidate="rblScreeningQ17" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q17 is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningQ18" AssociatedControlID="rblScreeningQ18" CssClass="control-label col-xs-10" runat="server" Text="18). Will you be processing data without giving a privacy notice directly to individuals involved in the processing?"></asp:Label>
                                <div class="radio radiobuttonlist col-sm-2">
                                    <asp:RadioButtonList ID="rblScreeningQ18" CssClass="dpiaradio1" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator18" runat="server" ControlToValidate="rblScreeningQ18" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q18 is required." SetFocusOnError="True" />
                                </div>
                            </div>
                        </asp:panel>
                       <hr />
                        <asp:panel runat="server" ClientIDMode="Static" class="alert-info clearfix collapse" id="pnlSchedTwo">
                              <div class="form-group">
                                <asp:Label ID="DPIARequired" CssClass="control-label col-xs-7" runat="server" Text="A DPIA is required for this project"></asp:Label>
                            </div>
                        </asp:panel>
                        <asp:panel runat="server" ClientIDMode="Static" class="alert-info clearfix collapse" id="pnlSchedThree">
                            <div class="form-group">
                                <asp:Label ID="IGLeadRequired" CssClass="control-label col-xs-7" runat="server" Text="An IG Lead Review is required for this Project"></asp:Label>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label3" runat="server" CssClass="control-label col-xs-6" AssociatedControlID="ddIGLead">IG Lead:</asp:Label>
                                <div class="col-xs-5">
                                    <div class="input-group">
                                        <span class="input-group-btn" id="igleadtip">
                                            <a tabindex="0" title="IG Lead" class="btn btn-default btn-tooltip" role="button" data-toggle="popover"  data-container="body" data-trigger="focus" data-placement="auto" data-content="Select the appropriate IG Lead from you organisation."><i aria-hidden="true" class="icon-info"></i></a>
                                        </span>
                                        <asp:DropDownList AppendDataBoundItems="true" ID="ddIGLead" CssClass="form-control freeze-on-sign" runat="server" DataSourceID="dsIGLeads" DataTextField="OrganisationUserName" DataValueField="UserID">
                                            <asp:ListItem Value="0">Please select...</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredIGLead" InitialValue="0" Enabled="false" runat="server" ControlToValidate="ddIGLead" CssClass="bg-danger" ErrorMessage="An IG Lead must be selected." SetFocusOnError="True" />
                                    </div>
                                </div>
                            </div>
                            <asp:ObjectDataSource ID="dsIGLeads" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="Users_GetOrgByIGRole" TypeName="InformationSharingPortal.DPIAProjectsTableAdapters.Users_GetOrgIGRolesTableAdapter">
                                <SelectParameters>
                                    <asp:SessionParameter Name="OrganisationID" SessionField="UserOrganisationID" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </asp:panel>
                        <asp:panel runat="server" ClientIDMode="Static" class="alert-info clearfix collapse" id="pnlSchedFour">
                              <div class="form-group">
                                <asp:Label ID="DPIANotRequired" CssClass="control-label col-xs-7" runat="server" Text="A DPIA Review is not required for the Project"></asp:Label>
                            </div>
                        </asp:panel>


                    </div>
                    <hr />
                </asp:Panel>
                &nbsp;
            </div>
            <div class="form-group">
                <asp:LinkButton Visible="false" ID="lbtUpdateSummary" CssClass="btn btn-primary pull-right" runat="server"><i aria-hidden="true" class="icon-checkmark"></i> Update Project</asp:LinkButton>
                <asp:LinkButton ID="lbtSaveProjectScreening" CssClass="btn btn-primary pull-right" runat="server"><i aria-hidden="true" class="icon-checkmark"></i> Save Project Screening</asp:LinkButton>
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
                    <asp:LinkButton ID="lbtAddDetail" CausesValidation="false" CommandArgument="0" CssClass="btn btn-default pull-right" runat="server" PostBackUrl="~/application/dpia.aspx">Perform DPIA</asp:LinkButton>
                    <button id="ModalOK" runat="server" type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>



    <script type="text/javascript">
        Sys.Application.add_load(BindEvents);
    </script>


</asp:Content>