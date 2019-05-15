Public Class SiteMaster
    Inherits MasterPage
    Private Sub SiteMaster_Init(sender As Object, e As EventArgs) Handles Me.Init
        Session("SiteTitle") = "Data Protection Impact Assessment Tool"
        If Not Request.IsSecureConnection And (Request.ServerVariables("SERVER_NAME").ToLower() = "www.info-sharing-system.org.uk" Or Request.ServerVariables("SERVER_NAME").ToLower() = "www.dpiatool.org.uk") Then
            Response.Redirect("https://" & Request.ServerVariables("SERVER_NAME") & Request.Url.PathAndQuery(), True)
            Exit Sub
        ElseIf Request.ServerVariables("SERVER_NAME").ToLower() = "info-sharing-system.org.uk" Or Request.ServerVariables("SERVER_NAME").ToLower() = "dpiatool.org.uk" Then
            Response.Redirect("https://www.dpiatool.org.uk" & Request.Url.PathAndQuery(), True)
            Exit Sub
        ElseIf Request.IsSecureConnection And (Request.ServerVariables("SERVER_NAME").ToLower() = "www.dpiasandpit.org.uk") Then
            'redirect to http if the sandpit is hit on https:
            Response.Redirect("http://www.dpiasandpit.org.uk" & Request.Url.PathAndQuery(), True)
        ElseIf Request.ServerVariables("SERVER_NAME").ToLower() = "informationsharingsandpit.org.uk" Then
            Response.Redirect("http://www.dpiasandpit.org.uk" & Request.Url.PathAndQuery(), True)
        End If
        Session("plAdminGroupID") = 0
        If Not Page.Request.Item("AdminGroupID") Is Nothing Then
            Session("plAdminGroupID") = CInt(Page.Request.Item("AdminGroupID"))
        End If

        Dim sSeg As String = HttpContext.Current.Request.Url.Host
        If sSeg = "www.info-sharing-sandpit.org.uk" Or sSeg = "www.dpiasandpit.org.uk" Then
            Session("SiteTitle") = "Data Protection Impact Assessment Tool Sandpit"
            'do some stuff to make the site look like the sandpit:
            Dim link = New HtmlLink()
            link.Href = "~/Content/stylesLP_SP.css"
            link.Attributes.Add("rel", "stylesheet")
            link.Attributes.Add("type", "text/css")
            Page.Header.Controls.Add(link)
            'hide stuff that we don't want to show on the Sandpit:
            'liNews.Visible = False
            'liFeatures.Visible = False
            'liAbout.Visible = False
            'liPricing.Visible = False
        Else
            Session("SiteTitle") = "Data Protection Impact Assessment Tool"
            Dim link = New HtmlLink()
            link.Href = "~/Content/stylesLP.css"
            link.Attributes.Add("rel", "stylesheet")
            link.Attributes.Add("type", "text/css")
            Page.Header.Controls.Add(link)
        End If
        If Not Page.IsPostBack Then
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
                    'Session("UserRoleDC") = tRoles.First.DC
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
                        Log_Out()
                    End If
                End If
            End If
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim thisURL As String = Request.Url.Segments(Request.Url.Segments.Count - 1)
            Select Case thisURL.ToLower().Replace(".aspx", "")
                'Home tab
                Case "default"
                    liHome.Attributes.Add("class", "nav-item active")
                Case "login", "verify", "recover"
                    liLogin.Attributes.Add("class", "nav-item active")
                Case "register"
                    liRegister.Attributes.Add("class", "nav-item active")
            End Select

        End If
        'lblUsername.Text = Session("UserOrgUserName")


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
    End Sub
    Protected Sub hideLoginNavs()
        liLogin.Visible = False
        liRegister.Visible = False
    End Sub
    Protected Sub hideApplicationNavs()

        If System.Web.HttpContext.Current.User.Identity.IsAuthenticated Then
            liLogout.Visible = True
            liLogin.Visible = False
            liRegister.Visible = False
        Else
            liLogout.Visible = False
            liLogin.Visible = True
        End If
    End Sub
    Protected Sub Log_Out()
        HttpContext.Current.Session.Clear()
        HttpContext.Current.Session.Abandon()
        HttpContext.Current.User = Nothing
        System.Web.Security.FormsAuthentication.SignOut()
        HttpContext.Current.Session.Abandon()
        FormsAuthentication.SignOut()
        Dim sLoginURL As String = "~/Account/Login.aspx"
        Response.Redirect(sLoginURL)
    End Sub
    Private Sub lbtLogOff_Click(sender As Object, e As EventArgs) Handles lbtLogOff.Click
        Log_Out()
    End Sub
   
End Class