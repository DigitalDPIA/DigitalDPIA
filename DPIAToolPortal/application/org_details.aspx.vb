Public Class org_details
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserRoleAdmin") = False Then
            Dim btn As LinkButton = fvCentreDetails.FindControl("EditButton")
            btn.Visible = False
            btn = fvCentreDetails.FindControl("lbtRequestClosure")
            btn.Visible = False
        End If
    End Sub
    Protected Function FixCrLf(value As String) As String
        If String.IsNullOrEmpty(value) Then Return String.Empty
        value = value.Replace(vbCr & vbLf, "<br />")
        value = value.Replace(vbLf, "<br />")
        Return value.Replace(Environment.NewLine, "<br />")
    End Function
    Protected Function PadID(value As Integer) As String

        Dim fmt As String = "ORG000000"
        Dim str As String = value.ToString(fmt)
        Return str
    End Function
    Protected Sub ddOrgType_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddOrgType As DropDownList = TryCast(sender, DropDownList)
        Dim divSponsorOrg As Panel = TryCast(Me.fvCentreDetails.FindControl("divSponsorOrg"), Panel)
        Dim cvSponsorOrg As CompareValidator = TryCast(Me.fvCentreDetails.FindControl("cvSponsorOrg"), CompareValidator)
        If ddOrgType.SelectedValue = 2 Then
            divSponsorOrg.Visible = True
            cvSponsorOrg.Enabled = True
        Else
            divSponsorOrg.Visible = False
            cvSponsorOrg.Enabled = False
        End If
    End Sub

    Private Sub lbtUploadEvidenceOK_Click(sender As Object, e As EventArgs) Handles lbtUploadEvidenceOK.Click
        Dim nUserID As Guid = Membership.GetUser().ProviderUserKey
        Dim taQ As New ispregistrationTableAdapters.QueriesTableAdapter
        Dim nFileGroupID As Integer = taQ.isp_FileGroup_Insert("organisation", Session("UserOrganisationID"))
        If filEvidence.PostedFiles.Count > 0 Then
            Dim bShowWarning As Boolean = 0
            Me.lblModalText.Text = ""
            Dim nFileID As Nullable(Of Integer)
            Dim sFilename As String = ""
            For Each pFile As HttpPostedFile In filEvidence.PostedFiles
                'Dim sExtension As String = System.IO.Path.GetExtension(Me.filEvidence.PostedFile.FileName).ToLower()
                sFilename = System.IO.Path.GetFileName(pFile.FileName)
                Dim nMaxKB As Integer = 5000
                If pFile.InputStream.Length > nMaxKB * 1024 Then
                    lblModalHeading.Text = "Evidence file too big"
                    Me.lblModalText.Text = Me.lblModalText.Text + "<p>" + sFilename + " is too big. Maximum file size is " + nMaxKB.ToString() + "K." + "</p>"
                    bShowWarning = True
                Else
                    Dim size As Integer = pFile.ContentLength
                    Dim sContentType As String = pFile.ContentType
                    Dim fileData As Byte() = New Byte(size - 1) {}
                    pFile.InputStream.Read(fileData, 0, size)
                    nFileID = taQ.InsertFile(sFilename, sContentType, pFile.InputStream.Length / 1024, fileData, Session("UserOrganisationID"), Session("UserEmail"))
                    If nFileID > 0 Then
                        taQ.FileGroupFile_Insert(nFileGroupID, nFileID)
                    Else
                        lblModalHeading.Text = "Evidence file error"
                        Me.lblModalText.Text = Me.lblModalText.Text + "<p>" + sFilename + " failed to upload due to an unknown error. </p>"
                        bShowWarning = True
                    End If
                End If
            Next
            If bShowWarning Then
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "msgFileTooBig", "<script>$('#modalMessage').modal('show');</script>")
            End If
        End If
        fvCentreDetails.DataBind()
    End Sub
    Protected Sub dsFilesSelected(sender As Object, e As ObjectDataSourceStatusEventArgs)
        If e.Exception Is Nothing Then
            Dim pnl As Panel = fvCentreDetails.FindControl("divEvidence")
            Dim btn As LinkButton = fvCentreDetails.FindControl("btnAddEvidence")
            If Not pnl Is Nothing Then

                Dim nRows As Integer = e.ReturnValue.Rows.Count
                If nRows > 0 Then
                    btn.Visible = False
                    pnl.Visible = True
                Else
                    btn.Visible = True
                    pnl.Visible = False
                End If
            End If
        End If
    End Sub
    Protected Sub dsPNFiles_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs)
        If e.Exception Is Nothing Then
            Dim pnl As Panel = fvCentreDetails.FindControl("pnlPNFiles")
            If Not pnl Is Nothing Then
                Dim nRows As Integer = e.ReturnValue.Rows.Count
                If nRows > 0 Then
                    pnl.Visible = True
                Else
                    pnl.Visible = False
                    Dim pnl2 As Panel = fvCentreDetails.FindControl("pnlPrivacyURL")
                    If Not pnl2 Is Nothing Then
                        If Not pnl2.Visible Then
                            Dim pnl3 As Panel = fvCentreDetails.FindControl("pnlPrivacy")
                            Dim lbl As Label = fvCentreDetails.FindControl("lblNoPrivacyNotice")
                            If Not pnl3 Is Nothing And Not lbl Is Nothing Then
                                pnl3.CssClass = "panel panel-danger"
                                lbl.Visible = True
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub


    Private Sub fvCentreDetails_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles fvCentreDetails.ItemCommand
        If e.CommandName = "CloseOrg" Then
            Dim taq As New isporgusersTableAdapters.QueriesTableAdapter
            lblSeniorUsers.Text = taq.GetSeniorUserEmails(Session("UserOrganisationID"))
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "modalCloseRequest", "<script>$('#modalRequestClose').modal('show');</script>")
        End If
    End Sub

    Private Sub lbtRequestCloseConfirm_Click(sender As Object, e As EventArgs) Handles lbtRequestCloseConfirm.Click
        Dim sSubject As String
        Dim sBody As String
        Dim taAG As New adminTableAdapters.isp_AdminGroupsTableAdapter
        Dim tag As New admin.isp_AdminGroupsDataTable
        Dim nAG As Integer = Session("OrgAdminGroupID")
        If nAG = 0 Then
            nAG = 1
        End If
        tag = taAG.GetByAdminGroupID(nAG)
        Dim sTo As String = ""
        If Not Session("orgSupportAdmin") Is Nothing Then
            sTo = Session("orgSupportAdmin")
        End If
        If sTo.Trim() = "" Then
            sTo = tag.First.EmailAddress
        End If
        Dim sCC As String = ""
        If Not sTo.ToString = "isg@mbhci.nhs.uk" Then
            sCC = "isg@mbhci.nhs.uk "
        End If
        sSubject = "Request for Closure of DPIA Organisation - " & Session("UserOrganisationName")
        sBody = "<p>Dear DPIA Administrator</p>"
        sBody = sBody & "<p><a href='mailto:" & Session("UserEmail") & "'>" & Session("UserOrgUserName") & "</a> has requested that the organisation <b>" & Session("UserOrganisationName") & "</b> be removed from the Data Protection Impact Assessment Tool.</p>"
        Dim taOrg As New isporganisationsTableAdapters.isp_OrganisationsTableAdapter
        If tbReason.Text.Length > 0 Then
            sBody = sBody & "<p>The reason given for the request for removal of the organisation is: <i>" & tbReason.Text & "</i></p>"
            taOrg.RequestClosure(tbReason.Text, Session("UserOrganisationID"))
        Else
            sBody = sBody & "<p>No reason was given by the user for the request for removal of the organisation.</p>"
            taOrg.RequestClosure("No reason given.", Session("UserOrganisationID"))
        End If
        sBody = sBody & "<p>This request was submitted from " & HttpContext.Current.Request.Url.Host & ".</p>"

        sCC = sCC & lblSeniorUsers.Text
        Dim bSent As Boolean = Utility.SendEmail(sTo, sSubject, sBody, True, , sCC)
        fvCentreDetails.DataBind()
        If bSent Then
            modalTitle.Text = "Request Submitted"
            Me.modalText.Text = "Your request to remove this organisation from the DPIA has been submitted. The request has been CCd to all Senior Officers at the organisation.</p>"
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "msgRequested", "<script>$('#modalMessage').modal('show');</script>")
        End If
    End Sub

    Protected Sub lbtUploadPrivacyNotice_Click(sender As Object, e As EventArgs)
        Dim nUserID As Guid = Membership.GetUser().ProviderUserKey
        Dim taQ As New ispregistrationTableAdapters.QueriesTableAdapter
        Dim nFileGroupID As Integer = taQ.isp_FileGroup_Insert("orgprivacy", Session("UserOrganisationID"))
        Dim fil As FileUpload = fvCentreDetails.FindControl("filPrivacyNotice")
        If Not fil Is Nothing Then
            If fil.PostedFiles.Count > 0 Then
                Dim bShowWarning As Boolean = 0
                Me.lblModalText.Text = ""
                Dim nFileID As Nullable(Of Integer)
                Dim sFilename As String = ""
                For Each pFile As HttpPostedFile In fil.PostedFiles
                    'Dim sExtension As String = System.IO.Path.GetExtension(Me.filEvidence.PostedFile.FileName).ToLower()
                    sFilename = System.IO.Path.GetFileName(pFile.FileName)
                    Dim nMaxKB As Integer = 5000
                    If pFile.InputStream.Length > nMaxKB * 1024 Then
                        lblModalHeading.Text = "Privacy Notice file too big"
                        Me.lblModalText.Text = Me.lblModalText.Text + "<p>" + sFilename + " is too big. Maximum file size is " + nMaxKB.ToString() + "K." + "</p>"
                        bShowWarning = True
                    Else
                        Dim size As Integer = pFile.ContentLength
                        Dim sContentType As String = pFile.ContentType
                        Dim fileData As Byte() = New Byte(size - 1) {}
                        pFile.InputStream.Read(fileData, 0, size)
                        nFileID = taQ.InsertFile(sFilename, sContentType, pFile.InputStream.Length / 1024, fileData, Session("UserOrganisationID"), Session("UserEmail"))
                        If nFileID > 0 Then
                            taQ.FileGroupFile_Insert(nFileGroupID, nFileID)
                        Else
                            lblModalHeading.Text = "Privacy notice file error"
                            Me.lblModalText.Text = Me.lblModalText.Text + "<p>" + sFilename + " failed to upload due to an unknown error. </p>"
                            bShowWarning = True
                        End If
                    End If
                Next
                If bShowWarning Then
                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "msgFileTooBig", "<script>$('#modalMessage').modal('show');</script>")
                End If
                Dim rpt As Repeater = fvCentreDetails.FindControl("rptPrivacyFiles")
                If Not rpt Is Nothing Then
                    rpt.DataBind()
                End If
            End If
        End If

    End Sub
    Protected Sub rptFiles_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If e.CommandName = "Delete" Then
            Dim taq As New ispregistrationTableAdapters.QueriesTableAdapter
            taq.File_Delete(CInt(e.CommandArgument))
            Dim rpt As Repeater = fvCentreDetails.FindControl("rptPrivacyFiles")
            If Not rpt Is Nothing Then
                rpt.DataBind()
            End If
        End If
    End Sub

    Private Sub dsOrganisation_Updated(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsOrganisation.Updated
        If e.ReturnValue = 0 Then
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "modalSupportingError", "<script>$('#modalSupportingError').modal('show');</script>")
        Else
            Dim taq As New isporganisationsTableAdapters.QueriesTableAdapter
            taq.UpdateOrganisationAssurance(Session("UserOrganisationID"))
        End If
    End Sub
End Class