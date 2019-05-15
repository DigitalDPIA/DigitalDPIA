Public Class screening_questions_v2
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Not Session("nProjectID") Is Nothing Then
                hfProjectID.Value = Session("nProjectID")
                lblFormTitle.Text = "Project Screening " & PadID(hfProjectID.Value)
            End If

            If Not hfProjectID.Value = 0 Then
                'Load the summary details:
                LoadSummary(hfProjectID.Value)
            End If
        End If
    End Sub
    Protected Sub LoadSummary(ByVal sid As Integer)

        If sid = 0 Then
            Response.Redirect("projects")
        End If

        Dim taP As New DPIAProjectsDataContext
        Dim tPScreening = taP.Project_GetScreeningV2ByID(sid).First()

        'First 3
        If tPScreening.PSQV201a IsNot Nothing Then
            rblScreeningV2Q01a.SelectedValue = tPScreening.PSQV201a
        End If
        If tPScreening.PSQV201b IsNot Nothing Then
            rblScreeningV2Q01b.SelectedValue = tPScreening.PSQV201b
        End If
        If tPScreening.PSQV201c IsNot Nothing Then
            rblScreeningV2Q01c.SelectedValue = tPScreening.PSQV201c
        End If
        If tPScreening.PSQV201d IsNot Nothing Then
            rblScreeningV2Q01d.SelectedValue = tPScreening.PSQV201d
        End If
        If tPScreening.PSQV201e IsNot Nothing Then
            rblScreeningV2Q01e.SelectedValue = tPScreening.PSQV201e
        End If
        If tPScreening.PSQV201f IsNot Nothing Then
            rblScreeningV2Q01f.SelectedValue = tPScreening.PSQV201f
        End If
        'If tPScreening.PSQV201g IsNot Nothing Then
        '    rblScreeningV2Q01g.SelectedValue = tPScreening.PSQV201g
        'End If
        'Q2
        If tPScreening.PSQV202a IsNot Nothing Then
            rblScreeningV2Q02a.SelectedValue = tPScreening.PSQV202a
        End If
        If tPScreening.PSQV202b IsNot Nothing Then
            rblScreeningV2Q02b.SelectedValue = tPScreening.PSQV202b
        End If
        If tPScreening.PSQV202c IsNot Nothing Then
            rblScreeningV2Q02c.SelectedValue = tPScreening.PSQV202c
        End If
        If tPScreening.PSQV202d IsNot Nothing Then
            rblScreeningV2Q02d.SelectedValue = tPScreening.PSQV202d
        End If
        If tPScreening.PSQV202e IsNot Nothing Then
            rblScreeningV2Q02e.SelectedValue = tPScreening.PSQV202e
        End If
        If tPScreening.PSQV202f IsNot Nothing Then
            rblScreeningV2Q02f.SelectedValue = tPScreening.PSQV202f
        End If
        'Q3
        If tPScreening.PSQV203a IsNot Nothing Then
            rblScreeningV2Q03a.SelectedValue = tPScreening.PSQV203a
        End If
        If tPScreening.PSQV203b IsNot Nothing Then
            rblScreeningV2Q03b.SelectedValue = tPScreening.PSQV203b
        End If
        If tPScreening.PSQV203c IsNot Nothing Then
            rblScreeningV2Q03c.SelectedValue = tPScreening.PSQV203c
        End If
        If tPScreening.PSQV203d IsNot Nothing Then
            rblScreeningV2Q03d.SelectedValue = tPScreening.PSQV203d
        End If
        If tPScreening.PSQV203e IsNot Nothing Then
            rblScreeningV2Q03e.SelectedValue = tPScreening.PSQV203e
        End If
        If tPScreening.PSQV203f IsNot Nothing Then
            rblScreeningV2Q03f.SelectedValue = tPScreening.PSQV203f
        End If
        If tPScreening.PSQV203g IsNot Nothing Then
            rblScreeningV2Q03g.SelectedValue = tPScreening.PSQV203g
        End If
        If tPScreening.PSQV203h IsNot Nothing Then
            rblScreeningV2Q03h.SelectedValue = tPScreening.PSQV203h
        End If
        'Q4
        If tPScreening.PSQV204a IsNot Nothing Then
            rblScreeningV2Q04a.SelectedValue = tPScreening.PSQV204a
        End If
        If tPScreening.PSQV204b IsNot Nothing Then
            rblScreeningV2Q04b.SelectedValue = tPScreening.PSQV204b
        End If
        If tPScreening.PSQV204c IsNot Nothing Then
            rblScreeningV2Q04c.SelectedValue = tPScreening.PSQV204c
        End If
        If tPScreening.PSQV204d IsNot Nothing Then
            rblScreeningV2Q04d.SelectedValue = tPScreening.PSQV204d
        End If
        If tPScreening.PSQV204e IsNot Nothing Then
            rblScreeningV2Q04e.SelectedValue = tPScreening.PSQV204e
        End If
        If tPScreening.PSQV204f IsNot Nothing Then
            rblScreeningV2Q04f.SelectedValue = tPScreening.PSQV204f
        End If
        If tPScreening.PSQV204g IsNot Nothing Then
            rblScreeningV2Q04g.SelectedValue = tPScreening.PSQV204g
        End If
        If tPScreening.PSQV204h IsNot Nothing Then
            rblScreeningV2Q04h.SelectedValue = tPScreening.PSQV204h
        End If

        ddIGLead.DataBind()
        If tPScreening.IG_Lead_ID IsNot Nothing Then
            ddIGLead.SelectedValue = tPScreening.IG_Lead_ID.ToString
        End If

        System.Web.UI.ScriptManager.RegisterStartupScript(Me, [GetType](), "check_Javascript", "doStartPage();", True)

    End Sub
    Protected Function PadID(value As Integer) As String

        Dim fmt As String = "PR0000000"
        Dim str As String = value.ToString(fmt)
        Return str
    End Function
    Protected Sub lbtSaveProjectScreening_Click(sender As Object, e As EventArgs) Handles lbtSaveProjectScreening.Click

        'Get userid:
        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim currentUserId As Guid = DirectCast(currentUser.ProviderUserKey, Guid)

        'Q2
        Dim PSQV202a, PSQV202b, PSQV202c, PSQV202d, PSQV202e, PSQV202f As Integer
        If rblScreeningV2Q02a.SelectedValue <> "" Then PSQV202a = rblScreeningV2Q02a.SelectedValue Else PSQV202a = Nothing
        If rblScreeningV2Q02b.SelectedValue <> "" Then PSQV202b = rblScreeningV2Q02b.SelectedValue Else PSQV202b = Nothing
        If rblScreeningV2Q02c.SelectedValue <> "" Then PSQV202c = rblScreeningV2Q02c.SelectedValue Else PSQV202c = Nothing
        If rblScreeningV2Q02d.SelectedValue <> "" Then PSQV202d = rblScreeningV2Q02d.SelectedValue Else PSQV202d = Nothing
        If rblScreeningV2Q02e.SelectedValue <> "" Then PSQV202e = rblScreeningV2Q02e.SelectedValue Else PSQV202e = Nothing
        If rblScreeningV2Q02f.SelectedValue <> "" Then PSQV202f = rblScreeningV2Q02f.SelectedValue Else PSQV202f = Nothing

        'Q3
        Dim PSQV203a, PSQV203b, PSQV203c, PSQV203d, PSQV203e, PSQV203f, PSQV203g, PSQV203h As Integer
        If rblScreeningV2Q03a.SelectedValue <> "" Then PSQV203a = rblScreeningV2Q03a.SelectedValue Else PSQV203a = Nothing
        If rblScreeningV2Q03b.SelectedValue <> "" Then PSQV203b = rblScreeningV2Q03b.SelectedValue Else PSQV203b = Nothing
        If rblScreeningV2Q03c.SelectedValue <> "" Then PSQV203c = rblScreeningV2Q03c.SelectedValue Else PSQV203c = Nothing
        If rblScreeningV2Q03d.SelectedValue <> "" Then PSQV203d = rblScreeningV2Q03d.SelectedValue Else PSQV203d = Nothing
        If rblScreeningV2Q03e.SelectedValue <> "" Then PSQV203e = rblScreeningV2Q03e.SelectedValue Else PSQV203e = Nothing
        If rblScreeningV2Q03f.SelectedValue <> "" Then PSQV203f = rblScreeningV2Q03f.SelectedValue Else PSQV203f = Nothing
        If rblScreeningV2Q03g.SelectedValue <> "" Then PSQV203g = rblScreeningV2Q03g.SelectedValue Else PSQV203g = Nothing
        If rblScreeningV2Q03g.SelectedValue <> "" Then PSQV203h = rblScreeningV2Q03h.SelectedValue Else PSQV203h = Nothing

        'Q4
        Dim PSQV204a, PSQV204b, PSQV204c, PSQV204d, PSQV204e, PSQV204f, PSQV204g, PSQV204h As Integer
        If rblScreeningV2Q04a.SelectedValue <> "" Then PSQV204a = rblScreeningV2Q04a.SelectedValue Else PSQV204a = Nothing
        If rblScreeningV2Q04b.SelectedValue <> "" Then PSQV204b = rblScreeningV2Q04b.SelectedValue Else PSQV204b = Nothing
        If rblScreeningV2Q04c.SelectedValue <> "" Then PSQV204c = rblScreeningV2Q04c.SelectedValue Else PSQV204c = Nothing
        If rblScreeningV2Q04d.SelectedValue <> "" Then PSQV204d = rblScreeningV2Q04d.SelectedValue Else PSQV204d = Nothing
        If rblScreeningV2Q04e.SelectedValue <> "" Then PSQV204e = rblScreeningV2Q04e.SelectedValue Else PSQV204e = Nothing
        If rblScreeningV2Q04f.SelectedValue <> "" Then PSQV204f = rblScreeningV2Q04f.SelectedValue Else PSQV204f = Nothing
        If rblScreeningV2Q04g.SelectedValue <> "" Then PSQV204g = rblScreeningV2Q04g.SelectedValue Else PSQV204g = Nothing
        If rblScreeningV2Q04g.SelectedValue <> "" Then PSQV204h = rblScreeningV2Q04h.SelectedValue Else PSQV204h = Nothing

        Dim IGLeadId As Guid
        Dim IGDate? As Date
        If ddIGLead.SelectedValue <> "0" Then
            IGLeadId = New Guid(ddIGLead.SelectedValue)
            IGDate = Date.UtcNow()
        Else
            IGLeadId = Nothing
            IGDate = Nothing
        End If

        Dim taP As New DPIAProjectsDataContext
        Dim tPScreening = taP.Project_UpdateScreeningV2(hfProjectID.Value, hfScreeningStatus.Value, IGLeadId, IGDate,
                                     rblScreeningV2Q01a.SelectedValue, rblScreeningV2Q01b.SelectedValue, rblScreeningV2Q01c.SelectedValue, rblScreeningV2Q01d.SelectedValue, rblScreeningV2Q01e.SelectedValue, rblScreeningV2Q01f.SelectedValue, Nothing,
                                     PSQV202a, PSQV202b, PSQV202c, PSQV202d, PSQV202e, PSQV202f,
                                     PSQV203a, PSQV203b, PSQV203c, PSQV203d, PSQV203e, PSQV203f, PSQV203g, PSQV203h,
                                     PSQV204a, PSQV204b, PSQV204c, PSQV204d, PSQV204e, PSQV204f, PSQV204g, PSQV204h, currentUserId)

        If tPScreening.ReturnValue > 0 Then
            lblModalHeading.Text = "Project Screening Saved"
            Me.lblModalText.Text = "Your project screening has been saved successfully. What would you like to do?"
            ShowMessage(True)
        Else
            lblModalHeading.Text = "Could Not Update the Project Screening"
            Me.lblModalText.Text = "This may be because your login has expired. Try logging out and logging back in again before attempting to re-enter the project screening. If the problem persists, please contact DPIA support."
            ShowMessage(False)
        End If

    End Sub

    Protected Sub ShowMessage(Optional ByVal ShowOptions As Boolean = False)
        If ShowOptions Then

            btnCloseModal.Visible = False
            lbtAddedReturn.Visible = True
            If hfScreeningStatus.Value = "6" Or hfScreeningStatus.Value = "7" Then
                lbtAddDetail.Visible = True
            Else
                lbtAddDetail.Visible = False
            End If

            ModalOK.Visible = False
        Else
            lbtAddedReturn.Visible = False
            lbtAddDetail.Visible = False
            ModalOK.Visible = True
        End If
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMessage", "<script>$('#modalMessage').modal('show');</script>")
    End Sub

    Private Sub lds_GetOrgIGRoles_Selecting(sender As Object, e As LinqDataSourceSelectEventArgs) Handles lds_GetOrgIGRoles.Selecting
        Dim taP As New DPIAProjectsDataContext

        e.Result = taP.Users_GetOrgIGRoles(Session("UserOrganisationID"))
    End Sub

End Class