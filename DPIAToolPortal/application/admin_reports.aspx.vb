Public Class admin_reports
    Inherits System.Web.UI.Page
    Public Function GetProgClass(ByVal pcComp As Integer) As String
        Dim sClass As String = ""
        Select Case pcComp
            Case Is <= 50
                sClass = "progress-bar progress-bar-success progress-bar-striped"
            Case Is <= 75
                sClass = "progress-bar progress-bar-warning progress-bar-striped"
            Case Else
                sClass = "progress-bar progress-bar-danger progress-bar-striped"
        End Select
        Return sClass
    End Function
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim taSAG As New adminTableAdapters.isp_SuperAdminGroupsTableAdapter
        Dim tSAG As New admin.isp_SuperAdminGroupsDataTable
        tSAG = taSAG.GetBySuperAdminID(Session("SuperAdminID"))
        If tSAG.Rows.Count = 1 And Not Session("IsCentralSA") Then
            pnlSADashboard.Visible = False
            pnlAGFilter.Attributes.Add("style", "display:none;")
            hfAdminGroupID.Value = tSAG.First.AdminGroupID
        Else
            If tSAG.Rows.Count >= 1 Then
                hfAdminGroupID.Value = tSAG.First.AdminGroupID
            Else
                hfAdminGroupID.Value = 1
            End If
            Dim taSADash As New adminTableAdapters.SADashboardTableAdapter
            Dim tSADash As New admin.SADashboardDataTable
            tSADash = taSADash.GetSummaryData(Session("SuperAdminID"), Session("IsCentralSA"))
            If tSADash.Count > 0 Then
                lblSARegisteredOrganisations.Text = tSADash.First.TotalOrgs
                lblSARegisteredLeadOrgs.Text = tSADash.First.LeadOrgs
                lblSARegisteredSponsoredOrgs.Text = tSADash.First.SponsoredOrgs
                lblSARegisteredUsers.Text = tSADash.First.ActiveUsers
                lblSATotalDataflows.Text = tSADash.First.DataFlows
            End If
        End If
    End Sub
    Protected Function FixCrLf(value As String) As String
        If String.IsNullOrEmpty(value) Then Return String.Empty
        value = value.Replace(vbCr & vbLf, "<br />")
        value = value.Replace(vbLf, "<br />")
        Return value.Replace(Environment.NewLine, "<br />")
    End Function
    Private Sub ddAdminGroupFilter_DataBound(sender As Object, e As EventArgs) Handles ddAdminGroupFilter.DataBound
        If Session("OrgAdminGroupID") > 0 Then
            ddAdminGroupFilter.SelectedValue = Session("OrgAdminGroupID")

            fvAGDashboard.DataBind()
        End If
    End Sub
    Public Function HideIfZero(ByVal nInt As Integer) As String
        Dim sStyle As String = ""
        If nInt = 0 Then
            sStyle = "display:none;"
        End If
        Return sStyle
    End Function

    Private Sub ddAdminGroupFilter_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddAdminGroupFilter.SelectedIndexChanged
        hfAdminGroupID.Value = ddAdminGroupFilter.SelectedValue
    End Sub
    Protected Sub btnGetOrgInfo_Click(sender As Object, e As EventArgs) Handles btnGetOrgInfo.Click
        Dim orgd As OrgDetailsModal = OrgDetailsModal
        If Not hfMapOrgID.Value Is Nothing Then
            Dim nOrgID As Integer = CInt(hfMapOrgID.Value)
            Dim ds As ObjectDataSource = orgd.FindControl("dsOrganisationDetails")
            ds.SelectParameters(0).DefaultValue = nOrgID
            Dim fv As FormView = orgd.FindControl("fvOrgDetails")
            fv.DataBind()
            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "orgDetailsModalOpen", "$('#modalOrgDetails').modal('show');", True)
        End If
    End Sub
End Class