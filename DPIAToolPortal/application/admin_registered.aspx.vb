Imports DevExpress.Web.Bootstrap

Public Class config_admin
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Private Sub lbtCommentsOK_Click(sender As Object, e As EventArgs) Handles lbtCommentsOK.Click
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        taq.UpdateMembershipComment(tbComments.Text, hfEmail.Value)
        bsgvRegisteredUsers.DataBind()
    End Sub

    Private Sub lbtConfirmEmailChange_Click(sender As Object, e As EventArgs) Handles lbtConfirmEmailChange.Click
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        Dim nUpdated As Integer = taq.UpdateEmailAddress(tbOldEmail.Text, tbNewEmail.Text)
        Select Case nUpdated
            Case 1
                modalTitle.Text = "User Email Address Updated"
                modalText.Text = "User e-mail address updated successfully throughout the DPIA. The user will now be able to login using their new e-mail address as their username and access all of their previous organisation user roles."
            Case 2
                modalTitle.Text = "User Email Address Updated"
                modalText.Text = "User e-mail address updated successfully throughout the DPIA. The user already has a login associated with their new e-mail address. When they login using the password they registered with, they will be able to access all of the organisation user roles associated with their previous e-mail address."
            Case 3
                modalTitle.Text = "User Email Address NOT Updated"
                modalText.Text = "The new e-mail address provided is already associates with a user login account and organisation user roles in the DPIA."
        End Select
        bsgvRegisteredUsers.DataBind()
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "modalMessageShow", "<script>$('#modalMessage').modal('show');</script>")
    End Sub
    Protected Sub EditEmail_Click(sender As Object, e As CommandEventArgs)
        tbOldEmail.Text = e.CommandArgument
        tbNewEmail.Text = ""
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "modalUpdateEmailShow", "<script>$('#modalUpdateEmail').modal('show');</script>")
    End Sub
    Protected Sub Remove_Click(sender As Object, e As CommandEventArgs)
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        taq.aspnet_Users_DeleteUser("InformationSharingPortal", e.CommandArgument, 15, 15)
        taq.InactivateAllOrgUserRolesByEmail(e.CommandArgument)
        bsgvRegisteredUsers.DataBind()
    End Sub
    Protected Sub Unlock_Click(sender As Object, e As CommandEventArgs)
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        taq.aspnet_Membership_UnlockUser("InformationSharingPortal", e.CommandArgument)
        bsgvRegisteredUsers.DataBind()
    End Sub
    Protected Sub Comment_Click(sender As Object, e As CommandEventArgs)
        hfEmail.Value = e.CommandArgument
        Dim taUser As New adminTableAdapters.RegUsersTableAdapter
        Dim tUser As New admin.RegUsersDataTable
        tUser = taUser.GetData(e.CommandArgument, False)
        commentsTitle.Text = e.CommandArgument & " Comments"
        tbComments.Text = tUser.First.Comment
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "modalCommentShow", "<script>$('#modalComment').modal('show');</script>")
    End Sub
    Protected Sub RegisterPostbackForLinkButton(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim lbt As LinkButton = TryCast(sender, LinkButton)

        If Not IsNothing(lbt) Then
            ScriptManager.GetCurrent(Me).RegisterPostBackControl(lbt)
        End If

    End Sub
    'Private Sub lbtClearFilters_Click(sender As Object, e As EventArgs) Handles lbtClearFilters.Click
    '    bsgvRegisteredUsers.FilterExpression = ""
    '    bsgvRegisteredUsers.SearchPanelFilter = ""
    '    bsgvRegisteredUsers.DataBind()
    'End Sub
    'Private Sub lbtExportDAList_Click(sender As Object, e As EventArgs) Handles lbtExportList.Click
    '    Dim bsgv As BootstrapGridView = bsgvRegisteredUsers
    '    Dim bDelVis As Boolean = bsgv.Columns("Delete").Visible
    '    bsgv.Columns("Delete").Visible = False
    '    bsgv.Columns("Resend").Visible = False
    '    bsgvRegisteredUsersExporter.WriteXlsxToResponse()
    '    bsgv.Columns("Delete").Visible = bDelVis
    'End Sub
    Protected Sub GridViewCustomToolbar_ToolbarItemClick(ByVal source As Object, ByVal e As BootstrapGridViewToolbarItemClickEventArgs)
        Select Case e.Item.Name
            Case "Export"
                Dim bsgv As BootstrapGridView = bsgvRegisteredUsers
                Dim bDelVis As Boolean = bsgv.Columns("Delete").Visible
                bsgv.Columns("Delete").Visible = False
                bsgvRegisteredUsersExporter.WriteXlsxToResponse()
                bsgv.Columns("Delete").Visible = bDelVis
            Case Else
        End Select
    End Sub
    Private Sub ddAdminGroupFilter_DataBound(sender As Object, e As EventArgs) Handles ddAdminGroupFilter.DataBound
        If ddAdminGroupFilter.Items.Count = 2 Then
            pnlAGFilter.Visible = False
            ddAdminGroupFilter.SelectedIndex = 1
            bsgvRegisteredUsers.DataBind()
        End If
    End Sub
End Class