Public Class confirm
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
		Dim currentUser As MembershipUser
		currentUser = Membership.GetUser()
        Dim taq As New ispregistrationTableAdapters.QueriesTableAdapter
        Dim bApproved As Boolean = taq.CheckEmailDomain(currentUser.Email)
		pnlDomainInvalid.Visible = Not bApproved
		lblSubHeading.Visible = Not bApproved
		pnlReg.Visible = bApproved
	End Sub

End Class