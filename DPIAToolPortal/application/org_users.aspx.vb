Imports DevExpress.Web.Bootstrap

Public Class org_users
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        listRolesEdit.DataBind()
        If Session("UserRoleAdmin") = False Then

            'daGridviewControlPanel.Visible = False
            lbtAdd.Visible = False
        End If
        If Not Page.IsPostBack Then
            Dim taq As New isporgusersTableAdapters.QueriesTableAdapter
            Dim nDPO As Integer = taq.CountDPOsForOrg(Session("UserOrganisationID"))
            If nDPO = 0 Then
                pnlNoDPO.Visible = True
            Else
                pnlNoDPO.Visible = False
            End If
        End If

    End Sub

    Private Sub lbtAdd_Click(sender As Object, e As EventArgs) Handles lbtAdd.Click
        BindRolesAdd()
        Me.mvOrgUsers.SetActiveView(vAddUser)
    End Sub

    Private Sub lbtCancelInsert_Click(sender As Object, e As EventArgs) Handles lbtCancelInsert.Click
        CloseAdd()
    End Sub
    Protected Sub BindRolesAdd()
        listRolesAdd.Items.Clear()
        Dim taRoles As New isporgusersTableAdapters.isp_RolesTableAdapter
        Dim tRoles As isporgusers.isp_RolesDataTable = taRoles.GetAvailableRoles(Session("UserOrganisationID"))

        For Each r As DataRow In tRoles.Rows
            Dim li As New ListItem
            li.Text = r.Item(1)
            li.Value = r.Item(0)
            If CBool(r.Item(2)) = False Then
                li.Attributes("disabled") = "disabled"
            End If
            listRolesAdd.Items.Add(li)
            'listRolesAdd.Items.Add(New ListItem(r.Item(1), r.Item(0)) With {.Enabled = CBool(r.Item(2))})
        Next
    End Sub

    Protected Sub BindRoleList(ByVal sEmail As String)
        listRolesEdit.Items.Clear()
        Dim taRoles As New isporgusersTableAdapters.isp_RolesTableAdapter
        Dim tRoles As isporgusers.isp_RolesDataTable = taRoles.GetActiveByUserOrg(sEmail, Session("UserOrganisationID"))
        For Each r As DataRow In tRoles.Rows
            listRolesEdit.Items.Add(New ListItem(r.Item(1), r.Item(0)) With {.Selected = CBool(r.Item(2))})
        Next
    End Sub

    Protected Sub CloseAdd()
        tbOrganisationUserEmail.Text = ""
        tbOrganisationUserName.Text = ""
        listRolesAdd.Items.Clear()
        ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "HideValidation", "$('.popover').hide();", True)
        Me.mvOrgUsers.SetActiveView(vUserGrid)
    End Sub

    Private Sub lbtInsertUser_Click(sender As Object, e As EventArgs) Handles lbtInsertUser.Click
        lblErrorDetail.Visible = False
        lblErrorHead.Visible = False
        Dim taUsers As New isporgusersTableAdapters.isp_OrganisationUsersTableAdapter
        Dim sHash As String = ""
        Dim sEmail As String = tbOrganisationUserEmail.Text
        Dim tUsers As New isporgusers.isp_OrganisationUsersDataTable
        Dim nInsertResult As Integer = 0
        tUsers = taUsers.GetRolesByUser(sEmail, Session("UserOrganisationID"))
        If tUsers.Count > 0 Then
            lblModalHeading.Text = "Error: User already exists"
            lblModalText.Text = "There is a user with the same e-mail address at this organisation. Please edit their existing record to add new roles."
        Else

            Dim sRoles As String = ""
            For Each li As ListItem In listRolesAdd.Items
                If li.Selected Then
                    Dim nOrg As Integer = Session("UserOrganisationID")
                    Dim sOrganisationName As String = tbOrganisationUserName.Text
                    Dim nRoleID As Integer = li.Value
                    nInsertResult = taUsers.InsertQuery(nOrg, sOrganisationName, sEmail, nRoleID)
                    If nInsertResult > 0 Then
                        'it worked, add this role to the list of roles given
                        sRoles = sRoles & li.Text & ", "
                        tUsers = taUsers.GetByOrganisationUserID(nInsertResult)
                        If sHash = "" Then
                            sHash = tUsers.First.ConfirmationHash.ToString()
                        End If
                    End If
                End If
            Next
            'Trim the roles string to remove the trailing , :
            sRoles = sRoles.Substring(0, sRoles.Length - 2)
            'check whether they are already registered:
            Dim taVerifyByEmail As New isporgusersTableAdapters.VerifyByEmailTableTableAdapter
            Dim tVerifyByEmail As New isporgusers.VerifyByEmailTableDataTable
            tVerifyByEmail = taVerifyByEmail.GetData(sEmail)
            Dim sMsg As String = ""
            Dim sbBody As New StringBuilder
            sbBody.Append("<p>Dear " & StrConv(tbOrganisationUserName.Text, VbStrConv.ProperCase) & ",</p>")

            Dim sSubject As String = ""
            Dim bSend As Boolean = True
            Dim bSent As Boolean
            Dim sPageName As String = HttpContext.Current.Request.UrlReferrer.GetLeftPart(UriPartial.Authority) & HttpContext.Current.Request.ApplicationPath

            'Work out which message to send them:
            If tVerifyByEmail.Count > 0 Then
                sPageName = sPageName & "default.aspx"
                If tVerifyByEmail.First.Confirmed = True Then
                    'already verified so send e-mail informing of new role:
                    sSubject = "Data Protection Impact Assessment Tool User Added"
                    sbBody.Append("<p>You have been given the role(s) of " & sRoles & " at " & Replace(StrConv(Session("UserOrganisationName"), VbStrConv.ProperCase), "Nhs", "NHS") & ".</p>")
                    sbBody.Append("<p>You are already registered and your registration has been verified. You will be able to access the Data Protection Impact Assessment Tool under this role / these roles when you next log in to the <a href='" & sPageName & "'>Data Protection Impact Assessment Tool</a>.</p>")
                    sbBody.Append("<p>You were given this role by <a href='mailto:" & Session("UserEmail") & "'>" & Session("UserOrgUserName") & " (" & Session("UserEmail") & ")</a>. If you have any queries about your role  or what to do next, please contact them.</p>")

                    sMsg = "The user is already registered and verified. An e-mail has been sent informing them of their new access role(s)."
                Else
                    'not verified, send verification e-mail:
                    bSend = False
                    bSent = Utility.SendVerificationEmail(sEmail)
                    sMsg = "The user is registered but not verified. An e-mail has been sent asking them to verify their registration."
                End If
            Else
                Dim sAboutURL As String = sPageName & "About"
                sPageName = sPageName & "Account/Register.aspx?pwdr=" & sHash & "&user=" & nInsertResult.ToString()
                'not registered, send registration invite:
                sMsg = "The user is not yet registered. An e-mail has been sent inviting them to register. <br/>Once registered and verified, they will have access to the system in the role(s) you set.</p>"
                sSubject = "Data Protection Impact Assessment Tool - Invitation to Register"
                sbBody.Append("<p>You have been added as a user of the Data Protection Impact Assessment Tool (DPIA) by <a href='mailto:" & Session("UserEmail") & "'>" & Session("UserOrgUserName") & " (" & Session("UserEmail") & ")</a>. You have been given the role(s) of " & sRoles & " at the organisation named " & Replace(StrConv(Session("UserOrganisationName"), VbStrConv.ProperCase), "Nhs", "NHS") & ".</p>")
                sbBody.Append("<p>You are are not yet registered to access the Data Protection Impact Assessment Tool.</p><p style='font-size:150%;'>Please visit the <a href='" & sPageName & "'>DPIA registration page</a> to register and access the DPIA in this role. </p>")
                sbBody.Append("<p>For more information about the DPIA, please click <a href='" & sAboutURL & "'>HERE</a>.")

            End If
            If bSend Then
                bSent = Utility.SendEmail(sEmail, sSubject, sbBody.ToString(), True)
            End If

            If bSent Then
                'Show modal confirmation:
                lblModalHeading.Text = "User Added and E-mail Notification Sent"
                lblModalText.Text = sMsg
            Else
                lblModalHeading.Text = "User Added but E-mail Notification Failed"
                lblModalText.Text = "An unknown error occured when attempting to send an e-mail to the user, please contact the technical team for advice."
            End If
            'update the gridview:
            bsgvOrgUsers.DataBind()
        End If
        'Close the Add form:
        CloseAdd()
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowModalADD", "$('#modalMessage').modal('show');", True)
    End Sub

    Protected Sub SendInvite(ByVal sEmail As String)
        Dim taVerifyByEmail As New isporgusersTableAdapters.VerifyByEmailTableTableAdapter
        Dim tVerifyByEmail As New isporgusers.VerifyByEmailTableDataTable
        Dim taOrgUsers As New isporgusersTableAdapters.isp_OrganisationUsersTableAdapter
        Dim torgusers As New isporgusers.isp_OrganisationUsersDataTable
        torgusers = taOrgUsers.GetDataByEmail(sEmail, Session("UserOrganisationID"))
        If torgusers.Count > 0 Then
            tVerifyByEmail = taVerifyByEmail.GetData(sEmail)
            Dim sMsg As String = ""
            Dim sbBody As New StringBuilder
            sbBody.Append("<p>Dear " & torgusers.First.OrganisationUserName & ",</p>")

            Dim sSubject As String = ""
            Dim bSent As Boolean
            If tVerifyByEmail.Count > 0 Then
                'not verified, send verification e-mail:
                bSent = Utility.SendVerificationEmail(sEmail)
                sMsg = "The user is registered but not verified. A reminder e-mail has been sent asking them to verify their registration."
            Else
                'not registered, send registration invite:
                Dim sPageName As String = HttpContext.Current.Request.UrlReferrer.GetLeftPart(UriPartial.Authority) & HttpContext.Current.Request.ApplicationPath & "default.aspx"
                sMsg = "The user is not yet registered. An e-mail has been sent reminding them to register. <br/>Once registered and verified, they will have access to the system in the role(s) you set."
                sSubject = "Data Protection Impact Assessment Tool Registration Reminder"
                sbBody.Append("<p>You have been given an Data Protection Impact Assessment Tool access role for " & Replace(StrConv(Session("UserOrganisationName"), VbStrConv.ProperCase), "Nhs", "NHS") & ".</p>")
                sbBody.Append("<p>You are are not yet registered to access the Data Protection Impact Assessment Tool.</p><p style='font-size:150%;'>Please visit the <a href='" & sPageName & "'>Data Protection Impact Assessment Tool registration page</a>  to register and access the Data Protection Impact Assessment Tool in this role. </p>")
                sbBody.Append("<p>You were given this role by <a href='mailto:" & Session("UserEmail") & "'>" & Session("UserOrgUserName") & " (" & Session("UserEmail") & ")</a>. If you have any queries about registration, your role  or what to do next, please contact them.</p>")

                bSent = Utility.SendEmail(sEmail, sSubject, sbBody.ToString(), True)
            End If
            If bSent Then
                'Show modal confirmation:
                lblModalHeading.Text = "E-mail Notification Sent"
                lblModalText.Text = sMsg
            Else
                lblModalHeading.Text = "User Added but E-mail Notification Failed"
                lblModalText.Text = "An unknown error occured when attempting to send an e-mail to the user, please contact the technical team for advice."
            End If
        End If
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowModalADD", "$('#modalMessage').modal('show');", True)

    End Sub
    Private Sub lbtEditCancel_Click(sender As Object, e As EventArgs) Handles lbtEditCancel.Click
        ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "HideValidation", "$('.popover').hide();", True)
        Me.mvOrgUsers.SetActiveView(vUserGrid)
    End Sub

    Private Sub lbtEditSubmit_Click(sender As Object, e As EventArgs) Handles lbtEditSubmit.Click
        Dim sEmail As String = tbOrganisationUserEmailEdit.Text
        Dim nOrg As Integer = Session("UserOrganisationID")
        Dim taQ As New isporgusersTableAdapters.QueriesTableAdapter
        Dim nCount As Integer = 0
        Dim nRoleID As Integer
        Dim bActive As Boolean
        For Each li As ListItem In listRolesEdit.Items
            nRoleID = CInt(li.Value)
            bActive = li.Selected
            nCount = nCount + taQ.OrganisationUsers_All_In_One(sEmail, nOrg, nRoleID, tbOrganisationUserNameEdit.Text, bActive, cbActiveEdit.Checked)
            'check if DPO and active and reset DPOExempt for organisation if so
            If nRoleID = 10 And bActive And cbActiveEdit.Checked Then
                taQ.DPOExemptOrganisation(False, Session("UserOrganisationID"))
            End If
        Next

        bsgvOrgUsers.DataBind()
        Me.mvOrgUsers.SetActiveView(vUserGrid)
        If nCount > 0 Then
            lblModalHeading.Text = "Update Successful"
            lblModalText.Text = "Your changes have been applied successfully."
        Else
            lblModalHeading.Text = "Nothing Updated"
            lblModalText.Text = "No changes were made."
        End If
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowModalUpdate", "$('#modalMessage').modal('show');", True)
    End Sub

    Private Sub bsgvOrgUsers_DataBound(sender As Object, e As EventArgs) Handles bsgvOrgUsers.DataBound
        If Session("orgLicenceType") = "Free, limited licence" Then
            Dim taq As New isporgusersTableAdapters.QueriesTableAdapter
            If taq.GetActiveUsersPerOrganisation(Session("UserOrganisationID")) >= 3 Then
                divUserLimitReached.Visible = True
                lbtAdd.Visible = False
            Else
                divUserLimitReached.Visible = False
                lbtAdd.Visible = True
            End If
        End If
    End Sub
    Protected Sub EditUser_Click(sender As Object, e As CommandEventArgs)
        Dim taUser As New isporgusersTableAdapters.isp_OrganisationUsersSummaryTableAdapter
        Dim tUser As New isporgusers.isp_OrganisationUsersSummaryDataTable
        tUser = taUser.GetByEmail(Session("UserOrganisationID"), e.CommandArgument)
        If tUser.Count > 0 Then
            tbOrganisationUserNameEdit.Text = tUser.First.OrganisationUserName
            tbOrganisationUserEmailEdit.Text = tUser.First.OrganisationUserEmail
            cbActiveEdit.Checked = tUser.First.Active

            BindRoleList(e.CommandArgument)
            Me.mvOrgUsers.SetActiveView(vEditUser)
        End If
    End Sub
    Protected Sub ResendInvite_Click(sender As Object, e As CommandEventArgs)
        Dim sEmail As String = e.CommandArgument
        SendInvite(sEmail)
    End Sub
    Protected Sub RegisterPostbackForLinkButton(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim lbt As LinkButton = TryCast(sender, LinkButton)

        If Not IsNothing(lbt) Then
            ScriptManager.GetCurrent(Me).RegisterPostBackControl(lbt)
        End If

    End Sub
    'Private Sub lbtClearFilters_Click(sender As Object, e As EventArgs) Handles lbtClearFilters.Click
    '    bsgvOrgUsers.FilterExpression = ""
    '    bsgvOrgUsers.SearchPanelFilter = ""
    '    bsgvOrgUsers.DataBind()
    'End Sub
    'Private Sub lbtExportDAList_Click(sender As Object, e As EventArgs) Handles lbtExportOrgUsersList.Click
    '    Dim bsgv As BootstrapGridView = bsgvOrgUsers
    '    Dim bEdVis As Boolean = bsgv.Columns("Edit").Visible
    '    Dim bArchVis As Boolean = bsgv.Columns("Resend").Visible
    '    bsgv.Columns("Edit").Visible = False
    '    bsgv.Columns("Resend").Visible = False
    '    OrgUserGridViewExporter.WriteXlsxToResponse()
    '    bsgv.Columns("Edit").Visible = bEdVis
    '    bsgv.Columns("Resend").Visible = bArchVis
    'End Sub
    Protected Sub GridViewCustomToolbar_ToolbarItemClick(ByVal source As Object, ByVal e As BootstrapGridViewToolbarItemClickEventArgs)
        Select Case e.Item.Name
            Case "Export"
                Dim bsgv As BootstrapGridView = bsgvOrgUsers
                Dim bEdVis As Boolean = bsgv.Columns("Edit").Visible
                Dim bArchVis As Boolean = bsgv.Columns("Resend").Visible
                bsgv.Columns("Edit").Visible = False
                bsgv.Columns("Resend").Visible = False
                OrgUserGridViewExporter.WriteXlsxToResponse()
                bsgv.Columns("Edit").Visible = bEdVis
                bsgv.Columns("Resend").Visible = bArchVis
            Case Else
        End Select
    End Sub

    Private Sub lbtDPOExemptionConfirmed_Click(sender As Object, e As EventArgs) Handles lbtDPOExemptionConfirmed.Click
        Dim taq As New isporgusersTableAdapters.QueriesTableAdapter
        taq.DPOExemptOrganisation(True, Session("UserOrganisationID"))
        pnlNoDPO.Visible = False
    End Sub
End Class