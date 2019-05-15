Imports System.IO
Imports DevExpress.Data.Linq

Public Class project_summary
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim sBtnTextScript As String = My.Settings.DisableMultiselectShowAll.ToString
        If Not Page.IsPostBack Then
            Session("FlowDetailID") = Nothing
            If Not Session("nProjectID") Is Nothing Then
                hfProjectID.Value = Session("nProjectID")
            End If
            hfPFrozen.Value = 0
            If Not Page.Request.Item("action") Is Nothing Then
                If Page.Request.Item("action") = "add" Then
                    hfProjectID.Value = 0
                End If
            End If
            'Set up role based access options
            If Session("UserRoleAdmin") = False And Session("UserRoleIAO") = False And Session("UserRoleIGO") = False Then
                pnlSummary.Enabled = False
                hfReadOnly.Value = 1
                pnlFileUpload.Visible = False
                lbtSaveProject.Visible = False
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "multiSelectDisable", "<script>function doMultiSelect() {$('.multiselector, .multiselect-dt').not('.no-freeze').attr('disabled', 'disabled').multiselect(" & sBtnTextScript & ");</script>")
                lblFormTitle.Text = "View Project"
                lblFormTitle.ToolTip = "Locked because you do not have permission to edit"
            Else
                'Page.ClientScript.RegisterStartupScript(Me.GetType(), "multiSelectEnable", "<script>function doMultiSelect() {$('.multiselector').multiselect();}</script>")
                lblFormTitle.Text = "Edit Project"
                hfReadOnly.Value = 0
            End If
            hfProjectFileGroup.Value = 0
            'Check if we have a summary id in the page request, if so, open it for editing.
            If Not hfProjectID.Value = 0 Then

                'Load the summary details:
                LoadSummary(hfProjectID.Value)
                lblFormTitle.Text = "Edit Project " & PadID(hfProjectID.Value)

                If lbtSaveProject.Visible Then
                    'Hide the save button:
                    lbtSaveProject.Visible = False
                    'Display the update button:
                    lbtUpdateSummary.Visible = True
                End If
                'Check if it has been updated:
                If Not Page.Request.Item("updated") Is Nothing And Not Page.IsPostBack Then
                    If CInt(Page.Request.Item("updated")) = 1 Then
                        'It has, so show a modal popup with choices:
                        lblModalHeading.Text = "Project Updated"
                        Me.lblModalText.Text = "Your Project has been updated successfully."
                        ShowMessage(False)
                    Else
                        lblModalHeading.Text = "Error Updating Project"
                        Me.lblModalText.Text = "The most likely reason for this is that another project already exists with the same name."
                        ShowMessage(False)
                    End If
                End If
            Else
                ClearSummary()
                lblFormTitle.Text = "Add Project"
                'Show the save button:
                lbtSaveProject.Visible = True
                'Hide the update button:
                lbtUpdateSummary.Visible = False
                'Add the user's organisation as a providing organisation by default:
            End If
        Else
            If Not hfProjectID.Value Is Nothing Then
            End If
        End If
    End Sub

    Protected Sub LoadSummary(ByVal sid As Integer)

        If sid = 0 Then
            Response.Redirect("projects")
        End If

        Dim taP As New DPIAProjectsDataContext
        Dim tFileGroupID = taP.Project_GetFileGroupByID("project", sid).First()
        hfProjectFileGroup.Value = tFileGroupID.FileGroupID

        Dim tPSummary = taP.Project_GetByID(sid).First()
        tbProjectName.Text = tPSummary.Name
        tbProjectDescription.Text = tPSummary.Description

        ddIGLead.DataBind()
        If tPSummary.IG_Lead_ID IsNot Nothing Then
            ddIGLead.SelectedValue = tPSummary.IG_Lead_ID.ToString
        End If

        ddIALead.DataBind()
        If tPSummary.Asset_Owner_ID IsNot Nothing Then
            ddIALead.SelectedValue = tPSummary.Asset_Owner_ID.ToString
        End If

        ddDPOLead.DataBind()
        If tPSummary.DPO_ID IsNot Nothing Then
            ddDPOLead.SelectedValue = tPSummary.DPO_ID.ToString
        End If

    End Sub
    Protected Sub ClearSummary()

        tbProjectName.Text = ""
        tbProjectDescription.Text = ""
    End Sub
    Protected Function PadID(value As Integer) As String

        Dim fmt As String = "PR0000000"
        Dim str As String = value.ToString(fmt)
        Return str
    End Function
    Private Sub lbtSaveProject_Click(sender As Object, e As EventArgs) Handles lbtSaveProject.Click

        'Dim taq As New DPIAProjectsTableAdapters.QueriesTableAdapter

        'Get userid:
        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim currentUserId As Guid = DirectCast(currentUser.ProviderUserKey, Guid)

        Dim IGLeadId As Guid
        Dim IGDate? As Date
        If ddIGLead.SelectedValue <> "0" Then
            IGLeadId = New Guid(ddIGLead.SelectedValue)
            IGDate = Date.UtcNow()
        Else
            IGLeadId = Nothing
            IGDate = Nothing
        End If

        Dim IALeadId As Guid
        Dim IADate? As Date
        If ddIALead.SelectedValue <> "0" Then
            IALeadId = New Guid(ddIALead.SelectedValue)
            IADate = Date.UtcNow()
        Else
            IALeadId = Nothing
            IADate = Nothing
        End If

        Dim DPOLeadId As Guid
        Dim DPODate? As Date
        If ddDPOLead.SelectedValue <> "0" Then
            DPOLeadId = New Guid(ddDPOLead.SelectedValue)
            DPODate = Date.UtcNow()
        Else
            DPOLeadId = Nothing
            DPODate = Nothing
        End If

        Dim taP As New DPIAProjectsDataContext
        Dim tPSummary = taP.Project_Insert(tbProjectName.Text, tbProjectDescription.Text, 1, Session("UserOrganisationID"),
                                    IGLeadId, IGDate, IALeadId, IADate, DPOLeadId, DPODate, Nothing, Nothing, currentUserId)
        If tPSummary.ReturnValue > 0 Then
            Session("nProjectID") = tPSummary.ReturnValue
            'Session("FlowDetailID") = Nothing
            taP.Project_FileGroups_UpdateID(tPSummary.ReturnValue, hfProjectFileGroup.Value)
            lblModalHeading.Text = "Project Added"
            Me.lblModalText.Text = "Your project has been added successfully. What would you like to do?"
            hfProjectID.Value = tPSummary.ReturnValue
            'lbtAddDetail.PostBackUrl = "~/application/summaries_list.aspx"
            ShowMessage(True)
        ElseIf tPSummary.ReturnValue = -10 Then
            lblModalHeading.Text = "A Project Already Exists"
            Me.lblModalText.Text = "A project with that name already exists. Please enter a unique name / identifier."
            ShowMessage(False)
        Else
            lblModalHeading.Text = "Could Not Save the Project"
            Me.lblModalText.Text = "This may be because your login has expired. Try logging out and logging back in again before attempting to re-add the project. If the problem persists, please contact DPIA support."
            ShowMessage(False)
        End If

    End Sub


    Protected Sub ShowMessage(Optional ByVal ShowOptions As Boolean = False)
        If ShowOptions Then
            btnCloseModal.Visible = False
            lbtAddedReturn.Visible = True
            lbtAddDetail.Visible = True
            ModalOK.Visible = False
        Else
            lbtAddedReturn.Visible = False
            lbtAddDetail.Visible = False
            ModalOK.Visible = True
        End If
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMessage", "<script>$('#modalMessage').modal('show');</script>")
        'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ShowModalMessage", "$('#modalMessage').modal('show');", True)
    End Sub
    Private Sub lbtUpload_Click(sender As Object, e As EventArgs) Handles lbtUpload.Click
        Dim nSummaryID = 0

        Dim taP As New DPIAProjectsDataContext
        If Not hfProjectID.Value Is Nothing Then
            nSummaryID = hfProjectID.Value
        End If
        If hfProjectFileGroup.Value = 0 Then
            hfProjectFileGroup.Value = taP.Project_FileGroup_Insert("project", nSummaryID).ReturnValue
        End If
        If filEvidence.PostedFiles.Count > 0 Then
            Dim bShowWarning As Boolean = 0
            Me.lblModalText.Text = ""
            Dim nFileID As Nullable(Of Integer)
            Dim sFilename As String = ""
            For Each pFile As HttpPostedFile In filEvidence.PostedFiles
                'Dim sExtension As String = System.IO.Path.GetExtension(Me.filEvidence.PostedFile.FileName).ToLower()
                sFilename = System.IO.Path.GetFileName(pFile.FileName)
                Dim nMaxKB As Integer = 5120
                If pFile.InputStream.Length > nMaxKB * 1024 Then
                    lblModalHeading.Text = "Evidence file error"
                    Me.lblModalText.Text = Me.lblModalText.Text + "<p>" + sFilename + " is too big. Maximum file size is " + (nMaxKB / 1024).ToString() + "MB." + "</p>"
                    bShowWarning = True
                Else
                    Dim size As Integer = pFile.ContentLength
                    Dim sContentType As String = pFile.ContentType
                    Dim fileData As Byte() = New Byte(size - 1) {}
                    pFile.InputStream.Read(fileData, 0, size)
                    nFileID = taP.Project_InsertFile(sFilename, sContentType, pFile.InputStream.Length / 1024, fileData, Session("UserOrganisationID"), Session("UserEmail")).ReturnValue
                    If nFileID > 0 Then
                        taP.Project_FileGroupFile_Insert(hfProjectFileGroup.Value, nFileID)
                    Else
                        lblModalHeading.Text = "Evidence file error"
                        Me.lblModalText.Text = Me.lblModalText.Text + "<p>" + sFilename + " failed to upload due to an unknown error. </p>"
                        bShowWarning = True
                    End If
                End If
            Next

            rptFiles.DataBind()
            If bShowWarning Then
                ShowMessage()
            End If
        End If
    End Sub
    Private Sub rptFiles_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles rptFiles.ItemCommand
        If e.CommandName = "Delete" Then
            Dim taP As New DPIAProjectsDataContext
            taP.Project_File_Delete(CInt(e.CommandArgument))
            rptFiles.DataBind()
        End If
    End Sub

    Private Sub rptFiles_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles rptFiles.ItemDataBound
        If pnlFileUpload.Visible = False Then
            Dim lbt As LinkButton = e.Item.FindControl("lbtDelete")
            If Not lbt Is Nothing Then
                lbt.Visible = False
            End If
        End If
    End Sub
    Protected Sub lbtUpdateSummary_Click(sender As Object, e As EventArgs) Handles lbtUpdateSummary.Click
        'Dim tap As New DPIAProjectsTableAdapters.Projects_GetFilteredTableAdapter

        'Get the userid:
        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim ModifiedUserId As Guid = DirectCast(currentUser.ProviderUserKey, Guid)

        Dim IGLeadId As Guid
        Dim IGDate? As Date
        If ddIGLead.SelectedValue <> "0" Then
            IGLeadId = New Guid(ddIGLead.SelectedValue)
            IGDate = Date.UtcNow()
        Else
            IGLeadId = Nothing
            IGDate = Nothing
        End If

        Dim IALeadId As Guid
        Dim IADate? As Date
        If ddIALead.SelectedValue <> "0" Then
            IALeadId = New Guid(ddIALead.SelectedValue)
            IADate = Date.UtcNow()
        Else
            IALeadId = Nothing
            IADate = Nothing
        End If

        Dim DPOLeadId As Guid
        Dim DPODate? As Date
        If ddDPOLead.SelectedValue <> "0" Then
            DPOLeadId = New Guid(ddDPOLead.SelectedValue)
            DPODate = Date.UtcNow()
        Else
            DPOLeadId = Nothing
            DPODate = Nothing
        End If

        Dim nProjectID As Integer = hfProjectID.Value
        Session("nProjectID") = hfProjectID.Value
        Dim taP As New DPIAProjectsDataContext
        Dim tPSummary = taP.Project_Update(nProjectID, tbProjectName.Text, tbProjectDescription.Text,
                                    IGLeadId, IGDate, IALeadId, IADate, DPOLeadId, DPODate, Nothing, Nothing, ModifiedUserId)
        If tPSummary.ReturnValue > 0 Then
            Response.Redirect("~/application/project_summary.aspx?summaryid=" & hfProjectID.Value & "&updated=1")
        Else
            Response.Redirect("~/application/project_summary.aspx?summaryid=" & hfProjectID.Value & "&updated=0")
        End If
    End Sub

    Private Sub lds_GetOrgIGRoles_Selecting(sender As Object, e As LinqDataSourceSelectEventArgs) Handles lds_GetOrgIGRoles.Selecting
        Dim taP As New DPIAProjectsDataContext

        e.Result = taP.Users_GetOrgIGRoles(Session("UserOrganisationID"))
    End Sub

    Private Sub lds_GetOrgDPORoles_Selecting(sender As Object, e As LinqDataSourceSelectEventArgs) Handles lds_GetOrgDPORoles.Selecting
        Dim taP As New DPIAProjectsDataContext

        e.Result = taP.Users_GetOrgDPORoles(Session("UserOrganisationID"))
    End Sub

    Private Sub lds_GetOrgIARoles_Selecting(sender As Object, e As LinqDataSourceSelectEventArgs) Handles lds_GetOrgIARoles.Selecting
        Dim taP As New DPIAProjectsDataContext

        e.Result = taP.Users_GetOrgIARoles(Session("UserOrganisationID"))
    End Sub

    Private Sub lds_SummaryFiles_Selecting(sender As Object, e As LinqDataSourceSelectEventArgs) Handles lds_SummaryFiles.Selecting
        '
        Dim taP As New DPIAProjectsDataContext

        e.Result = taP.Projects_GetFilesByGroup(hfProjectFileGroup.Value)
    End Sub

End Class