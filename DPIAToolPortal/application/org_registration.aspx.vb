Public Class org_registration
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
			Session("OrganisationFileGroupID") = -1
			If Session("OrgAdminGroupID") = 0 Then
				divNoAdminWarning.Visible = True
			Else
				divNoAdminWarning.Visible = False
            End If

        End If
        Dim sEmail As String = Membership.GetUser().Email
        tbEmail.Text = sEmail
        tbEmail.Enabled = False
        If Not Session("UserOrganisationID") Is Nothing Then

            ddOrgType.SelectedValue = 2
            ddOrgType.Enabled = False
            divSponsorOrg.Visible = True
            ddSponsorOrg.SelectedValue = Session("UserOrganisationID")
            tbUserName.Text = Session("UserOrgUserName")
            tbUserName.Enabled = False
            ddSponsorOrg.Enabled = False
            ddRole.SelectedValue = 5
            ddRole.Enabled = False
        Else
            lbtSearchCancel.Visible = False
            btnRegCancel.Visible = False
        End If
    End Sub

    Private Sub cbConfirm_CheckedChanged(sender As Object, e As EventArgs) Handles cbConfirm.CheckedChanged
        If cbConfirm.Checked Then
            rptFiles.DataBind()
            divEvidence.Visible = True
            btnSubmit.Enabled = True
        Else
            btnSubmit.Enabled = False
            divEvidence.Visible = False
        End If
    End Sub

    Private Sub ddOrgType_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddOrgType.SelectedIndexChanged
        If ddOrgType.SelectedValue = 2 Then
            divSponsorOrg.Visible = True
            cvSponsorOrg.Enabled = True
        Else
            divSponsorOrg.Visible = False
            cvSponsorOrg.Enabled = False
        End If
    End Sub

    Private Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click, lbtConfirmICODup.Click
        'If Page.IsValid Then
        Dim nUserID As Guid = Membership.GetUser().ProviderUserKey
        Dim taQ As New ispregistrationTableAdapters.QueriesTableAdapter
        Dim taOrg As New isporganisationsTableAdapters.QueriesTableAdapter
        Dim nFileID As Integer
        If filEvidence.PostedFile IsNot Nothing Then

            'Dim sExtension As String = System.IO.Path.GetExtension(Me.filEvidence.PostedFile.FileName).ToLower()
            Dim sFilename As String = System.IO.Path.GetFileName(Me.filEvidence.PostedFile.FileName)
            Dim nMaxKB As Integer = 256
            If Me.filEvidence.PostedFile.InputStream.Length > nMaxKB * 1024 Then
                lblModalHeading.Text = "Evidence file too big"
                Me.lblModalText.Text = sFilename + " is too big. Maximum file size is " + nMaxKB.ToString() + "K."
                Exit Sub
            End If
            Dim size As Integer = Me.filEvidence.PostedFile.ContentLength
            Dim sContentType As String = filEvidence.PostedFile.ContentType
            Dim fileData As Byte() = New Byte(size - 1) {}
            Me.filEvidence.PostedFile.InputStream.Read(fileData, 0, size)
            nFileID = taQ.InsertFile(sFilename, sContentType, Me.filEvidence.PostedFile.InputStream.Length / 1024, fileData, Session("UserOrganisationID"), Session("UserEmail"))
        End If
        If nFileID < 1 Then
            nFileID = Nothing
        End If
        Dim bForce As Boolean = False
        Dim lbt As LinkButton = TryCast(sender, LinkButton)
        If Not lbt Is Nothing Then
            If lbt.ID = "lbtConfirmICODup" Then
                bForce = True
            End If
        End If
        Dim bIsLead As Boolean = True
        Dim nRegister As Integer = taOrg.Organisations_Insert(tbOrgName.Text, ddOrgType.SelectedValue, ddSponsorOrg.SelectedValue, tbAddress.Text, nUserID, tbEmail.Text, tbUserName.Text, ddRole.SelectedValue, tbICONumber.Text, nFileID, hfLongitude.Text, hfLattitude.Text, tbContact.Text, hfCounty.Text, Session("OrgAdminGroupID"), tbAliases.Text, tbIdentifiers.Text, bIsLead, bForce)
        If nRegister > 0 Then
            'it worked
            'If they are already registered redirect to default.aspx
            taOrg.FileGroups_UpdateID(nRegister, Session("OrganisationFileGroupID"))
            If Not Session("UserOrganisationID") Is Nothing Then
                lblRegisteredHeading.Text = Replace(StrConv(tbOrgName.Text & " REGISTRATION SUCCESSFUL", VbStrConv.ProperCase), "Nhs", "NHS")
                Dim sMessage As String
                sMessage = "<p>You have successfully registered the organisation <b>" & Replace(StrConv(tbOrgName.Text, VbStrConv.ProperCase), "Nhs", "NHS") & "</b> on the Data Protection Impact Assessment Tool.</p>"
                sMessage = sMessage & "<p>You have been setup as an <b>Administrator</b> for the organisation.</p><p> Please assign additional user roles and complete your organisational assurance details to complete the setup process.</p>"
                lblRegisteredText.Text = sMessage
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalRegistered", "<script>$('#modalSponsorRegistered').modal('show');</script>")
                'Response.Redirect("~/Default.aspx")
            Else
                'setup and send e-mail
                Dim bSent As Boolean = Utility.SendVerificationEmail(tbEmail.Text)
                If bSent Then
                    Response.Redirect("~/Account/Verify.aspx")
                Else
                    lblModalHeading.Text = "Error Sending Verification E-mail"
                    lblModalText.Text = "Organisation registration was successful but attempts to send a verification message to the e-mail address " & tbEmail.Text & " failed. Please report this fault to the technical team."
                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModal", "<script>$('#modalMessage').modal('show');</script>")
                End If
            End If
        Else
            'Handle errors
            '-1 = unknown error
            '-10 = Organisation name already exists
            '-11 = User already has active centre registration
            Select Case nRegister
                Case -1
                    lblModalHeading.Text = "Error: Unknown"
                    lblModalText.Text = "An unexpected error occured registering your organisation. Please report this fault to the technical team."
                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModal", "<script>$('#modalMessage').modal('show');</script>")
                    'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ShowModalAdded", "$('#modalMessage').modal('show');", True)
                Case -10
                    lblModalHeading.Text = "Error: Organisation Already Exists"
                    lblModalText.Text = "An organisation with exactly the same name as the one you provided already exists in the Data Protection Impact Assessment Tool. Please consult with your colleagues and ask them to set you up with access to the Data Protection Impact Assessment Tool. If you believe you are receiving this message in error, please contact dpiatool@mbhci.nhs.uk or using the Contact tab for assistance."

                    'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ShowModalAdded", "$('#modalMessage').modal('show');", True)
                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModal", "<script>$('#modalMessage').modal('show');</script>")
                Case -11
                    'lblModalHeading.Text = "Error: ICO Number Already Registered"
                    'lblModalText.Text = "An organisation with exactly the same ICO number as the one you provided already exists in the Data Protection Impact Assessment Tool. Please consult with your colleagues and ask them to set you up with access to the Data Protection Impact Assessment Tool. If you believe you are receiving this message in error, please contact dpiatool@mbhci.nhs.uk or using the Contact tab for assistance."
                    dsICOOrgs.SelectParameters(0).DefaultValue = tbICONumber.Text
                    rptICOOrgs.DataBind()
                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModal", "<script>$('#modalICOExists').modal('show');</script>")
                    'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ShowModalAdded", "$('#modalMessage').modal('show');", True)
                Case Else
                    lblModalHeading.Text = "Error: Unknown, Code:" & nRegister.ToString()
                    lblModalText.Text = "An unexpected error occured registering your organisation. Please report this fault to the technical team."
                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModal", "<script>$('#modalMessage').modal('show');</script>")
                    'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ShowModalAdded", "$('#modalMessage').modal('show');", True)
            End Select
            'Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModal", "<script>$('#modalMessage').modal('show');</script>")
            'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ShowModalAdded", "$('#modalMessage').modal('show');", True)
        End If
        'End If
    End Sub

    Private Sub btnLookup_Click(sender As Object, e As EventArgs) Handles btnLookup.Click
        divInst.Visible = False
        Dim sRegNum As String = tbICONumber.Text
        Dim sOrgSearch As String = tbOrgName.Text.Replace(" ", "%")
        Dim taICO As New isporganisationsTableAdapters.isp_ICO_RegisterTableAdapter
        Dim tICO As New isporganisations.isp_ICO_RegisterDataTable
        If sRegNum.Length > 1 Then
            tICO = taICO.GetDataByRegNum(sRegNum)
        Else
            tICO = taICO.GetDataByOrgName(sOrgSearch)
        End If
        If tICO.Count = 0 Then
            lblModalHeading.Text = "Organisation not Found"
            lblModalText.Text = "No organisations matched your search criteria. All organisations registered with the ICO for more than 1 month should be matched. Please modify your criteria and search again. If you are sure you cannot find a match for your organisation, please provide full details manually in the registration form."
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalAdded", "<script>$('#modalMessage').modal('show');</script>")
            'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ShowModalAdded", "$('#modalMessage').modal('show');", True)
            'something here to change placeholder text 
        ElseIf tICO.Count = 1 Then
            PopulateDetailsFromICO(tICO)
        Else
            gvICORes.DataSource = tICO
            gvICORes.DataBind()
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalCentreLookup", "<script>$('#modalCentreLookup').modal('show');</script>")
            'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ShowModalCentreLookup", "$('#modalCentreLookup').modal('hide');", True)
        End If

    End Sub

    Private Sub gvICORes_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvICORes.RowCommand
        Dim sRegNum As String = e.CommandArgument
        Dim taICO As New isporganisationsTableAdapters.isp_ICO_RegisterTableAdapter
        Dim tICO As New isporganisations.isp_ICO_RegisterDataTable
        tICO = taICO.GetDataByRegNum(sRegNum)

        If tICO.Count = 0 Then
            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "HideModalCentreLookup", "$('#modalCentreLookup').modal('hide');", True)
            lblModalHeading.Text = "Organisation not Found"
            lblModalText.Text = "No organisations matched your search criteria. All organisations registered with the ICO for more than 1 month should be matched. Please modify your criteria and search again. If you are sure you cannot find a match for your organisation, please provide full details manually in the registration form."
            'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ShowModalAdded", "$('#modalMessage').modal('show');", True)
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalAdded", "<script>$('#modalMessage').modal('show');</script>")
            'something here to change placeholder text 
        ElseIf tICO.Count = 1 Then
            PopulateDetailsFromICO(tICO)
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "HideModalCentreLookup", "<script>$('#modalCentreLookup').modal('hide');</script>")
            'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "HideModalCentreLookup", "$(document).ready(function () {$('#modalCentreLookup').modal('hide');});", True)
        End If

    End Sub
    Private Sub PopulateDetailsFromICO(ByVal tICO As isporganisations.isp_ICO_RegisterDataTable)
        tbOrgName.Text = tICO.First.Organisation_name
        Dim sAddressStr As String = tICO.First.Address1 + Environment.NewLine + tICO.First.Address2 + Environment.NewLine + tICO.First.Address3 + Environment.NewLine + tICO.First.Address4 + Environment.NewLine + tICO.First.Address5 + Environment.NewLine + tICO.First.Postcode
        sAddressStr = sAddressStr.Replace("" + Environment.NewLine + Environment.NewLine + "", "" + Environment.NewLine + "")
        sAddressStr = sAddressStr.Replace("" + Environment.NewLine + Environment.NewLine + "", "" + Environment.NewLine + "")
        sAddressStr = sAddressStr.Replace("" + Environment.NewLine + Environment.NewLine + "", "" + Environment.NewLine + "")
        sAddressStr = sAddressStr.Trim()
        tbAddress.Text = sAddressStr
        tbICONumber.Text = tICO.First.Registration_number
        tbAliases.Text = tICO.First.Trading_names
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "GetGeo", "<script>getGeoCode();</script>")
    End Sub
    Private Sub rptFiles_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles rptFiles.ItemCommand
        If e.CommandName = "Delete" Then
            Dim taq As New ispregistrationTableAdapters.QueriesTableAdapter
            taq.File_Delete(CInt(e.CommandArgument))
            rptFiles.DataBind()
        End If
    End Sub
    Private Sub lbtUpload_Click(sender As Object, e As EventArgs) Handles lbtUpload.Click
        Dim nOrganisationID = 0
        Dim taq As New ispregistrationTableAdapters.QueriesTableAdapter
        If Not Session("nOrganisationID") Is Nothing Then
            nOrganisationID = Session("nOrganisationID")
        End If
        If Session("OrganisationFileGroupID") = -1 Then
            Session("OrganisationFileGroupID") = taq.isp_FileGroup_Insert("organisation", nOrganisationID)
        End If
        If filEvidence.PostedFiles.Count > 0 Then
            Dim bShowWarning As Boolean = 0
            Me.lblModalText.Text = ""
            Dim nFileID As Nullable(Of Integer)
            Dim sFilename As String = ""
            For Each pFile As HttpPostedFile In filEvidence.PostedFiles
                'Dim sExtension As String = System.IO.Path.GetExtension(Me.filEvidence.PostedFile.FileName).ToLower()
                sFilename = System.IO.Path.GetFileName(pFile.FileName)
                Dim nMaxKB As Integer = 256
                If pFile.InputStream.Length > nMaxKB * 1024 Then
                    lblModalHeading.Text = "Evidence file too big"
                    Me.lblModalText.Text = Me.lblModalText.Text + "<p>" + sFilename + " is too big. Maximum file size is " + nMaxKB.ToString() + "K." + "</p>"
                    bShowWarning = True
                Else
                    Dim size As Integer = pFile.ContentLength
                    Dim sContentType As String = pFile.ContentType
                    Dim fileData As Byte() = New Byte(size - 1) {}
                    pFile.InputStream.Read(fileData, 0, size)
                    nFileID = taq.InsertFile(sFilename, sContentType, pFile.InputStream.Length / 1024, fileData, Session("UserOrganisationID"), Session("UserEmail"))
                    If nFileID > 0 Then
                        taq.FileGroupFile_Insert(Session("OrganisationFileGroupID"), nFileID)
                    Else
                        lblModalHeading.Text = "Evidence file error"
                        Me.lblModalText.Text = Me.lblModalText.Text + "<p>" + sFilename + " failed to upload due to an unknown error. </p>"
                        bShowWarning = True
                    End If
                End If
            Next

            rptFiles.DataBind()
            If bShowWarning Then
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "msgFileTooBig", "<script>$('#modalMessage').modal('show');</script>")
            End If
        End If
    End Sub

	Private Sub ddRole_DataBound(sender As Object, e As EventArgs) Handles ddRole.DataBound
		ddRole.SelectedValue = 5
	End Sub

End Class