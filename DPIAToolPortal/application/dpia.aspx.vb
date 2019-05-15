Public Class dpia
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Not Session("nProjectID") Is Nothing Then
                hfProjectID.Value = Session("nProjectID")
                lblFormTitle.Text = "Project DPIA " & PadID(hfProjectID.Value)
            End If

            hfProjectFileGroup.Value = 0
            If Not hfProjectID.Value = 0 Then
                'Load the summary details:
                LoadSummary(hfProjectID.Value)
            End If

            If Not Page.Request.Item("saved") Is Nothing And Not Page.IsPostBack Then
                If CInt(Page.Request.Item("saved")) = 1 Then
                    'It has, so show a modal popup with choices:
                    lblModalHeading.Text = "DPIA Saved"
                    Me.lblModalText.Text = "Your DPIA has been saved successfully."
                    ShowMessage(False)
                Else
                    lblModalHeading.Text = "Error saving DPIA"
                    Me.lblModalText.Text = "The most likely reason for this is a database issue."
                    ShowMessage(False)
                End If
            End If


        End If
        System.Web.UI.ScriptManager.RegisterStartupScript(Me, [GetType](), "check_Javascript", "doStartPage();", True)
    End Sub

    Protected Sub LoadSummary(ByVal sid As Integer)

        If sid = 0 Then
            Response.Redirect("projects")
        End If

        Dim taP As New DPIAProjectsDataContext
        Dim tFileGroupID = taP.Project_GetFileGroupByID("project_legint", sid).First()
        hfProjectFileGroup.Value = tFileGroupID.FileGroupID

        Dim tSPIFileGroupID = taP.Project_GetFileGroupByID("project_spi", sid).First()
        hfSPIFileGroup.Value = tSPIFileGroupID.FileGroupID

        'Dim taP As New DPIAProjectsDataContext
        Dim tPDPIA = taP.Project_GetDPIAByID(sid).First()


        'Legal Personal Data
        If tPDPIA.DPIALegalQ01 IsNot Nothing Then
            rblDPIALegalQ01.SelectedValue = tPDPIA.DPIALegalQ01
        End If
        If tPDPIA.DPIALegalQ01a IsNot Nothing Then
            rblDPIALegalQ01a.SelectedValue = tPDPIA.DPIALegalQ01a
        End If

        cbDPIALegalQ01aa.Checked = tPDPIA.DPIALegalQ01aa
        cbDPIALegalQ01ab.Checked = tPDPIA.DPIALegalQ01ab
        cbDPIALegalQ01ac.Checked = tPDPIA.DPIALegalQ01ac
        cbDPIALegalQ01ad.Checked = tPDPIA.DPIALegalQ01ad
        cbDPIALegalQ01ae.Checked = tPDPIA.DPIALegalQ01ae
        cbDPIALegalQ01af.Checked = tPDPIA.DPIALegalQ01af

        tbDPIALegalQ01acleg.Text = tPDPIA.DPIALegalQ01acleg
        tbDPIALegalQ01aeleg.Text = tPDPIA.DPIALegalQ01aeleg


        If tPDPIA.DPIALegalQ01aa2 IsNot Nothing Then
            rblDPIALegalQ01aa2.SelectedValue = tPDPIA.DPIALegalQ01aa2
        End If
        If tPDPIA.DPIALegalQ01aa3 IsNot Nothing Then
            rblDPIALegalQ01aa3.SelectedValue = tPDPIA.DPIALegalQ01aa3
        End If

        cblDPIALegalQ01aa1.DataBind()


        'Legal Special Data
        If tPDPIA.DPIALegalQ02 IsNot Nothing Then
            rblDPIALegalQ02.SelectedValue = tPDPIA.DPIALegalQ02
        End If
        cbDPIALegalQ02aa.Checked = tPDPIA.DPIALegalQ02aa
        cbDPIALegalQ02ab.Checked = tPDPIA.DPIALegalQ02ab
        cbDPIALegalQ02ac.Checked = tPDPIA.DPIALegalQ02ac
        cbDPIALegalQ02ad.Checked = tPDPIA.DPIALegalQ02ad
        cbDPIALegalQ02ae.Checked = tPDPIA.DPIALegalQ02ae
        cbDPIALegalQ02af.Checked = tPDPIA.DPIALegalQ02af
        cbDPIALegalQ02ag.Checked = tPDPIA.DPIALegalQ02ag
        cbDPIALegalQ02ah.Checked = tPDPIA.DPIALegalQ02ah
        cbDPIALegalQ02ai.Checked = tPDPIA.DPIALegalQ02ai
        cbDPIALegalQ02aga.Checked = tPDPIA.DPIALegalQ02aga
        cbDPIALegalQ02agb.Checked = tPDPIA.DPIALegalQ02agb
        cbDPIALegalQ02agc.Checked = tPDPIA.DPIALegalQ02agc
        cbDPIALegalQ02agd.Checked = tPDPIA.DPIALegalQ02agd
        cbDPIALegalQ02age.Checked = tPDPIA.DPIALegalQ02age
        cbDPIALegalQ02agf.Checked = tPDPIA.DPIALegalQ02agf
        cbDPIALegalQ02agg.Checked = tPDPIA.DPIALegalQ02agg
        cbDPIALegalQ02agh.Checked = tPDPIA.DPIALegalQ02agh
        cbDPIALegalQ02agi.Checked = tPDPIA.DPIALegalQ02agi
        cbDPIALegalQ02agj.Checked = tPDPIA.DPIALegalQ02agj
        cbDPIALegalQ02agk.Checked = tPDPIA.DPIALegalQ02agk
        cbDPIALegalQ02agl.Checked = tPDPIA.DPIALegalQ02agl
        cbDPIALegalQ02agm.Checked = tPDPIA.DPIALegalQ02agm
        cbDPIALegalQ02agn.Checked = tPDPIA.DPIALegalQ02agn
        cbDPIALegalQ02ago.Checked = tPDPIA.DPIALegalQ02ago
        cbDPIALegalQ02agp.Checked = tPDPIA.DPIALegalQ02agp
        cbDPIALegalQ02agq.Checked = tPDPIA.DPIALegalQ02agq
        cbDPIALegalQ02agr.Checked = tPDPIA.DPIALegalQ02agr
        cbDPIALegalQ02ags.Checked = tPDPIA.DPIALegalQ02ags
        cbDPIALegalQ02agt.Checked = tPDPIA.DPIALegalQ02agt
        cbDPIALegalQ02agu.Checked = tPDPIA.DPIALegalQ02agu
        cbDPIALegalQ02agv.Checked = tPDPIA.DPIALegalQ02agv
        cbDPIALegalQ02agw.Checked = tPDPIA.DPIALegalQ02agw

        'Health Confidentiality
        If tPDPIA.DPIALegalQ03 IsNot Nothing Then
            rblDPIALegalQ03.SelectedValue = tPDPIA.DPIALegalQ03
        End If

        cblDPIALegalQ03a.DataBind()
        cblDPIALegalQ03b.DataBind()

        'Resposibilities of Data Contoller and Data Processor
        If tPDPIA.DPIALegalQ04 IsNot Nothing Then
            rblDPIALegalQ04.SelectedValue = tPDPIA.DPIALegalQ04
        End If

        cblDPIALegalQ04a.DataBind()
        If tPDPIA.DPIALegalQ04b IsNot Nothing Then
            rblDPIALegalQ04b.SelectedValue = tPDPIA.DPIALegalQ04b
        End If

    End Sub
    Private Sub cblDPIALegalQ01aa1_DataBound(sender As Object, e As EventArgs) Handles cblDPIALegalQ01aa1.DataBound
        Dim nSummaryID = 0
        If Not hfProjectID.Value Is Nothing Then
            nSummaryID = hfProjectID.Value
        End If
        If nSummaryID > 0 Then
            Dim taSched2 As New DPIAProjectsDataContext
            Dim tSchedList = taSched2.Project_GetDPIAInformedConsentByID(nSummaryID).ToList()
            For Each r In tSchedList
                For Each li As ListItem In cblDPIALegalQ01aa1.Items
                    If li.Value = r.InformationSharedID Then
                        li.Selected = True
                    End If
                Next
            Next
        End If
    End Sub
    Private Sub cblDPIALegalQ03a_DataBound(sender As Object, e As EventArgs) Handles cblDPIALegalQ03a.DataBound
        Dim nSummaryID = 0
        If Not hfProjectID.Value Is Nothing Then
            nSummaryID = hfProjectID.Value
        End If
        If nSummaryID > 0 Then
            Dim taSched2 As New DPIAProjectsDataContext
            Dim tSchedList = taSched2.Project_GetDPIAHealthPurposeByID(nSummaryID).ToList()
            For Each r In tSchedList
                For Each li As ListItem In cblDPIALegalQ03a.Items
                    If li.Value = r.InformationSharedID Then
                        li.Selected = True
                    End If
                Next
            Next
        End If
    End Sub
    Private Sub cblDPIALegalQ03b_DataBound(sender As Object, e As EventArgs) Handles cblDPIALegalQ03b.DataBound
        Dim nSummaryID = 0
        If Not hfProjectID.Value Is Nothing Then
            nSummaryID = hfProjectID.Value
        End If
        If nSummaryID > 0 Then
            Dim taSched2 As New DPIAProjectsDataContext
            Dim tSchedList = taSched2.Project_GetDPIAHealthConfRespByID(nSummaryID).ToList()
            For Each r In tSchedList
                For Each li As ListItem In cblDPIALegalQ03b.Items
                    If li.Value = r.InformationSharedID Then
                        li.Selected = True
                    End If
                Next
            Next
        End If
    End Sub
    Private Sub cblDPIALegalQ04a_DataBound(sender As Object, e As EventArgs) Handles cblDPIALegalQ04a.DataBound
        Dim nSummaryID = 0
        If Not hfProjectID.Value Is Nothing Then
            nSummaryID = hfProjectID.Value
        End If
        If nSummaryID > 0 Then
            Dim taSched2 As New DPIAProjectsDataContext
            Dim tSchedList = taSched2.Project_GetDPIADCDPResposibilityByID(nSummaryID).ToList()
            For Each r In tSchedList
                For Each li As ListItem In cblDPIALegalQ04a.Items
                    If li.Value = r.InformationSharedID Then
                        li.Selected = True
                    End If
                Next
            Next
        End If
    End Sub

    Private Sub lbtDPIALegal_Click(sender As Object, e As EventArgs) Handles lbtDPIALegal.Click
        RemoveActiveClasses()
        mvDPIA.SetActiveView(vLegal)
        liDPIALegal.Attributes.Add("class", "active")
    End Sub

    Private Sub lbtDPIAProcess_Click(sender As Object, e As EventArgs) Handles lbtDPIAProcess.Click
        RemoveActiveClasses()
        mvDPIA.SetActiveView(vProcess)
        liDPIAProcess.Attributes.Add("class", "active")
    End Sub




    Private Sub lbtDPIARights_Click(sender As Object, e As EventArgs) Handles lbtDPIARights.Click
        RemoveActiveClasses()
        mvDPIA.SetActiveView(vRights)
        liDPIARights.Attributes.Add("class", "active")
    End Sub

    Private Sub lbtDPIASecurity_Click(sender As Object, e As EventArgs) Handles lbtDPIASecurity.Click
        RemoveActiveClasses()
        mvDPIA.SetActiveView(vSecurity)
        liDPIASecurity.Attributes.Add("class", "active")
    End Sub

    Private Sub lbtDPIARisks_Click(sender As Object, e As EventArgs) Handles lbtDPIARisks.Click
        RemoveActiveClasses()
        mvDPIA.SetActiveView(vRisks)
        liDPIARisks.Attributes.Add("class", "active")
    End Sub

    Private Sub lbtDPIADocuments_Click(sender As Object, e As EventArgs) Handles lbtDPIADocuments.Click
        RemoveActiveClasses()
        mvDPIA.SetActiveView(vDocuments)
        liDPIADocuments.Attributes.Add("class", "active")
    End Sub

    Private Sub lbtDPIAFinalise_Click(sender As Object, e As EventArgs) Handles lbtDPIAFinalise.Click
        RemoveActiveClasses()
        mvDPIA.SetActiveView(vFinalise)
        liDPIAFinalise.Attributes.Add("class", "active")
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
        'Dim taq As New DPIAProjectsTableAdapters.QueriesTableAdapter
        Dim taq As New DPIAProjectsDataContext
        If Not hfProjectID.Value Is Nothing Then
            nSummaryID = hfProjectID.Value
        End If
        If hfProjectFileGroup.Value = 0 Then
            hfProjectFileGroup.Value = taq.Project_FileGroup_Insert("project_legint", nSummaryID).ReturnValue
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
                    nFileID = taq.Project_InsertFile(sFilename, sContentType, pFile.InputStream.Length / 1024, fileData, Session("UserOrganisationID"), Session("UserEmail")).ReturnValue
                    If nFileID > 0 Then
                        taq.Project_FileGroupFile_Insert(hfProjectFileGroup.Value, nFileID)
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
        'System.Web.UI.ScriptManager.RegisterStartupScript(Me, [GetType](), "check_Javascript", "doStartPage();", True)
    End Sub
    Private Sub lbtSPIUpload_Click(sender As Object, e As EventArgs) Handles lbtSPIUpload.Click
        Dim nSummaryID = 0
        'Dim taq As New DPIAProjectsTableAdapters.QueriesTableAdapter
        Dim taq As New DPIAProjectsDataContext
        If Not hfProjectID.Value Is Nothing Then
            nSummaryID = hfProjectID.Value
        End If
        If hfSPIFileGroup.Value = 0 Then
            hfSPIFileGroup.Value = taq.Project_FileGroup_Insert("project_spi", nSummaryID).ReturnValue
        End If
        If filSPIEvidence.PostedFiles.Count > 0 Then
            Dim bShowWarning As Boolean = 0
            Me.lblModalText.Text = ""
            Dim nFileID As Nullable(Of Integer)
            Dim sFilename As String = ""
            For Each pFile As HttpPostedFile In filSPIEvidence.PostedFiles
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
                    nFileID = taq.Project_InsertFile(sFilename, sContentType, pFile.InputStream.Length / 1024, fileData, Session("UserOrganisationID"), Session("UserEmail")).ReturnValue
                    If nFileID > 0 Then
                        taq.Project_FileGroupFile_Insert(hfSPIFileGroup.Value, nFileID)
                    Else
                        lblModalHeading.Text = "Evidence file error"
                        Me.lblModalText.Text = Me.lblModalText.Text + "<p>" + sFilename + " failed to upload due to an unknown error. </p>"
                        bShowWarning = True
                    End If
                End If
            Next

            rptSPIFiles.DataBind()
            If bShowWarning Then
                ShowMessage()
            End If
        End If
        'System.Web.UI.ScriptManager.RegisterStartupScript(Me, [GetType](), "check_Javascript", "doStartPage();", True)
    End Sub





    Private Sub rptFiles_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles rptFiles.ItemCommand
        If e.CommandName = "Delete" Then
            'Dim taq As New DPIAProjectsTableAdapters.QueriesTableAdapter
            Dim taq As New DPIAProjectsDataContext
            taq.Project_File_Delete(CInt(e.CommandArgument))
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
    Private Sub rptSPIFiles_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles rptSPIFiles.ItemCommand
        If e.CommandName = "Delete" Then
            'Dim taq As New DPIAProjectsTableAdapters.QueriesTableAdapter
            Dim taq As New DPIAProjectsDataContext
            taq.Project_File_Delete(CInt(e.CommandArgument))
            rptSPIFiles.DataBind()
        End If
    End Sub

    Private Sub rptSPIFiles_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles rptSPIFiles.ItemDataBound
        If pnlSPIFileUpload.Visible = False Then
            Dim lbt As LinkButton = e.Item.FindControl("lbtSPIDelete")
            If Not lbt Is Nothing Then
                lbt.Visible = False
            End If
        End If
    End Sub

    Protected Sub RemoveActiveClasses()
        liDPIALegal.Attributes.Remove("class")
        liDPIAProcess.Attributes.Remove("class")
        liDPIARights.Attributes.Remove("class")
        liDPIASecurity.Attributes.Remove("class")
        liDPIARisks.Attributes.Remove("class")
        liDPIADocuments.Attributes.Remove("class")
        liDPIAFinalise.Attributes.Remove("class")
    End Sub

    Protected Function PadID(value As Integer) As String

        Dim fmt As String = "PR0000000"
        Dim str As String = value.ToString(fmt)
        Return str
    End Function

    Private Sub lbtSaveDPIA_Click(sender As Object, e As EventArgs) Handles lbtSaveDPIA.Click
        Dim sDPIALegalQ01aa1CSV As String = ""
        Dim sDPIALegalQ03aCSV As String = ""
        Dim sDPIALegalQ03bCSV As String = ""
        Dim sDPIALegalQ04aCSV As String = ""

        'Get the userid:
        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim ModifiedUserId As Guid = DirectCast(currentUser.ProviderUserKey, Guid)

        Dim nProjectID As Integer = hfProjectID.Value
        Session("nProjectID") = hfProjectID.Value

        'clear hidden elements begore saving
        'Q1
        If Not cbDPIALegalQ01aa.Checked Then
            cbDPIALegalQ01aa.Checked = False
            rblDPIALegalQ01aa2.ClearSelection()
            rblDPIALegalQ01aa3.ClearSelection()
        End If
        If Not cbDPIALegalQ01ac.Checked Then
            tbDPIALegalQ01acleg.Text = ""
        End If
        If Not cbDPIALegalQ01ae.Checked Then
            tbDPIALegalQ01aeleg.Text = ""
        End If
        If rblDPIALegalQ01a.SelectedValue = "0" Or rblDPIALegalQ01a.SelectedValue = "" Then
            cbDPIALegalQ01aa.Checked = False
            cblDPIALegalQ01aa1.ClearSelection()
            rblDPIALegalQ01aa2.ClearSelection()
            rblDPIALegalQ01aa3.ClearSelection()
            cbDPIALegalQ01ab.Checked = False
            cbDPIALegalQ01ac.Checked = False
            tbDPIALegalQ01acleg.Text = ""
            cbDPIALegalQ01ad.Checked = False
            cbDPIALegalQ01ae.Checked = False
            tbDPIALegalQ01aeleg.Text = ""
            cbDPIALegalQ01af.Checked = False
        End If
        If rblDPIALegalQ01.SelectedValue = "0" Or rblDPIALegalQ01.SelectedValue = "" Then
            rblDPIALegalQ01a.ClearSelection()
            cbDPIALegalQ01aa.Checked = False
            cblDPIALegalQ01aa1.ClearSelection()
            rblDPIALegalQ01aa2.ClearSelection()
            rblDPIALegalQ01aa3.ClearSelection()
            cbDPIALegalQ01ab.Checked = False
            cbDPIALegalQ01ac.Checked = False
            tbDPIALegalQ01acleg.Text = ""
            cbDPIALegalQ01ad.Checked = False
            cbDPIALegalQ01ae.Checked = False
            tbDPIALegalQ01aeleg.Text = ""
            cbDPIALegalQ01af.Checked = False
        End If

        'clear hidden elements begore saving
        'Q2
        If Not cbDPIALegalQ02ag.Checked Then
            cbDPIALegalQ02aga.Checked = False
            cbDPIALegalQ02agb.Checked = False
            cbDPIALegalQ02agc.Checked = False
            cbDPIALegalQ02agd.Checked = False
            cbDPIALegalQ02age.Checked = False
            cbDPIALegalQ02agf.Checked = False
            cbDPIALegalQ02agg.Checked = False
            cbDPIALegalQ02agh.Checked = False
            cbDPIALegalQ02agi.Checked = False
            cbDPIALegalQ02agj.Checked = False
            cbDPIALegalQ02agk.Checked = False
            cbDPIALegalQ02agl.Checked = False
            cbDPIALegalQ02agm.Checked = False
            cbDPIALegalQ02agn.Checked = False
            cbDPIALegalQ02ago.Checked = False
            cbDPIALegalQ02agp.Checked = False
            cbDPIALegalQ02agq.Checked = False
            cbDPIALegalQ02agr.Checked = False
            cbDPIALegalQ02ags.Checked = False
            cbDPIALegalQ02agt.Checked = False
            cbDPIALegalQ02agu.Checked = False
            cbDPIALegalQ02agv.Checked = False
            cbDPIALegalQ02agw.Checked = False
        End If

        If rblDPIALegalQ02.SelectedValue = "0" Or rblDPIALegalQ02.SelectedValue = "" Then
            cbDPIALegalQ02aa.Checked = False
            cbDPIALegalQ02ab.Checked = False
            cbDPIALegalQ02ac.Checked = False
            cbDPIALegalQ02ad.Checked = False
            cbDPIALegalQ02ae.Checked = False
            cbDPIALegalQ02af.Checked = False
            cbDPIALegalQ02ag.Checked = False
            cbDPIALegalQ02ah.Checked = False
            cbDPIALegalQ02ai.Checked = False

            cbDPIALegalQ02aga.Checked = False
            cbDPIALegalQ02agb.Checked = False
            cbDPIALegalQ02agc.Checked = False
            cbDPIALegalQ02agd.Checked = False
            cbDPIALegalQ02age.Checked = False
            cbDPIALegalQ02agf.Checked = False
            cbDPIALegalQ02agg.Checked = False
            cbDPIALegalQ02agh.Checked = False
            cbDPIALegalQ02agi.Checked = False
            cbDPIALegalQ02agj.Checked = False
            cbDPIALegalQ02agk.Checked = False
            cbDPIALegalQ02agl.Checked = False
            cbDPIALegalQ02agm.Checked = False
            cbDPIALegalQ02agn.Checked = False
            cbDPIALegalQ02ago.Checked = False
            cbDPIALegalQ02agp.Checked = False
            cbDPIALegalQ02agq.Checked = False
            cbDPIALegalQ02agr.Checked = False
            cbDPIALegalQ02ags.Checked = False
            cbDPIALegalQ02agt.Checked = False
            cbDPIALegalQ02agu.Checked = False
            cbDPIALegalQ02agv.Checked = False
            cbDPIALegalQ02agw.Checked = False
        End If
        'clear hidden elements begore saving
        'Q3
        If (Not cblDPIALegalQ03a.Items(1).Selected) And (Not cblDPIALegalQ03a.Items(2).Selected) And (Not cblDPIALegalQ03a.Items(3).Selected) Then
            cblDPIALegalQ03b.ClearSelection()
        End If

        If rblDPIALegalQ03.SelectedValue = "0" Or rblDPIALegalQ03.SelectedValue = "" Then
            cblDPIALegalQ03a.ClearSelection()
            cblDPIALegalQ03b.ClearSelection()
        End If
        'clear hidden elements begore saving
        'Q4
        If (Not cblDPIALegalQ04a.Items(0).Selected) Then
            rblDPIALegalQ04b.ClearSelection()
        End If
        If rblDPIALegalQ04.SelectedValue = "0" Or rblDPIALegalQ04.SelectedValue = "" Then
            cblDPIALegalQ04a.ClearSelection()
            rblDPIALegalQ04b.ClearSelection()
        End If

        'Q1 Legal Personal Data
        Dim DPIALegalQ01 As Integer
        If rblDPIALegalQ01.SelectedValue <> "" Then DPIALegalQ01 = rblDPIALegalQ01.SelectedValue Else DPIALegalQ01 = Nothing
        Dim DPIALegalQ01a?, DPIALegalQ01aa2?, DPIALegalQ01aa3? As Integer
        If rblDPIALegalQ01a.SelectedValue <> "" Then DPIALegalQ01a = rblDPIALegalQ01a.SelectedValue Else DPIALegalQ01a = Nothing
        If rblDPIALegalQ01aa2.SelectedValue <> "" Then DPIALegalQ01aa2 = rblDPIALegalQ01aa2.SelectedValue Else DPIALegalQ01aa2 = Nothing
        If rblDPIALegalQ01aa3.SelectedValue <> "" Then DPIALegalQ01aa3 = rblDPIALegalQ01aa3.SelectedValue Else DPIALegalQ01aa3 = Nothing

        For Each li As ListItem In cblDPIALegalQ01aa1.Items
            If li.Selected Then
                sDPIALegalQ01aa1CSV = sDPIALegalQ01aa1CSV + li.Value.ToString() + ", "
            End If
        Next
        If sDPIALegalQ01aa1CSV.Length > 2 Then  'Trim the trailing , from the CSV string:
            sDPIALegalQ01aa1CSV = sDPIALegalQ01aa1CSV.Substring(0, sDPIALegalQ01aa1CSV.Length - 2)
        End If

        'Q2 Legal Special Data
        Dim DPIALegalQ02 As Integer
        If rblDPIALegalQ02.SelectedValue <> "" Then DPIALegalQ02 = rblDPIALegalQ02.SelectedValue Else DPIALegalQ02 = Nothing

        'Q3 Health Confidentiality
        Dim DPIALegalQ03 As Integer
        If rblDPIALegalQ03.SelectedValue <> "" Then DPIALegalQ03 = rblDPIALegalQ03.SelectedValue Else DPIALegalQ03 = Nothing

        For Each li As ListItem In cblDPIALegalQ03a.Items
            If li.Selected Then
                sDPIALegalQ03aCSV = sDPIALegalQ03aCSV + li.Value.ToString() + ", "
            End If
        Next
        If sDPIALegalQ03aCSV.Length > 2 Then  'Trim the trailing , from the CSV string:
            sDPIALegalQ03aCSV = sDPIALegalQ03aCSV.Substring(0, sDPIALegalQ03aCSV.Length - 2)
        End If

        For Each li As ListItem In cblDPIALegalQ03b.Items
            If li.Selected Then
                sDPIALegalQ03bCSV = sDPIALegalQ03bCSV + li.Value.ToString() + ", "
            End If
        Next
        If sDPIALegalQ03bCSV.Length > 2 Then  'Trim the trailing , from the CSV string:
            sDPIALegalQ03bCSV = sDPIALegalQ03bCSV.Substring(0, sDPIALegalQ03bCSV.Length - 2)
        End If

        'Q4 Resposibilities of Data Contoller and Data Processor
        Dim DPIALegalQ04 As Integer
        If rblDPIALegalQ04.SelectedValue <> "" Then DPIALegalQ04 = rblDPIALegalQ04.SelectedValue Else DPIALegalQ04 = Nothing
        Dim DPIALegalQ04b? As Integer
        If rblDPIALegalQ04b.SelectedValue <> "" Then DPIALegalQ04b = rblDPIALegalQ04b.SelectedValue Else DPIALegalQ04b = Nothing

        For Each li As ListItem In cblDPIALegalQ04a.Items
            If li.Selected Then
                sDPIALegalQ04aCSV = sDPIALegalQ04aCSV + li.Value.ToString() + ", "
            End If
        Next
        If sDPIALegalQ04aCSV.Length > 2 Then  'Trim the trailing , from the CSV string:
            sDPIALegalQ04aCSV = sDPIALegalQ04aCSV.Substring(0, sDPIALegalQ04aCSV.Length - 2)
        End If

        Dim taP As New DPIAProjectsDataContext
        Dim tPDPIA = taP.Project_UpdateDPIA(nProjectID, 7, DPIALegalQ01, DPIALegalQ01a,
                                    cbDPIALegalQ01aa.Checked, cbDPIALegalQ01ab.Checked, cbDPIALegalQ01ac.Checked, cbDPIALegalQ01ad.Checked, cbDPIALegalQ01ae.Checked, cbDPIALegalQ01af.Checked,
                                    tbDPIALegalQ01acleg.Text, tbDPIALegalQ01aeleg.Text, DPIALegalQ01aa2, DPIALegalQ01aa3, DPIALegalQ02,
                                    cbDPIALegalQ02aa.Checked, cbDPIALegalQ02ab.Checked, cbDPIALegalQ02ac.Checked, cbDPIALegalQ02ad.Checked, cbDPIALegalQ02ae.Checked,
                                    cbDPIALegalQ02af.Checked, cbDPIALegalQ02ag.Checked, cbDPIALegalQ02ah.Checked, cbDPIALegalQ02ai.Checked,
                                    cbDPIALegalQ02aga.Checked, cbDPIALegalQ02agb.Checked, cbDPIALegalQ02agc.Checked, cbDPIALegalQ02agd.Checked, cbDPIALegalQ02age.Checked,
                                    cbDPIALegalQ02agf.Checked, cbDPIALegalQ02agg.Checked, cbDPIALegalQ02agh.Checked, cbDPIALegalQ02agi.Checked, cbDPIALegalQ02agj.Checked,
                                    cbDPIALegalQ02agk.Checked, cbDPIALegalQ02agl.Checked, cbDPIALegalQ02agm.Checked, cbDPIALegalQ02agn.Checked, cbDPIALegalQ02ago.Checked,
                                    cbDPIALegalQ02agp.Checked, cbDPIALegalQ02agq.Checked, cbDPIALegalQ02agr.Checked, cbDPIALegalQ02ags.Checked, cbDPIALegalQ02agt.Checked,
                                    cbDPIALegalQ02agu.Checked, cbDPIALegalQ02agv.Checked, cbDPIALegalQ02agw.Checked,
                                    DPIALegalQ03, DPIALegalQ04, DPIALegalQ04b,
                                    sDPIALegalQ01aa1CSV, sDPIALegalQ03aCSV, sDPIALegalQ03bCSV, sDPIALegalQ04aCSV, ModifiedUserId)
        If tPDPIA.ReturnValue > 0 Then
            Response.Redirect("~/application/dpia.aspx?summaryid=" & hfProjectID.Value & "&saved=1")
        Else
            Response.Redirect("~/application/dpia.aspx?summaryid=" & hfProjectID.Value & "&saved=0")
        End If


    End Sub

    Private Sub lds_SummaryFiles_Selecting(sender As Object, e As LinqDataSourceSelectEventArgs) Handles lds_SummaryFiles.Selecting
        Dim taP As New DPIAProjectsDataContext

        e.Result = taP.Projects_GetFilesByGroup(hfProjectFileGroup.Value)
    End Sub

    Private Sub lds_SPISummaryFiles_Selecting(sender As Object, e As LinqDataSourceSelectEventArgs) Handles lds_SPISummaryFiles.Selecting
        Dim taP As New DPIAProjectsDataContext

        e.Result = taP.Projects_GetFilesByGroup(hfSPIFileGroup.Value)

    End Sub
End Class