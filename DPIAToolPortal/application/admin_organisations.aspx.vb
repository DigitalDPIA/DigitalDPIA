Imports DevExpress.Web
Imports DevExpress.Web.Bootstrap

Public Class admin_organisations
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ScriptManager.RegisterStartupScript(Me, Me.GetType, "DatePicker", " $('#tbSOLicenceEndDate').datepicker({ dateFormat: 'dd/mm/yy' });", True)
    End Sub
    Public Function GetProgClass(ByVal pcComp As Integer) As String
        Dim sClass As String = Utility.GetProgClass(pcComp)
        Return sClass
    End Function


    Private Sub lbtGeoOK_Click(sender As Object, e As EventArgs) Handles lbtGeoOK.Click
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        taq.UpdateOrgLocByAddress(hfLongitude.Text, hfLattitude.Text, hfCounty.Text, tbAddress.Text)
        bsgvOrganisations.DataBind()
    End Sub

    Private Sub lbtConfirmAG_Click(sender As Object, e As EventArgs) Handles lbtConfirmAG.Click
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        taq.UpdateOrganisationAdminGroup(CInt(ddAdminGroup.SelectedValue), CInt(hfOrgID.Value))
        taq.ClearAGLicence(CInt(hfOrgID.Value), CInt(ddAdminGroup.SelectedValue))
        bsgvOrganisations.DataBind()
        fvLicenceUsage.DataBind()
    End Sub

    Private Sub dsOrganisations_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsOrganisations.Selected
        'Dim nRows As Integer = DirectCast(e.ReturnValue, InformationSharingPortal.admin.isp_OrganisationsDataTable).Count
        'lblOrgCount.Text = "Matching organisations: " & nRows.ToString
    End Sub

    Private Sub lbtSubmitCategory_Click(sender As Object, e As EventArgs) Handles lbtSubmitCategory.Click
        Dim taq As New isporganisationsTableAdapters.QueriesTableAdapter
        taq.UpdateOrganisationCategory(ddCategory.SelectedValue, tbOtherCategory.Text, hfOrgID.Value)
        bsgvOrganisations.DataBind()
    End Sub

    Private Sub lbtSubmitIdentifier_Click(sender As Object, e As EventArgs) Handles lbtSubmitIdentifier.Click
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        taq.UpdateOrganisationIdentifiers(Trim(tbODSCode.Text), hfOrgID.Value)
        tbODSCode.Text = ""
        bsgvOrganisations.DataBind()
    End Sub

    Private Sub lbtUpdateSOLicence_Click(sender As Object, e As EventArgs) Handles lbtUpdateSOLicence.Click
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        Dim nOrganisationID = CInt(hfOrgID.Value)
        Dim bHasLicence As Boolean = cbSOLicence.Checked
        Dim dEnd As Nullable(Of Date) = Nothing
        If Not tbSOLicenceEndDate.Text = "" Then
            dEnd = CDate(tbSOLicenceEndDate.Text)
        End If
        taq.UpdateSingleOrgLicence(dEnd, bHasLicence, nOrganisationID)
        bsgvOrganisations.DataBind()
        fvLicenceUsage.DataBind()
    End Sub

    Private Sub ddSuperAdmin_DataBound(sender As Object, e As EventArgs) Handles ddSuperAdmin.DataBound
        If Not hfCurrentSA.Value.ToString() = "" Then
            Dim nSuperAdminID As Integer = CInt(hfCurrentSA.Value)
            If ddSuperAdmin.Items.FindByValue(nSuperAdminID) IsNot Nothing Then
                ddSuperAdmin.SelectedValue = nSuperAdminID
            End If
        End If
    End Sub

    Private Sub lbtConfirmSA_Click(sender As Object, e As EventArgs) Handles lbtConfirmSA.Click
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        If hfAdminGroupID.Value <> ddSuperAdmin.SelectedValue Then
            taq.UpdateOrgSuperAdmin(ddSuperAdmin.SelectedValue, hfOrgID.Value)
            bsgvOrganisations.DataBind()
        End If
    End Sub
    Protected Sub PinOnMap_Click(sender As Object, e As CommandEventArgs)
        hfLattitude.Text = ""
        hfLongitude.Text = ""
        hfCounty.Text = ""
        tbAddress.Text = e.CommandArgument
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "GetGeo", "<script>getGeoCode();</script>")
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "modalPinOnMap", "<script>$('#modalPin').modal('show');</script>")
    End Sub
    Protected Sub Remove_Click(sender As Object, e As CommandEventArgs)
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        taq.InactivateOrganisation(CInt(e.CommandArgument))
        bsgvOrganisations.DataBind()
        fvLicenceUsage.DataBind()
    End Sub
    Protected Sub Reactivate_Click(sender As Object, e As CommandEventArgs)
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        taq.ReactivateOrganisation(CInt(e.CommandArgument))
        bsgvOrganisations.DataBind()
        fvLicenceUsage.DataBind()
    End Sub
    Protected Sub ViewOrg_Click(sender As Object, e As CommandEventArgs)
        Session("UserOrganisationID") = CInt(e.CommandArgument)
        Response.Redirect("~/application/home_intray.aspx?orgid=" & e.CommandArgument.ToString())
    End Sub
    Protected Sub EditAdminGroup_Click(sender As Object, e As CommandEventArgs)
        Dim taOrg As New isporganisationsTableAdapters.isp_OrganisationsTableAdapter
        Dim tOrg As New isporganisations.isp_OrganisationsDataTable
        tOrg = taOrg.GetData(e.CommandArgument)
        tbOrganisation.Text = tOrg.First.OrganisationName
        If Not ddAdminGroup.Items.FindByValue(tOrg.First.AdminGroupID) Is Nothing Then
            ddAdminGroup.SelectedValue = tOrg.First.AdminGroupID
        End If
        hfOrgID.Value = e.CommandArgument
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "modalEditAG", "<script>$('#modalEditAG').modal('show');</script>")
    End Sub
    Protected Sub EditSA_Click(sender As Object, e As CommandEventArgs)
        Dim taOrg As New adminTableAdapters.OrgDetailTableAdapter
        Dim tOrg As New admin.OrgDetailDataTable
        tOrg = taOrg.GetData(e.CommandArgument)
        tbOrganisationSA.Text = tOrg.First.OrganisationName
        hfAdminGroupID.Value = tOrg.First.AdminGroupID
        hfCurrentSA.Value = tOrg.First.SuperAdminID
        Dim liNone As ListItem = ddSuperAdmin.Items(0)
        ddSuperAdmin.Items.Clear()
        ddSuperAdmin.Items.Add(liNone)
        ddSuperAdmin.DataBind()
        hfOrgID.Value = e.CommandArgument
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "modalEditAG", "<script>$('#modalEditSA').modal('show');</script>")
    End Sub
    Protected Sub EditCategory_Click(sender As Object, e As CommandEventArgs)
        Dim taOrg As New isporganisationsTableAdapters.isp_OrganisationsTableAdapter
        Dim tOrg As New isporganisations.isp_OrganisationsDataTable
        tOrg = taOrg.GetData(e.CommandArgument)
        tbOrganisation2.Text = tOrg.First.OrganisationName
        ddCategory.SelectedValue = tOrg.First.OrganisationCategoryID
        If ddCategory.SelectedValue = 33 Then
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "showOther", "<script>$('#divOther').collapse('show');</script>")
        End If
        tbOtherCategory.Text = tOrg.First.OrganisationCategoryOther
        hfOrgID.Value = e.CommandArgument
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "modalEditCategory", "<script>$('#modalEditCategory').modal('show');</script>")
    End Sub
    Protected Sub ODSLookup_Click(sender As Object, e As CommandEventArgs)
        Dim taOrg As New isporganisationsTableAdapters.isp_OrganisationsTableAdapter
        Dim tOrg As New isporganisations.isp_OrganisationsDataTable
        tOrg = taOrg.GetData(e.CommandArgument)
        tbODSSearch.Text = tOrg.First.OrganisationName
        hfOrgID.Value = e.CommandArgument
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "modalLookupODS", "<script>$('#modalLookupODS').modal('show');</script>")
    End Sub
    Protected Sub ToggleSingleLicence_Click(sender As Object, e As CommandEventArgs)
        Dim taOrg As New adminTableAdapters.isp_OrganisationsTableAdapter
        Dim tOrg As New admin.isp_OrganisationsDataTable
        tOrg = taOrg.GetByOrganisationID(e.CommandArgument)
        hfOrgID.Value = e.CommandArgument
        lblSOOrgTitle.Text = tOrg.First.OrganisationName
        If Not tOrg.First.IsSingleOrgLicenceEndNull Then
            tbSOLicenceEndDate.Text = tOrg.First.SingleOrgLicenceEnd.ToString("dd/MM/yyyy")
        End If
        tbSOLicenceEndDate.Enabled = tOrg.First.SingleOrgLicence
        cbSOLicence.Checked = tOrg.First.SingleOrgLicence
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "modalLookupODS", "<script>$('#modalEditSingleOrg').modal('show');</script>")
    End Sub
    Protected Sub ToggleLicence_Click(sender As Object, e As CommandEventArgs)
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        Dim nAssignLicence As Integer = taq.AssignAGLicence(CInt(e.CommandArgument))
        If nAssignLicence = 1 Then
            bsgvOrganisations.DataBind()
            fvLicenceUsage.DataBind()
        Else
            'handle error codes here:
            lblModalHeading.Text = "Failed to Assign Licence"
            Select Case nAssignLicence
                Case -1
                    lblModalText.Text = "This organisation is not assigned to an admin group and, therefore, cannot be assigned a licence."
                Case -2
                    lblModalText.Text = "The licence limit has been reached for this admin group. To arrange additional licences, contact <a href='mailto:isg@mbhci.nhs.uk'>DPIA central admin</a>."
                Case -3
                    lblModalText.Text = "The admin group associated with this organisation is inactive."
                Case -4
                    lblModalText.Text = "The contract end date for this admin group has passed. To arrange a contract extension, contact <a href='mailto:isg@mbhci.nhs.uk'>DPIA central admin</a>."
            End Select
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "modalError", "<script>$('#modalMessage').modal('show');</script>")
        End If
    End Sub
    Protected Sub RegisterPostbackForLinkButton(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim lbt As LinkButton = TryCast(sender, LinkButton)

        If Not IsNothing(lbt) Then
            ScriptManager.GetCurrent(Me).RegisterPostBackControl(lbt)
        End If

    End Sub
    'Private Sub lbtClearFilters_Click(sender As Object, e As EventArgs) Handles lbtClearFilters.Click
    '    bsgvOrganisations.FilterExpression = ""
    '    bsgvOrganisations.SearchPanelFilter = ""
    '    bsgvOrganisations.DataBind()
    'End Sub
    'Private Sub lbtExportDAList_Click(sender As Object, e As EventArgs) Handles lbtExportList.Click
    '    Dim bsgv As BootstrapGridView = bsgvOrganisations
    '    Dim bArchVis As Boolean = bsgv.Columns("Inactivate").Visible
    '    bsgv.Columns("Inactivate").Visible = False
    '    bsgvOrganisationsExporter.WriteXlsxToResponse()
    '    bsgv.Columns("Inactivate").Visible = bArchVis
    'End Sub
    Protected Sub ViewOrgDetails_Click(sender As Object, e As CommandEventArgs)
        Dim orgd As OrgDetailsModal = OrgDetailsModal
        If Not e.CommandArgument Is Nothing Then
            Dim nOrgID As Integer = CInt(e.CommandArgument)
            Dim ds As ObjectDataSource = orgd.FindControl("dsOrganisationDetails")
            ds.SelectParameters(0).DefaultValue = nOrgID
            Dim fv As FormView = orgd.FindControl("fvOrgDetails")
            fv.DataBind()
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "orgDetailsModalOpen", "<script>$('#modalOrgDetails').modal('show');</script>")
        End If
    End Sub


    Protected Sub GridViewCustomToolbar_ToolbarItemClick(ByVal source As Object, ByVal e As BootstrapGridViewToolbarItemClickEventArgs)
        Select Case e.Item.Name
            Case "Export"
                '  Dim bsgv As BootstrapGridView = bsgvOrganisations
                '    Dim bArchVis As Boolean = bsgv.Columns("Inactivate").Visible
                '      bsgv.Columns("Inactivate").Visible = False
                bsgvOrganisationsExporter.WriteXlsxToResponse()
                '     bsgv.Columns("Inactivate").Visible = bArchVis
            Case "Reset"
                bsgvOrganisations.FilterExpression = ""
                bsgvOrganisations.SearchPanelFilter = ""
                bsgvOrganisations.ClearSort()
                bsgvOrganisations.LoadClientLayout("version0.174|hierarchy30|0|-1|1|-1|2|-1|3|-1|4|-1|5|-1|6|-1|7|-1|8|-1|9|-1|10|-1|11|-1|12|-1|13|-1|14|-1|15|-1|16|-1|17|-1|18|-1|19|-1|20|-1|21|-1|22|-1|23|-1|24|-1|25|-1|26|-1|27|-1|28|-1|29|-1|visible30|t0|t1|t2|t3|f4|t5|f6|t7|f8|f9|f10|f11|f12|f13|t14|f15|t16|t17|f18|f19|f20|f21|t22|f23|f24|f25|f26|f27|f28|f29|width30|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e|e")
            Case Else
        End Select
    End Sub

    Private Sub ddAdminGroupFilter_DataBound(sender As Object, e As EventArgs) Handles ddAdminGroupFilter.DataBound
        If ddAdminGroupFilter.Items.Count = 2 Then
            pnlAGFilter.Visible = False
            ddAdminGroupFilter.SelectedIndex = 1
            fvLicenceUsage.DataBind()
            bsgvOrganisations.DataBind()
        End If
    End Sub

    'Private Sub bsgvOrganisations_ClientLayout(sender As Object, e As ASPxClientLayoutArgs) Handles bsgvOrganisations.ClientLayout
    '    Dim layout As String = e.LayoutData
    'End Sub
End Class