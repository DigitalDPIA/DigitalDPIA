Imports DevExpress.Web.Bootstrap

Public Class admin_orgusers
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Not Page.Request.Item("email") Is Nothing Then
                Session("sFilterEmail") = Page.Request.Item("email")
            End If
        End If
    End Sub

    Protected Sub Verify_Click(sender As Object, e As CommandEventArgs)
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        taq.VerifyByEmail(e.CommandArgument)
        bsgvOrganisationUsers.DataBind()
    End Sub
    Protected Sub ViewOrg_Click(sender As Object, e As CommandEventArgs)

        Session("UserOrganisationID") = CInt(e.CommandArgument)
        Response.Redirect("~/application/home_intray.aspx?orgid=" & e.CommandArgument.ToString())
    End Sub
    Protected Sub ValidateDomain_Click(sender As Object, e As CommandEventArgs)
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        taq.ValidateDomainByEmail(e.CommandArgument)
        bsgvOrganisationUsers.DataBind()
    End Sub
    Protected Sub RegisterPostbackForLinkButton(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim lbt As LinkButton = TryCast(sender, LinkButton)

        If Not IsNothing(lbt) Then
            ScriptManager.GetCurrent(Me).RegisterPostBackControl(lbt)
        End If

    End Sub
    'Private Sub lbtClearFilters_Click(sender As Object, e As EventArgs) Handles lbtClearFilters.Click
    '    bsgvOrganisationUsers.FilterExpression = ""
    '    bsgvOrganisationUsers.SearchPanelFilter = ""
    '    bsgvOrganisationUsers.DataBind()
    'End Sub
    'Private Sub lbtExportDAList_Click(sender As Object, e As EventArgs) Handles lbtExportOUList.Click
    '    Dim bsgv As BootstrapGridView = bsgvOrganisationUsers
    '    Try
    '        bsgvOrganisationUsersExporter.WriteXlsxToResponse("ISGSuperAdminOrgUsersExport")
    '    Catch ex As Exception
    '        Dim sEx As String = ex.Message
    '    End Try

    'End Sub
    Protected Sub GridViewCustomToolbar_ToolbarItemClick(ByVal source As Object, ByVal e As BootstrapGridViewToolbarItemClickEventArgs)
        Select Case e.Item.Name
            Case "Export"
                Dim bsgv As BootstrapGridView = bsgvOrganisationUsers
                bsgvOrganisationUsersExporter.WriteXlsxToResponse()
            Case Else
        End Select
    End Sub

    Private Sub bsgvOrganisationUsers_DataBound(sender As Object, e As EventArgs) Handles bsgvOrganisationUsers.DataBound
        If Not Session("sFilterEmail") Is Nothing Then
            If Not Page.Request.Item("email") Is Nothing Then
                Dim sEmail = Session("sFilterEmail")
                bsgvOrganisationUsers.FilterExpression = "[OrganisationUserEmail] = '" & sEmail & "'"

            End If
            Session("sFilterEmail") = Nothing
        End If
    End Sub
    Private Sub ddAdminGroupFilter_DataBound(sender As Object, e As EventArgs) Handles ddAdminGroupFilter.DataBound
        If ddAdminGroupFilter.Items.Count = 2 Then
            pnlAGFilter.Visible = False
            ddAdminGroupFilter.SelectedIndex = 1
            bsgvOrganisationUsers.DataBind()
        End If
    End Sub
End Class