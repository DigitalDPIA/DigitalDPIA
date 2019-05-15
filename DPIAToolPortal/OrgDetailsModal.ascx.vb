Public Class OrgDetailsModal
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

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
    Public Function GetPanelClass(ByVal sScore As String) As String
        Dim sClass As String = "panel-info"
        Dim nClass As Integer = CInt(sScore)
        Select Case nClass
            Case 0
                sClass = "panel-success"
            Case 1
                sClass = "panel-warning"
            Case Is > 1
                sClass = "panel-danger"
            Case -10
                sClass = "panel-default"
            Case -1
                sClass = "panel-default"

        End Select
        Return sClass
    End Function
    Protected Sub dsPNFiles_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs)
        If e.Exception Is Nothing Then
            Dim pnl As Panel = fvOrgDetails.FindControl("pnlPNFiles")
            If Not pnl Is Nothing Then
                Dim nRows As Integer = e.ReturnValue.Rows.Count
                If nRows > 0 Then
                    pnl.Visible = True
                Else
                    pnl.Visible = False
                    Dim pnl2 As Panel = fvOrgDetails.FindControl("pnlPrivacyURL")
                    If Not pnl2 Is Nothing Then
                        If Not pnl2.Visible Then
                            Dim lbl As Label = fvOrgDetails.FindControl("lblNoPrivacyNotice")
                            If Not lbl Is Nothing Then
                                lbl.Visible = True
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub
End Class