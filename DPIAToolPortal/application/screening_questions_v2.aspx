<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="screening_questions_v2.aspx.vb" Inherits="InformationSharingPortal.screening_questions_v2" MaintainScrollPositionOnPostback="true"%>


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
        function doQ1Select() {

            var nQ1NoCount = 0;
            var nQ1YesCount = 0;
            var nQ1NullCount = 0;

            $('#<%=pnlQ1.ClientID %> input:radio:checked').each(function () {
                if ($(this).val() == "0") {
                    nQ1NoCount++;                
                } else if ($(this).val() == "1") {
                    nQ1YesCount++;
                }
            })
            nQ1NullCount = 6 - nQ1NoCount - nQ1YesCount;

            if (nQ1YesCount >= 1 && nQ1NullCount == 0) {
                $("#pnlQ2").collapse('hide');                
                $("#pnlQ3").collapse('hide');                
                $("#pnlQ4").collapse('hide');
                $("#pnlIGleadReview").collapse('hide');
                $("#pnlDPIANotRequired").collapse('hide');
                $("#pnlDPIARequired").collapse('show');
                $("#<%= hfScreeningStatus.ClientID %>").val("6"); // DPIA Required + Disable Mandatory Q2
                var validator = $get('<%=rvxScreeningV2Q02a.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q02b.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q02c.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q02d.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q02e.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q02f.ClientID %>');
                validator.enabled = false;

                //Clear Q2
                $('#<%=pnlQ2.ClientID %> input[type=radio]:checked').removeAttr("checked");
                //Clear Q3
                $('#<%=pnlQ3.ClientID %> input[type=radio]:checked').removeAttr("checked");
                //Clear Q4
                $('#<%=pnlQ4.ClientID %> input[type=radio]:checked').removeAttr("checked");

            } else if (nQ1NoCount == 6) {
                $("#pnlQ2").collapse('show'); //Show Q2 + Enable Mandatory Q2
                var validator = $get('<%=rvxScreeningV2Q02a.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q02b.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q02c.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q02d.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q02e.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q02f.ClientID %>');
                validator.enabled = true;
            } 
        };

        function doQ2Select() {

            var nQ2NoCount = 0;
            var nQ2YesCount = 0;
            var nQ2NullCount = 0;

            $('#<%=pnlQ2.ClientID %> input:radio:checked').each(function () {
                if ($(this).val() == "0") {
                    nQ2NoCount++;                
                } else if ($(this).val() == "1") {
                    nQ2YesCount++;
                } 
            })   
            nQ2NullCount = 6 - nQ2NoCount - nQ2YesCount;

           if (nQ2YesCount >= 1 && nQ2NullCount == 0) {                
                // Enable Q3Panel + Mandatory Q3 + Disable Mandatory Q4
                $("#pnlQ3").collapse('show');                
                $("#pnlQ4").collapse('hide');
                $("#pnlIGleadReview").collapse('hide');
                $("#pnlDPIANotRequired").collapse('hide');
                $("#pnlDPIARequired").collapse('hide');
                var validator = $get('<%=rvxScreeningV2Q03a.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q03b.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q03c.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q03d.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q03e.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q03f.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q03g.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q03h.ClientID %>');
                validator.enabled = true;

                var validator = $get('<%=rvxScreeningV2Q04a.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q04b.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q04c.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q04d.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q04e.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q04f.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q04g.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q04h.ClientID %>');
                validator.enabled = false;
                //Clear Q4
               $('#<%=pnlQ4.ClientID %> input[type=radio]:checked').removeAttr("checked");

            } else if (nQ2NoCount == 6) {
                // Enable Q4Panel + Mandatory Q4 + Disable Mandatory Q3
                $("#pnlQ3").collapse('hide');                
                $("#pnlQ4").collapse('show');
                $("#pnlIGleadReview").collapse('hide');
                $("#pnlDPIANotRequired").collapse('hide');
                $("#pnlDPIARequired").collapse('hide');
                var validator = $get('<%=rvxScreeningV2Q03a.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q03b.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q03c.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q03d.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q03e.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q03f.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q03g.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxScreeningV2Q03h.ClientID %>');
                validator.enabled = false;
                //Clear Q3
               $('#<%=pnlQ3.ClientID %> input[type=radio]:checked').removeAttr("checked");

                var validator = $get('<%=rvxScreeningV2Q04a.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q04b.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q04c.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q04d.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q04e.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q04f.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q04g.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxScreeningV2Q04h.ClientID %>');
                validator.enabled = true;
            } 
        };

        function doQ3Select() {

            var nQ3NoCount = 0;
            var nQ3YesCount = 0;
            var nQ3NullCount = 0;

            $('#<%=pnlQ3.ClientID %> input:radio:checked').each(function () {
                if ($(this).val() == "0") {
                    nQ3NoCount++;                
                } else if ($(this).val() == "1") {
                    nQ3YesCount++;
                } 
            })   
            nQ3NullCount = 8 - nQ3NoCount - nQ3YesCount;

            var validator = $get('<%=RequiredIGLead.ClientID %>');
            validator.enabled = false;

           if (nQ3YesCount >= 1 && nQ3NullCount == 0) {                
                $("#pnlIGleadReview").collapse('hide');
                $("#pnlDPIANotRequired").collapse('hide');
                $("#pnlDPIARequired").collapse('show');
                $("#<%= hfScreeningStatus.ClientID %>").val("6"); // DPIA Required + Disable Mandatory Q2
            } else if (nQ3NoCount == 8) {
                $("#pnlIGleadReview").collapse('show');
                $("#pnlDPIANotRequired").collapse('hide');
                $("#pnlDPIARequired").collapse('hide');
                var validator = $get('<%=RequiredIGLead.ClientID %>');
                validator.enabled = true;
                $("#<%= hfScreeningStatus.ClientID %>").val("5"); // IG Review Required
            }

        };

        function doQ4Select() {

            var nQ4NoCount = 0;
            var nQ4YesCount = 0;
            var nQ4NullCount = 0;

            $('#<%=pnlQ4.ClientID %> input:radio:checked').each(function () {
                if ($(this).val() == "0") {
                    nQ4NoCount++;                
                } else if ($(this).val() == "1") {
                    nQ4YesCount++;
                }
            })   
            nQ4NullCount = 8 - nQ4NoCount - nQ4YesCount;

            var validator = $get('<%=RequiredIGLead.ClientID %>');
            validator.enabled = false;

            var validator = $get('<%=RequiredIGLead.ClientID %>');
            validator.enabled = false;

           if (nQ4NullCount == 0) {                
                $("#pnlIGleadReview").collapse('show');
                $("#pnlDPIANotRequired").collapse('hide');
                $("#pnlDPIARequired").collapse('hide');
                var validator = $get('<%=RequiredIGLead.ClientID %>');
                validator.enabled = true;
                $("#<%= hfScreeningStatus.ClientID %>").val("5"); // IG Review Required
            }

        };


        function doStartPage() {

            doQ4Select();
            doQ3Select();
            doQ2Select();
            doQ1Select();
        };


    </script>

    <script type="text/javascript">
        function BindEvents() {
            $("#pnlQ2").collapse({ 'toggle': false });
            $("#pnlQ3").collapse({ 'toggle': false });
            $("#pnlQ4").collapse({ 'toggle': false });
            $("#pnlDPIARequired").collapse({ 'toggle': false });
            $("#pnlIGleadReview").collapse({ 'toggle': false });
            $("#pnlDPIANotRequired").collapse({ 'toggle': false });


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

            //Q1
            $("#<%=pnlQ1.ClientID %>").change(function() { 
                doQ1Select();
            }); 
            //Q2
             $("#<%=pnlQ2.ClientID %>").change(function() { 
                doQ2Select();
            });
            // Q3
             $("#<%=pnlQ3.ClientID %>").change(function() { 
                doQ3Select();
            });
            // Q4
             $("#<%=pnlQ4.ClientID %>").change(function() { 
                doQ4Select();
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
                        <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix" id="pnlQ1">
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q01" CssClass="col-xs-10" runat="server" ><span style="font-weight:bold">Q1) DPIA required under GDPR or expected by the ICO:</span></asp:Label>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q01a" AssociatedControlID="rblScreeningV2Q01a" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="1a). Will you be “evaluating” or “profiling” large numbers of individuals? E.g. performance at work, economic situation, health, personal preferences or interests, reliability or behaviour, location or movements of individuals."></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q01a" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q01a" runat="server" ControlToValidate="rblScreeningV2Q01a" CssClass="bg-danger" ErrorMessage="Screening Q1a is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q01b" AssociatedControlID="rblScreeningV2Q01b" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="1b). Will the data being processed include special category data of large numbers of individuals? E.g. racial or ethnic origin; political opinions; religious or philosophical beliefs; trade union membership; genetic data; biometric data; health data; or data concerning a person’s sex life or sexual orientation."></asp:Label>                                                        
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q01b" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q01b" runat="server" ControlToValidate="rblScreeningV2Q01b" CssClass="bg-danger" ErrorMessage="Screening Q1b is required." SetFocusOnError="True" />

                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q01c" AssociatedControlID="rblScreeningV2Q01c" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="1c). Will you be making decisions about an individual’s access to a product, service, opportunity or benefit which is abased to any extent on automated decision-making (including profiling)?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q01c" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q01c" runat="server" ControlToValidate="rblScreeningV2Q01c" CssClass="bg-danger" ErrorMessage="Screening Q1c is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q01d" AssociatedControlID="rblScreeningV2Q01d" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="1d). Carry out profiling on a large scale"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q01d" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q01d" runat="server" ControlToValidate="rblScreeningV2Q01d" CssClass="bg-danger" ErrorMessage="Screening Q1d is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q01e" AssociatedControlID="rblScreeningV2Q01e" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="1e). Process children’s personal data for profiling or automatic decision making or for marketing purposes or offer online services directly to them"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q01e" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q01e" runat="server" ControlToValidate="rblScreeningV2Q01e" CssClass="bg-danger" ErrorMessage="Screening Q1e is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q01f" AssociatedControlID="rblScreeningV2Q01f" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="1f). Is the processing of such a nature that a personal data breach could jeopardise the physical health and safety of individuals?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q01f" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q01f" runat="server" ControlToValidate="rblScreeningV2Q01f" CssClass="bg-danger" ErrorMessage="Screening Q1f is required." SetFocusOnError="True" />
                                </div>
                            </div>
                        </asp:panel>
<%--                        <div class="form-group">
                            <asp:Label ID="lblScreeningV2Q01g" AssociatedControlID="rblScreeningV2Q01g" CssClass="control-label col-xs-10" runat="server" Text="1g). Use of CCTV in a publicly accessible area. CCTV includes use of cameras including ANPR, AFR, dashcams, drones, fixed cameras, mobile cameras etc."></asp:Label>
                            <div class="radio radiobuttonlist col-sm-2">
                                <asp:RadioButtonList ID="rblScreeningV2Q01g" CssClass="dpiaradio1" runat="server">
                                    <asp:ListItem Text="Yes" Value="1" />
                                    <asp:ListItem Text="No" Value="0" />
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q01g" runat="server" ControlToValidate="rblScreeningV2Q01g" CssClass="bg-danger" ErrorMessage="Screening Q1g is required." SetFocusOnError="True" />
                            </div>
                        </div>--%>
                        <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlQ2">
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q02" CssClass="col-xs-10" runat="server" ><span style="font-weight:bold">Q2) One or more of the below:</span></asp:Label>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q02a" AssociatedControlID="rblScreeningV2Q02a" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="2a) Does the project involve you using new or innovative technology?" ></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q02a" runat="server" >
                                        <asp:ListItem Text="Yes" Value="1"  />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                     <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q02a" runat="server" ControlToValidate="rblScreeningV2Q02a" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q2a is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q02b" AssociatedControlID="rblScreeningV2Q02b" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="2b) Will the processing include biometric data?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q02b" runat="server" >
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q02b" runat="server" ControlToValidate="rblScreeningV2Q02b" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q2b is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q02c" AssociatedControlID="rblScreeningV2Q02c" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="2c) Will the processing include genetic data, other than that processed by an individual GP or health professional, for the provision of health care direct to the data subject?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q02c" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q02c" runat="server" ControlToValidate="rblScreeningV2Q02c" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q2c is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q02d" AssociatedControlID="rblScreeningV2Q02d" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="2d) Will you be processing data without giving a privacy notice directly to individuals involved in the processing?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q02d" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q02d" runat="server" ControlToValidate="rblScreeningV2Q02d" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q2d is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q02e" AssociatedControlID="rblScreeningV2Q02e" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="2e) Will the processing involve tracking an individual’s location, including but not limited to the online environment?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q02e" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q02e" runat="server" ControlToValidate="rblScreeningV2Q02e" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q2e is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q02f" AssociatedControlID="rblScreeningV2Q02f" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="2f) Will the processing involve monitoring an individual’s behaviour, including but not limited to the online environment?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q02f" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q02f" runat="server" ControlToValidate="rblScreeningV2Q02f" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q2f is required." SetFocusOnError="True" />
                                </div>
                            </div>
                        </asp:panel>
                        <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlQ3">
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q03" CssClass="col-xs-10" runat="server" ><span style="font-weight:bold">Q3) One or more of the below:</span></asp:Label>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q03a" AssociatedControlID="rblScreeningV2Q03a" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="3a) Evaluating or scoring individuals?" ></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q03a" runat="server" >
                                        <asp:ListItem Text="Yes" Value="1"  />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                     <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q03a" runat="server" ControlToValidate="rblScreeningV2Q03a" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q3a is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q03b" AssociatedControlID="rblScreeningV2Q03b" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="3b) Making automated decisions about individuals which have a legal effect on them?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q03b" runat="server" >
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q03b" runat="server" ControlToValidate="rblScreeningV2Q03b" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q3b is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q03c" AssociatedControlID="rblScreeningV2Q03c" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="3c) Systematically monitoring individuals?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q03c" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q03c" runat="server" ControlToValidate="rblScreeningV2Q03c" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q3c is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q03d" AssociatedControlID="rblScreeningV2Q03d" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="3d) Processing special category data?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q03d" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q03d" runat="server" ControlToValidate="rblScreeningV2Q03d" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q3d is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q03e" AssociatedControlID="rblScreeningV2Q03e" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="3e) Processing data about a large number of individuals?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q03e" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q03e" runat="server" ControlToValidate="rblScreeningV2Q03e" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q3e is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q03f" AssociatedControlID="rblScreeningV2Q03f" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="3f) Matching or combining datasets?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q03f" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q03f" runat="server" ControlToValidate="rblScreeningV2Q03f" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q3f is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q03g" AssociatedControlID="rblScreeningV2Q03g" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="3g) Using innovative technology or organisational arrangements?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q03g" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q03g" runat="server" ControlToValidate="rblScreeningV2Q03g" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q3g is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q03h" AssociatedControlID="rblScreeningV2Q03h" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="3h) Processing in a way which means individuals will not be able to exercise their rights, or use a service or contract?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q03h" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q03h" runat="server" ControlToValidate="rblScreeningV2Q03h" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q3h is required." SetFocusOnError="True" />
                                </div>
                            </div>
                        </asp:panel>
                        <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlQ4">
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q04" CssClass="col-xs-10" runat="server" ><span style="font-weight:bold">Q4) Other processing considerations</span></asp:Label>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q04a" AssociatedControlID="rblScreeningV2Q04a" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="4a) Evaluating or scoring individuals?" ></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q04a" runat="server" >
                                        <asp:ListItem Text="Yes" Value="1"  />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                     <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q04a" runat="server" ControlToValidate="rblScreeningV2Q04a" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q4a is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q04b" AssociatedControlID="rblScreeningV2Q04b" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="4b) Making automated decisions about individuals which have a legal effect on them?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q04b" runat="server" >
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q04b" runat="server" ControlToValidate="rblScreeningV2Q04b" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q4b is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q04c" AssociatedControlID="rblScreeningV2Q04c" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="4c) Systematically monitoring individuals?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q04c" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q04c" runat="server" ControlToValidate="rblScreeningV2Q04c" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q4c is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q04d" AssociatedControlID="rblScreeningV2Q04d" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="4d) Processing special category data?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q04d" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q04d" runat="server" ControlToValidate="rblScreeningV2Q04d" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q4d is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q04e" AssociatedControlID="rblScreeningV2Q04e" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="4e) Processing data about a large number of individuals?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q04e" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q04e" runat="server" ControlToValidate="rblScreeningV2Q04e" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q4e is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q04f" AssociatedControlID="rblScreeningV2Q04f" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="4f) Matching or combining datasets?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q04f" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q04f" runat="server" ControlToValidate="rblScreeningV2Q04f" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q4f is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q04g" AssociatedControlID="rblScreeningV2Q04g" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="4g) Using innovative technology or organisational arrangements?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q04g" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q04g" runat="server" ControlToValidate="rblScreeningV2Q04g" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q4g is required." SetFocusOnError="True" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblScreeningV2Q04h" AssociatedControlID="rblScreeningV2Q04h" CssClass="col-xs-offset-1 col-xs-9 text-left" runat="server" Text="4h) Processing in a way which means individuals will not be able to exercise their rights, or use a service or contract?"></asp:Label>
                                <div class="col-xs-2 dpiaradio1">
                                    <asp:RadioButtonList ID="rblScreeningV2Q04h" runat="server">
                                        <asp:ListItem Text="Yes" Value="1" />
                                        <asp:ListItem Text="No" Value="0" />
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxScreeningV2Q04h" runat="server" ControlToValidate="rblScreeningV2Q04h" CssClass="bg-danger" Enabled="false" ErrorMessage="Screening Q4h is required." SetFocusOnError="True" />
                                </div>
                            </div>
                        </asp:panel>
                        <hr />
                        <asp:panel runat="server" ClientIDMode="Static" CssClass="alert-info clearfix collapse" id="pnlDPIARequired">
                              <div class="form-group">
                                <asp:Label ID="DPIARequired" CssClass="control-label col-xs-7" runat="server" Text="A DPIA is required for this project"></asp:Label>
                            </div>
                        </asp:panel>
                        <asp:panel runat="server" ClientIDMode="Static" CssClass="alert-info clearfix collapse" id="pnlIGleadReview">
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
                                        <asp:DropDownList AppendDataBoundItems="true" ID="ddIGLead" CssClass="form-control freeze-on-sign" runat="server" DataSourceID="lds_GetOrgIGRoles" DataTextField="OrganisationUserName" DataValueField="UserID">
                                            <asp:ListItem Value="0">Please select...</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredIGLead" InitialValue="0" Enabled="false" runat="server" ControlToValidate="ddIGLead" CssClass="bg-danger" ErrorMessage="An IG Lead must be selected." SetFocusOnError="True" />
                                    </div>
                                </div>
                            </div>
                            <asp:LinqDataSource ID="lds_GetOrgIGRoles" runat="server" ContextTypeName="DPIAProjectsDataContext"></asp:LinqDataSource>
                        </asp:panel>
                        <asp:panel runat="server" ClientIDMode="Static" CssClass="alert-info clearfix collapse" id="pnlDPIANotRequired">
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
