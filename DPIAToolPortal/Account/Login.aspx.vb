Public Class Login
    Inherits Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not Page.Request.Item("doclear") Is Nothing Then
            HttpContext.Current.Session.Clear()
            HttpContext.Current.Session.Abandon()
            HttpContext.Current.User = Nothing
            System.Web.Security.FormsAuthentication.SignOut()
            HttpContext.Current.Session.Abandon()
            FormsAuthentication.SignOut()
            Dim returnURL As String = ""
            If Not Page.Request.Item("returnurl") Then
                returnURL = Page.Request.Item("returnurl")
            End If
            If returnURL = "" Then
                Dim sLoginURL As String = "~/Account/Login.aspx"
                Response.Redirect(sLoginURL)
            Else
                Dim sLogin As String = "~/Account/Login.aspx"
                Response.Redirect(String.Format("{0}?ReturnUrl={1}", sLogin, returnURL))
            End If
        End If
        Dim currentUser As MembershipUser
        If Not Page.Request.Item("view") Is Nothing Then
            If Page.Request.Item("view") = "vSelectRole" Then
                Session("UserOrganisationID") = Nothing


                currentUser = Membership.GetUser()
                If currentUser Is Nothing Then
                    Response.Redirect("~/Default.aspx")
                    Exit Sub
                End If
                Session("MultipleOrgs") = True
                Session("UserEmail") = currentUser.Email
                mvLogin.SetActiveView(vSelectRole)
            End If
        Else
            Dim returnURL As String = Request.QueryString("ReturnURL")
            Dim sRedirect As String = Utility.RedirectAuthenticatedUser(returnURL)
            Dim sSeg As String = Request.ServerVariables("SERVER_NAME").ToLower()
            If sRedirect <> "" Then
                Response.Redirect("~/" & sRedirect)
            ElseIf (sSeg = "www.info-sharing-sandpit.org.uk" Or sSeg = "www.dpiasandpit.org.uk") And Not Page.IsPostBack Then
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalRequest", "<script>$('#modalMessage').modal('show');</script>")
			End If
		End If
        If Not IsPostBack Then
            Session("mloginAttempts") = 0
            Session("maxLoginAttempt") = 5
        End If
	End Sub

    'Private Sub ISSLogin_LoggedIn(sender As Object, e As EventArgs) Handles ISSLogin.LoggedIn
    '    Dim sRedirect As String = Utility.RedirectAuthenticatedUser
    '    If sRedirect = "vSelectRole" Then
    '        Session("MultipleOrgs") = True
    '        mvLogin.SetActiveView(vSelectRole)
    '    Else
    '        If sRedirect <> "" Then
    '            Response.Redirect("../" & sRedirect)
    '        End If
    '        RegisterHyperLink.NavigateUrl = "Register"
    '        'OpenAuthLogin.ReturnUrl = Request.QueryString("ReturnUrl")

    '        Dim returnUrl = HttpUtility.UrlEncode(Request.QueryString("ReturnUrl"))
    '        If Not String.IsNullOrEmpty(returnUrl) Then
    '            Session("MultipleOrgs") = False
    '            RegisterHyperLink.NavigateUrl &= "?ReturnUrl=" & returnUrl
    '        End If
    '    End If
    'End Sub

    Private Sub btnSelect_Click(sender As Object, e As EventArgs) Handles btnSelect.Click
        Dim nOrgID As Integer = ddSelectOrganisation.SelectedValue
        Dim returnURL As String = Page.Request.Item("ReturnURL")
        Session("UserOrganisationID") = nOrgID
        If returnURL Is Nothing Then
            Response.Redirect("~/application/projects.aspx")

            'Response.Redirect("~/application/home_intray.aspx?orgid=" & nOrgID.ToString())
        ElseIf returnURL = "" Or returnURL.Contains("?Action=Edit") Then
            Response.Redirect("~/application/projects.aspx")
            'Response.Redirect("~/application/home_intray.aspx?orgid=" & nOrgID.ToString())
        Else
            Response.Redirect("~/application/projects.aspx")
            'Response.Redirect("~/application/home_intray.aspx?orgid=" & nOrgID.ToString() & "&returnURL=" & returnURL)
        End If



    End Sub

    Private Sub ISSLogin_LoginError(sender As Object, e As EventArgs) Handles ISSLogin.LoginError

        Dim userInfo As MembershipUser = Membership.GetUser(ISSLogin.UserName)
        Dim LoginErrorDetails As Label = ISSLogin.FindControl("LoginErrorDetails")
        Dim pnlError As Panel = ISSLogin.FindControl("pnlError")
        If userInfo Is Nothing Then
            'The user entered an invalid username...
            LoginErrorDetails.Text = "There is no user in the database with the username " & ISSLogin.UserName

        Else
            'See if the user is locked out or not approved
            If Not userInfo.IsApproved Then
                LoginErrorDetails.Text = "Your account has not yet been approved by the site's administrators. Please try again later..."
            ElseIf userInfo.IsLockedOut Then
                LoginErrorDetails.Text = "Your account has been locked out because of a maximum number of incorrect login attempts. You will NOT be able to login until you <a href='Contact.aspx'>contact a system administrator</a> and have your account unlocked."
            ElseIf Session("mloginAttempts") < 1 Then
                'The password was incorrect (don't show anything, the Login control already describes the problem)
                LoginErrorDetails.Text = "Your password, when you set it had a minimum of 7 characters with at least 1 symbol, 1 letter and 1 numeral."
                Session("mloginAttempts") = Convert.ToInt32(Session("mloginAttempts")) + 1
            ElseIf Session("mloginAttempts") < 4 Then
                LoginErrorDetails.Text = "Your password, when you set it had a minimum of 7 characters with at least 1 symbol, 1 letter and 1 numeral. If you can't remember your password, <a href='Recover.aspx'>click here</a> to reset it."
                Session("mloginAttempts") = Convert.ToInt32(Session("mloginAttempts")) + 1
            Else
                LoginErrorDetails.Text = "One more failed login attempt will result in your account being locked. <a href='Recover.aspx'>Click here</a> to reset your password instead."
                Session("mloginAttempts") = Convert.ToInt32(Session("mloginAttempts")) + 1
            End If
        End If
        If LoginErrorDetails.Text.Length > 0 Then
            pnlError.Visible = True
        Else
            pnlError.Visible = False
        End If
    End Sub
End Class