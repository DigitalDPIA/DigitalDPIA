Public Class cookiecheck
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
		If Context.Request.Cookies.AllKeys.Contains("CookieCheck") Then
			Response.Redirect(Context.Request.QueryString("ref").Insert(0, "~/"))
		Else
			Response.Redirect(System.Configuration.ConfigurationManager.AppSettings("CookieFailPage"))
		End If
    End Sub

End Class