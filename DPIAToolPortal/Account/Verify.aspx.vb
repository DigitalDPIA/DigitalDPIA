Public Class Verify
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim taQ As New isporgusersTableAdapters.QueriesTableAdapter
        Dim sUID As String = Page.Request.Item("uid")
        If Not sUID Is Nothing Then
            Dim idUserID As New Guid(Page.Request.Item("uid"))

            Dim sHashID As String = Page.Request.Item("pwdr")
            Dim nVerified As Integer = taQ.VerifyRegistration(sHashID, idUserID)
            Select Case nVerified
                Case 1
                    'success!
                    lblVerifyHead.Text = "Verification Successful"
                    If HttpContext.Current.User.Identity.IsAuthenticated Then
                        lblVerifyText.Text = "Click Continue, below, to access the Data Protection Impact Assessment Tool."
                        btnLogin.Text = "Continue"
                    Else
                        lblVerifyText.Text = "Click Log in below to login to the Data Protection Impact Assessment Tool using the username and password that you set up during registration."
                        btnLogin.Text = "Log in"
                    End If
                Case 2
					lblVerifyHead.Text = "Verification Successful - Additional Validation Needed"
                    lblVerifyText.Text = "Because you have registered from an unrecogniced domain, our support team will need to contact you to validate your registration. They will contact you at the e-mail address provided within the next 14 days."
                    Dim sAGEmail As String = "isg@mbhci.nhs.uk"
                    Dim sBody As String = ""
                    Dim sRegEmail As String = Membership.GetUser().Email
                    Dim sSubject As String = "User Requires Domain Approval: " & sRegEmail
                    Dim sTicketURL As String = HttpContext.Current.Request.UrlReferrer.GetLeftPart(UriPartial.Authority) & HttpContext.Current.Request.ApplicationPath
                    sBody = "<p>Dear Administrator</p>"
                    If sTicketURL.Contains("sandpit") Then
                        sBody = sBody & "<p>A user has registered on the DPIA Sandpit site with the e-mail address <a href='" & sRegEmail & "'>" & sRegEmail & "</a>.</p>"
                    Else
                        sBody = sBody & "<p>A user has registered on the DPIA Live site with the e-mail address <a href='" & sRegEmail & "'>" & sRegEmail & "</a>.</p>"
                    End If
                    sBody = sBody & "<p>This e-mail address is not from an pre-approved domain and, therefore, requires manual approval.</p>"
                    sBody = sBody & "<p>Please contact the user to verify that they have a valid reason for registering from that domain before approving or adding their domain to the approved list.</p>"
                    Utility.SendEmail(sAGEmail, sSubject, sBody, True)
                Case -20
                    lblVerifyHead.Text = "Verification Failed"
                    lblVerifyText.Text = "Unfortunately we couldn't match your verification request to any record. Please contact the technical team for help."
                Case -21
                    lblVerifyHead.Text = "Verification Failed"
                    lblVerifyText.Text = "Your account has already been verified. Click Log in below to login to the Data Protection Impact Assessment Tool using the username and password that you set up during registration."
            End Select
        Else
            If System.Web.HttpContext.Current.User.Identity.IsAuthenticated Then
                lblVerifyHead.Text = "Verification Required"
				lblVerifyText.Text = "You should have been sent an e-mail asking you to verify your registration to the address you provided. Please check your Inbox and follow the link. If you do not receive the e-mail within 10 minutes, please e-mail <a href='mailto:isg@mbhci.nhs.uk'>isg@mbhci.nhs.uk</a> from the e-mail address you registered with and ask for your account to be verified manually."
                btnLogin.Visible = False
                btnResend.Visible = True
            End If
        End If
    End Sub

    Private Sub btnResend_Click(sender As Object, e As EventArgs) Handles btnResend.Click
        Dim sUserEmail As String = Membership.GetUser().Email
        Dim bSent As Boolean = Utility.SendVerificationEmail(sUserEmail)
        If bSent Then
            lblOutcome.Text = "Verification e-mail resent. Please check your Inbox."
        Else
            lblOutcome.Text = "There were problems resending your verification e-mail. Please contact the technical team."
        End If
    End Sub
End Class