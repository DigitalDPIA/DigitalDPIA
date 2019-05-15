Public Class Unsubscribe
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
		Dim sEmail As String = Page.Request.Item("emailid")
		If Not sEmail Is Nothing Then
			If sEmail.Length = 0 Then
				mvUnsub.SetActiveView(Me.vError)
			Else
                Dim taUnsub As New ispusersTableAdapters.isp_UnsubscribeListTableAdapter
                If taUnsub.CheckIfEmailInList(sEmail) > 0 Then
                    mvUnsub.SetActiveView(Me.vDone)
                ElseIf taUnsub.CheckIFAG(sEmail) > 0 Or taUnsub.CheckIfSA(sEmail) > 0 Then
                    mvUnsub.SetActiveView(Me.vIsAdmin)
                Else
					taUnsub.Insert(sEmail)
				End If
			End If
		Else
			mvUnsub.SetActiveView(Me.vError)
		End If

	End Sub

End Class