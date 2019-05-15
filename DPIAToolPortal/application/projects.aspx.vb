Imports DevExpress.Data.Linq
Imports DevExpress.Web
Imports DevExpress.Web.Bootstrap

Public Class projects
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Session("FlowDetailID") = Nothing
        End If

        'If Session("orgLicenceType") = "Free, limited licence" Then
        '    pnlFreeLicenceMessage.Visible = True
        '    bsgvProjects.Toolbars(0).Items.FindByName("Export").Visible = False
        'End If
    End Sub
    Private Sub LinqServerModeDataSource1_Selecting(sender As Object, e As LinqServerModeDataSourceSelectEventArgs) Handles LinqServerModeDataSource1.Selecting
        Dim taP As New DPIAProjectsDataContext
        e.KeyExpression = "ID"
        Dim tPFiltered = taP.Projects_GetFiltered(Session("UserOrganisationID"), Session("UserID"), cbIncludeArchived.Checked).ToList()


        e.QueryableSource = (From cProject In tPFiltered
                             Select New With {
                                .ID = cProject.ID,
                                .Name = cProject.Name,
                                .Status = cProject.Status,
                                .Organisation_ID = cProject.Organisation_ID,
                                .Assigned_Name = cProject.Assigned_Name,
                                .Created_Name = cProject.Created_Name,
                                .Created_Date = cProject.Created_Date,
                                .Modified_Date = cProject.Modified_Date,
                                .IG_Lead_Name = cProject.IG_Lead_Name,
                                .IG_Lead_Sign_Off_Date = cProject.IG_Lead_Sign_Off_Date,
                                .Asset_Owner_Name = cProject.Asset_Owner_Name,
                                .Asset_Owner_Sign_Off_Date = cProject.Asset_Owner_Sign_Off_Date,
                                .DPO_Name = cProject.DPO_Name,
                                .DPO_Sign_Off_Date = cProject.DPO_Sign_Off_Date,
                                .ICO_Name = cProject.ICO_Name,
                                .ICO_Sign_Off_Date = cProject.ICO_Sign_Off_Date,
                                .Archived_Date = cProject.Archived_Date
                             }).AsQueryable()

    End Sub


    Protected Function PadID(value As Integer) As String

        Dim fmt As String = "PR0000000"
        Dim str As String = value.ToString(fmt)
        Return str
    End Function
    Protected Sub EditProject(sender As Object, e As CommandEventArgs)
        Dim nShareID As Integer = e.CommandArgument
        Session("nProjectID") = nShareID
        Response.Redirect("~/application/project_summary.aspx")
    End Sub
    Protected Sub Screening(sender As Object, e As CommandEventArgs)
        Dim nShareID As Integer = e.CommandArgument
        Session("nProjectID") = nShareID
        Response.Redirect("~/application/screening_questions_v2.aspx")
    End Sub
    Protected Sub Dpia(sender As Object, e As CommandEventArgs)
        Dim nShareID As Integer = e.CommandArgument
        Session("nProjectID") = nShareID
        Response.Redirect("~/application/dpia.aspx")
    End Sub

    Protected Sub ArchiveProject(sender As Object, e As CommandEventArgs)
        hfArchiveProjectID.Value = e.CommandArgument
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalArchive", "<script>$('#modalArchive').modal('show');</script>")
        'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ShowModalArchive", "$('#modalArchive').modal('show');", True)
    End Sub
    Private Sub lbtArchiveConfirm_Click(sender As Object, e As EventArgs) Handles lbtArchiveConfirm.Click
        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim currentUserId As Guid = DirectCast(currentUser.ProviderUserKey, Guid)
        Dim lbt As LinkButton = TryCast(sender, LinkButton)

        'We are only archiving so pass in false, false for recycle params
        Dim taP As New DPIAProjectsDataContext
        Dim tProject = taP.Project_SetArchive(hfArchiveProjectID.Value, currentUserId)
        bsgvProjects.DataBind()

    End Sub

    Private Sub lbtAdd_Click(sender As Object, e As EventArgs) Handles lbtAdd.Click


        Response.Redirect("~/application/Project_summary.aspx?action=add")
    End Sub

    Private Sub cbIncludeArchived_CheckedChanged(sender As Object, e As EventArgs) Handles cbIncludeArchived.CheckedChanged
        bsgvProjects.DataBind()
    End Sub
End Class