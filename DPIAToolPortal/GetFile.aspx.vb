Public Class GetFileBeforeLogin
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Get the file id from the query string
        Dim id As Integer = Convert.ToInt16(Request.QueryString("FileID"))

        ' Get the file from the database
        Dim taFile As New ispgetfilesTableAdapters.isp_FilesTableAdapter
        Dim file As ispgetfiles.isp_FilesDataTable = taFile.GetAFile(id)
        Dim row As DataRow = file.Rows(0)
        Dim name As String = DirectCast(row("FileName"), String)
        Dim contentType As String = DirectCast(row("FileType"), String)
        Dim data As [Byte]() = DirectCast(row("FileData"), [Byte]())

        ' Send the file to the browser
        Response.AddHeader("Content-type", contentType)
        Response.AddHeader("Content-Disposition", Convert.ToString("attachment; filename=") & name)
        Response.BinaryWrite(data)
        Response.Flush()
        Response.[End]()
    End Sub

End Class