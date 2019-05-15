Imports System.Globalization
Imports System.IO
Imports System.Data.SqlClient
Imports DevExpress.Web.Data
Imports DevExpress.Web

Public Class admin_lists
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    'Private Sub lbtDomains_Click(sender As Object, e As EventArgs) Handles lbtDomains.Click
    '    tabDomains.Attributes.Add("class", "active")
    '    tabSuperAdmins.Attributes.Remove("class")
    '    tabAdminGroups.Attributes.Remove("class")
    '    tabNotifications.Attributes.Remove("class")
    '    tabApiKeys.Attributes.Remove("class")
    '    tabPickLists.Attributes.Remove("class")
    '    mvManageLists.SetActiveView(vDomains)
    'End Sub

    'Private Sub lbtSuperAdmins_Click(sender As Object, e As EventArgs) Handles lbtSuperAdmins.Click
    '    tabDomains.Attributes.Remove("class")
    '    tabAdminGroups.Attributes.Remove("class")
    '    tabNotifications.Attributes.Remove("class")
    '    tabSuperAdmins.Attributes.Add("class", "active")
    '    tabApiKeys.Attributes.Remove("class")
    '    tabPickLists.Attributes.Remove("class")
    '    mvManageLists.SetActiveView(vSuperAdmins)
    'End Sub
    'Private Sub lbtAdminGroups_Click(sender As Object, e As EventArgs) Handles lbtAdminGroups.Click
    '    tabDomains.Attributes.Remove("class")
    '    tabSuperAdmins.Attributes.Remove("class")
    '    tabNotifications.Attributes.Remove("class")
    '    tabAdminGroups.Attributes.Add("class", "active")
    '    tabApiKeys.Attributes.Remove("class")
    '    tabPickLists.Attributes.Remove("class")
    '    mvManageLists.SetActiveView(vAdminGroups)
    'End Sub
    'Private Sub lbtNotifications_Click(sender As Object, e As EventArgs) Handles lbtNotifications.Click
    '    tabDomains.Attributes.Remove("class")
    '    tabSuperAdmins.Attributes.Remove("class")
    '    tabAdminGroups.Attributes.Remove("class")
    '    tabNotifications.Attributes.Add("class", "active")
    '    tabApiKeys.Attributes.Remove("class")
    '    tabPickLists.Attributes.Remove("class")
    '    mvManageLists.SetActiveView(vNotifications)
    'End Sub
    'Private Sub lbtAPIKeys_Click(sender As Object, e As EventArgs) Handles lbtAPIKeys.Click
    '    tabDomains.Attributes.Remove("class")
    '    tabSuperAdmins.Attributes.Remove("class")
    '    tabAdminGroups.Attributes.Remove("class")
    '    tabApiKeys.Attributes.Add("class", "active")
    '    tabNotifications.Attributes.Remove("class")
    '    tabPickLists.Attributes.Remove("class")
    '    mvManageLists.SetActiveView(vAPIKeys)
    'End Sub
    'Private Sub lbtPickLists_Click(sender As Object, e As EventArgs) Handles lbtPickLists.Click
    '    tabDomains.Attributes.Remove("class")
    '    tabSuperAdmins.Attributes.Remove("class")
    '    tabAdminGroups.Attributes.Remove("class")
    '    tabApiKeys.Attributes.Remove("class")
    '    tabNotifications.Attributes.Remove("class")
    '    tabPickLists.Attributes.Add("class", "active")
    '    mvManageLists.SetActiveView(vPickLists)
    'End Sub
    Private Sub lbtAddDomain_Click(sender As Object, e As EventArgs) Handles lbtAddDomain.Click
        Dim sDomain As String = tbDomainAdd.Text
        If sDomain.Length > 0 Then
            Dim taq As New adminTableAdapters.QueriesTableAdapter
            taq.Insert_Domain(sDomain, cbShowInListAdd.Checked)
            gvDomains.DataBind()
        End If
        tbDomainAdd.Text = ""
        cbShowInListAdd.Checked = False
    End Sub

    Private Sub lbtAddSA_Click(sender As Object, e As EventArgs) Handles lbtAddSA.Click
        Dim sAdminGroupsCSV As String = ""
        'Go through admin group list box and populate CSV string:
        For Each li As ListItem In listAdminGroups.Items
            If li.Selected Then
                sAdminGroupsCSV = sAdminGroupsCSV + li.Value.ToString() + ", "
            End If
        Next
        'Trim the trailing , from the CSV string:
        If sAdminGroupsCSV.Length > 2 Then
            sAdminGroupsCSV = sAdminGroupsCSV.Substring(0, sAdminGroupsCSV.Length - 2)
        End If
        Dim sSA As String = tbSuperAdminEmail.Text
        If sSA.Length > 0 Then
            Dim taSA As New adminTableAdapters.isp_SuperAdminsTableAdapter
            taSA.InsertSuperAdmin(sSA, cbContentManager.Checked, cbCentralSA.Checked, sAdminGroupsCSV)

            gvSuperAdmins.DataBind()
        End If
        ClearSAForm()
    End Sub


    Private Sub lbtAddAdminGroup_Click(sender As Object, e As EventArgs) Handles lbtAddAdminGroup.Click
        Dim taAG As New adminTableAdapters.isp_AdminGroupsTableAdapter
        Dim contractEndDate As Nullable(Of DateTime)
        If tbContractEndDateAdd.Text.Length > 1 Then
            contractEndDate = DateTime.ParseExact(tbContractEndDateAdd.Text, "d/M/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None)
        End If
        taAG.InsertQuery(tbGroupNameAdd.Text, tbGroupContactAdd.Text, contractEndDate, tbEmailAdd.Text, tbAddressAdd.Text, tbTelephoneAdd.Text, ddRegionAdd.SelectedValue, CInt(tbOrganisationLicences.Text))
        gvAdminGroups.DataBind()
        tbGroupNameAdd.Text = ""
        tbGroupContactAdd.Text = ""
        tbContractEndDateAdd.Text = ""
        tbEmailAdd.Text = ""
        tbAddressAdd.Text = ""
        tbTelephoneAdd.Text = ""
        ddRegionAdd.SelectedIndex = 0
        tbOrganisationLicences.Text = 1000
    End Sub

    Private Sub gvAdminGroups_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvAdminGroups.RowCommand
        If e.CommandName = "EmailLink" Then
            Dim sAdminGroupName As String = e.CommandArgument
            Dim sShortenedName As String = sAdminGroupName.Replace(" ", "")
            Dim taq As New isporgusersTableAdapters.QueriesTableAdapter
            Dim nAdminGroupID As Integer = taq.GetAdminGroupIDFromName(sShortenedName)
            Dim taag As New adminTableAdapters.isp_AdminGroupsTableAdapter
            Dim tag As New admin.isp_AdminGroupsDataTable
            tag = taag.GetByAdminGroupID(nAdminGroupID)
            Dim sPageName As String = HttpContext.Current.Request.UrlReferrer.GetLeftPart(UriPartial.Authority) & HttpContext.Current.Request.ApplicationPath & "AdminGroup/" & sShortenedName
            Dim sMailMessage As String = ""
            sMailMessage = sMailMessage & "<p>Dear colleague,</p>"
            sMailMessage = sMailMessage & "<p>The Data Protection Impact Assessment (DPIA) administration group, " & tag.First.GroupName & ", has now been registered.</p>"
            sMailMessage = sMailMessage & "<p>The unique web address that will allow organisations to register for the DPIA in your admin group is <a href='" & sPageName & "'>" & sPageName & "</a>.</p>"
            sMailMessage = sMailMessage & "<p>If you have any questions or require further support please don't hesitate to get in touch at <a href='isg@mbhci.nhs.uk'>isg@mbhci.nhs.uk</a>.</p>"
            Utility.SendEmail(tag.First.EmailAddress, "The Data Protection Impact Assessment - Administration Group Created", sMailMessage, True, , "isg@mbhci.nhs.uk")
        End If
    End Sub

    Private Sub bsgvSANotifications_RowInserted(sender As Object, e As ASPxDataInsertedEventArgs) Handles bsgvSANotifications.RowInserted
        Dim sSubject As String = "Data Protection Impact Assessment Tool System Notification - " & e.NewValues("SubjectLine")
        Dim sBody As String = e.NewValues("BodyHTML")
        Dim taNots As New ispusersTableAdapters.UsersForNotifocationTableAdapter
        Dim tNots As New ispusers.UsersForNotifocationDataTable
        tNots = taNots.GetData(4)
        For Each r As DataRow In tNots.Rows
            Utility.SendEmail(r.Item("UserEmail"), sSubject, sBody, True)
        Next
    End Sub
    Protected Sub ClearSAForm()
        'Default settings are for inserting new SA
        tbSuperAdminEmail.Text = ""
        cbCentralSA.Checked = False
        cbContentManager.Checked = False
        lblManageSATitle.Text = "Add Super Administrator"
        lbtUpdateSA.Visible = False
        lbtAddSA.Visible = True
        hfSuperAdminID.Value = 0
        For Each li As ListItem In listAdminGroups.Items
            li.Selected = False
        Next
    End Sub
    Private Sub gvSuperAdmins_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvSuperAdmins.RowCommand
        If e.CommandName = "EditSA" Then
            ClearSAForm()
            Dim taSA As New adminTableAdapters.isp_SuperAdminsTableAdapter
            Dim tSA As New admin.isp_SuperAdminsDataTable
            tSA = taSA.GetBySuperAdminID(e.CommandArgument)
            hfSuperAdminID.Value = e.CommandArgument
            If tSA.Rows.Count > 0 Then
                tbSuperAdminEmail.Text = tSA.First.SuperAdminEmail
                cbCentralSA.Checked = tSA.First.CentralSA
                cbContentManager.Checked = tSA.First.ContentManager
                Dim taSAG As New adminTableAdapters.isp_SuperAdminGroupsTableAdapter
                Dim tSAG As New admin.isp_SuperAdminGroupsDataTable
                tSAG = taSAG.GetBySuperAdminID(e.CommandArgument)
                If tSAG.Rows.Count > 0 Then
                    For Each r As DataRow In tSAG.Rows
                        For Each li As ListItem In listAdminGroups.Items
                            If li.Value = r.Item("AdminGroupID") Then
                                li.Selected = True
                            End If
                        Next
                    Next
                End If
                lblManageSATitle.Text = "Edit Super Administrator"
                lbtUpdateSA.Visible = True
                lbtAddSA.Visible = False

                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowEditModal", "<script>$('#modalManagSA').modal('show');</script>")
            End If
        End If
    End Sub

    Private Sub lbtUpdateSA_Click(sender As Object, e As EventArgs) Handles lbtUpdateSA.Click
        Dim sAdminGroupsCSV As String = ""
        'Go through admin group list box and populate CSV string:
        For Each li As ListItem In listAdminGroups.Items
            If li.Selected Then
                sAdminGroupsCSV = sAdminGroupsCSV + li.Value.ToString() + ", "
            End If
        Next
        'Trim the trailing , from the CSV string:
        If sAdminGroupsCSV.Length > 2 Then
            sAdminGroupsCSV = sAdminGroupsCSV.Substring(0, sAdminGroupsCSV.Length - 2)
        End If
        'update the SA record
        Dim taSA As New adminTableAdapters.isp_SuperAdminsTableAdapter
        taSA.UpdateSuperAdmin(hfSuperAdminID.Value, tbSuperAdminEmail.Text, cbContentManager.Checked, cbCentralSA.Checked, sAdminGroupsCSV)
        gvSuperAdmins.DataBind()
    End Sub

    Private Sub lbtAddNewSA_Click(sender As Object, e As EventArgs) Handles lbtAddNewSA.Click
        ClearSAForm()
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowAddModal", "<script>$('#modalManagSA').modal('show');</script>")
    End Sub

    Private Sub gvDomains_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvDomains.RowCommand


        If e.CommandName = "EditD" Then
            tbDomain.Text = ""
            cbActive.Checked = False
            cbShowInList.Checked = False
            hfDomainID.Value = 0

            Dim taDomains As New adminTableAdapters.isp_DomainsTableAdapter
            Dim tDomains As New admin.isp_DomainsDataTable
            tDomains = taDomains.GetByDomainID(e.CommandArgument)
            hfDomainID.Value = e.CommandArgument
            If tDomains.Rows.Count > 0 Then
                tbDomain.Text = tDomains.First.Domain
                cbActive.Checked = tDomains.First.Active
                cbShowInList.Checked = tDomains.First.ShowInList

                lblManageDomainTitle.Text = "Edit Domain"
                lbtUpdateDomain.Visible = True
                lbtAddDom.Visible = False

                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowEditModal", "<script>$('#modalManagDomain').modal('show');</script>")

            End If
        End If


    End Sub

    Private Sub lbtUpdateDomain_Click(sender As Object, e As EventArgs) Handles lbtUpdateDomain.Click

        'update the Domain record
        Dim taDomains As New adminTableAdapters.isp_DomainsTableAdapter
        taDomains.UpdateDomains(hfDomainID.Value, tbDomain.Text, cbActive.Checked, cbShowInList.Checked)
        gvDomains.DataBind()

    End Sub
End Class