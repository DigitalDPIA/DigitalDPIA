Public Class Recover
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub pwRecovery_VerifyingUser(sender As Object, e As LoginCancelEventArgs) Handles pwRecovery.VerifyingUser
        Dim membershipUser As MembershipUser = Membership.GetUser(pwRecovery.UserName)
        If membershipUser IsNot Nothing AndAlso membershipUser.IsLockedOut Then
            pwRecovery.UserNameFailureText = String.Format("<span style='font-size:large'>Your account has been locked. Please contact<br/>the <a href='mailto:isg@mbhci.nhs.uk?subject=Locked DPIA Account - {0}'>DPIA system administrator</a>.</span>", pwRecovery.UserName)
        End If
    End Sub
End Class