Imports System.Net.Http
Imports System.Net.Http.Headers
Imports System.IO
Imports System.Net
Imports Newtonsoft.Json

Public Class organisation_registration
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Session("OrganisationFileGroupID") = -1
            If Not Page.Request.Item("devtest") Then
                If CInt(Page.Request.Item("devtest")) = 1 Then
                    lbtSearchODSCB.Visible = True
                    btnSearchODS.Visible = False

                End If
            End If
            'If Not Session("UserOrganisationID") Is Nothing Then
            '    cbAutoApprove.Checked = True
            'Else
            '    cbAutoApprove.Checked = False
            'End If
            'ddOrgType.Attributes.Add("onChange", "if ($('#ddOrgType').val() == 33){$('#divOther').collapse.in;}else{$('#divOther').collapse;}")

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
            pnlType.CssClass = "hidden"
            ddOrgType.SelectedValue = 1
            ddOrgType.Enabled = False
            'lbtSearchCancel.Visible = False
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
        Dim sEmail As String = Membership.GetUser().Email
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
        Dim nOrgType As Integer = 1
        If ddOrgType.SelectedValue > 0 Then
            nOrgType = ddOrgType.SelectedValue
        End If
        Dim nRegister As Integer = taOrg.Organisations_Insert_V2(tbOrgName.Text, nOrgType, ddCategory.SelectedValue, tbOtherCategory.Text, ddSponsorOrg.SelectedValue, tbAddress.Text, nUserID, tbEmail.Text, tbUserName.Text, ddRole.SelectedValue, tbICONumber.Text, nFileID, hfLongitude.Text, hfLattitude.Text, tbContact.Text, hfCounty.Text, ddAdminGroup.SelectedValue, tbAliases.Text, tbIdentifiers.Text, bIsLead, bForce)
        If nRegister > 0 Then
            'it worked
            'If they are already registered redirect to default.aspx
            taOrg.FileGroups_UpdateID(nRegister, Session("OrganisationFileGroupID"))
            hlStep1.Enabled = False
            hlStep2.Enabled = False
            hlStep3.Enabled = False
            hlStep4.Enabled = False
            hlComplete.Enabled = True

            lblRegisteredHeading.Text = Replace(StrConv(tbOrgName.Text & " REGISTRATION SUCCESSFUL", VbStrConv.ProperCase), "Nhs", "NHS")
            'Check if a licence has been requested and send an e-mail if so:
            If cbRequestLicence.Checked Then
                Dim taAG As New adminTableAdapters.isp_AdminGroupsTableAdapter
                Dim tAG As New admin.isp_AdminGroupsDataTable
                'Dim taqt As New TicketsTableAdapters.QueriesTableAdapter
                Dim sBody As String = ""
                Dim sSubject As String = ""
                Dim sUserName As String = Session("UserOrgUserName")
                Dim sTicketURL As String = HttpContext.Current.Request.UrlReferrer.GetLeftPart(UriPartial.Authority) & HttpContext.Current.Request.ApplicationPath
                Dim nAGID As Integer = 1
                If ddAdminGroup.SelectedValue > 0 Then
                    nAGID = ddAdminGroup.SelectedValue
                End If
                tAG = taAG.GetByAdminGroupID(nAGID)
                If tAG.Count > 0 Then
                    Dim sAGContactName As String = tAG.First.GroupContact
                    Dim sAGEmail As String = tAG.First.EmailAddress
                    If sAGEmail <> "" And sEmail <> "" Then
                        sBody = "<p>Dear " & sAGContactName & "</p>"
                        If sTicketURL.Contains("sandpit") Then
                            sSubject = "New DPIA Sandpit Organisation Registration Requests Licence - " & tbOrgName.Text & " (ISGID " & nRegister & ")"
                            sBody = sBody & "<p>A newly registered DPIA Sandpit organisation - " & tbOrgName.Text & " -  has requested a franchise licence to be assigned. The registration and licence request was carried out by " & sUserName & " (" & sEmail & ").</p>"
                        Else
                            sSubject = "New DPIA Organisation Registration Requests Licence - " & tbOrgName.Text & " (ISGID " & nRegister & ")"
                            sBody = sBody & "<p>A newly registered DPIA organisation - " & tbOrgName.Text & " -  has requested a franchise licence to be assigned. The registration and licence request was carried out by " & sUserName & " (" & sEmail & ").</p>"
                        End If
                        sBody = sBody & "<p>If appropriate, please assign a licence using the Admin / Organisations tab in the system.</p>"
                        sBody = sBody & "<p>Otherwise, please contact the requestor explaining why a licence has not been assigned.</p>"
                        sBody = sBody & "<p>PLEASE DO NOT REPLY TO THIS E-MAIL. IT WAS SENT FROM AN E-MAIL ADDRESS THAT IS NOT MONITORED.</p>"
                        Utility.SendEmail(sAGEmail, sSubject, sBody, True)
                    End If
                End If

            End If
            Dim sMessage As String
            sMessage = "<p>You have successfully registered the organisation <b>" & Replace(StrConv(tbOrgName.Text, VbStrConv.ProperCase), "Nhs", "NHS") & "</b> on the Data Protection Impact Assessment Tool.</p>"
            sMessage = sMessage & "<p>You have been setup as an <b>Administrator</b> for the organisation.</p><p> Please assign additional user roles and complete your organisational assurance details to complete the setup process.</p>"
            lblRegisteredText.Text = sMessage
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "stepComplete", "<script>$('#hfTabIndex').val('4');$('#myTabs li:eq(4) a').tab('show');</script>")

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
                    dsICOOrgs.SelectParameters(1).DefaultValue = tbIdentifiers.Text
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

    Private Sub lbtStep1Next_Click(sender As Object, e As EventArgs) Handles lbtStep1Next.Click
        Dim ta As New isporganisationsTableAdapters.isp_ODSCategoriesTableAdapter
        Dim t As New isporganisations.isp_ODSCategoriesDataTable
        t = ta.GetData
        Dim odsArray As New ArrayList()
        For Each r As DataRow In t.Rows
            odsArray.Add(String.Join(";", r.ItemArray.Select(Function(item) item.ToString())))
        Next
        If odsArray.IndexOf(ddCategory.SelectedValue) >= 0 Then
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "step1Next", "<script>$('#hfTabIndex').val('1');$('#myTabs li:eq(1) a').tab('show');</script>")
        Else
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "step1Next", "<script>$('#hfTabIndex').val('2');$('#myTabs li:eq(2) a').tab('show');</script>")
        End If
    End Sub

    Private Sub lbtStep2Next_Click(sender As Object, e As EventArgs) Handles lbtStep2Next.Click
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "step2Next", "<script>$('#hfTabIndex').val('2');$('#myTabs li:eq(2) a').tab('show');</script>")
    End Sub

    Private Sub btnFinish_Click(sender As Object, e As EventArgs) Handles btnFinish.Click
        If Not Session("UserOrganisationID") Is Nothing Then
            Response.Redirect("~/Default.aspx")
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
    End Sub

    Private Sub ddAdminGroup_DataBound(sender As Object, e As EventArgs) Handles ddAdminGroup.DataBound
        If Not Session("OrgAdminGroupID") Is Nothing Then
            If Not ddAdminGroup.Items.FindByValue(Session("OrgAdminGroupID")) Is Nothing Then
                ddAdminGroup.SelectedValue = Session("OrgAdminGroupID")
            End If
        ElseIf Not Session("plAdminGroupID") Is Nothing Then
            If Not ddAdminGroup.Items.FindByValue(Session("plAdminGroupID")) Is Nothing Then
                ddAdminGroup.SelectedValue = Session("plAdminGroupID")
            End If
        End If
    End Sub

    Private Sub lbtSearchODSCB_Click(sender As Object, e As EventArgs) Handles lbtSearchODSCB.Click

        '"https://directory.spineservices.nhs.uk/ORD/2-0-0/organisations?Name=preston&Limit=500&Status=Active" This string works correctly from the browser URL search
        '"/application/organisation_registration.aspx?devtest=1"
        Dim apiUrl As String = "https://directory.spineservices.nhs.uk/"
        Dim sSearchStr As String = tbODSSearch.Text.Trim()
        Dim input As Object = New With {Key .Name = sSearchStr}
        Dim rxSearch As New Regex("([Gg][Ii][Rr] 0[Aa]{2})|((([A-Za-z][0-9]{1,2})|(([A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2})|(([A-Za-z][0-9][A-Za-z])|([A-Za-z][A-Ha-hJ-Yj-y][0-9][A-Za-z]?))))\s?[0-9][A-Za-z]{2})")
        Dim rxMatch As Match = rxSearch.Match(sSearchStr)
        Dim sParams As String
        'Dim request As HttpWebRequest
        'Dim response As HttpWebResponse = Nothing
        'Dim reader As StreamReader


        If rxMatch.Success Then
            'It's a postcode:
            sParams = "ORD/2-0-0/organisations" + "?PostCode=" + sSearchStr.Replace(" ", "+") + "&Limit=500&Status=Active"
        Else
            'It's not a postcode:
            sParams = "ORD/2-0-0/organisations" + "?Name=" + sSearchStr.Replace(" ", "+") + "&Limit=500&Status=Active"
        End If

        'request = DirectCast(WebRequest.Create(apiUrl + sParams), HttpWebRequest)
        ' Get response  
        'response = DirectCast(request.GetResponse(), HttpWebResponse)
        ' Get the response stream into a reader  
        'reader = New StreamReader(response.GetResponseStream())
        'Dim request As WebRequest = WebRequest.Create(apiUrl + sParams)
        'request.AuthenticationLevel = SecurityProtocolType.Tls12
        'Dim response As WebResponse = request.GetResponse()
        'client.DefaultRequestHeaders.Accept.Add(New MediaTypeWithQualityHeaderValue("application/json"))

        System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12
        Dim client As HttpClient = New HttpClient With {.BaseAddress = New Uri(apiUrl)}
        Dim response As HttpResponseMessage = client.GetAsync(sParams).Result
        '.Result
        If response.IsSuccessStatusCode Then
            lblModalHeading.Text = "Response from ODS API!"
            'Dim json1 = response.Content.ReadAsStringAsync
            'Dim json2 = response.Content.ToString

            lblModalText.Text = response.StatusCode.ToString + " " + response.Content.Headers.ToString
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModal", "<script>$('#modalMessage').modal('show');</script>")
        End If
    End Sub
End Class