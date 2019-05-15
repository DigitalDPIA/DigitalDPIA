Imports System.Data.SqlClient
Imports System.IO

Public Class admin_config
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Private Sub lbtICO_Click(sender As Object, e As EventArgs) Handles lbtICO.Click
        tabMOU.Attributes.Remove("class")
        tabTOU.Attributes.Remove("class")
        tabPrivacy.Attributes.Remove("class")
        tabSecurity.Attributes.Remove("class")
        tabICO.Attributes.Add("class", "active")
        mvConfig.SetActiveView(vICO)
    End Sub
    Private Sub lbtMOU_Click(sender As Object, e As EventArgs) Handles lbtMOU.Click
        tabICO.Attributes.Remove("class")
        tabTOU.Attributes.Remove("class")
        tabPrivacy.Attributes.Remove("class")
        tabSecurity.Attributes.Remove("class")
        tabMOU.Attributes.Add("class", "active")
        mvConfig.SetActiveView(vMOU)
    End Sub
    Private Sub lbtTOU_Click(sender As Object, e As EventArgs) Handles lbtTOU.Click
        tabMOU.Attributes.Remove("class")
        tabICO.Attributes.Remove("class")
        tabPrivacy.Attributes.Remove("class")
        tabSecurity.Attributes.Remove("class")
        tabTOU.Attributes.Add("class", "active")
        mvConfig.SetActiveView(vTOU)
    End Sub
    Private Sub lbtPrivacy_Click(sender As Object, e As EventArgs) Handles lbtPrivacy.Click
        tabMOU.Attributes.Remove("class")
        tabICO.Attributes.Remove("class")
        tabTOU.Attributes.Remove("class")
        tabSecurity.Attributes.Remove("class")
        tabPrivacy.Attributes.Add("class", "active")
        mvConfig.SetActiveView(vPrivacy)
    End Sub
    Private Sub lbtSecurity_Click(sender As Object, e As EventArgs) Handles lbtSecurity.Click
        tabMOU.Attributes.Remove("class")
        tabICO.Attributes.Remove("class")
        tabTOU.Attributes.Remove("class")
        tabPrivacy.Attributes.Remove("class")
        tabSecurity.Attributes.Add("class", "active")
        mvConfig.SetActiveView(vSecurity)
    End Sub

    Private Sub lbtUpload_Click(sender As Object, e As EventArgs) Handles lbtUpload.Click
        'Upload and save the file
        If fupICOCSV.PostedFiles.Count > 0 Then
            Dim csvPath As String = Server.MapPath("~/Resources/") + Path.GetFileName(fupICOCSV.PostedFile.FileName)
            fupICOCSV.SaveAs(csvPath)
            Dim fmtPath As String = Server.MapPath("~/Resources/ico-fmt.xml")
            'Dim taq As New adminTableAdapters.QueriesTableAdapter
            Try
                Dim consString As String = ConfigurationManager.ConnectionStrings("csICOData").ConnectionString
                Dim conn As SqlConnection = New SqlConnection(consString)
                Dim comm As New SqlCommand
                comm.Connection = conn
                comm.CommandType = CommandType.StoredProcedure
                comm.CommandText = "dbo.PopulateICORegisterFullFromCSV"
                comm.Parameters.Add("@ICORegCSV", SqlDbType.VarChar)
                comm.Parameters.Add("@ICOTableTemplate", SqlDbType.VarChar)
                comm.Parameters("@ICORegCSV").Value = csvPath
                comm.Parameters("@ICOTableTemplate").Value = fmtPath
                comm.CommandTimeout = 0
                conn.Open()
                Dim n As Integer = comm.ExecuteScalar
                IO.File.Delete(csvPath)
                If n > 0 Then
                    lblModalHeading.Text = "Upload Successful"
                    lblModalText.Text = "ICO register upload was successful. " & n.ToString & " ICO registered organisations were uploaded."
                End If
                'If taq.PopulateICORegisterFullFromCSV(csvPath, fmtPath) > 0 Then
                '    
                'End If
            Catch ex As Exception
                lblModalHeading.Text = "Upload Failed"
                lblModalText.Text = "<p>The ICO register upload failed. The server returned the following error message: </p><p>" & ex.Message & "</p>"

            End Try
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMessage", "<script>$('#modalMessage').modal('show');</script>")
        End If
        'Using con As New SqlConnection(consString)
        '    Using sqlBulkCopy As New SqlBulkCopy(con)
        '        'Set the database table name
        '        sqlBulkCopy.DestinationTableName = "dbo.isp_ICO_RegisterTest"
        '        con.Open()
        '        sqlBulkCopy.WriteToServer(dt)
        '        con.Close()
        '    End Using
        'End Using
    End Sub

    Private Sub vTOU_Activate(sender As Object, e As EventArgs) Handles vTOU.Activate
        LoadTOU()
    End Sub
    Protected Sub LoadTOU()
        Dim taTOU As New adminTableAdapters.isp_TermsOfUseTableAdapter
        Dim tTOU As New admin.isp_TermsOfUseDataTable
        tTOU = taTOU.GetCurrent("TOU")
        If tTOU.Count > 0 Then
            lblLastChanged.Text = tTOU.First.StartDate
            litDetail.Text = tTOU.First.TermsHTML
            htmlDetail.Html = tTOU.First.TermsHTML
            litSummary.Text = tTOU.First.TermsSummary
            htmlSummary.Html = tTOU.First.TermsSummary
        End If
    End Sub
    
    Private Sub lbtUpdate_Click(sender As Object, e As EventArgs) Handles lbtUpdate.Click
        mvTOU.SetActiveView(vEditTOU)
    End Sub

    Private Sub lbtUpdateCancel_Click(sender As Object, e As EventArgs) Handles lbtUpdateCancel.Click
        mvTOU.SetActiveView(vTOUView)
    End Sub

    Private Sub lbtUpdateConfirm_Click(sender As Object, e As EventArgs) Handles lbtUpdateConfirm.Click
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        taq.TOUArchiveAndRefresh(htmlDetail.Html, htmlSummary.Html, "TOU")
        LoadTOU()
        mvTOU.SetActiveView(vTOUView)
    End Sub

    Private Sub vMOU_Activate(sender As Object, e As EventArgs) Handles vMOU.Activate
        LoadMOU()
    End Sub

    Protected Sub LoadMOU()
        Dim taTOU As New adminTableAdapters.isp_TermsOfUseTableAdapter
        Dim tTOU As New admin.isp_TermsOfUseDataTable
        tTOU = taTOU.GetCurrent("MOU")
        If tTOU.Count > 0 Then
            lblMOULastChanged.Text = tTOU.First.StartDate
            litMOUDetail.Text = tTOU.First.TermsHTML
            htmlMOUDetail.Html = tTOU.First.TermsHTML
            litMOUSummary.Text = tTOU.First.TermsSummary
            htmlMOUSummary.Html = tTOU.First.TermsSummary
        End If
    End Sub

    Private Sub lbtUpdateMOU_Click(sender As Object, e As EventArgs) Handles lbtUpdateMOU.Click
        mvMOU.SetActiveView(vMOUEdit)
    End Sub

    Private Sub lbtUpdateMOUCancel_Click(sender As Object, e As EventArgs) Handles lbtUpdateMOUCancel.Click
        mvMOU.SetActiveView(vMOUView)
    End Sub

    Private Sub lbtUpdateMOUConfirm_Click(sender As Object, e As EventArgs) Handles lbtUpdateMOUConfirm.Click
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        taq.TOUArchiveAndRefresh(htmlMOUDetail.Html, htmlMOUSummary.Html, "MOU")
        LoadMOU()
        mvMOU.SetActiveView(vMOUView)
    End Sub
    Private Sub vPrivacy_Activate(sender As Object, e As EventArgs) Handles vPrivacy.Activate
        LoadPrivacy()
    End Sub

    Protected Sub LoadPrivacy()
        Dim taTOU As New adminTableAdapters.isp_TermsOfUseTableAdapter
        Dim tTOU As New admin.isp_TermsOfUseDataTable
        tTOU = taTOU.GetCurrent("Privacy")
        If tTOU.Count > 0 Then
            lblPrivacyLastChanged.Text = tTOU.First.StartDate
            litPrivacyDetail.Text = tTOU.First.TermsHTML
            htmlPrivacyDetail.Html = tTOU.First.TermsHTML
            litPrivacySummary.Text = tTOU.First.TermsSummary
            htmlPrivacySummary.Html = tTOU.First.TermsSummary
        End If
    End Sub

    Private Sub lbtUpdatePrivacy_Click(sender As Object, e As EventArgs) Handles lbtPrivacyUpdate.Click
        mvPrivacy.SetActiveView(vPrivacyEdit)
    End Sub

    Private Sub lbtUpdatePrivacyCancel_Click(sender As Object, e As EventArgs) Handles lbtPrivacyUpdateCancel.Click
        mvPrivacy.SetActiveView(vPrivacyView)
    End Sub

    Private Sub lbtUpdatePrivacyConfirm_Click(sender As Object, e As EventArgs) Handles lbtPrivacyUpdateConfirm.Click
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        taq.TOUArchiveAndRefresh(htmlPrivacyDetail.Html, htmlPrivacySummary.Html, "Privacy")
        LoadPrivacy()
        mvPrivacy.SetActiveView(vPrivacyView)
    End Sub

    Private Sub vSecurity_Activate(sender As Object, e As EventArgs) Handles vSecurity.Activate
        LoadSecurity()
    End Sub

    Protected Sub LoadSecurity()
        Dim taTOU As New adminTableAdapters.isp_TermsOfUseTableAdapter
        Dim tTOU As New admin.isp_TermsOfUseDataTable
        tTOU = taTOU.GetCurrent("Security")
        If tTOU.Count > 0 Then
            lblSecurityLastChanged.Text = tTOU.First.StartDate
            litSecurityDetail.Text = tTOU.First.TermsHTML
            htmlSecurityDetail.Html = tTOU.First.TermsHTML
            litSecuritySummary.Text = tTOU.First.TermsSummary
            htmlSecuritySummary.Html = tTOU.First.TermsSummary
        End If
    End Sub

    Private Sub lbtUpdateSecurity_Click(sender As Object, e As EventArgs) Handles lbtSecurityUpdate.Click
        mvSecurity.SetActiveView(vSecurityEdit)
    End Sub

    Private Sub lbtUpdateSecurityCancel_Click(sender As Object, e As EventArgs) Handles lbtSecurityUpdateCancel.Click
        mvSecurity.SetActiveView(vSecurityView)
    End Sub

    Private Sub lbtUpdateSecurityConfirm_Click(sender As Object, e As EventArgs) Handles lbtSecurityUpdateConfirm.Click
        Dim taq As New adminTableAdapters.QueriesTableAdapter
        taq.TOUArchiveAndRefresh(htmlSecurityDetail.Html, htmlSecuritySummary.Html, "Security")
        LoadSecurity()
        mvSecurity.SetActiveView(vSecurityView)
    End Sub
End Class