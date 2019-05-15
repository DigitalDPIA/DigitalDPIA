Public Class Application
    Inherits System.Web.UI.MasterPage

    Private Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1))
        Response.Cache.SetNoStore()
        If Session("SuppressEmails") Is Nothing Then
            Session("SuppressEmails") = False
        End If
        'cbSASuppressEmail.Checked = Session("SuppressEmails")
        If Session("MultipleOrgs") = Nothing Then
			Session("MultipleOrgs") = False
		End If
        'If Session("MultipleOrgs") = True Then
        '    lbtSwicthOrg.Visible = True
        'Else
        '    lbtSwicthOrg.Visible = False
        'End If
        If Not Request.IsSecureConnection And (Request.ServerVariables("SERVER_NAME").ToLower() = "www.info-sharing-system.org.uk" Or Request.ServerVariables("SERVER_NAME").ToLower() = "www.dpiatool.org.uk") Then
            Response.Redirect("https://" & Request.ServerVariables("SERVER_NAME") & Request.Url.PathAndQuery(), True)
            Exit Sub
        ElseIf Request.ServerVariables("SERVER_NAME").ToLower() = "info-sharing-system.org.uk" Or Request.ServerVariables("SERVER_NAME").ToLower() = "dpiatool.org.uk" Then
            Response.Redirect("https://www.dpiatool.org.uk" & Request.Url.PathAndQuery(), True)
            Exit Sub
        ElseIf Request.IsSecureConnection And (Request.ServerVariables("SERVER_NAME").ToLower() = "www.informationsharingsandpit.org.uk") Then
            'redirect to http if the sandpit is hit on https:
            Response.Redirect("http://www.dpiasandpit.org.uk" & Request.Url.PathAndQuery(), True)
        ElseIf Request.ServerVariables("SERVER_NAME").ToLower() = "informationsharingsandpit.org.uk" Then
            Response.Redirect("http://www.dpiasandpit.org.uk" & Request.Url.PathAndQuery(), True)
        End If
        If Not Page.IsPostBack Then
            Dim sSeg As String = HttpContext.Current.Request.Url.Host
            If sSeg = "www.info-sharing-sandpit.org.uk" Or sSeg = "www.informationsharingsandpit.org.uk" Then
                lblSiteHeading.Text = "Information Sharing Sandpit"
                lblSiteSubheading.Text = "Testing and evaluation site for the Data Protection Impact Assessment Tool. This site does not and should not contain a record of actual data sharing practices."
            End If
            Dim thisPath As String = Request.Url.Segments(Request.Url.Segments.Count - 2)
            If Session("UserOrganisationID") Is Nothing Then
                If Not Page.Request.Item("orgid") Is Nothing Then
                    Session("UserOrganisationID") = CInt(Page.Request.Item("orgid"))
                End If
            End If
            If Not Session("UserOrganisationID") Is Nothing Then
                'First let's set up session variable to store some basic information:
                Dim currentUser As MembershipUser
                currentUser = Membership.GetUser()
                Session("UserID") = currentUser.ProviderUserKey
                Session("UserEmail") = currentUser.Email

                Dim taVerify As New isporgusersTableAdapters.VerifyByEmailTableTableAdapter
                Dim tVerify As New isporgusers.VerifyByEmailTableDataTable
                tVerify = taVerify.GetByEmailOrg(currentUser.Email, CInt(Session("UserOrganisationID")))
                If tVerify.Count > 0 Then
                    Session("TOUAgreed") = tVerify.First.TOUAgreed
                    Session("UserOrganisationName") = tVerify.First.OrganisationName
                    Session("UserOrgUserName") = tVerify.First.OrganisationUserName
                    Session("UserOrgUserID") = ""
                    Session("UserSponsorOrganisationID") = tVerify.First.SponsorOrganisationID
                    Session("UserOrgICONum") = tVerify.First.ICORegistrationNumber
                    Session("IsSuperAdmin") = tVerify.First.IsSuperAdmin
                    Dim nAGID As Integer = tVerify.First.AdminGroupID
                    Session("OrgAdminGroupID") = nAGID
                    Dim taRoles As New isporgusersTableAdapters.UserAdminRolesTableAdapter
                    Dim tRoles As New isporgusers.UserAdminRolesDataTable
                    tRoles = taRoles.GetData(Session("UserOrganisationID"), currentUser.Email)
                    Session("UserRoleAO") = tRoles.First.AO
                    Session("UserRoleDPO") = tRoles.First.DPO
                    'Session("UserRoleSIRO") = tRoles.First.SIRO
                    Session("UserRoleCSO") = tRoles.First.CSO
                    Session("UserRoleAdmin") = tRoles.First.Admin
                    If Session("IsSuperAdmin") Then
                        Session("UserRoleAdmin") = True
                    End If
                    Session("UserRoleViewer") = tRoles.First.VIEWER
                    Session("UserRoleIAO") = tRoles.First.IAO
                    Session("UserRoleIGO") = tRoles.First.IGO
                    'Session("UserRolePROJ") = tRoles.First.PROJ
                    Session("UserRoleDELEG") = tRoles.First.DELEG
                    hideLoginNavs()
                    getLicenceInfo()
                ElseIf Session("IsSuperAdmin") Then
                    Dim taOrg As New isporganisationsTableAdapters.isp_OrganisationsTableAdapter
                    Dim tOrg As New isporganisations.isp_OrganisationsDataTable
                    tOrg = taOrg.GetData(Session("UserOrganisationID"))
                    Session("UserOrganisationName") = tOrg.First.OrganisationName
                    Session("UserSponsorOrganisationID") = tOrg.First.SponsorOrganisationID
                    Session("UserOrgICONum") = tOrg.First.ICORegistrationNumber
                    Session("OrgAdminGroupID") = tOrg.First.AdminGroupID
                    Session("UserRoleAO") = False
                    'Session("UserRoleDC") = False
                    'Session("UserRoleSIRO") = False
                    Session("UserRoleCSO") = False
                    Session("UserRoleAdmin") = True
                    Session("UserRoleViewer") = False
                    Session("UserRoleIAO") = False
                    Session("UserRoleIGO") = False
                    'Session("UserRolePROJ") = False
                    Session("UserRoleDELEG") = False
                    hideLoginNavs()
                    getLicenceInfo()
                Else
                    hideApplicationNavs()

                    If thisPath = "application/" Then
                        Dim sReqUrl As String = Request.RawUrl
                        Dim sLogin As String = "~/Account/Login.aspx"
                        Response.Redirect(String.Format("{0}?ReturnUrl={1}", sLogin, sReqUrl))
                    End If
                End If
                If Session("IsSuperAdmin") Then
                    Dim taq As New adminTableAdapters.QueriesTableAdapter
                    Dim bCentralSA As Boolean = taq.GetIsCentralSA(currentUser.Email)
                    Session("IsCentralSA") = bCentralSA
                    Session("SuperAdminID") = taq.GetSuperAdminID(currentUser.Email)
                End If

            Else
                hideApplicationNavs()
                Dim sPage As String = ""
                Dim currentUser As MembershipUser
                currentUser = Membership.GetUser()
                If Not currentUser Is Nothing Then
                    sPage = Request.Url.Segments(Request.Url.Segments.Count - 1)
                End If
                If sPage <> "organisation_registration.aspx" Then
                    If thisPath = "application/" Then
                        Dim sReqUrl As String = Request.RawUrl
                        Log_Out(sReqUrl)
                    End If
                End If
            End If
        End If
    End Sub
    Protected Sub hideLoginNavs()
        liLogin.Visible = False
        liRegister.Visible = False
        'liHomeUnauth.Visible = False
        'liResourcesPL.Visible = False
        PreloginHeader.Visible = False
        liContact.Visible = False
        liAbout.Visible = False
    End Sub
    Protected Sub getLicenceInfo()
        Dim taLic As New adminTableAdapters.GetOrganisationLicenceStatusTableAdapter
        Dim tLic As New admin.GetOrganisationLicenceStatusDataTable
        tLic = taLic.GetData(Session("UserOrganisationID"))
        Session("orgLicenceType") = tLic.First.LicenceType
        Session("orgSupportAdmin") = tLic.First.SuperAdmin
    End Sub
    Protected Sub hideApplicationNavs()
        'liResources.Visible = False
        'liHome.Visible = False
        liFlows.Visible = False
        'liInv.Visible = False
        liManage.Visible = False
        liOrg.Visible = False
        'liHelp.Visible = False
        If System.Web.HttpContext.Current.User.Identity.IsAuthenticated Then
            liLogoff.Visible = True
            liLogin.Visible = False
            liRegister.Visible = False
            'liContact.Visible = False
        Else
            liLogoff.Visible = False
            liLogin.Visible = True
        End If
    End Sub
    Protected Sub Log_Out(Optional returnURL As String = "")
        HttpContext.Current.Session.Clear()
        HttpContext.Current.Session.Abandon()
        HttpContext.Current.User = Nothing
        System.Web.Security.FormsAuthentication.SignOut()
        HttpContext.Current.Session.Abandon()
        FormsAuthentication.SignOut()
        If returnURL = "" Then
            Dim sLoginURL As String = "~/Account/Login.aspx"
            Response.Redirect(sLoginURL)
        Else
            Dim sLogin As String = "~/Account/Login.aspx"
            Response.Redirect(String.Format("{0}?ReturnUrl={1}", sLogin, returnURL))
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'Dim sSeg As String = HttpContext.Current.Request.Url.Host
            'If sSeg = "www.info-sharing-sandpit.org.uk" Or sSeg.Contains("localhost") Then
            '    imgCubeLogo.ImageUrl = "Images/DPIA-HS-inverted-sp-small.png"
            '    imgCubeLogo.ToolTip = "The Data Protection Impact Assessment Tool Sandpit"
            'End If
            If CInt(Session("OrgAdminGroupID")) > 0 Then
                Dim taag As New adminTableAdapters.isp_AdminGroupsTableAdapter
                Dim tag As New admin.isp_AdminGroupsDataTable
                tag = taag.GetByAdminGroupID(Session("OrgAdminGroupID"))
                If tag.Count > 0 Then
                    lblSiteSubheading.Text = "Governance and assurance for data sharing between organisations, provided by " & tag.First.GroupName & "."
                End If
            End If
            Dim url As New Uri(Request.Url.ToString())
            Dim sHelpUrl As String = url.GetLeftPart(UriPartial.Authority)
            Dim thisURL As String = Request.Url.Segments(Request.Url.Segments.Count - 1)
            Select Case thisURL.ToLower().Replace(".aspx", "")
                'Home tab
                Case "default"
                    'liHomeUnauth.Attributes.Add("class", "tab1 active")
                Case "login"
                    liLogin.Attributes.Add("class", "tab1 active")
                Case "about"
                    liAbout.Attributes.Add("class", "tab1 active")
                Case "contact"
                    liContact.Attributes.Add("class", "tab1 active")
                Case "register"
                    sHelpUrl += "/help/RegisterasaUser.html"
                    liRegister.Attributes.Add("class", "tab1 active")
                    'Case "home_intray"
                    '   sHelpUrl += "/help/InTray.html"
                    '  mvNavigation.SetActiveView(vHome)
                    'liHome.Attributes.Add("class", "tab1 active")
                    ' tabHomeIntray.Attributes.Add("class", "active")
                    'Case "home_profile"
                    '    sHelpUrl += "/help/Profile.html"
                    '   mvNavigation.SetActiveView(vHome)
                    'liHome.Attributes.Add("class", "tab1 active")
                  '  tabHomeProfile.Attributes.Add("class", "active")
                'Case "org_details"
                '    sHelpUrl += "/help/OrganisationDetails.html"
                '    mvNavigation.SetActiveView(vOrg)
                '    liOrg.Attributes.Add("class", "tab2 active")
                '    tabOrgDetails.Attributes.Add("class", "active")



                'Case "org_assurance"
                '    sHelpUrl += "/help/Assurance.html"
                '    mvNavigation.SetActiveView(vOrg)
                '    liOrg.Attributes.Add("class", "tab2 active")
                '    tabOrgAssure.Attributes.Add("class", "active")
                Case "org_users"
                    sHelpUrl += "/help/ManageUsers.html"
                    mvNavigation.SetActiveView(vOrg)
                    liOrg.Attributes.Add("class", "tab2 active")
                    tabOrgUsers.Attributes.Add("class", "active")
                'Case "org_Supported"
                '    sHelpUrl += "/help/SupportedOrganisations.html"
                '    mvNavigation.SetActiveView(vOrg)
                '    liOrg.Attributes.Add("class", "tab2 active")
                '    tabOrgSupported.Attributes.Add("class", "active")
                    'Inventory tab
                    'Case "inv_dataset_list"
                    'sHelpUrl += "/help/Inventory.html"
                    'mvNavigation.SetActiveView(vInventory)
                    'liInv.Attributes.Add("class", "tab3 active")
                    'tabInvDatasets.Attributes.Add("class", "active")
                    'Data-flows tab
                Case "summaries_list"
                    sHelpUrl += "/help/DataSharingSummaryList.html"
                    mvNavigation.SetActiveView(Me.vFlows)
                    liFlows.Attributes.Add("class", "tab5 active")
                    tabSummaryList.Attributes.Add("class", "active")
                Case "dataflow_summary"
                    sHelpUrl += "/help/AddDataSharingSummary.html"
                    mvNavigation.SetActiveView(Me.vFlows)
                    liFlows.Attributes.Add("class", "tab5 active")
                    tabFlowSummary.Attributes.Add("class", "active")
                Case "flows_list"
                    sHelpUrl += "/help/DataFlows.html"
                    mvNavigation.SetActiveView(Me.vFlows)
                    liFlows.Attributes.Add("class", "tab5 active")
                    tabFlowList.Attributes.Add("class", "active")
                Case "dataflow_detail"
                    sHelpUrl += "/help/AddDataFlow.html"
                    mvNavigation.SetActiveView(Me.vFlows)
                    liFlows.Attributes.Add("class", "tab5 active")
                    tabFlowDetail.Attributes.Add("class", "active")
                Case "dataflow_adhoc"
                    mvNavigation.SetActiveView(Me.vFlows)
                    liFlows.Attributes.Add("class", "tab5 active")
                    'tabFlowAdHoc.Attributes.Add("class", "active")
                    'Resources
                'Case "resources"
                    'mvNavigation.SetActiveView(Me.vResources)
                    'liResources.Attributes.Add("class", "tab6 active")
                    'tabResources.Attributes.Add("class", "active")
                'Case "support_help"
                '    mvNavigation.SetActiveView(Me.vHelp)
                '    liHelp.Attributes.Add("class", "tab7 active")
                '    tabHelpGuide.Attributes.Add("class", "active")
                'Case "support_tickets"
                '    mvNavigation.SetActiveView(Me.vHelp)
                '    liHelp.Attributes.Add("class", "tab7 active")
                '    tabHelpTickets.Attributes.Add("class", "active")
                'Case "support_faqs"
                '    mvNavigation.SetActiveView(Me.vHelp)
                '    liHelp.Attributes.Add("class", "tab7 active")
                '    tabHelpFAQs.Attributes.Add("class", "active")
                Case "admin_registered"
                    If Not Session("IsSuperAdmin") Then
                        Log_Out()
                    End If
                    'If Not Session("IsCentralSA") Then
                    '    Response.Redirect("~/application/admin_organisations.aspx")
                    'End If
                    mvNavigation.SetActiveView(Me.vAdmin)
                    liAdmin.Attributes.Add("class", "tab7 active")
                    tabAdminRegisteredUsers.Attributes.Add("class", "active")
                Case "admin_organisations"
                    If Not Session("IsSuperAdmin") Then
                        Log_Out()
                    End If
                    mvNavigation.SetActiveView(Me.vAdmin)
                    liAdmin.Attributes.Add("class", "tab7 active")
                    tabAdminOrganisations.Attributes.Add("class", "active")
                Case "admin_orgusers"
                    If Not Session("IsSuperAdmin") Then
                        Log_Out()
                    End If
                    mvNavigation.SetActiveView(Me.vAdmin)
                    liAdmin.Attributes.Add("class", "tab7 active")
                    tabAdminOrgUsers.Attributes.Add("class", "active")
                'Case "admin_resources"
                '    If Not Session("IsSuperAdmin") Then
                '        Log_Out()
                '    End If
                '    mvNavigation.SetActiveView(Me.vAdmin)
                '    liAdmin.Attributes.Add("class", "tab7 active")
                '    tabAdminResources.Attributes.Add("class", "active")
                'Case "admin_reports"

                '    mvNavigation.SetActiveView(Me.vAdmin)
                '    liAdmin.Attributes.Add("class", "tab7 active")
                '    tabAdminReports.Attributes.Add("class", "active")
                Case "admin_registered"

                    mvNavigation.SetActiveView(Me.vAdmin)
                    liAdmin.Attributes.Add("class", "tab7 active")
                    tabAdminRegisteredUsers.Attributes.Add("class", "active")

                Case "admin_lists"
                    If Not Session("IsSuperAdmin") Or Not Session("IsCentralSA") Then
                        Log_Out()
                    End If
                    mvNavigation.SetActiveView(Me.vAdmin)
                    liAdmin.Attributes.Add("class", "tab7 active")
                    tabAdminLists.Attributes.Add("class", "active")
                    'Case "admin_config"
                    '    If Not Session("IsSuperAdmin") Or Not Session("IsCentralSA") Then
                    '        Log_Out()
                    '    End If
                    '    mvNavigation.SetActiveView(Me.vAdmin)
                    '    liAdmin.Attributes.Add("class", "tab7 active")
                    '    tabAdminConfig.Attributes.Add("class", "active")
                    ''Case "admin_faqs"
                    '    If Not Session("IsSuperAdmin") Then
                    '        Log_Out()
                    '    End If
                    '    mvNavigation.SetActiveView(Me.vAdmin)
                    '    liAdmin.Attributes.Add("class", "tab7 active")
                    '    tabAdminFAQs.Attributes.Add("class", "active")
                Case Else

            End Select
            If sHelpUrl <> url.GetLeftPart(UriPartial.Authority) Then
                'aHelp.HRef = sHelpUrl
            End If
            Dim taTOU As New adminTableAdapters.isp_TermsOfUseTableAdapter
            Dim tTOU As New admin.isp_TermsOfUseDataTable
            tTOU = taTOU.GetCurrent("TOU")
            If tTOU.Count > 0 Then
                litTOUDetail.Text = tTOU.First.TermsHTML
            End If
            tTOU = taTOU.GetCurrent("Privacy")
            If tTOU.Count > 0 Then
                litPrivacyDetail.Text = tTOU.First.TermsHTML
            End If
            tTOU = taTOU.GetCurrent("Security")
            If tTOU.Count > 0 Then
                litSecurityDetail.Text = tTOU.First.TermsHTML
            End If
            lbtAdmin.Visible = Session("IsSuperAdmin")

            If Session("IsSuperAdmin") Then
                If Not Session("IsCentralSA") Then
                    'liAdminDDRegisteredUsers.Visible = False
                    'tabAdminRegisteredUsers.Visible = False
                    liAdminDDConfig.Visible = False
                    'tabAdminConfig.Visible = False
                    'tabAdminResources.Visible = False
                    liAdminDDLists.Visible = False
                    tabAdminLists.Visible = False
                    'cbSASuppressEmail.Visible = False
                Else
                    'Show the suppress e-mail button only for central SAs
                    'cbSASuppressEmail.Visible = True
                End If
            End If
        End If
        'lblUsername.Text = Session("UserOrgUserName")
        If Not Session("UserOrganisationName") Is Nothing Then
            Dim sSystem As String = "DPIA LIVE - "
            Dim sSeg As String = Request.ServerVariables("SERVER_NAME").ToLower()
            If Not sSeg = "www.info-sharing-system.org.uk" And Not sSeg = "www.dpiatool.org.uk" And Not sSeg = "dpiatool.org.uk" Then
                sSystem = "DPIA SANDPIT - "
            End If
            lblOrganisation.Text = sSystem & Session("UserOrganisationName")
        End If
        If Session("UserSponsorOrganisationID") = 0 Then
            liOrgSupported.Visible = True
            'lbtOrgSupported.Visible = True
        Else
            liOrgSupported.Visible = False
            'lbtOrgSupported.Visible = False
        End If


    End Sub
#Region "Navigation"
    Protected Sub lbt_Click(sender As Object, e As EventArgs)
        Dim lb As LinkButton = TryCast(sender, LinkButton)
        Dim sPage As String = ""
        sPage = "~/application/" & lb.CommandArgument & ".aspx"
        Response.Redirect(sPage)
    End Sub
    Private Sub lbtLogOff_Click(sender As Object, e As EventArgs) Handles lbtLogOff.Click
        Log_Out()
    End Sub
    'Private Sub lbtSwicthOrg_Click(sender As Object, e As EventArgs) Handles lbtSwicthOrg.Click
    '    Session("UserOrganisationID") = Nothing
    '    Response.Redirect("~/account/Login.aspx?view=vSelectRole")
    'End Sub
#End Region

    'Private Sub cbSASuppressEmail_CheckedChanged(sender As Object, e As EventArgs) Handles cbSASuppressEmail.CheckedChanged
    '    Session("SuppressEmails") = cbSASuppressEmail.Checked
    'End Sub
End Class