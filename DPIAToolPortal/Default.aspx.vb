Public Class _Default
    Inherits Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim sSeg As String = HttpContext.Current.Request.Url.Host
            If sSeg = "www.dpiasandpit.org.uk" Then
                lblIntro.Text = "Testing and evaluation site for the Data Protection Impact Assessment Tool. This site does not and should not contain a record of actual data protection impact assessments."
                pnlLiveOnly.Visible = False
                pnlSandpitOnly.Visible = True
            Else
                pnlLiveOnly.Visible = True
                pnlSandpitOnly.Visible = False
            End If
            Dim admingroup As String = TryCast(Page.RouteData.Values("GroupName"), String)
            If Session("OrgAdminGroupID") Is Nothing Or Session("OrgAdminGroupID") = 0 Then
                If admingroup <> "" Then
                    Dim taq As New isporgusersTableAdapters.QueriesTableAdapter
                    Dim adminGroupID As Integer = taq.GetAdminGroupIDFromName(admingroup)
                    Session("OrgAdminGroupID") = adminGroupID
                Else
                    Session("OrgAdminGroupID") = 0
                End If
            End If
            'Dim taSADash As New adminTableAdapters.SADashboardTableAdapter
            'Dim tDash As New admin.SADashboardDataTable
            'tDash = taSADash.GetData(1, 0)
            'If tDash.Count > 0 Then
            ' lblUserCount.Text = tDash.First.ActiveUsers.ToString("N0")
            ' lblOrgCount.Text = tDash.First.TotalOrgs.ToString("N0")
            ' lblFlowCount.Text = tDash.First.DataFlows.ToString("N0")
            'End If
        End If
        Dim sPage As String = ""
        Dim currentUser As MembershipUser
        currentUser = Membership.GetUser()
        If Not currentUser Is Nothing Then
            sPage = Request.Url.Segments(Request.Url.Segments.Count - 1)
        End If
        If sPage <> "organisation_registration.aspx" Then
            Dim sRedirect As String = Utility.RedirectAuthenticatedUser
            If sRedirect <> "" Then
                Response.Redirect(sRedirect)
            End If
        End If
    End Sub
    
    Protected Function getQuoteItemCSSclass(ByVal nOrderByNumber As Integer) As String
        Dim sCss As String = "item"
        If nOrderByNumber = 0 Then
            sCss = "item active"
        End If
        Return sCss
    End Function
    Protected Function getCarouselButtonItemCSSclass(ByVal nOrderByNumber As Integer) As String
        Dim sCss As String = ""
        If nOrderByNumber = 0 Then
            sCss = "active"
        End If
        Return sCss
    End Function
End Class