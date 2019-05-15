Public Class screening_questions
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
        Dim tPScreening = taP.Project_GetScreeningByID(sid).First()
        'First 3
        If tPScreening.PSQ01 IsNot Nothing Then
            rblScreeningQ01.SelectedValue = tPScreening.PSQ01
        End If
        If tPScreening.PSQ02 IsNot Nothing Then
            rblScreeningQ02.SelectedValue = tPScreening.PSQ02
        End If
        If tPScreening.PSQ03 IsNot Nothing Then
            rblScreeningQ03.SelectedValue = tPScreening.PSQ03
        End If

        '' Next 15
        If tPScreening.PSQ04 IsNot Nothing Then
            rblScreeningQ04.SelectedValue = tPScreening.PSQ04
        End If
        If tPScreening.PSQ05 IsNot Nothing Then
            rblScreeningQ05.SelectedValue = tPScreening.PSQ05
        End If
        If tPScreening.PSQ06 IsNot Nothing Then
            rblScreeningQ06.SelectedValue = tPScreening.PSQ06
        End If
        If tPScreening.PSQ07 IsNot Nothing Then
            rblScreeningQ07.SelectedValue = tPScreening.PSQ07
        End If
        If tPScreening.PSQ08 IsNot Nothing Then
            rblScreeningQ08.SelectedValue = tPScreening.PSQ08
        End If
        If tPScreening.PSQ09 IsNot Nothing Then
            rblScreeningQ09.SelectedValue = tPScreening.PSQ09
        End If
        If tPScreening.PSQ10 IsNot Nothing Then
            rblScreeningQ10.SelectedValue = tPScreening.PSQ10
        End If
        If tPScreening.PSQ11 IsNot Nothing Then
            rblScreeningQ11.SelectedValue = tPScreening.PSQ11
        End If
        If tPScreening.PSQ12 IsNot Nothing Then
            rblScreeningQ12.SelectedValue = tPScreening.PSQ12
        End If
        If tPScreening.PSQ13 IsNot Nothing Then
            rblScreeningQ13.SelectedValue = tPScreening.PSQ13
        End If
        If tPScreening.PSQ14 IsNot Nothing Then
            rblScreeningQ14.SelectedValue = tPScreening.PSQ14
        End If
        If tPScreening.PSQ15 IsNot Nothing Then
            rblScreeningQ15.SelectedValue = tPScreening.PSQ15
        End If
        If tPScreening.PSQ16 IsNot Nothing Then
            rblScreeningQ16.SelectedValue = tPScreening.PSQ16
        End If
        If tPScreening.PSQ17 IsNot Nothing Then
            rblScreeningQ17.SelectedValue = tPScreening.PSQ17
        End If
        If tPScreening.PSQ18 IsNot Nothing Then
            rblScreeningQ18.SelectedValue = tPScreening.PSQ18
        End If

        ddIGLead.DataBind()
        If tPScreening.IG_Lead_ID IsNot Nothing Then
            ddIGLead.SelectedValue = tPScreening.IG_Lead_ID.ToString
        End If

        System.Web.UI.ScriptManager.RegisterStartupScript(Me, [GetType](), "check_Javascript", "doStartPage();", True)


        'If tP.First.IG_Lead_ID <> Nothing Then
        '    ddIGLead.SelectedValue = tP.First.IG_Lead_ID.ToString
        'End If

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

        Dim PSQ04, PSQ05, PSQ06, PSQ07, PSQ08, PSQ09, PSQ10, PSQ11, PSQ12, PSQ13, PSQ14, PSQ15, PSQ16, PSQ17, PSQ18 As Integer
        If rblScreeningQ04.SelectedValue <> "" Then PSQ04 = rblScreeningQ04.SelectedValue Else PSQ04 = Nothing
        If rblScreeningQ05.SelectedValue <> "" Then PSQ05 = rblScreeningQ05.SelectedValue Else PSQ05 = Nothing
        If rblScreeningQ06.SelectedValue <> "" Then PSQ06 = rblScreeningQ06.SelectedValue Else PSQ06 = Nothing
        If rblScreeningQ07.SelectedValue <> "" Then PSQ07 = rblScreeningQ07.SelectedValue Else PSQ07 = Nothing
        If rblScreeningQ08.SelectedValue <> "" Then PSQ08 = rblScreeningQ08.SelectedValue Else PSQ08 = Nothing
        If rblScreeningQ09.SelectedValue <> "" Then PSQ09 = rblScreeningQ09.SelectedValue Else PSQ09 = Nothing
        If rblScreeningQ10.SelectedValue <> "" Then PSQ10 = rblScreeningQ10.SelectedValue Else PSQ10 = Nothing
        If rblScreeningQ11.SelectedValue <> "" Then PSQ11 = rblScreeningQ11.SelectedValue Else PSQ11 = Nothing
        If rblScreeningQ12.SelectedValue <> "" Then PSQ12 = rblScreeningQ12.SelectedValue Else PSQ12 = Nothing
        If rblScreeningQ13.SelectedValue <> "" Then PSQ13 = rblScreeningQ13.SelectedValue Else PSQ13 = Nothing
        If rblScreeningQ14.SelectedValue <> "" Then PSQ14 = rblScreeningQ14.SelectedValue Else PSQ14 = Nothing
        If rblScreeningQ15.SelectedValue <> "" Then PSQ15 = rblScreeningQ15.SelectedValue Else PSQ15 = Nothing
        If rblScreeningQ16.SelectedValue <> "" Then PSQ16 = rblScreeningQ16.SelectedValue Else PSQ16 = Nothing
        If rblScreeningQ17.SelectedValue <> "" Then PSQ17 = rblScreeningQ17.SelectedValue Else PSQ17 = Nothing
        If rblScreeningQ18.SelectedValue <> "" Then PSQ18 = rblScreeningQ18.SelectedValue Else PSQ18 = Nothing


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
        Dim tPScreening = taP.Project_UpdateScreening(hfProjectID.Value, hfScreeningStatus.Value, IGLeadId, IGDate, rblScreeningQ01.SelectedValue, rblScreeningQ02.SelectedValue, rblScreeningQ03.SelectedValue,
                                    PSQ04, PSQ05, PSQ06, PSQ07, PSQ08, PSQ09, PSQ10, PSQ11, PSQ12, PSQ13, PSQ14, PSQ15, PSQ16, PSQ17, PSQ18, currentUserId)

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
        'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ShowModalMessage", "$('#modalMessage').modal('show');", True)
    End Sub

End Class