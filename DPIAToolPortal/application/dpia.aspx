<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="dpia.aspx.vb" Inherits="InformationSharingPortal.dpia" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Content/bootstrap-multiselect.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageHeading" runat="server">
    <h1 id="summary">
        <asp:Label ID="lblFormTitle" runat="server" Text="Project DPIA"></asp:Label>
    </h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Content/dpia-additional.css" rel="stylesheet" />
    <script src="../Scripts/bs.pagination.js"></script>
    <script src="../Scripts/bootstrap/bootstrap-multiselect.js"></script>
    <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.0/css/bootstrap-toggle.min.css" rel="stylesheet">
    <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.0/js/bootstrap-toggle.min.js"></script>
    <script src="../Scripts/bsasper.js"></script>
    <script src="../Scripts/autosize.min.js"></script>
    

    <script>
        function doDPIALegalQ01Select() {

            var q01value = $("input[name='<%=rblDPIALegalQ01.UniqueID%>']:radio:checked").val();

            if (q01value == "1") {
                $("#pnlLegalQ01").collapse('show');
                var validator = $get('<%=rvxDPIALegalQ01a.ClientID %>');
                validator.enabled = true;
            } else if (q01value == "0") {
                if ($('#pnlLegalQ01').hasClass('in')) {
                    $("#pnlLegalQ01").collapse('hide');
                    var validator = $get('<%=rvxDPIALegalQ01a.ClientID %>');
                    validator.enabled = false;
                }
                
            } 

        };

        function doDPIALegalQ01aSelect() {

            var q01avalue = $("input[name='<%=rblDPIALegalQ01a.UniqueID%>']:radio:checked").val();
            if (q01avalue == "1") {
                $("#pnlLegalQ01a").collapse('show');
                var validator = $get('<%=rvxDPIALegalQ01aa2.ClientID %>');
                validator.enabled = true;
                var validator = $get('<%=rvxDPIALegalQ01aa3.ClientID %>');
                validator.enabled = true;

            } else {
                if ($('#pnlLegalQ01a').hasClass('in')) {
                    $("#pnlLegalQ01a").collapse('hide');
                var validator = $get('<%=rvxDPIALegalQ01aa2.ClientID %>');
                validator.enabled = false;
                var validator = $get('<%=rvxDPIALegalQ01aa3.ClientID %>');
                validator.enabled = false;
                }
            } 

        };

        function doDPIALegalQ01aaSelect() {

            var q02avalue = $("input[name='<%=cbDPIALegalQ01aa.UniqueID%>']:checked").val();
            if (q02avalue == "on" ) {
                $("#pnlLegalQ01aa").collapse('show');

            } else {
                $("#pnlLegalQ01aa").collapse('hide');               
            } 

        };

        function doDPIALegalQ01acSelect() {

            var q02cvalue = $("input[name='<%=cbDPIALegalQ01ac.UniqueID%>']:checked").val();
            if (q02cvalue == "on" ) {
                $("#pnlLegalQ01ac").collapse('show');

            } else {
                $("#pnlLegalQ01ac").collapse('hide');               
            } 

        };

        function doDPIALegalQ01aeSelect() {

            var q01aevalue = $("input[name='<%=cbDPIALegalQ01ae.UniqueID%>']:checked").val();
            if (q01aevalue == "on" ) {
                $("#pnlLegalQ01ae").collapse('show');

            } else {
                $("#pnlLegalQ01ae").collapse('hide');               
            } 

        };

        function doDPIALegalQ01afSelect() {

            var q01afvalue = $("input[name='<%=cbDPIALegalQ01af.UniqueID%>']:checked").val();
            if (q01afvalue == "on" ) {
                $("#pnlLegalQ01af").collapse('show');

            } else {
                $("#pnlLegalQ01af").collapse('hide');               
            } 

        };

        function doDPIALegalQ02Select() {

            var q02value = $("input[name='<%=rblDPIALegalQ02.UniqueID%>']:radio:checked").val();
            if (q02value == "1") {
                $("#pnlLegalQ02").collapse('show');
            } else {
                if ($('#pnlLegalQ02').hasClass('in')) {
                    $("#pnlLegalQ02").collapse('hide');
                }
            } 
        };

        function doDPIALegalQ02agSelect() {
            var q02agvalue = $("input[name='<%=cbDPIALegalQ02ag.UniqueID%>']:checked").val();
            if (q02agvalue == "on" ) {
                $("#pnlLegalQ02ag").collapse('show');

            } else {
                $("#pnlLegalQ02ag").collapse('hide');               
            } 
        };

        function doDPIALegalQ03Select() {

            var q03value = $("input[name='<%=rblDPIALegalQ03.UniqueID%>']:radio:checked").val();
            if (q03value == "1") {
                $("#pnlLegalQ03").collapse('show');
            } else {
                if ($('#pnlLegalQ03').hasClass('in')) {
                    $("#pnlLegalQ03").collapse('hide');
                }
            } 
        };
         function doDPIALegalQ03aSelect() {

            var chkList3a = $('#<%= cblDPIALegalQ03a.ClientID %>').find('input:checkbox');

            if (chkList3a[1].checked == true || chkList3a[2].checked == true || chkList3a[3].checked == true ) {
                $("#pnlLegalQ03a").collapse('show');
            } else {
                $("#pnlLegalQ03a").collapse('hide');
            }

        };

        function doDPIALegalQ03bSelect() {

            var chkList3b = $('#<%= cblDPIALegalQ03b.ClientID %>').find('input:checkbox');

            if (chkList3b[0].checked == true || chkList3b[1].checked == true || chkList3b[2].checked == true || chkList3b[3].checked == true ) {
                $("#pnlLegalQ03b").collapse('hide');
            } else {          
                $("#pnlLegalQ03b").collapse('show');                
            }

        };

        function doDPIALegalQ04Select() {

            var q04value = $("input[name='<%=rblDPIALegalQ04.UniqueID%>']:radio:checked").val();
            if (q04value == "1") {
                $("#pnlLegalQ04").collapse('show');
            } else {
                if ($('#pnlLegalQ04').hasClass('in')) {
                    $("#pnlLegalQ04").collapse('hide');
                }
            } 
        };

        function doDPIALegalQ04aSelect() {

            var chkList = $('#<%= cblDPIALegalQ04a.ClientID %>').find('input:checkbox');

            if (chkList[0].checked == true) {
                $("#pnlLegalQ04a").collapse('show');
                var validator = $get('<%=rvxDPIALegalQ04b.ClientID %>');
                validator.enabled = true;
            } else {
                $("#pnlLegalQ04a").collapse('hide');
                var validator = $get('<%=rvxDPIALegalQ04b.ClientID %>');
                validator.enabled = false;
            }

        };

        function doEnableSPIFileUpload() {

            var nYesCount = 0;
            $('#<%=pnlLegalQ02ag.ClientID %> input:checked').each(function () {

                if ($(this).prop('checked', true)) {
                    nYesCount++;
                  }
            })
            if (nYesCount >= 1) {
                $("#pnlLegalQ02agfiles").collapse('show');
            } else {
                $("#pnlLegalQ02agfiles").collapse('hide');
            }

        };


        function doStartPage() {

            doEnableSPIFileUpload();
            doDPIALegalQ04aSelect();
            doDPIALegalQ04Select();
            doDPIALegalQ03bSelect();
            doDPIALegalQ03aSelect();
            doDPIALegalQ03Select();
            doDPIALegalQ02agSelect();
            doDPIALegalQ02Select();
            doDPIALegalQ01afSelect();
            doDPIALegalQ01aeSelect();
            doDPIALegalQ01acSelect();
            doDPIALegalQ01aaSelect();
            doDPIALegalQ01aSelect();
            doDPIALegalQ01Select();
        };


    </script>

    <script type="text/javascript">
        function BindEvents() {

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
            $("#<%=rblDPIALegalQ01.ClientID %>").change(function() { 
                doDPIALegalQ01Select();
            });
            $("#<%=rblDPIALegalQ01a.ClientID %>").change(function() { 
                doDPIALegalQ01aSelect();
            });
            $("#<%=cbDPIALegalQ01aa.ClientID %>").change(function() { 
                doDPIALegalQ01aaSelect();
            });            
            $("#<%=cbDPIALegalQ01ac.ClientID %>").change(function() { 
                doDPIALegalQ01acSelect();
            });
            $("#<%=cbDPIALegalQ01ae.ClientID %>").change(function() { 
                doDPIALegalQ01aeSelect();
            });
            $("#<%=cbDPIALegalQ01af.ClientID %>").change(function() { 
                doDPIALegalQ01afSelect();
            });
            $("#<%=rblDPIALegalQ02.ClientID %>").change(function() { 
                doDPIALegalQ02Select();
            });
            $("#<%=cbDPIALegalQ02ag.ClientID %>").change(function() { 
                doDPIALegalQ02agSelect();
            });
            $("#<%=rblDPIALegalQ03.ClientID %>").change(function() { 
                doDPIALegalQ03Select();
            });
            $("#<%=cblDPIALegalQ03a.ClientID %>").change(function() { 
                doDPIALegalQ03aSelect();
            });
            $("#<%=cblDPIALegalQ03b.ClientID %>").change(function() { 
                doDPIALegalQ03bSelect();
            });
            $("#<%=rblDPIALegalQ04.ClientID %>").change(function() { 
                doDPIALegalQ04Select();
            }); 
            $("#<%=cblDPIALegalQ04a.ClientID %>").change(function() { 
                doDPIALegalQ04aSelect();
            });  

            //SPI
            $("#<%=pnlLegalQ02ag.ClientID %>").change(function() { 
                doEnableSPIFileUpload();
            });         
        });
    </script>


    <asp:HiddenField ID="hfProjectFileGroup" runat="server" Value="0" />
    <asp:HiddenField ID="hfSPIFileGroup" runat="server" Value="0" />
    <asp:HiddenField ID="hfProjectID" runat="server" Value="0" />
    <asp:HiddenField ID="hfReadOnly" runat="server" Value="0" />
    <asp:HiddenField ID="hfScreeningValidation" runat="server" Value="0" />
    <asp:HiddenField ID="hfPFrozen" runat="server" />

    <ul class="nav nav-tabs">
        <li runat="server" id="liDPIALegal" role="presentation">
            <asp:LinkButton ID="lbtDPIALegal" runat="server" CausesValidation="False">Legal</asp:LinkButton>
        </li>
        <li runat="server" id="liDPIAProcess" role="presentation">
            <asp:LinkButton ID="lbtDPIAProcess" CausesValidation="False" runat="server">Process</asp:LinkButton>
        </li>
        <li runat="server" id="liDPIARights" role="presentation">
            <asp:LinkButton ID="lbtDPIARights" CausesValidation="False" runat="server">Rights</asp:LinkButton>
        </li>        
        <li runat="server" id="liDPIASecurity" role="presentation">
            <asp:LinkButton ID="lbtDPIASecurity" CausesValidation="False" runat="server">Security</asp:LinkButton>
        </li>
        <li runat="server" id="liDPIARisks" role="presentation">
            <asp:LinkButton ID="lbtDPIARisks" CausesValidation="False" runat="server">Risks</asp:LinkButton>
        </li>
        <li runat="server" id="liDPIADocuments" role="presentation">
            <asp:LinkButton ID="lbtDPIADocuments" CausesValidation="False" runat="server" Text="Documents"></asp:LinkButton>
        </li>
        <li runat="server" ID="liDPIAFinalise" role="presentation">
            <asp:LinkButton CssClass="disabled" ID="lbtDPIAFinalise" CausesValidation="False" runat="server">Finalise</asp:LinkButton>
        </li>
    </ul>

    <div class="container">
        <div class="row">
            <div id="form-content" class="col-xs-12 scroll-area">
                <div class="form-horizontal">
                    <asp:MultiView ID="mvDPIA" runat="server" ActiveViewIndex="0">
                        <asp:View ID="vLegal" runat="server">
                            <asp:Panel ID="pnlLegal" runat="server">
                                <h2 id="lblLegal">Legal</h2>
                                <hr />
                                <div class="form-horizontal">
                                    <h3>Personal Data (Article 6)</h3>
                                    <div class="form-group">
                                        <div class="col-xs-10 text-left">
                                            <asp:Label ID="lblDPIALegalQ01" AssociatedControlID="rblDPIALegalQ01" CssClass="" runat="server" Text="Q1). Will you be processing personal information?" ></asp:Label>
                                            <a tabindex="0" title="Will you be processing personal information?" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                                                                                
                                        </div>
                                        <div class="col-xs-2">
                                            <asp:RadioButtonList ID="rblDPIALegalQ01" CssClass="FormatRadioButtonList" RepeatDirection="Horizontal" runat="server" CellSpacing="20" CellPadding="-1" RepeatColumns="2" RepeatLayout="Flow">
                                                <asp:ListItem Text="Yes" Value="1" />
                                                <asp:ListItem Text="No" Value="0" />
                                            </asp:RadioButtonList>
                                            <asp:RequiredFieldValidator Display="Dynamic" ID="rvxDPIALegalQ01" runat="server" ControlToValidate="rblDPIALegalQ01" CssClass="bg-danger" ErrorMessage="DPIA Legal Q1 is required." SetFocusOnError="True" />
                                        </div>
                                    </div>
                                    <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlLegalQ01">                                        
                                        <div class="form-group">
                                            <div class="col-xs-10 text-left">
                                                <asp:Label ID="lblDPIALegalQ01a" AssociatedControlID="rblDPIALegalQ01a" CssClass="" runat="server" Text="Q1a). Have the conditions for processing been identified and recorded for the data items/categories?" ></asp:Label>
                                                <a tabindex="0" title="Have the conditions for processing been identified and recorded for the data items/categories?" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                                                                                                                           
                                            </div>
                                            <div class="col-xs-2">
                                                <asp:RadioButtonList ID="rblDPIALegalQ01a" CssClass="FormatRadioButtonList" RepeatDirection="Horizontal" runat="server" CellSpacing="20" CellPadding="-1" RepeatColumns="2" RepeatLayout="Flow">
                                                    <asp:ListItem Text="Yes" Value="1" />
                                                    <asp:ListItem Text="No" Value="0" />
                                                </asp:RadioButtonList>
                                                <asp:RequiredFieldValidator Display="Dynamic" ID="rvxDPIALegalQ01a" runat="server" ControlToValidate="rblDPIALegalQ01a" CssClass="bg-danger" Enabled="false" ErrorMessage="DPIA Legal Q1a is required." SetFocusOnError="True" />
                                            </div>
                                        </div>                                              
                                        <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlLegalQ01a">                                            
                                            <div class="alert alert-warning clearfix">
                                                <p>If you are using data that could identify a living person you must pick one of the following "Conditions" as the legal basis allows you to use it for your project.</p>
                                                <ul>
                                                    <li>You must NOT adopt a one-size-fits-all approach.</li>
                                                    <li>No one basis should be seen as always better, safer or more important than the others</li>
                                                    <li>You might consider that more than one basis applies, in which case you should identify and document all of them.</li>
                                                </ul>
                                            </div>
                                             <div class="form-group">
                                                <div class="col-xs-offset-1">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ01aa" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ01aa" AssociatedControlID="cbDPIALegalQ01aa" CssClass="text-left" runat="server" >(a) Consent:</asp:Label>
                                                        <a tabindex="0" title="Consent" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                    <div class=" col-xs-10">
                                                        <asp:Label ID="lbl2DPIALegalQ01aa" CssClass="text-left" runat="server" ><span style="background-color: #eeeeee; font-weight:normal"> - the individual has given clear consent for you to process their personal data for a specific purpose - Article 6 - 1(a)</span></asp:Label>
                                                    </div>
                                                </div>
                                            </div>                                            
                                            <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlLegalQ01aa">
                                                <div class="form-group">
                                                    <div class="col-xs-offset-2">
                                                        <asp:Label ID="lblDPIALegalQ01aa1" AssociatedControlID="cblDPIALegalQ01aa1" CssClass="" runat="server" Text="i). How will you collect and inform the individual about what they are consenting to?"></asp:Label>
                                                        <a tabindex="0" title="How will you collect and inform the individual about what they are consenting to?" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                                                                                
                                                        <div class="col-xs-7">
                                                            <asp:CheckBoxList CssClass="checkbox" ID="cblDPIALegalQ01aa1" runat="Server">
                                                                <asp:ListItem Text="On-line / electronic explanation" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="Paper based explanation" Value="2"></asp:ListItem>
                                                                <%--<asp:ListItem Text="None of the above" Value="3"></asp:ListItem>--%>
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-xs-offset-2">
                                                        <asp:Label ID="lblDPIALegalQ01aa2" AssociatedControlID="rblDPIALegalQ01aa2" CssClass="" runat="server" Text="ii). Can consent be considered 'freely given'?"></asp:Label>                                                    
                                                        <a tabindex="0" title="Can consent be considered 'freely given'?" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                                                                                   
                                                        <asp:RadioButtonList ID="rblDPIALegalQ01aa2" runat="server">
                                                            <asp:ListItem Text="Yes" Value="1" />
                                                            <asp:ListItem Text="No" Value="0" />
                                                        </asp:RadioButtonList>
                                                        <asp:RequiredFieldValidator Display="Dynamic" ID="rvxDPIALegalQ01aa2" runat="server" ControlToValidate="rblDPIALegalQ01aa2" CssClass="bg-danger" Enabled="false" ErrorMessage="DPIA Legal Q1a Part ii) is required." SetFocusOnError="True" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-xs-offset-2">
                                                        <asp:Label ID="lblDPIALegalQ01aa3" AssociatedControlID="rblDPIALegalQ01aa3" CssClass="" runat="server" Text="iii). if consent for any of the purposes is withdrawn can this processing be stopped immediately?"></asp:Label>
                                                        <a tabindex="0" title="if consent for any of the purposes is withdrawn can this processing be stopped immediately?" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                                                                                   
                                                        <asp:RadioButtonList ID="rblDPIALegalQ01aa3" runat="server">
                                                            <asp:ListItem Text="Yes" Value="1" />
                                                            <asp:ListItem Text="No" Value="0" />
                                                        </asp:RadioButtonList>
                                                        <asp:RequiredFieldValidator Display="Dynamic" ID="rvxDPIALegalQ01aa3" runat="server" ControlToValidate="rblDPIALegalQ01aa3" CssClass="bg-danger" Enabled="false" ErrorMessage="DPIA Legal Q1a Part iii) is required." SetFocusOnError="True" />
                                                    </div>
                                                </div>
                                            </asp:panel>
                                             <div class="form-group">
                                                <div class="col-xs-offset-1">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ01ab" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ01ab" AssociatedControlID="cbDPIALegalQ01ab" CssClass="text-left" runat="server" >(b) Contract:</asp:Label>
                                                        <a tabindex="0" title="Contract" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                    <div class=" col-xs-10">
                                                        <asp:Label ID="lbl2DPIALegalQ01ab" CssClass="text-left" runat="server" ><span style="background-color: #eeeeee; font-weight:normal"> - the processing is necessary for a contract you have with the individual, or because they have asked you to take specific steps before entering into a contract. Article 6 - 1(b)</span></asp:Label>
                                                    </div>
                                                </div>
                                            </div>    
                                            <div class="form-group">
                                                <div class="col-xs-offset-1">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ01ac" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ01ac" AssociatedControlID="cbDPIALegalQ01ac" CssClass="text-left" runat="server" >(c) Legal obligation:</asp:Label>
                                                        <a tabindex="0" title="Legal obligation" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                    <div class=" col-xs-10">
                                                        <asp:Label ID="lbl2DPIALegalQ01ac" CssClass="text-left" runat="server" ><span style="background-color: #eeeeee; font-weight:normal"> - the processing is necessary for you to comply with the law (not including contractual obligations).  Article 6 - 1(c)</span></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                            <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlLegalQ01ac">
                                                <div class="form-group">
                                                    <div class="col-xs-offset-1">
                                                        <asp:Label ID="lblDPIALegalQ01acleg" AssociatedControlID="tbDPIALegalQ01acleg" CssClass="control-label col-xs-1" runat="server" Text="Legislation"></asp:Label>
                                                        <div class="col-xs-7">
                                                            <asp:TextBox CssClass="form-control" ID="tbDPIALegalQ01acleg" runat="server" MaxLength="500" TextMode="MultiLine"></asp:TextBox>
                                                            <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="tbDPIALegalQ01acleg" ID="rxvDPIALegalQ01acleg" ValidationExpression="^[\s\S]{0,500}$" runat="server" ErrorMessage="Maximum 500 characters."></asp:RegularExpressionValidator>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:panel>
                                            <div class="form-group">
                                                <div class="col-xs-offset-1">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ01ad" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ01ad" AssociatedControlID="cbDPIALegalQ01ad" CssClass="text-left" runat="server" >(d) Vital interests:</asp:Label>
                                                        <a tabindex="0" title="Lorem / ipsum" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                    <div class=" col-xs-10">
                                                        <asp:Label ID="lbl2DPIALegalQ01ad" CssClass="text-left" runat="server" ><span style="background-color: #eeeeee; font-weight:normal"> - the processing is necessary to protect someone’s life. Article 6 - 1(d)</span></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-1">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ01ae" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ01ae" AssociatedControlID="cbDPIALegalQ01ae" CssClass="text-left" runat="server" >(e) Public task:</asp:Label>
                                                        <a tabindex="0" title="Public task:" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                    <div class=" col-xs-10">
                                                        <asp:Label ID="lbl2DPIALegalQ01ae" CssClass="text-left" runat="server" ><span style="background-color: #eeeeee; font-weight:normal"> - the processing is necessary for you to perform a task in the public interest or for your official functions, and the task or function has a clear basis in law.  Article 6 - 1(e)</span></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                            <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlLegalQ01ae">
                                                <div class="form-group">
                                                    <div class="col-xs-offset-1">
                                                        <asp:Label ID="lblDPIALegalQ01aeleg" AssociatedControlID="tbDPIALegalQ01aeleg" CssClass="control-label col-xs-1" runat="server" Text="Legislation"></asp:Label>
                                                        <div class="col-xs-7">
                                                            <asp:TextBox CssClass="form-control" ID="tbDPIALegalQ01aeleg" runat="server" MaxLength="500" TextMode="MultiLine"></asp:TextBox>
                                                            <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="tbDPIALegalQ01aeleg" ID="rxvDPIALegalQ01aeleg" ValidationExpression="^[\s\S]{0,500}$" runat="server" ErrorMessage="Maximum 500 characters."></asp:RegularExpressionValidator>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:panel>
                                            <div class="form-group">
                                                <div class="col-xs-offset-1">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ01af" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ01af" AssociatedControlID="cbDPIALegalQ01af" CssClass="text-left" runat="server" >(f) Legitimate interests*:</asp:Label>
                                                        <a tabindex="0" title="Public task:" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                    <div class=" col-xs-10">
                                                        <asp:Label ID="lbl2DPIALegalQ01af" CssClass="text-left" runat="server" ><span style="background-color: #eeeeee; font-weight:normal"> - the processing is necessary for your legitimate interests or the legitimate interests of a third party, unless there is a good reason to protect the individual’s personal data which overrides those legitimate interests. (This cannot apply if you are a public authority processing data to perform your official tasks.) Article 6 - 1(f)</span></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                            &nbsp;
                                            <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlLegalQ01af">
                                                <div class="form-group" id="divEvidence" runat="server">
                                                    <label for="filEvidence" class="control-label col-xs-3">
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
                                            </asp:panel>
                                        </asp:panel>
                                    </asp:panel>
                                    <hr />
                                    <h3>Special Data (Article 9)</h3>
                                    <div class="form-group">                                                                                                                        
                                        <div class="col-xs-10 text-left">
                                            <asp:Label ID="lblDPIALegalQ02" AssociatedControlID="rblDPIALegalQ02" CssClass="" runat="server" Text="Q2). Will the project involve the use of sensitve types of data, like health, care or ethnicity data?" ></asp:Label>
                                            <a tabindex="0" title="Will the project involve the use of sensitve types of data, like health, care or ethnicity data?" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="<b>Sensitive types</b> of data are know as Special Categories of Data.  As these are more sensitive, they must be handled with more care.  The data that is consider in this Special Category are: race; ethnic origin; politics; religion; trade union membership; genetics; biometrics (where used for ID purposes); health; sex life; or sexual orientation."><i aria-hidden="true" class="icon-info"></i></a>                                                                                                                                        
                                        </div>
                                        <div class="col-xs-2">
                                            <asp:RadioButtonList ID="rblDPIALegalQ02" CssClass="FormatRadioButtonList" RepeatDirection="Horizontal" runat="server" CellSpacing="20" CellPadding="-1" RepeatColumns="2" RepeatLayout="Flow">
                                                <asp:ListItem Text="Yes" Value="1" />
                                                <asp:ListItem Text="No" Value="0" />
                                            </asp:RadioButtonList>
                                            <asp:RequiredFieldValidator Display="Dynamic" ID="rvxDPIALegalQ02" runat="server" ControlToValidate="rblDPIALegalQ02" CssClass="bg-danger" ErrorMessage="DPIA Legal Q2 is required." SetFocusOnError="True" />
                                        </div>
                                    </div>
                                    <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlLegalQ02">
                                        <div class="form-group">
                                            <asp:Label ID="lblDPIALegalQ02a" CssClass="col-xs-10" runat="server" ><span style="font-weight:bold">Q2a).</span> As a <span style="font-weight:bold">Special Category</span>  of data is being used, one or more of the following CONDITIONS must be chosen as the legal basis that will allow you to use it for the project.</asp:Label>
                                        </div>
                                        <div class="alert alert-warning clearfix">
                                            <p>You might consider that more than one basis applies, in which case you should identify and document all of them.</p>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-xs-offset-1">
                                                <div class="rr-element">
                                                    <asp:CheckBox ID="cbDPIALegalQ02aa" runat="server"  />
                                                    <asp:Label ID="lblDPIALegalQ02aa" AssociatedControlID="cbDPIALegalQ02aa" CssClass="text-left" runat="server" >(a) Explicit Consent*:</asp:Label>
                                                    <a tabindex="0" title="Explicit Consent" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="<b>Explicit consent</b> is not defined in the GDPR.  However all consent must involve a specific, informed and unambiguous indication of the individual’s wishes. The key difference is likely to be that ‘explicit’ consent must be confirmed in a clear statement (whether oral or written).<br /><br />Explicit consent must be specifically confirmed in words.  Individuals do not have to write the consent statement in their own words; you can write it for them. However you need to make sure that individuals can clearly indicate that they agree to the statement – for example by signing their name or ticking a box next to it.<br /><br />You will need to take extra care over the wording. Even in a written context, not all consent will be explicit. You should always use an express statement of consent.  For more detail see ICO guidance or speak to your Data Protection specialist."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                </div>
                                                <div class=" col-xs-10">
                                                    <asp:Label ID="lbl2DPIALegalQ02aa" CssClass="text-left" runat="server" ><span style="background-color: #eeeeee; font-weight:normal"> - the individual has given a clear statement expressed in words, providing consent for you to process their personal data for a specific purpose - Article 9 - 2(a)</span></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-xs-offset-1">
                                                <div class="rr-element">
                                                    <asp:CheckBox ID="cbDPIALegalQ02ab" runat="server"  />
                                                    <asp:Label ID="lblDPIALegalQ02ab" AssociatedControlID="cbDPIALegalQ02ab" CssClass="text-left" runat="server" >(b) Carrying out the obligations in the field of employment and social security and social protection law*:</asp:Label>
                                                    <a tabindex="0" title="Carrying out the obligations in the field of employment and social security and social protection law" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="This would involve your project using Special Category data for <b>employment purposes</b> (equalities and adaptations in the workplace). Supporting an individual in obtaining appropriate <b>benefits</b> (sickness benefits; maternity and equivalent paternity benefits; invalidity benefits; old-age benefits; survivors benefits; benefits in respect of accidents at work and occupational diseases; death grants; unemployment benefits; pre-retirement benefits; family benefits.)  <b>Social Protection Law</b>  would include using the data for involvements by public or private bodies, where the UK Law allows that are indended to reduce the impact on famililes and individuals of sickness and/or health care; disability; old age; survivorship; family/children; unemployment; housing; and social exclusion not elsewhere classified."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                </div>
                                                <div class=" col-xs-10">
                                                    <asp:Label ID="lbl2DPIALegalQ02ab" CssClass="text-left" runat="server" ><span style="background-color: #eeeeee; font-weight:normal"> - processing is necessary for the purposes of carrying out the obligations and exercising specific rights of the controller or of the data subject in the field of employment and social security and social protection law in so far as it is authorised by Union or Member State law or a collective agreement pursuant to Member State law providing for appropriate safeguards for the fundamental rights and the interests of the data subject - Article 9 - 2 (b)</span></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-xs-offset-1">
                                                <div class="rr-element">
                                                    <asp:CheckBox ID="cbDPIALegalQ02ac" runat="server"  />
                                                    <asp:Label ID="lblDPIALegalQ02ac" AssociatedControlID="cbDPIALegalQ02ac" CssClass="text-left" runat="server" >(c) Vital interests*:</asp:Label>
                                                    <a tabindex="0" title="Vital interests" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="<b>Vital Interests</b> are interests that are essential for someone’s life. So this lawful basis is very limited in its scope, and generally only applies to matters of life and death. If an individual is incapable of giving consent due to, for example, being unconsciousness, medical data can be provided to the paramedics. It is also recommended that you document the circumstances where it will be relevant and ensure you can justify your reasoning for using vital interest as a reason to use the data."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                </div>
                                                <div class=" col-xs-10">
                                                    <asp:Label ID="lbl2DPIALegalQ02ac" CssClass="text-left" runat="server" ><span style="background-color: #eeeeee; font-weight:normal"> - using the data is necessary to protect someone’s life. Where the individual is physically or legally incapable of giving consent - Article 9 -2 (c)</span></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-xs-offset-1">
                                                <div class="rr-element">
                                                    <asp:CheckBox ID="cbDPIALegalQ02ad" runat="server"  />
                                                    <asp:Label ID="lblDPIALegalQ02ad" AssociatedControlID="cbDPIALegalQ02ad" CssClass="text-left" runat="server" >(d) The legitimate activities with appropriate organisational safeguards*:</asp:Label>
                                                    <a tabindex="0" title="The legitimate activities with appropriate organisational safeguards" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                </div>
                                                <div class=" col-xs-10">
                                                    <asp:Label ID="lbl2DPIALegalQ02ad" CssClass="text-left" runat="server" ><span style="background-color: #eeeeee; font-weight:normal"> - Organisations encompass a foundation, association or any other not-for-profit body with a political, philosophical, religious or trade union aim. The use of this condition requires that the use of the data relates solely to the members or to former members of the organisation or to persons who have regular contact with it in connection with its purposes and that the personal data are not disclosed outside the organisation without the consent of the individual - Article 9 - 2 (d)</span></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-xs-offset-1">
                                                <div class="rr-element">
                                                    <asp:CheckBox ID="cbDPIALegalQ02ae" runat="server"  />
                                                    <asp:Label ID="lblDPIALegalQ02ae" AssociatedControlID="cbDPIALegalQ02ae" CssClass="text-left" runat="server" >(e) The personal data has been deliberately made public by the individual*:</asp:Label>
                                                    <a tabindex="0" title="The personal data has been deliberately made public by the individual" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-trigger="focus" data-placement="auto" data-content="Personal data can be made public in a number of different ways, however the individual must be aware that the data is publicly available. For this condition to be used.  Examples of this could include media interviews published in a newspaper or broadcast on TV.   In the case of publishing through social media, this will need to be considered on a case-by-case basis. If you are in a situation where you may wish to rely on this legal basis, please contact the Data Protection Officer for advice.  This does not include photographs, even though they might show the racial group or even the sexual orientation of an individual."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                </div>
                                                <div class=" col-xs-10">
                                                    <asp:Label ID="lbl2DPIALegalQ02ae" CssClass="text-left" runat="server" ><span style="background-color: #eeeeee; font-weight:normal"> - Article 9 - 2(e)</span></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-xs-offset-1">
                                                <div class="rr-element">
                                                    <asp:CheckBox ID="cbDPIALegalQ02af" runat="server"  />
                                                    <asp:Label ID="lblDPIALegalQ02af" AssociatedControlID="cbDPIALegalQ02af" CssClass="text-left" runat="server" >(f) Legal Action*: </asp:Label>
                                                    <a tabindex="0" title="Legal Action" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                </div>
                                                <div class=" col-xs-10">
                                                    <asp:Label ID="lbl2DPIALegalQ02af" CssClass="text-left" runat="server" ><span style="background-color: #eeeeee; font-weight:normal"> - Necessary for the establishment, exercise or defence of legal claims or whenever courts are acting in their judicial capacity - Article 9 - 2(f)</span></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-xs-offset-1">
                                                <div class="rr-element">
                                                    <asp:CheckBox ID="cbDPIALegalQ02ag" runat="server"  />
                                                    <asp:Label ID="lblDPIALegalQ02ag" AssociatedControlID="cbDPIALegalQ02ag" CssClass="text-left" runat="server" >(g) Substantial public interest*: </asp:Label>
                                                    <a tabindex="0" title="Substantial public interest" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="There is no specific definition of <q>Public Interest</q> but it is generally accepted to mean - <q>relating to the public good, or what is in the best interests of society</q>. To use this condition the UK Data Protection Act requires a number of things be in place. One is an appropriate policy and the other is to evidence safeguards to the rights of the individuals involved.  It is recommended that a separate document is written that explains the benefits and safeguards that are in place for the use for the data in the project.  It must also be noted in your Record of Processing Activities."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                </div>
                                                <div class=" col-xs-10">
                                                    <asp:Label ID="lbl2DPIALegalQ02ag" CssClass="text-left" runat="server" ><span style="background-color: #eeeeee; font-weight:normal"> - Must still be proportionate to the aim the project is pursuing, respect the spirit of the right to data protection. But also must provide for suitable and specific measures to safeguard the fundamental rights and the interests of the individuals involved. Article 9 - 2(g)</span></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlLegalQ02ag">                                            
                                           <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02aga" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02aga" AssociatedControlID="cbDPIALegalQ02aga" CssClass="text-left" runat="server" ><span style="font-weight:normal">a) Statutory etc and government purposes</span></asp:Label>
                                                        <a tabindex="0" title="Statutory etc and government purposes" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="This condition is met if the processing:-<ul><li>(a) is necessary for a purpose either (i)for the exercise of a function conferred on a person by an enactment or rule of law; or - (ii) for the exercise of a function of the Crown, a Minister of the Crown or a government department.</li><li>(b) is necessary for reasons of substantial public interest.</li></ul>"><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                        <a tabindex="0" title="Statutory etc and government purposes - Layman's guidance" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Additional popover help expresed in layman's terms"><i aria-hidden="true" class="icon-question"></i></a>                                            

                                                    </div>
                                                </div>
                                            </div>                                            
                                           <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agb" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agb" AssociatedControlID="cbDPIALegalQ02agb" CssClass="text-left" runat="server" ><span style="font-weight:normal">b) Administration of justice and parliamentary purposes</span></asp:Label>
                                                        <a tabindex="0" title="Administration of justice and parliamentary purposes" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="This condition is met if the processing is necessary:- <ul><li>(a) for the administration of justice, or</li><li>(b) for the exercise of a function of either House of Parliament.</li></ul>"><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                           <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agc" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agc" AssociatedControlID="cbDPIALegalQ02agc" CssClass="text-left" runat="server" ><span style="font-weight:normal">c) Equality of opportunity or treatment</span></asp:Label>
                                                        <a tabindex="0" title="Equality of opportunity or treatment" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="This condition is met if the processing:-<ul><li>(a) is of a specified category of personal data, and</li><li>(b) is necessary for the purposes of identifying or keeping under review the existence or absence of equality of opportunity or treatment between groups of people specified in relation to that category with a view to enabling such equality to be promoted or maintained, subject to the exceptions in sub-paragraphs (3) to (5).</li></ul>(2) In sub-paragraph (1), <q>specified</q> means specified in the following table:-<table><tbody><tr><td><strong>Category of personal data&nbsp;</strong></td><td><strong>Groups of people (in relation to a category of personal data)&nbsp;</strong></td></tr><tr><td>Personal data revealing racial or ethnic origin&nbsp;</td><td>People of different racial or ethnic origins&nbsp;</td></tr><tr><td>Personal data revealing religious or philosophical beliefs&nbsp;</td><td>People holding different religious or philosophical beliefs&nbsp;</td></tr><tr><td>Data concerning health&nbsp;</td><td>People with different states of physical or mental health&nbsp;</td></tr><tr><td>Personal data concerning an individual&rsquo;s sexual orientation&nbsp;</td><td>People of different sexual orientation&nbsp;</td></tr></tbody></table><br />(3) Processing does not meet the condition in sub-paragraph (1) if it is carried out for the purposes of measures or decisions with respect to a particular data subject.<br /><br />(4) Processing does not meet the condition in sub-paragraph (1) if it is likely to cause substantial damage or substantial distress to an individual.<br /><br />(5) Processing does not meet the condition in sub-paragraph (1) if:-<ul><li>(a) an individual who is the data subject (or one of the data subjects) has given notice in writing to the controller requiring the controller not to process personal data in respect of which the individual is the data subject (and has not given notice in writing withdrawing that requirement),</li><li>(b) the notice gave the controller a reasonable period in which to stop processing such data, and</li><li>(c) that period has ended.</li></ul>"><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agd" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agd" AssociatedControlID="cbDPIALegalQ02agd" CssClass="text-left" runat="server" ><span style="font-weight:normal">d) Racial and ethnic diversity at senior levels of organisations</span></asp:Label>
                                                        <a tabindex="0" title="Racial and ethnic diversity at senior levels of organisations" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="This condition is met if the processing:-<ul><li>(a) is of personal data revealing racial or ethnic origin,</li><li>(b) is carried out as part of a process of identifying suitable individuals to hold senior positions in a particular organisation, a type of organisation or organisations generally,</li><li>(c) is necessary for the purposes of promoting or maintaining diversity in the racial and ethnic origins of individuals who hold senior positions in the organisation or organisations, and</li><li>(d)can reasonably be carried out without the consent of the data subject,subject to the exception in sub-paragraph (3).</li></ul>(2) For the purposes of sub-paragraph (1)(d), processing can reasonably be carried out without the consent of the data subject only where:-<ul><li>(a) the controller cannot reasonably be expected to obtain the consent of the data subject, and</li><li>(b) the controller is not aware of the data subject withholding consent.</li></ul>(3) Processing does not meet the condition in sub-paragraph (1) if it is likely to cause substantial damage or substantial distress to an individual.<br /><br />(4) For the purposes of this paragraph, an individual holds a senior position in an organisation if the individual:-<ul><li>(a) holds a position listed in sub-paragraph (5), or</li><li>(b) does not hold such a position but is a senior manager of the organisation.</li></ul>(5) Those positions are:-<ul><li>(a) a director, secretary or other similar officer of a body corporate;</li><li>(b) a member of a limited liability partnership;</li><li>(c) a partner in a partnership within the Partnership Act 1890, a limited partnership registered under the Limited Partnerships Act 1907 or an entity of a similar character formed under the law of a country or territory outside the United Kingdom.</li></ul>(6) In this paragraph, <q>senior manager</q>, in relation to an organisation, means a person who plays a significant role in:-<ul><li>(a) the making of decisions about how the whole or a substantial part of the organisation’s activities are to be managed or organised, or</li><li>(b) the actual managing or organising of the whole or a substantial part of those activities.</li></ul>(7) The reference in sub-paragraph (2)(b) to a data subject withholding consent does not include a data subject merely failing to respond to a request for consent."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02age" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02age" AssociatedControlID="cbDPIALegalQ02age" CssClass="text-left" runat="server" ><span style="font-weight:normal">e) Preventing or detecting unlawful acts</span></asp:Label>
                                                        <a tabindex="0" title="Preventing or detecting unlawful acts" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="This condition is met if the processing:-<ul><li>(a) is necessary for the purposes of the prevention or detection of an unlawful act,</li><li>(b) must be carried out without the consent of the data subject so as not to prejudice those purposes, and</li><li>(c) is necessary for reasons of substantial public interest.</li></ul>(2) If the processing consists of the disclosure of personal data to a competent authority, or is carried out in preparation for such disclosure, the condition in sub-paragraph (1) is met even if, when the processing is carried out, the controller does not have an appropriate policy document in place (see paragraph 5 of this Schedule).<br /><br />(3) In this paragraph:-<q>act</q> includes a failure to act;<q>competent authority</q> has the same meaning as in Part 3 of this Act (see section 30)."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agf" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agf" AssociatedControlID="cbDPIALegalQ02agf" CssClass="text-left" runat="server" ><span style="font-weight:normal">f) Protecting the public against dishonesty etc</span></asp:Label>
                                                        <a tabindex="0" title="Protecting the public against dishonesty etc" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="11(1) This condition is met if the processing:-<ul><li>(a) is necessary for the exercise of a protective function,</li><li>(b) must be carried out without the consent of the data subject so as not to prejudice the exercise of that function, and</li><li>(c) is necessary for reasons of substantial public interest.</li></ul>(2) In this paragraph, <q>protective function</q> means a function which is intended to protect members of the public against:-<ul><li>(a) dishonesty, malpractice or other seriously improper conduct,</li><li>(b) unfitness or incompetence,</li><li>(c) mismanagement in the administration of a body or association, or</li><li>(d) failures in services provided by a body or association.</li></ul>"><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agg" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agg" AssociatedControlID="cbDPIALegalQ02agg" CssClass="text-left" runat="server" ><span style="font-weight:normal">g) Regulatory requirements relating to unlawful acts and dishonesty etc</span></asp:Label>
                                                        <a tabindex="0" title="Regulatory requirements relating to unlawful acts and dishonesty etc" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="12(1) This condition is met if:-<ul><li>(a) the processing is necessary for the purposes of complying with, or assisting other persons to comply with, a regulatory requirement which involves a person taking steps to establish whether another person has:-</li><ul><li>(i) committed an unlawful act, or</li> <li>(ii) been involved in dishonesty, malpractice or other seriously improper conduct,</li></ul><li>(b) in the circumstances, the controller cannot reasonably be expected to obtain the consent of the data subject to the processing, and</li> <li>(c) the processing is necessary for reasons of substantial public interest.</li></ul>(2) In this paragraph:-<ul><li><q>act</q> includes a failure to act;</li><li><q>regulatory requirement</q> means:-</li><ul><li>(a) a requirement imposed by legislation or by a person in exercise of a function conferred by legislation, or</li><li>(b) a requirement forming part of generally accepted principles of good practice relating to a type of body or an activity.</li></ul></ul>"><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agh" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agh" AssociatedControlID="cbDPIALegalQ02agh" CssClass="text-left" runat="server" ><span style="font-weight:normal">h) Journalism etc in connection with unlawful acts and dishonesty etc</span></asp:Label>
                                                        <a tabindex="0" title="Journalism etc in connection with unlawful acts and dishonesty etc" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="13(1) This condition is met if:-<ul><li>(a) the processing consists of the disclosure of personal data for the special purposes,</li><li>(b) it is carried out in connection with a matter described in sub-paragraph (2),</li><li>(c) it is necessary for reasons of substantial public interest,</li><li>(d) it is carried out with a view to the publication of the personal data by any person, and</li><li>(e) the controller reasonably believes that publication of the personal data would be in the public interest.</li></ul>(2) The matters mentioned in sub-paragraph (1)(b) are any of the following (whether alleged or established):-<ul><li>(a) the commission of an unlawful act by a person;</li><li>(b) dishonesty, malpractice or other seriously improper conduct of a person;</li><li>(c) unfitness or incompetence of a person;</li><li>(d) mismanagement in the administration of a body or association;</li><li>(e) a failure in services provided by a body or association.</li></ul>(3) The condition in sub-paragraph (1) is met even if, when the processing is carried out, the controller does not have an appropriate policy document in place (see paragraph 5 of this Schedule).<br /><br />(4) In this paragraph:-<ul><li><q>act</q> includes a failure to act;</li><li><q>the special purposes</q> means:-</li><ul><li>(a) the purposes of journalism;</li><li>(b) academic purposes;</li><li>(c) artistic purposes;</li><li>(d) literary purposes.</li></ul></ul>" ><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agi" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agi" AssociatedControlID="cbDPIALegalQ02agi" CssClass="text-left" runat="server" ><span style="font-weight:normal">i) Preventing fraud</span></asp:Label>
                                                        <a tabindex="0" title="Preventing fraud" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="14(1) This condition is met if the processing:-<ul><li>(a) is necessary for the purposes of preventing fraud or a particular kind of fraud, and</li><li>(b) consists of:-</li><ul><li>(i) the disclosure of personal data by a person as a member of an anti-fraud organisation,</li><li>(ii) the disclosure of personal data in accordance with arrangements made by an anti-fraud organisation, or</li><li>(iii) the processing of personal data disclosed as described in sub-paragraph (i) or (ii).</li></ul></ul>(2) In this paragraph, <q>anti-fraud organisation</q> has the same meaning as in section 68 of the Serious Crime Act 2007."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agj" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agj" AssociatedControlID="cbDPIALegalQ02agj" CssClass="text-left" runat="server" ><span style="font-weight:normal">j) Suspicion of terrorist financing or money laundering</span></asp:Label>
                                                        <a tabindex="0" title="Suspicion of terrorist financing or money laundering" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="This condition is met if the processing is necessary for the purposes of making a disclosure in good faith under either of the following:-<ul><li>(a) section 21CA of the Terrorism Act 2000 (disclosures between certain entities within regulated sector in relation to suspicion of commission of terrorist financing offence or for purposes of identifying terrorist property);</li><li>(b) section 339ZB of the Proceeds of Crime Act 2002 (disclosures within regulated sector in relation to suspicion of money laundering).</li></ul>"><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agk" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agk" AssociatedControlID="cbDPIALegalQ02agk" CssClass="text-left" runat="server" ><span style="font-weight:normal">k) Support for individuals with a particular disability or medical condition</span></asp:Label>
                                                        <a tabindex="0" title="Support for individuals with a particular disability or medical condition" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="16(1) This condition is met if the processing:-<ul><li>(a) is carried out by a not-for-profit body which provides support to individuals with a particular disability or medical condition,</li><li>(b) is of a type of personal data falling within sub-paragraph (2) which relates to an individual falling within sub-paragraph (3),</li><li>(c) is necessary for the purposes of:-<ul><li>(i) raising awareness of the disability or medical condition, or</li><li>(ii) providing support to individuals falling within sub-paragraph (3) or enabling such individuals to provide support to each other,</li></ul><li>(d) can reasonably be carried out without the consent of the data subject, and</li><li>(e) is necessary for reasons of substantial public interest.</li></ul>(2) The following types of personal data fall within this sub-paragraph:-<ul><li>(a) personal data revealing racial or ethnic origin;</li><li>(b) genetic data or biometric data;</li><li>(c) data concerning health;</li><li>(d) personal data concerning an individual’s sex life or sexual orientation.</li></ul>(3) An individual falls within this sub-paragraph if the individual is or has been a member of the body mentioned in sub-paragraph (1)(a) and:-<ul><li>(a) has the disability or condition mentioned there, has had that disability or condition or has a significant risk of developing that disability or condition, or</li><li>(b) is a relative or carer of an individual who satisfies paragraph (a) of this sub-paragraph.</li></ul>(4) For the purposes of sub-paragraph (1)(d), processing can reasonably be carried out without the consent of the data subject only where:-<ul><li>(a) the controller cannot reasonably be expected to obtain the consent of the data subject, and</li><li>(b) the controller is not aware of the data subject withholding consent.</li></ul>(5) In this paragraph:-<ul><li><q>carer</q> means an individual who provides or intends to provide care for another individual other than:-</li><ul><li>(a) under or by virtue of a contract, or</li><li>(b) as voluntary work;</li></ul><li><q>disability</q> has the same meaning as in the Equality Act 2010 (see section 6 of, and Schedule 1 to, that Act).</li></ul>(6) The reference in sub-paragraph (4)(b) to a data subject withholding consent does not include a data subject merely failing to respond to a request for consent."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agl" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agl" AssociatedControlID="cbDPIALegalQ02agl" CssClass="text-left" runat="server" ><span style="font-weight:normal">l) Counselling etc</span></asp:Label>
                                                        <a tabindex="0" title="Counselling etc" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="17(1) This condition is met if the processing:-<ul><li>(a) is necessary for the provision of confidential counselling, advice or support or of another similar service provided confidentially,</li><li>(b) is carried out without the consent of the data subject for one of the reasons listed in sub-paragraph (2), and</li><li>(c) is necessary for reasons of substantial public interest.</li></ul>(2) The reasons mentioned in sub-paragraph (1)(b) are:-<ul><li>(a) in the circumstances, consent to the processing cannot be given by the data subject;</li><li>(b) in the circumstances, the controller cannot reasonably be expected to obtain the consent of the data subject to the processing;</li><li>(c) the processing must be carried out without the consent of the data subject because obtaining the consent of the data subject would prejudice the provision of the service mentioned in sub-paragraph (1)(a).</li></ul>"><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agm" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agm" AssociatedControlID="cbDPIALegalQ02agm" CssClass="text-left" runat="server" ><span style="font-weight:normal">m) Safeguarding of children and of individuals at risk</span></asp:Label>
                                                        <a tabindex="0" title="Safeguarding of children and of individuals at risk" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="18(1) This condition is met if:-<ul><li>(a) the processing is necessary for the purposes of:-</li><ul><li>(i) protecting an individual from neglect or physical, mental or emotional harm, or</li><li>(ii) protecting the physical, mental or emotional well-being of an individual,</li></ul><li>(b) the individual is:-</li><ul><li>(i) aged under 18, or</li><li>(ii) aged 18 or over and at risk,</li></ul> <li>(c) the processing is carried out without the consent of the data subject for one of the reasons listed in sub-paragraph (2), and</li><li>(d) the processing is necessary for reasons of substantial public interest.</li></ul>(2) The reasons mentioned in sub-paragraph (1)(c) are:-<ul><li>(a) in the circumstances, consent to the processing cannot be given by the data subject;</li><li>(b) in the circumstances, the controller cannot reasonably be expected to obtain the consent of the data subject to the processing;</li><li>(c) the processing must be carried out without the consent of the data subject because obtaining the consent of the data subject would prejudice the provision of the protection mentioned in sub-paragraph (1)(a).</li></ul>(3) For the purposes of this paragraph, an individual aged 18 or over is <q>at risk</q> if the controller has reasonable cause to suspect that the individual:-<ul><li>(a) has needs for care and support,</li><li>(b) is experiencing, or at risk of, neglect or physical, mental or emotional harm, and</li><li>(c) as a result of those needs is unable to protect himself or herself against the neglect or harm or the risk of it.</li></ul>(4) In sub-paragraph (1)(a), the reference to the protection of an individual or of the well-being of an individual includes both protection relating to a particular individual and protection relating to a type of individual."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agn" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agn" AssociatedControlID="cbDPIALegalQ02agn" CssClass="text-left" runat="server" ><span style="font-weight:normal">n) Safeguarding of economic well-being of certain individuals</span></asp:Label>
                                                        <a tabindex="0" title="Safeguarding of economic well-being of certain individuals" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="19(1) This condition is met if the processing:-<ul><li>(a) is necessary for the purposes of protecting the economic well-being of an individual at economic risk who is aged 18 or over,</li><li>(b) is of data concerning health,</li><li>(c) is carried out without the consent of the data subject for one of the reasons listed in sub-paragraph (2), and</li><li>(d) is necessary for reasons of substantial public interest.</li></ul>(2) The reasons mentioned in sub-paragraph (1)(c) are:-<ul><li>(a) in the circumstances, consent to the processing cannot be given by the data subject;</li><li>(b) in the circumstances, the controller cannot reasonably be expected to obtain the consent of the data subject to the processing;</li><li>(c) the processing must be carried out without the consent of the data subject because obtaining the consent of the data subject would prejudice the provision of the protection mentioned in sub-paragraph (1)(a).</li></ul>(3) In this paragraph, <q>individual at economic risk</q> means an individual who is less able to protect his or her economic well-being by reason of physical or mental injury, illness or disability."><i aria-hidden="true" class="icon-info"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02ago" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02ago" AssociatedControlID="cbDPIALegalQ02ago" CssClass="text-left" runat="server" ><span style="font-weight:normal">o) Insurance</span></asp:Label>
                                                        <a tabindex="0" title="Insurance" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="20(1) This condition is met if the processing:-<ul><li>(a) is necessary for an insurance purpose,</li><li>(b) is of personal data revealing racial or ethnic origin, religious or philosophical beliefs or trade union membership, genetic data or data concerning health, and</li><li>(c) is necessary for reasons of substantial public interest, subject to sub-paragraphs (2) and (3).</li></ul>(2) Sub-paragraph (3) applies where:-<ul><li>(a) the processing is not carried out for the purposes of measures or decisions with respect to the data subject, and</li><li>(b) the data subject does not have and is not expected to acquire:-</li><ul><li>(i) rights against, or obligations in relation to, a person who is an insured person under an insurance contract to which the insurance purpose mentioned in sub-paragraph (1)(a) relates, or</li><li>(ii) other rights or obligations in connection with such a contract.</li></ul></ul>(3) Where this sub-paragraph applies, the processing does not meet the condition in sub-paragraph (1) unless, in addition to meeting the requirements in that sub-paragraph, it can reasonably be carried out without the consent of the data subject.<br /><br />(4) For the purposes of sub-paragraph (3), processing can reasonably be carried out without the consent of the data subject only where:-<ul><li>(a) the controller cannot reasonably be expected to obtain the consent of the data subject, and</li><li>(b) the controller is not aware of the data subject withholding consent.</li></ul>(5) In this paragraph:-<ul><li><q>insurance contract</q> means a contract of general insurance or long-term insurance;</li><li><q>insurance purpose</q> means:-</li><ul><li>(a) advising on, arranging, underwriting or administering an insurance contract,</li><li>(b) administering a claim under an insurance contract, or</li><li>(c) exercising a right, or complying with an obligation, arising in connection with an insurance contract, including a right or obligation arising under an enactment or rule of law.</li></ul></ul>(6) The reference in sub-paragraph (4)(b) to a data subject withholding consent does not include a data subject merely failing to respond to a request for consent.<br /><br />(7) Terms used in the definition of <q>insurance contract</q> in sub-paragraph (5) and also in an order made under section 22 of the Financial Services and Markets Act 2000 (regulated activities) have the same meaning in that definition as they have in that order."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agp" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agp" AssociatedControlID="cbDPIALegalQ02agp" CssClass="text-left" runat="server" ><span style="font-weight:normal">p) Occupational pensions</span></asp:Label>
                                                        <a tabindex="0" title="Occupational pensions" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="21(1) This condition is met if the processing:-<ul><li>(a) is necessary for the purpose of making a determination in connection with eligibility for, or benefits payable under, an occupational pension scheme,</li><li>(b) is of data concerning health which relates to a data subject who is the parent, grandparent, great-grandparent or sibling of a member of the scheme,</li><li>(c) is not carried out for the purposes of measures or decisions with respect to the data subject, and</li><li>(d) can reasonably be carried out without the consent of the data subject.</li></ul>(2) For the purposes of sub-paragraph (1)(d), processing can reasonably be carried out without the consent of the data subject only where:-<ul><li>(a)the controller cannot reasonably be expected to obtain the consent of the data subject, and</li><li>(b)the controller is not aware of the data subject withholding consent.</li></ul>(3) In this paragraph:-<ul><li><q>occupational pension scheme</q> has the meaning given in section 1 of the Pension Schemes Act 1993;</li><li><q>member</q>, in relation to a scheme, includes an individual who is seeking to become a member of the scheme.</li></ul>(4) The reference in sub-paragraph (2)(b) to a data subject withholding consent does not include a data subject merely failing to respond to a request for consent."><i aria-hidden="true" class="icon-info"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agq" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agq" AssociatedControlID="cbDPIALegalQ02agq" CssClass="text-left" runat="server" ><span style="font-weight:normal">q) Political parties</span></asp:Label>
                                                        <a tabindex="0" title="Political parties" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="22(1) This condition is met if the processing:-<ul><li>(a) is of personal data revealing political opinions,</li><li>(b) is carried out by a person or organisation included in the register maintained under section 23 of the Political Parties, Elections and Referendums Act 2000, and</li><li>(c) is necessary for the purposes of the person’s or organisation’s political activities, subject to the exceptions in sub-paragraphs (2) and (3).</li></ul>(2) Processing does not meet the condition in sub-paragraph (1) if it is likely to cause substantial damage or substantial distress to a person.<br /><br />(3) Processing does not meet the condition in sub-paragraph (1) if:-<ul><li>(a) an individual who is the data subject (or one of the data subjects) has given notice in writing to the controller requiring the controller not to process personal data in respect of which the individual is the data subject (and has not given notice in writing withdrawing that requirement),</li><li>(b) the notice gave the controller a reasonable period in which to stop processing such data, and</li><li>(c) that period has ended.</li></ul>(4) In this paragraph, <q>political activities</q> include campaigning, fund-raising, political surveys and case-work."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agr" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agr" AssociatedControlID="cbDPIALegalQ02agr" CssClass="text-left" runat="server" ><span style="font-weight:normal">r) Elected representatives responding to requests</span></asp:Label>
                                                        <a tabindex="0" title="Elected representatives responding to requests" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="23(1) This condition is met if:-<ul><li>(a) the processing is carried out:-</li><ul><li>(i) by an elected representative or a person acting with the authority of such a representative,</li><li>(ii) in connection with the discharge of the elected representative’s functions, and</li><li>(iii) in response to a request by an individual that the elected representative take action on behalf of the individual, and</li></ul><li>(b) the processing is necessary for the purposes of, or in connection with, the action reasonably taken by the elected representative in response to that request, subject to sub-paragraph (2).</li></ul>(2) Where the request is made by an individual other than the data subject, the condition in sub-paragraph (1) is met only if the processing must be carried out without the consent of the data subject for one of the following reasons:-<ul><li>(a) in the circumstances, consent to the processing cannot be given by the data subject;</li><li>(b) in the circumstances, the elected representative cannot reasonably be expected to obtain the consent of the data subject to the processing;</li><li>(c) obtaining the consent of the data subject would prejudice the action taken by the elected representative;</li><li>(d) the processing is necessary in the interests of another individual and the data subject has withheld consent unreasonably.</li></ul>(3) In this paragraph, <q>elected representative</q> means:-<ul><li>(a) a member of the House of Commons;</li><li>(b) a member of the National Assembly for Wales;</li><li>(c) a member of the Scottish Parliament;</li><li>(d) a member of the Northern Ireland Assembly;</li><li>(e) a member of the European Parliament elected in the United Kingdom;</li><li>(f) an elected member of a local authority within the meaning of section 270(1) of the Local Government Act 1972, namely:-</li><ul><li>(i) in England, a county council, a district council, a London borough council or a parish council;</li><li>(ii) in Wales, a county council, a county borough council or a community council;</li></ul><li>(g) an elected mayor of a local authority within the meaning of Part 1A or 2 of the Local Government Act 2000;</li><li>(h) a mayor for the area of a combined authority established under section 103 of the Local Democracy, Economic Development and Construction Act 2009;</li><li>(i) the Mayor of London or an elected member of the London Assembly;</li><li>(j) an elected member of:-</li><ul><li>(i) the Common Council of the City of London, or</li><li>(ii) the Council of the Isles of Scilly;</li></ul><li>(k) an elected member of a council constituted under section 2 of the Local Government etc (Scotland) Act 1994;</li><li>(l) an elected member of a district council within the meaning of the Local Government Act (Northern Ireland) 1972 (c. 9 (N.I.));</li><li>(m) a police and crime commissioner.</li></ul>"><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02ags" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02ags" AssociatedControlID="cbDPIALegalQ02ags" CssClass="text-left" runat="server" ><span style="font-weight:normal">s) Disclosure to elected representatives</span></asp:Label>
                                                        <a tabindex="0" title="Disclosure to elected representatives" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="24(1) This condition is met if:-<ul><li>(a)the processing consists of the disclosure of personal data:-</li><ul><li>(i) to an elected representative or a person acting with the authority of such a representative, and</li><li>(ii) in response to a communication to the controller from that representative or person which was made in response to a request from an individual,</li></ul><li>(b) the personal data is relevant to the subject matter of that communication, and</li><li>(c) the disclosure is necessary for the purpose of responding to that communication,subject to sub-paragraph (2).</li></ul>(2) Where the request to the elected representative came from an individual other than the data subject, the condition in sub-paragraph (1) is met only if the disclosure must be made without the consent of the data subject for one of the following reasons:-<ul><li>(a) in the circumstances, consent to the processing cannot be given by the data subject;</li><li>(b) in the circumstances, the elected representative cannot reasonably be expected to obtain the consent of the data subject to the processing;</li><li>(c) obtaining the consent of the data subject would prejudice the action taken by the elected representative;</li><li>(d) the processing is necessary in the interests of another individual and the data subject has withheld consent unreasonably.</li></ul>(3) In this paragraph, <q>elected representative</q> has the same meaning as in paragraph 23."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agt" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agt" AssociatedControlID="cbDPIALegalQ02agt" CssClass="text-left" runat="server" ><span style="font-weight:normal">t) Informing elected representatives about prisoners</span></asp:Label>
                                                        <a tabindex="0" title="Informing elected representatives about prisoners" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="25(1) This condition is met if:-<ul><li>(a) the processing consists of the processing of personal data about a prisoner for the purpose of informing a member of the House of Commons, a member of the National Assembly for Wales or a member of the Scottish Parliament about the prisoner, and</li><li>(b) the member is under an obligation not to further disclose the personal data.</li></ul>(2) The references in sub-paragraph (1) to personal data about, and to informing someone about, a prisoner include personal data about, and informing someone about, arrangements for the prisoner’s release.<br /><br />(3) In this paragraph:-<ul><li><q>prison</q> includes a young offender institution, a remand centre, a secure training centre or a secure college;</li><li><q>prisoner</q> means a person detained in a prison.</li></ul>"><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agu" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agu" AssociatedControlID="cbDPIALegalQ02agu" CssClass="text-left" runat="server" ><span style="font-weight:normal">u) Publication of legal judgments</span></asp:Label>
                                                        <a tabindex="0" title="Publication of legal judgments" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="26 This condition is met if the processing:-<ul><li>(a) consists of the publication of a judgment or other decision of a court or tribunal, or</li><li>(b) is necessary for the purposes of publishing such a judgment or decision.</li></ul>"><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agv" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agv" AssociatedControlID="cbDPIALegalQ02agv" CssClass="text-left" runat="server" ><span style="font-weight:normal">v) Anti-doping in sport</span></asp:Label>
                                                        <a tabindex="0" title="Anti-doping in sport" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="27(1) This condition is met if the processing is necessary:-<ul><li>(a) for the purposes of measures designed to eliminate doping which are undertaken by or under the responsibility of a body or association that is responsible for eliminating doping in a sport, at a sporting event or in sport generally, or</li><li>(b) for the purposes of providing information about doping, or suspected doping, to such a body or association.</li></ul>(2) The reference in sub-paragraph (1)(a) to measures designed to eliminate doping includes measures designed to identify or prevent doping.<br /><br />(3) If the processing consists of the disclosure of personal data to a body or association described in sub-paragraph (1)(a), or is carried out in preparation for such disclosure, the condition in sub-paragraph (1) is met even if, when the processing is carried out, the controller does not have an appropriate policy document in place (see paragraph 5 of this Schedule)."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2">
                                                    <div class="rr-element">
                                                        <asp:CheckBox ID="cbDPIALegalQ02agw" runat="server"  />
                                                        <asp:Label ID="lblDPIALegalQ02agw" AssociatedControlID="cbDPIALegalQ02agw" CssClass="text-left" runat="server" ><span style="font-weight:normal">w) Standards of behaviour in sport</span></asp:Label>
                                                        <a tabindex="0" title="Standards of behaviour in sport" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="28(1) This condition is met if the processing:- <ul><li>(a) is necessary for the purposes of measures designed to protect the integrity of a sport or a sporting event, </li><li>(b) must be carried out without the consent of the data subject so as not to prejudice those purposes, and </li><li>(c) is necessary for reasons of substantial public interest. </li></ul>(2) In sub-paragraph (1)(a), the reference to measures designed to protect the integrity of a sport or a sporting event is a reference to measures designed to protect a sport or a sporting event against:- <ul><li>(a) dishonesty, malpractice or other seriously improper conduct, or </li><li>(b) failure by a person participating in the sport or event in any capacity to comply with standards of behaviour set by a body or association with responsibility for the sport or event.</li></ul>"><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    </div>
                                                </div>
                                            </div>
                                            <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlLegalQ02agfiles">
                                                <div class="col-xs-offset-2 alert alert-warning clearfix">
                                                    <p>Please upload appropriate policy or documentation to evidence safeguards to the rights of the individuals involved.</p>
                                                </div>
                                                <div class="form-group" id="div1" runat="server">
                                                    <label for="filSPIEvidence" class="control-label col-xs-4">
                                                        Additional files (optional):
                                                    </label>
                                                    <div class="col-xs-6">
                                                        <div class="panel panel-default">
                                                            <asp:LinqDataSource ID="lds_SPISummaryFiles" runat="server" ContextTypeName="DPIAProjectsDataContext"></asp:LinqDataSource>     
                                                            <table class="table table-striped">
                                                                <asp:Repeater ID="rptSPIFiles" runat="server" DataSourceID="lds_SPISummaryFiles">
                                                                    <HeaderTemplate>
                                                                        <div class="table-responsive">
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:HyperLink ID="hlSPIFile" runat="server"
                                                                                    NavigateUrl='<%# Eval("FileID", "GetFile.aspx?FileID={0}")%>'>
                                                                                    <i id="I1" aria-hidden="true" class='<%# Eval("Type")%>' runat="server"></i>
                                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("FileName")%>'></asp:Label>
                                                                                </asp:HyperLink>
                                                                            </td>
                                                                            <td style="width: 20px"><asp:LinkButton ID="lbtSPIDelete" Visible='<%# Eval("OrganisationID") = Session("UserOrganisationID") Or Session("IsSuperAdmin")%>' OnClientClick="return confirm('Are you sure you want to delete this file?');" runat="server" CommandName="Delete" CommandArgument='<%# Eval("FileID")%>' CssClass="btn btn-danger btn-xs" ToolTip="Delete File" CausesValidation="false"><i aria-hidden="true" class="icon-minus"></i><!--[if lt IE 8]>Delete<![endif]--></asp:LinkButton></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate></div></FooterTemplate>
                                                                </asp:Repeater>
                                                            </table>
                                                        </div>
                                                        <asp:Panel ID="pnlSPIFileUpload" runat="server" CssClass="input-group">                                                                    
                                                            <span class="input-group-btn">
                                                                <span class="btn btn-default btn-file">Browse&hellip;
                                                                    <asp:FileUpload AllowMultiple="true" ID="filSPIEvidence" runat="server" />
                                                                </span>
                                                            </span>
                                                            <input type="text" placeholder="Optional (max 5 MB)" class="form-control freeze-on-sign">
                                                            <span class="input-group-btn">
                                                                <asp:LinkButton ID="lbtSPIUpload" CausesValidation="false" CssClass="btn btn-default" runat="server"><i aria-hidden="true" class="icon-upload2"></i>  Upload</asp:LinkButton>
                                                            </span>
                                                        </asp:Panel>
                                                    </div>
                                                </div>
                                            </asp:panel>
                                        </asp:panel>
                                        <div class="form-group">
                                            <div class="col-xs-offset-1">
                                                <div class="rr-element">
                                                    <asp:CheckBox ID="cbDPIALegalQ02ah" runat="server"  />
                                                    <asp:Label ID="lblDPIALegalQ02ah" AssociatedControlID="cbDPIALegalQ02ah" CssClass="text-left" runat="server" >(h) Medical purposes and the provision of health or social care*: </asp:Label>
                                                    <a tabindex="0" title="Medical purposes and the provision of health or social care" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="The use of the data is necessary for health or social care purposes.  It must only be used by or the use supervised by health or care professionals, like qualified Doctors, Nurses, Social Care Workers, Dentists etc. Or similar health/care professionals that either have a legal obligation of secrecy or a requirement of secrecy under the rules of their professional body.<br /><br /><b>To use this Condition please confirm the following requirement is in place:</b><br />To use the data for medical, health or social care purposes it can only be used by or under the responsibility of a professional subject to the obligation of professional secrecy under law or rules established by national competent bodies or by another person also subject to an obligation of secrecy under the law or rules established by national competent bodies."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                </div>
                                                <div class=" col-xs-10">
                                                    <asp:Label ID="lbl2DPIALegalQ02ah" CssClass="text-left" runat="server" ><span style="background-color: #eeeeee; font-weight:normal"> - Data to be used for preventive or occupational medicine, including the assessment of the working capacity of an employee. As well as medical diagnosis, the provision of health or social care including treatment. Also the management of health or social care systems and services based on a legal requirement or a contract with a health professional and subject to conditions and safeguards.</span></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-xs-offset-1">
                                                <div class="rr-element">
                                                    <asp:CheckBox ID="cbDPIALegalQ02ai" runat="server"  />
                                                    <asp:Label ID="lblDPIALegalQ02ai" AssociatedControlID="cbDPIALegalQ02ai" CssClass="text-left" runat="server" >(i) Public Health*: </asp:Label>
                                                    <a tabindex="0" title="Public Health" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="There is no specific definition of <q>Public Interest</q> but it is generally accepted to mean - <q>relating to the public good, or what is in the best interests of society</q>. <q>public health</q> shall mean all elements related to health, namely health status, including morbidity and disability, the determinants having an effect on that health status, health care needs, resources allocated to health care, the provision of, and universal access to, health care as well as health care expenditure and financing, and the causes of mortality.  Cross border threats would include preventing international threats to health from infectious diseases.  Allowing central government to be notified to prevent the spread of the disease.  As well as for studies conducted in the public interest in the area of public health. <u>Using data concerning health for reasons of public interest should not result in personal data being provided or used for other purposes by third parties such as employers or insurance and banking companies.</u>"><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                </div>
                                                <div class=" col-xs-10">
                                                    <asp:Label ID="lbl2DPIALegalQ02ai" CssClass="text-left" runat="server" ><span style="background-color: #eeeeee; font-weight:normal"> - The data will be used in the public interest in the area of public health, such as protecting against serious cross-border threats to health. Including processing by the management and NHS authorities for the purpose of quality control, management information and the general national and local supervision of the health or social care system.  All within the legal requirement for suitable and specific safeguards for the rights of the individuals involved, in particular professional secrecy.</span></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                    </asp:panel>
                                    <hr />
                                    <h3>Health Confidentiality</h3>
                                    <div class="form-group">                                        
                                        <div class="col-xs-10 text-left">
                                            <asp:Label ID="lblDPIALegalQ03" AssociatedControlID="rblDPIALegalQ03" CssClass="" runat="server" Text="Q3). Will the collected data include any items relating to an individual's health or care?" ></asp:Label>
                                            <a tabindex="0" title="Will the collected data include any items relating to an individual's health or care?" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                                                                                                                                                                
                                        </div>
                                        <div class="col-xs-2">
                                            <asp:RadioButtonList ID="rblDPIALegalQ03" CssClass="FormatRadioButtonList" RepeatDirection="Horizontal" runat="server" CellSpacing="20" CellPadding="-1" RepeatColumns="2" RepeatLayout="Flow">
                                                <asp:ListItem Text="Yes" Value="1" />
                                                <asp:ListItem Text="No" Value="0" />
                                            </asp:RadioButtonList>
                                            <asp:RequiredFieldValidator Display="Dynamic" ID="rvxDPIALegalQ03" runat="server" ControlToValidate="rblDPIALegalQ03" CssClass="bg-danger" ErrorMessage="DPIA Legal Q3 is required." SetFocusOnError="True" />
                                        </div>
                                    </div>
                                    <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlLegalQ03">
                                        <div class="form-group">
                                            <div class="col-xs-offset-1">
                                            <asp:Label ID="lblDPIALegalQ03a" AssociatedControlID="cblDPIALegalQ03a" CssClass="" runat="server" Text="Q3a). Will these data items be used for the individual's direct care or for other purposes too?"></asp:Label>
                                            <a tabindex="0" title="Will these data items be used for the individual's direct care or for other purposes too?" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                            <div class="col-xs-7">
                                                <asp:CheckBoxList CssClass="checkbox" ID="cblDPIALegalQ03a" runat="Server">
                                                    <asp:ListItem Text="Direct Care" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Research / Evaluation" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="Risk stratification for case finding (GPs only)" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="Targeting of a public service provided to individuals or households" Value="4"></asp:ListItem>
                                                </asp:CheckBoxList>
                                            </div>
                                            </div>
                                        </div>
                                        <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlLegalQ03a">
                                            <div class="form-group">
                                                <div class="col-xs-offset-1">
                                                    <asp:Label ID="lblDPIALegalQ03b" AssociatedControlID="cblDPIALegalQ03b" CssClass="" runat="server" Text="Q3b). As this data is subject to a confidentiality responsbility, how will you deal with this?"></asp:Label>
                                                    <a tabindex="0" title="As this data is subject to a confidentiality responsbility, how will you deal with this?" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                            
                                                    <div class="col-xs-7">
                                                        <asp:CheckBoxList CssClass="checkbox" ID="cblDPIALegalQ03b" runat="Server">
                                                            <asp:ListItem Text="Verbal request to use the data, decision recorded by staff member" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="Explanation and request on website questionnaire, decision recorded in the questionnaire" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="Explanation and request on paper questionnaire, decision recorded in the questionnaire" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="The process has an NHS Act 2006 Section 251 Exemption" Value="4"></asp:ListItem>
                                                        </asp:CheckBoxList>
                                                    </div>
                                                </div>
                                            </div>
                                            <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse in" id="pnlLegalQ03b">
                                                <div class="alert alert-warning clearfix">
                                                    <p>You have not complied with the Common Law duty of Confidentiality. The general position is that if information is given in circumstances where it is expected that a duty of confidence applies, that information cannot normally be disclosed without the information provider’s consent. In practice, this means that all patient/client information, must not normally be disclosed without the consent of the patient/client.</p>
                                                    <p>Three circumstances making disclosure of confidential information lawful are:</p>
                                                    <ul>
                                                        <li>where the individual to whom the information relates has consented</li>
                                                        <li>where disclosure is necessary to safeguard the individual, or others, or is in the public interest</li>
                                                        <li>where there is a legal duty to do so, for example a court order</li>
                                                    </ul>
                                                </div>
                                            </asp:panel>
                                        </asp:panel>
                                    </asp:panel>
                                    <hr />
                                    <h3>Responsibilities of Data Controller and Data Processor</h3>                                                                        
                                    <div class="form-group">
                                        <div class="col-xs-10 text-left">
                                            <asp:Label ID="lblDPIALegalQ04" AssociatedControlID="rblDPIALegalQ04" CssClass="" runat="server" Text="Q4). Have the responsibilities of the Data Controller and Data Processor been identified?" ></asp:Label>
                                            <a tabindex="0" title="Have the responsibilities of the Data Controller and Data Processor been identified?" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                                                                                                                                                                
                                        </div>    
                                        <div class="col-xs-2">
                                            <asp:RadioButtonList ID="rblDPIALegalQ04" CssClass="FormatRadioButtonList" RepeatDirection="Horizontal" runat="server" CellSpacing="20" CellPadding="-1" RepeatColumns="2" RepeatLayout="Flow">
                                                <asp:ListItem Text="Yes" Value="1" />
                                                <asp:ListItem Text="No" Value="0" />
                                            </asp:RadioButtonList>
                                            <asp:RequiredFieldValidator Display="Dynamic" ID="rvxDPIALegalQ04" runat="server" ControlToValidate="rblDPIALegalQ04" CssClass="bg-danger" ErrorMessage="DPIA Legal Q4 is required." SetFocusOnError="True" />
                                        </div>
                                    </div>                                    
                                    <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlLegalQ04">
                                        <div class="form-group">
                                            <div class="col-xs-offset-1">
                                                <asp:CheckBoxList CssClass="checkbox" ID="cblDPIALegalQ04a" runat="Server">
                                                    <asp:ListItem Text="Yes - a contract is in place with processors" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Yes an agreement is in place between controllers" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="No - I need help" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="n/a no third parties are involved" Value="4"></asp:ListItem>
                                                </asp:CheckBoxList>
                                             </div>
                                        </div>
                                        <asp:panel runat="server" ClientIDMode="Static" CssClass="clearfix collapse" id="pnlLegalQ04a">                                            
                                            <div class="form-group">                                                                                 
                                                <div class="col-xs-10 text-left">
                                                    <asp:Label ID="lblDPIALegalQ04b" AssociatedControlID="rblDPIALegalQ04b" CssClass="" runat="server" Text="Q4a). Does the contract include necessary clauses under DP legislation?" ></asp:Label>
                                                    <a tabindex="0" title="Does the contract include necessary clauses under DP legislation?" class="btn btn-sm" role="button" data-toggle="popover" data-container="body" data-html="true" data-trigger="focus" data-placement="auto" data-content="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."><i aria-hidden="true" class="icon-info"></i></a>                                                                                                                                                                                
                                                </div> 
                                                    <div class="col-xs-2">
                                                    <asp:RadioButtonList ID="rblDPIALegalQ04b" CssClass="FormatRadioButtonList" RepeatDirection="Horizontal" runat="server" CellSpacing="20" CellPadding="-1" RepeatColumns="2" RepeatLayout="Flow">
                                                        <asp:ListItem Text="Yes" Value="1" />
                                                        <asp:ListItem Text="No" Value="0" />
                                                    </asp:RadioButtonList>
                                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rvxDPIALegalQ04b" runat="server" ControlToValidate="rblDPIALegalQ04b" CssClass="bg-danger" ErrorMessage="DPIA Legal Q4b is required." SetFocusOnError="True" />
                                                </div>
                                            </div>
                                        </asp:panel>
                                    </asp:panel>
                                </div>
                            </asp:Panel>
                        </asp:View>
                        
                        <asp:View ID="vProcess" runat="server">
                            <asp:Panel ID="pnlProcess" runat="server">
                                <h2 id="lblProcess">Process</h2>
                                <hr />
                            </asp:Panel>
                        </asp:View>
                        <asp:View ID="vRights" runat="server">
                            <asp:Panel ID="pnlRights" runat="server">
                                <h2 id="lblRights">Rights</h2>
                                <hr />
                            </asp:Panel>
                        </asp:View>
                        <asp:View ID="vSecurity" runat="server">
                            <asp:Panel ID="pnlSecurity" runat="server">
                                <h2 id="lblSecurity">Security</h2>
                                <hr />
                            </asp:Panel>
                        </asp:View>
                        <asp:View ID="vRisks" runat="server">
                            <asp:Panel ID="pnlRisks" runat="server">
                                <h2 id="lblRisks">Risks</h2>
                                <hr />
                            </asp:Panel>
                        </asp:View>
                        <asp:View ID="vDocuments" runat="server">
                            <asp:Panel ID="pblDocuments" runat="server">
                                <h2 id="lblDocuments">Documents</h2>
                                <hr />
                            </asp:Panel>
                        </asp:View>
                        <asp:View ID="vFinalise" runat="server">
                            <asp:Panel ID="pnlFinalise" runat="server">
                                <h2 id="lblDinalise">Finalise</h2>
                                <hr />
                            </asp:Panel>
                        </asp:View>
                    </asp:MultiView>
                    <hr />
                    <div class="row">
                        <asp:LinkButton Visible="false" ID="lbtUpdateDPIA" CssClass="btn btn-primary pull-right" runat="server"><i aria-hidden="true" class="icon-checkmark"></i> Update DPIA</asp:LinkButton>
                        <asp:LinkButton ID="lbtSaveDPIA" CssClass="btn btn-primary pull-right" runat="server"><i aria-hidden="true" class="icon-checkmark"></i> Save DPIA</asp:LinkButton>
                    </div>
                </div>
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
                    <asp:LinkButton ID="lbtAddDetail" CausesValidation="false" CommandArgument="0" CssClass="btn btn-default pull-right" runat="server" PostBackUrl="~/application/dataflow_detail?action=Add">Perform DPIA</asp:LinkButton>
                    <button id="ModalOK" runat="server" type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        Sys.Application.add_load(BindEvents);
    </script>

</asp:Content>